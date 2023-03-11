--Plan

-- Need to get list of all the shares owned at a particular date
-- Need to get the current price of those shares at that date
-- Calculate the portfolio value
-- Get that as a day by day


DECLARE
	 @PortfolioName		VARCHAR(200) = 'A Peterson Portfolio'
	,@StartDate			INT = 20200101
	,@EndDate			INT = 20230105
;

DECLARE
	@LastShareDateRecord INT = (SELECT TOP 1 [Date] FROM [dbo].[ASXEODPrice] ORDER BY [Date] DESC)
	,@PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @PortfolioName)
	,@DateToUse INT


IF NOT EXISTS (SELECT 1 FROM [dbo].[ASXEODPrice] WHERE [Date] = @EndDate)
	BEGIN
	SET @DateToUse = @LastShareDateRecord;
	END
ELSE
	BEGIN
	SET @DateToUse = @EndDate;
	END;
;

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
			[Portfolio].[Id] = @PortfolioNameId
				AND [Tran].[Date] BETWEEN @StartDate AND @DateToUse
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
	)


SELECT 
	 [FIFOShares].ASXCode
	,[FIFOShares].[TotalBuy] - [FIFOShares].[TotalSell] AS [Balance]
	,SUM(
		CASE
													-- Amount Brought					-- Amt Brought				--Entire Share Total Cost Base			--Average Cost base per line
			WHEN [FIFOShares].[isIncrease] = 1 THEN (([FIFOShares].[Quantity]*1.0) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalCostBase]*1.0)) / ([FIFOShares].[TotalBuy]*1.0)
			ELSE 0
			END 
		) AS [CostBase]
	,SUM(
		CASE
													-- Amount Brought					-- Amt Brought				--Entire Share Total Cost Base			--Average Cost base per line		-- Multipled by current balance of shares
			WHEN [FIFOShares].[isIncrease] = 1 THEN (([FIFOShares].[Quantity]*1.0) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalCostBase]*1.0)) / ([FIFOShares].[TotalBuy]*1.0) * ([FIFOShares].[TotalBuy] - [FIFOShares].[TotalSell])
			ELSE 0
			END 
		) AS [CostBase]

FROM 
	[FIFOShares] [FIFOShares]
	
GROUP BY
	 [FIFOShares].ASXCode
	,[FIFOShares].TotalBuy
	,[FIFOShares].TotalSell

