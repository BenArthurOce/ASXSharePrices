USE [BENASXDATABASE]
GO

CREATE PROC spQUERY_PortfolioValue2
	(
		 @in_PortfolioName	VARCHAR(100)
		,@in_EndDate		INT
	)
AS
BEGIN

	SET NOCOUNT ON ;


	DECLARE
		 @PortfolioId UNIQUEIDENTIFIER
		,@ErrorMesssage VARCHAR(MAX)
		,@DateReformmated INT


	PRINT 'Stored Procedure:' + OBJECT_NAME(@@PROCID)
	PRINT '  Parameters:'	
	PRINT CONCAT(
	'    '
	,'[@in_PortfolioName = ',@in_PortfolioName,'] '
	,'[@in_EndDate = ',@in_EndDate,'] '
	)


	PRINT '  CHECKING PORTFOLIO MATCH...'
	IF EXISTS (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		BEGIN
			PRINT '    PORTFOLIO MATCH FOUND'
			SET @PortfolioId = (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		END
	IF NOT EXISTS (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		BEGIN
			SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The specified portfolio does not exist. ')
			RAISERROR(@ErrorMesssage, 16, 1);
			RETURN
		END;


----------------------------------------------------------

-- Get full list of transactions from portfolio
	WITH [cteTransactions] AS
		(
			SELECT
				 [Tran].[Id]				AS [TranId]
				,[Tran].[SequenceNumber]	AS [SequenceNumber]
				,[Entity].[ASXCode]			AS [ASXCode]
				,[Tran].[Date]				AS [Date]
				,[Tran].[Quantity]			AS [Quantity]
				,[Tran].[UnitPrice]			AS [UnitPrice]
				,[Tran].[TotalValue]		AS [TotalValue]
				,[Type].[isIncrease]		AS [isIncrease]
				,[Type].[isDecrease]		AS [isDecrease]

			FROM [dbo].[TradingTransaction] [Tran]
				INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
				INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId
				INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
				INNER JOIN [dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId
			
			WHERE 
				[Portfolio].[Id] = @PortfolioId
					AND [Tran].[Date] <= @in_EndDate
		),

	

	--Applies a FIFO schedule to each share transaction
	[FIFOShares] AS 
		(
			SELECT 
				[cteTransactions].[ASXCode]		AS [ASXCode]
				,[cteTransactions].[Date]			AS [Date]
				,[cteTransactions].[UnitPrice]		AS [UnitPrice]
				,[cteTransactions].[Quantity]
				,[cteTransactions].[isIncrease]		AS [isIncrease]
				,[cteTransactions].[isDecrease]		AS [isDecrease]
				,CAST(
					CASE
						WHEN [cteTransactions].[isIncrease] = 1 THEN [cteTransactions].[Quantity] * [cteTransactions].[UnitPrice]
						ELSE 0
						END AS FLOAT
					) AS [CostBase]
				,SUM(
					CASE 
						WHEN [cteTransactions].[isIncrease] = 1 THEN [cteTransactions].[Quantity] * [cteTransactions].[UnitPrice]			
						ELSE 0 END
						)  OVER (PARTITION BY [cteTransactions].[ASXCode]
					) AS [TotalCostBase]

				,CAST(
					CASE
						WHEN [cteTransactions].[isIncrease] = 1 THEN ROUND([cteTransactions].[TotalValue] / [cteTransactions].[Quantity],4)
						ELSE 0
						END AS FLOAT
					) AS [CostPerShare]
				,SUM(
					CASE 
						WHEN [isIncrease] = 1 THEN [Quantity] 
						WHEN [isDecrease] = 1 THEN [Quantity] * -1			
						ELSE 0 END) 
							OVER (PARTITION BY [cteTransactions].[ASXCode] ORDER BY [cteTransactions].[Date], [cteTransactions].[TranId]
					) AS [CumulativeQuantity]
				,SUM(
					CASE 
						WHEN [isIncrease] = 1 THEN [Quantity] 			
						ELSE 0 END
					)  OVER (PARTITION BY [cteTransactions].[ASXCode]) AS [TotalBuy]

				,SUM(
					CASE 
						WHEN [isDecrease] = 1 THEN [Quantity] 			
						ELSE 0 END
					)  OVER (PARTITION BY [cteTransactions].[ASXCode]) AS [TotalSell]

			FROM 
				[cteTransactions] [cteTransactions]
		),

	[PortfolioCostBase] AS 
		(
			SELECT 
				 [FIFOShares].ASXCode
				,[FIFOShares].[TotalBuy] - [FIFOShares].[TotalSell] AS [Balance]
				,SUM(
					CASE
																-- Amount Brought					-- Amt Brought				--Entire Share Total Cost Base			--Average Cost base per line		-- Multipled by current balance of shares
						WHEN [FIFOShares].[isIncrease] = 1 THEN (([FIFOShares].[Quantity]*1.0) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalCostBase]*1.0)) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalBuy] - [FIFOShares].[TotalSell])
						ELSE 0
						END 
					) AS [CostBase]
				,SUM(
					CASE
																-- Amount Brought					-- Amt Brought				--Entire Share Total Cost Base			--Average Cost base per line
						WHEN [FIFOShares].[isIncrease] = 1 THEN (([FIFOShares].[Quantity]*1.0) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalCostBase]*1.0)) / ([FIFOShares].[TotalBuy]*1.0)
						ELSE 0
						END 
					) AS [CostPerShare]
			FROM 
				[FIFOShares] [FIFOShares]	
			GROUP BY
				 [FIFOShares].ASXCode
				,[FIFOShares].TotalBuy
				,[FIFOShares].TotalSell
		)

	SELECT  
		 [PortfolioCostBase].[ASXCode] AS [ASXCode]
		,[PortfolioCostBase].[Balance] AS [SharesOwned]
		,CAST([PortfolioCostBase].[CostBase] AS DECIMAL(18, 2)) AS [CostBase]
		,CAST([PortfolioCostBase].[CostPerShare] AS DECIMAL(18, 3)) AS [CostPerShare]
		,[LastPriceValue].[PriceClose] AS [CurrentPrice]
		,[LastPriceValue].[MarketValue] AS [MarketValue]
		,CAST([LastPriceValue].[MarketValue] - [PortfolioCostBase].[CostBase] AS DECIMAL(18, 2)) AS [ProfitLoss]
		,CAST((([LastPriceValue].[MarketValue] - [PortfolioCostBase].[CostBase]) / [PortfolioCostBase].[CostBase]) * 100 AS DECIMAL(18, 2)) AS [ProfitLossPct]
		,CAST(([LastPriceValue].MarketValue / SUM([LastPriceValue].MarketValue) OVER() *100) AS DECIMAL(18, 2)) AS [WeightPct]

	FROM [PortfolioCostBase]

			OUTER APPLY
				(
					SELECT TOP 1	 CAST([Prices].[PriceClose] AS DECIMAL(18, 3))  AS [PriceClose]
									,CAST([Prices].[PriceClose] * [PortfolioCostBase].[Balance] AS DECIMAL(18, 2)) AS [MarketValue]
					FROM			[ASXEODPrice] [Prices]
					WHERE			[PortfolioCostBase].[ASXCode] = [Prices].[ASXCode]
					AND				[Prices].[Date] < @in_EndDate
					ORDER BY		[Prices].[Date] DESC
				) AS [LastPriceValue]

		WHERE 
			[PortfolioCostBase].[Balance] > 0

END