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
WITH [PortfolioTransactions] AS
	(
		SELECT
			 [Tran].[SequenceNumber]	AS [in_TranId]
			,[Tran].[SequenceNumber]	AS [in_SequenceNumber]
			,[Entity].[ASXCode]			AS [in_ASXCode]
			,[Tran].[Date]				AS [in_Date]
			,[Tran].[Quantity]			AS [in_Quantity]
			,[Tran].[TotalValue]		AS [in_TotalValue]
			,[Tran].[UnitPrice]			AS [in_UnitPrice]
			,[Type].[isIncrease]		AS [in_isIncrease]
			,[Type].[isDecrease]		AS [in_isDecrease]
			,CASE
				WHEN [Type].[isIncrease] = 1 THEN [Tran].[Quantity] * 1
				WHEN [Type].[isDecrease] = 1 THEN [Tran].[Quantity] * -1
				ELSE 0 END AS [in_QuantUpDown]

		FROM [dbo].[TradingTransaction] [Tran]
			INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
			INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId
			INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
			INNER JOIN [dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId
			
		WHERE 
			[Portfolio].[Id] = @PortfolioNameId
				AND [Tran].[Date] BETWEEN @StartDate AND @DateToUse
	),

--Calculates the current balance of each share
[ShareBalances] AS (
	SELECT 
		 [cteTrans].[in_ASXCode] AS [bal_ASXCode]
		 ,SUM(
		 		CASE
				WHEN [cteTrans].[in_isIncrease] = 1 THEN [cteTrans].[in_Quantity] * 1
				WHEN [cteTrans].[in_isDecrease] = 1 THEN [cteTrans].[in_Quantity] * -1
				ELSE 0 END 
		 ) [bal_ShareBalance]
	FROM 
		[PortfolioTransactions] [cteTrans]
	GROUP BY
		[cteTrans].[in_ASXCode]
)

,

--Applies a FIFO schedule to each share transaction
[FIFOShares] AS (
  SELECT 
     [cteTrans].[in_ASXCode]	 AS [fifo_ASXCode]
    ,[cteTrans].[in_Date]		 AS [fifo_Date]
    ,[cteTrans].[in_QuantUpDown] AS [fifo_Quantity]
    ,[cteTrans].[in_UnitPrice]	 AS [fifo_UnitPrice]
	,SUM(
		CASE
			WHEN [cteTrans].[in_isIncrease] = 1 THEN [cteTrans].[in_UnitPrice]
			ELSE 0 END 
		)	OVER (
				PARTITION BY [cteTrans].[in_ASXCode] ORDER BY [cteTrans].[in_Date], [cteTrans].[in_Date]
				) AS [fifo_CostBase]
	


	,[cteTrans].in_isIncrease AS [fifo_isIncrease]
	,[cteTrans].in_isDecrease AS [fifo_isDecrease]
    ,SUM(
		 CASE
			WHEN [cteTrans].[in_isIncrease] = 1 THEN [cteTrans].[in_Quantity] * 1
			WHEN [cteTrans].[in_isDecrease] = 1 THEN [cteTrans].[in_Quantity] * -1
			ELSE 0 END 
		)	OVER (
				PARTITION BY [cteTrans].[in_ASXCode] ORDER BY [cteTrans].[in_Date], [cteTrans].[in_Date]
				) AS [fifo_CumulativeQuantity]
	
	,CASE
			WHEN [cteTrans].[in_isIncrease] = 1 THEN [cteTrans].[in_UnitPrice] 
			WHEN [cteTrans].[in_isDecrease] = 1 THEN 0
			ELSE 0 END AS [fifo_CostBaseNew]

	FROM 
		[PortfolioTransactions] [cteTrans]
)
-- Get a List of Cost Bases
SELECT 

[cteFIFO].[fifo_ASXCode]
,[cteFIFO].fifo_isIncrease
,[cteFIFO].fifo_isDecrease
,SUM
	([cteFIFO].fifo_CostBaseNew * [cteFIFO].fifo_Quantity)

,SUM
	([cteFIFO].fifo_Quantity)

FROM [FIFOShares] [cteFIFO]
--WHERE [cteFIFO].[fifo_isIncrease] = 1 AND [cteFIFO].[fifo_isDecrease] = 0
GROUP BY [cteFIFO].[fifo_ASXCode]
,[cteFIFO].fifo_isIncrease
,[cteFIFO].fifo_isDecrease
--ORDER BY [cteFIFO].[fifo_Date]


/*


|__CODE__|___TYPE_|___AMT__|___CB______|________|________|________|________|________|________|________|________|________|
|   JBH  |   BUY  |   100  |  4,862.95 |        |        |        |        |        |        |        |        |        |
|   JBH  |   SELL |    90  |           |        |        |        |        |        |        |        |        |        |
|   JBH  |   SELL |     9  |           |        |        |        |        |        |        |        |        |        |
|   JBH  |   BUY  |    80  |  4,426.79 |        |        |        |        |        |        |        |        |        |
|   JBH  |   SELL |    30  |           |        |        |        |        |        |        |        |        |        |
|        |        |        |           |        |        |        |        |        |        |        |        |        |
|        |        |        |           |        |        |        |        |        |        |        |        |        |
|        |        |        |           |        |        |        |        |        |        |        |        |        |








*/