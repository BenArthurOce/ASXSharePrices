
DECLARE
	 @PortfolioName		VARCHAR(200) = 'Ben'
	,@StartDate			INT = 20220101
	,@EndDate			INT = 20221028

SELECT
	 [Tran].[SequenceNumber]
	,[Tran].[ContractNote]
	,[Tran].[ASXCode]
	,[Tran].[Date]
	,[Type].[Name]
---	,[Tran].[TypeId]
	,[Tran].[Quantity]
	,[Tran].[UnitPrice]
	,[Tran].[TradeValue]
	,[Tran].[Brokerage]
	,[Tran].[TotalValue]
	,[Tran].[IsIncrease]




FROM [ShareTransaction] [Tran]
	INNER JOIN [PortfolioShareTransactionConnector] [Conn] ON [Conn].ShareTransactionId = [Tran].Id
	INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Conn].PortfolioId
	INNER JOIN [ShareTransactionType] [Type] ON [Type].Id = [Tran].TypeId

WHERE 
	[Portfolio].[Name] LIKE '%Ben%' 
		--AND [Prices].ASXDate BETWEEN @StartDate AND @EndDate
		--AND [Tran].ASXCode = 'INA'
			
ORDER BY
	SequenceNumber