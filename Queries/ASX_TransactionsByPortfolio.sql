
SELECT
	 [Tran].[SequenceNumber]
	,[Tran].[ContractNote]
	,[Tran].[ASXCode]
	,[Tran].[Date]
	,[Tran].[TypeId]
	,[Tran].[Quantity]
	,[Tran].[UnitPrice]
	,[Tran].[TradeValue]
	,[Tran].[Brokerage]
	,[Tran].[TotalValue]
	,[Tran].[IsIncrease]
FROM [ShareTransaction] [Tran]
	INNER JOIN [PortfolioShareTransactionConnector] [Conn] ON [Conn].ShareTransactionId = [Tran].Id
	INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Conn].PortfolioId

WHERE 
	[Portfolio].[Name] LIKE '%Ben%'

	ORDER BY
		SequenceNumber