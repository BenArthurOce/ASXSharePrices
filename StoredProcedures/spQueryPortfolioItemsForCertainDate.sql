USE [BENASXDATABASE]
GO

CREATE PROC spQueryPortfolioItemsForCertainDate
	(
		 @in_PortfolioName	VARCHAR(100)
		,@in_StartDate		INT
		,@in_EndDate		INT
	)
AS
BEGIN

	SET NOCOUNT ON ;


	DECLARE
		 @LastShareDateRecord INT = (SELECT TOP 1 ASXDate FROM [ASXSharePrices] ORDER BY ASXDate DESC)
		,@PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @in_PortfolioName)
		,@DateToUse INT


	IF NOT EXISTS (SELECT 1 FROM ASXSharePrices WHERE ASXDate = @in_EndDate)
		BEGIN
		SET @DateToUse = @LastShareDateRecord;
		END
	ELSE
		BEGIN
		SET @DateToUse = @in_EndDate;
		END;

----------------------------------------------------------
----------------------------------------------------------

	WITH [PortfolioTransactions] AS
		(
			SELECT
				 [Tran].[SequenceNumber]	AS [in_SequenceNumber]
				,[Tran].[ASXCode]			AS [in_ASXCode]
				,[Tran].[Date]				AS [in_Date]
				,[Tran].[Quantity]			AS [in_Quantity]
				,[Tran].[TotalValue]		AS [in_TotalValue]
				,[Tran].[IsIncrease]		AS [in_IsIncrease]
				,CASE
					WHEN [Tran].IsIncrease = 1 THEN [Tran].Quantity
					ELSE [Tran].Quantity * -1 END AS [in_QuantUpDown]

			FROM [ShareTransaction] [Tran]
				INNER JOIN [PortfolioShareTransactionConnector] [Conn] ON [Conn].ShareTransactionId = [Tran].Id
				INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Conn].PortfolioId
				INNER JOIN [ShareTransactionType] [Type] ON [Type].Id = [Tran].TypeId

			WHERE 
				[Portfolio].[Id] = @PortfolioNameId
					AND [Tran].[Date] BETWEEN @in_StartDate AND @in_EndDate
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
		,CAST((([LastPriceValue].[MarketValue] - [PortfolioSummary].[CostValue]) / [PortfolioSummary].[CostValue]) * 100 AS DECIMAL(18, 2)) AS 'ProfitLossP'
		,CAST(([LastPriceValue].MarketValue / SUM([LastPriceValue].MarketValue) OVER() *100) AS DECIMAL(18, 2)) AS 'WeightP'
		
		
	FROM 
		[PortfolioSummary] [PortfolioSummary]

		OUTER APPLY
			(
				SELECT TOP 1	 CAST([Prices].[PriceClose] AS DECIMAL(18, 3))  AS 'PriceClose'
								,CAST([Prices].[PriceClose] * [PortfolioSummary].[SharesOwned] AS DECIMAL(18, 2)) AS 'MarketValue'
				FROM			 [ASXSharePrices] [Prices]
				WHERE			 [PortfolioSummary].[ASXCode] = [Prices].[ASXCode]
				AND				 [Prices].[ASXDate] = @LastShareDateRecord
			) AS [LastPriceValue]

	WHERE [PortfolioSummary].[SharesOwned] > 0

END