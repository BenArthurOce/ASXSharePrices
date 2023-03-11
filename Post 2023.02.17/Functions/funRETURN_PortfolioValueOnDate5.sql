USE [BENASXDATABASE]
GO

-- Main difference between this one and 3rd, is the entitiyId

CREATE FUNCTION [dbo].[funRETURN_PortfolioValueOnDate5]
	(
	 @in_PortfolioName NVARCHAR(100)
	,@in_EndDate INT
	)
RETURNS TABLE
AS
RETURN 



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
				[Portfolio].[Id] = (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
					AND [Tran].[Date] <= @in_EndDate
		),

	

	--Reads the Increase Transactions and calculates the cost base (Is possible that it can create FIFO schedule to each share transaction using CumulativeQuantity)
	[EachCB] AS 
		(
			SELECT 
				 [cteTransactions].[ASXCode]		AS [ASXCode]
				,[cteTransactions].[Date]			AS [Date]
				,[cteTransactions].[UnitPrice]		AS [UnitPrice]
				,[cteTransactions].[Quantity]		AS [Quantity]
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

	-- Creates a weighted cost base per share
	[PortfolioCostBase] AS 
		(
			SELECT 
				 [EachCB].[ASXCode]
				,[EachCB].[TotalBuy] - [EachCB].[TotalSell] AS [Balance]
				,SUM(
					CASE
																-- Amount Brought					-- Amt Brought				--Entire Share Total Cost Base			--Average Cost base per line		-- Multipled by current balance of shares
						WHEN [EachCB].[isIncrease] = 1 THEN (([EachCB].[Quantity]*1.0) / ([EachCB].[TotalBuy]*1.0) * ([EachCB].[TotalCostBase]*1.0)) / ([EachCB].[TotalBuy]*1.0) * ([EachCB].[TotalBuy] - [EachCB].[TotalSell])
						ELSE 0
						END 
					) AS [CostBase]
				,SUM(
					CASE
															-- Amt Brought				-- Amt Brought				--Entire Share Total Cost Base		--Average Cost base per line
						WHEN [EachCB].[isIncrease] = 1 THEN (([EachCB].[Quantity]*1.0) / ([EachCB].[TotalBuy]*1.0) * ([EachCB].[TotalCostBase]*1.0)) / ([EachCB].[TotalBuy]*1.0)
						ELSE 0
						END 
					) AS [CostPerShare]
			FROM 
				[EachCB] [EachCB]	
			GROUP BY
				 [EachCB].[ASXCode]
				,[EachCB].[TotalBuy]
				,[EachCB].[TotalSell]
		)

	SELECT  
		 (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName) AS [PortfolioId] 
		,@in_EndDate AS [DateKey]
		,[Entity].[Id] AS [EntityId]
		,[Sector].[Id] AS [SectorId]
		,[PortfolioCostBase].[Balance] AS [SharesOwned]
		,CAST([PortfolioCostBase].[CostBase] AS DECIMAL(18, 2)) AS [CostBase]
		,CAST([PortfolioCostBase].[CostPerShare] AS DECIMAL(18, 3)) AS [CostPerShare]
		,[LastPriceValue].[PriceClose] AS [CurrentPrice]
		,[LastPriceValue].[MarketValue] AS [MarketValue]
		,CAST([LastPriceValue].[MarketValue] - [PortfolioCostBase].[CostBase] AS DECIMAL(18, 2)) AS [ProfitLoss]
		,CAST((([LastPriceValue].[MarketValue] - [PortfolioCostBase].[CostBase]) / [PortfolioCostBase].[CostBase]) * 100 AS DECIMAL(18, 2)) AS [ProfitLossPct]
		,CAST(([LastPriceValue].MarketValue / SUM([LastPriceValue].MarketValue) OVER() *100) AS DECIMAL(18, 2)) AS [WeightPct]

	FROM [PortfolioCostBase]
	INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].[ASXCode] = [PortfolioCostBase].[ASXCode]
	INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].[Id] = [Entity].[SectorId]

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

