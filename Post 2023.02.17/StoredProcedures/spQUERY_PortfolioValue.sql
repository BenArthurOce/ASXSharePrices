USE [BENASXDATABASE]
GO

CREATE PROC spQUERY_PortfolioValue
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

	WITH [PortfolioTransactions] AS
		(
			SELECT
				 [Tran].[SequenceNumber]	AS [in_SequenceNumber]
				,[Entity].[ASXCode]			AS [in_ASXCode]
				,[Tran].[Date]				AS [in_Date]
				,[Tran].[Quantity]			AS [in_Quantity]
				,[Tran].[TotalValue]		AS [in_TotalValue]
				,[Type].[IsIncrease]		AS [in_IsIncrease]
				,[Type].[isDecrease]		AS [in_IsDecrease]

				,CASE
					WHEN [Type].[IsIncrease] = 1 THEN [Tran].Quantity
					WHEN [Type].[isDecrease] = 1 THEN [Tran].Quantity * -1
					END AS [in_QuantUpDown]

			FROM [TradingTransaction] [Tran]
				INNER JOIN [dbo].[Portfolio] [Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
				INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
				INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId
				INNER JOIN [dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId

			WHERE 
				[Portfolio].[Id] = @PortfolioId
				AND [Tran].[Date] < @in_EndDate
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
				FROM			 [ASXEODPrice] [Prices]
				WHERE			 [PortfolioSummary].[ASXCode] = [Prices].[ASXCode]
				AND				 [Prices].[Date] = @in_EndDate
			) AS [LastPriceValue]

	WHERE [PortfolioSummary].[SharesOwned] > 0

END