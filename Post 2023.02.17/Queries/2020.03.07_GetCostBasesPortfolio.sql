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
		,SUM([in_QuantUpDown]) AS [bal_ShareBalance]
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
    ,SUM(CASE 
			WHEN [in_isIncrease] = 1 THEN [in_Quantity] ELSE [in_Quantity]*-1 END) 
			OVER (PARTITION BY [cteTrans].[in_ASXCode] ORDER BY [cteTrans].[in_Date], [cteTrans].[in_TranId]
		) AS [fifo_CumulativeQuantity]
  FROM 
	[PortfolioTransactions] [cteTrans]
)

SELECT 
   [cteFIFO].[fifo_ASXCode]
  ,[cteBalances].[bal_ShareBalance]
  ,SUM(CASE WHEN [cteFIFO].[fifo_CumulativeQuantity] - ABS([cteFIFO].[fifo_Quantity]) < [cteBalances].[bal_ShareBalance] THEN [cteFIFO].[fifo_Quantity] ELSE [cteFIFO].[fifo_CumulativeQuantity] - [cteBalances].[bal_ShareBalance] END) AS RemainingQuantity
  ,SUM(CASE WHEN [cteFIFO].[fifo_CumulativeQuantity] - ABS([cteFIFO].[fifo_Quantity]) < [cteBalances].[bal_ShareBalance] THEN [cteFIFO].[fifo_Quantity] * [cteFIFO].[fifo_UnitPrice] ELSE ([cteFIFO].[fifo_CumulativeQuantity] - [cteBalances].[bal_ShareBalance]) * [cteFIFO].[fifo_UnitPrice] END) AS CostBase

FROM [FIFOShares] [cteFIFO]
JOIN [ShareBalances] [cteBalances] ON [cteFIFO].[fifo_ASXCode] = [cteBalances].[bal_ASXCode]
GROUP BY [cteFIFO].[fifo_ASXCode], [cteBalances].[bal_ShareBalance]
