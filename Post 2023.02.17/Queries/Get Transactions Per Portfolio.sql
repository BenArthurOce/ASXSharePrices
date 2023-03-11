
DECLARE
	 @PortfolioName		VARCHAR(200) = 'A Peterson Portfolio';
DECLARE
	 @PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @PortfolioName)


SELECT
	 [Tran].[ContractNote]
	,[Entity].[ASXCode]
	,[Tran].[Date]
	,[Type].[Name]		AS 'Type'
	,[Tran].[Quantity]
	,[Tran].[UnitPrice]
	,[Tran].[TradeValue]
	,[Tran].[Brokerage]
	,[Tran].[TotalValue]


FROM		[dbo].[TradingTransaction] [Tran]
INNER JOIN	[dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
INNER JOIN	[dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId
INNER JOIN	[dbo].[Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
INNER JOIN	[dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId

WHERE [Portfolio].[Id] = @PortfolioNameId

ORDER BY [Tran].[Date], [Tran].[ContractNote]