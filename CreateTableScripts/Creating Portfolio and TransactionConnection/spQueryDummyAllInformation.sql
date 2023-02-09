--spQueryDummyTransactions2

USE [BENASXDATABASE]
GO

CREATE PROC spQueryDummyAllInformation

AS
BEGIN

	SET NOCOUNT ON ;



SELECT 
	-- Splits at Id - Portfolio
	 [Portfolio].[Id]					AS [Id]	
	,[Portfolio].[PortfolioIdNumber]	AS [PortfolioIdNumber]
	,[Portfolio].[Name]					AS [Name]
	,[Portfolio].[isDeleted]			AS [isDeleted]

	-- Connector
	,[Connect].[Id]						AS [Id]
	--,[Connect].[DummyPortfolioId]		AS [DummyPortfolioId]		-- The GUID is not meant to be run in the query
	--,[Connect].[DummyIndividualId]		AS [DummyIndividualId]		-- The GUID is not meant to be run in the query

	--Individual
	,[Individual].[Id]					AS [Id]
	,[Individual].[CustomerNumber]		AS [CustomerNumber]
	,[Individual].[FirstName]			AS [FirstName]
	,[Individual].[LastName]			AS [LastName]
	,[Individual].[SearchName]			AS [SearchName]
	,[Individual].[HIN]					AS [HIN]
	,[Individual].[Postcode]			AS [Postcode]
	,[Individual].[isDeleted]			AS [isDeleted]

	-- Splits at Id - Transaction
	,[Trans].[Id]				AS [Id]
	,[Trans].[SequenceNumber]	AS [SequenceNumber]
	--,[Trans].[PortfolioId]		AS [PortfolioId]	-- The GUID is not meant to be run in the query
	--,[Trans].[CompanyId]		AS [CompanyId]			-- The GUID is not meant to be run in the query
	,[Trans].[Date]				AS [Date]
	--,[Trans].[TypeId]			AS [TypeId]				-- The GUID is not meant to be run in the query
	,[Trans].[Quantity]			AS [Quantity]
	,[Trans].[UnitPrice]		AS [UnitPrice]
	,[Trans].[TradeValue]		AS [TradeValue]
	,[Trans].[Brokerage]		AS [Brokerage]
	,[Trans].[TotalValue]		AS [TotalValue]
	,[Trans].[IsIncrease]		AS [IsIncrease]
	,[Trans].[IsDeleted]		AS [IsDeleted]

	-- Splits at Id - TransactionType
	,[Type].[Id]				AS [Id]			
	,[Type].[Name]				AS [Name]
	,[Type].[isDeleted]			AS [isDeleted]

	-- Splits at Id - Company
	,[Company].[Id]				AS [Id]
	,[Company].[ASXCode]		AS [ASXCode]
	,[Company].[Name]			AS [Name]
	--,[Company].[SectorId]		AS [SectorId]	-- The GUID is not meant to be run in the query

	-- Splits at Id - Sector
	,[Sector].[Id]				AS [Id]
	,[Sector].[Name]			AS [Name]


FROM
	[dbo].[DummyPortfolio] [Portfolio]
	INNER JOIN [dbo].[DummyConnectorIndividualsPortfolios] [Connect] ON [Connect].[DummyPortfolioId] = [Portfolio].[Id]
	INNER JOIN [dbo].[DummyIndividual] [Individual] ON [Individual].[Id] = [Connect].[DummyIndividualId]
	INNER JOIN [dbo].[DummyShareTransaction] [Trans] ON [Trans].PortfolioId = [Portfolio].Id
	INNER JOIN [dbo].[DummyShareTransactionType] [Type] ON [Type].Id = [Trans].TypeId
	INNER JOIN [dbo].[DummyTradingCompany] [Company] ON [Company].Id = [Trans].[CompanyId]
	INNER JOIN [dbo].[DummyTradingSector] [Sector] ON [Sector].Id = [Company].SectorId	

ORDER BY
	[Portfolio].PortfolioIdNumber, [Trans].SequenceNumber



END
