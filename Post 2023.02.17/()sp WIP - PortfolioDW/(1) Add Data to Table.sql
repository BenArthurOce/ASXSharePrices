DECLARE @PortfolioName NVARCHAR(100) = 'Jimmys Renewerables'
DECLARE @RequestDate INT = 20220505
DECLARE @PortfolioId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = @PortfolioName)

INSERT INTO [dbo].[DW_PortfolioStandings] ([PortfolioId], [DateKey], [EntityId], [SharesOwned], [CostBase], [CostPerShare], [CurrentPrice], [MarketValue], [ProfitLoss], [ProfitLossPct], [WeightPct])

SELECT 
	 @PortfolioId	AS [PortfolioId]
	,@RequestDate	AS [DateKey]
	,* 

FROM [dbo].[funRETURN_PortfolioValueOnDate4] ('Jimmys Renewerables', 20220505)