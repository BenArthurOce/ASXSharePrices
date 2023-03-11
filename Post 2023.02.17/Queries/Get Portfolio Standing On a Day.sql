
DECLARE
	 @PortfolioName		VARCHAR(200) = 'A Peterson Portfolio'
	,@StartDate			INT = 20200101
	,@EndDate			INT = 20230101
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

WITH [PortfolioTransactions] AS
	(
		SELECT
			 [Tran].[SequenceNumber]	AS [in_SequenceNumber]
			,[Entity].[ASXCode]			AS [in_ASXCode]
			,[Tran].[Date]				AS [in_Date]
			,[Tran].[Quantity]			AS [in_Quantity]
			,[Tran].[TotalValue]		AS [in_TotalValue]
			,[Type].[isIncrease]		AS [in_isIncrease]
			,[Type].[isDecrease]		AS [in_isDecrease]
			,CASE
				WHEN [Type].IsIncrease = 1 THEN [Tran].Quantity
				ELSE [Tran].Quantity * -1 END AS [in_QuantUpDown]

		FROM [dbo].[TradingTransaction] [Tran]
			INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
			INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId
			INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
			INNER JOIN [dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId
			
		WHERE 
			[Portfolio].[Id] = @PortfolioNameId
				AND [Tran].[Date] BETWEEN @StartDate AND @DateToUse
	),


  [PortfolioSummary] AS
	(
		SELECT
			[PortfolioTransactions].in_ASXCode AS 'ASXCode'	 	
			,SUM([PortfolioTransactions].in_QuantUpDown) AS 'SharesOwned'
			,SUM(CASE 
					WHEN [PortfolioTransactions].in_IsIncrease > 0 
					THEN [PortfolioTransactions].in_TotalValue 
					ELSE 0 
				END) AS 'CostValue'

		FROM
			[PortfolioTransactions]
		GROUP BY
			[PortfolioTransactions].in_ASXCode
	)


SELECT 
		[PortfolioSummary].[ASXCode] AS 'ASXCode'
	,[PortfolioSummary].[SharesOwned] AS 'SharesOwned'
	,CAST([PortfolioSummary].[CostValue] AS DECIMAL(18, 2)) AS 'CostBase'
	,CASE
		WHEN [PortfolioSummary].[SharesOwned] = 0 
		THEN 0
		ELSE CAST([PortfolioSummary].[CostValue] / [PortfolioSummary].[SharesOwned] AS DECIMAL(18, 3))
		END AS 'CostPrice'
	,[LastPriceValue].[PriceClose] AS 'CurrentPrice'
	,[LastPriceValue].[MarketValue] AS 'MarketValue'	
	,CAST([LastPriceValue].[MarketValue] - [PortfolioSummary].[CostValue] AS DECIMAL(18, 2)) AS 'ProfitLoss'
	,CAST((([LastPriceValue].[MarketValue] - [PortfolioSummary].[CostValue]) / [PortfolioSummary].[CostValue]) * 100 AS DECIMAL(18, 2)) AS 'ProfitLoss%'
	,CAST(([LastPriceValue].MarketValue / SUM([LastPriceValue].MarketValue) OVER() *100) AS DECIMAL(18, 2)) AS 'Weight%'
		
		
FROM 
	[PortfolioSummary] [PortfolioSummary]

	OUTER APPLY
		(
			SELECT TOP 1	 CAST([Prices].[PriceClose] AS DECIMAL(18, 3))  AS 'PriceClose'
							,CAST([Prices].[PriceClose] * [PortfolioSummary].[SharesOwned] AS DECIMAL(18, 2)) AS 'MarketValue'
			FROM			 [dbo].[ASXEODPrice] [Prices]
			WHERE			 [PortfolioSummary].[ASXCode] = [Prices].[ASXCode]
			AND				 [Prices].[Date] = @LastShareDateRecord
		) AS [LastPriceValue]

WHERE [PortfolioSummary].[SharesOwned] > 0

PRINT @DateToUse


