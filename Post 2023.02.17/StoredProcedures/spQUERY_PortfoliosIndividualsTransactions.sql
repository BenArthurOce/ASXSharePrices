CREATE PROC spQUERY_PortfoliosIndividualsTransactions
AS
BEGIN

	SET NOCOUNT ON ;


SELECT 
	-- Splits at Id - Portfolio
	 [Portfolio].[Id]						AS [Id]	
	,[Portfolio].[PortfolioCustomerNumber]	AS [PortfolioCustomerNumber]
	,[Portfolio].[Name]						AS [Name]
	,[Portfolio].[isDeleted]				AS [isDeleted]

	-- Connector
	,[Connect].[Id]						AS [Id]
	--,[Connect].[DummyPortfolioId]		AS [DummyPortfolioId]		-- The GUID is not meant to be run in the query
	--,[Connect].[DummyIndividualId]		AS [DummyIndividualId]		-- The GUID is not meant to be run in the query

	--Individual
	,[Individual].[Id]						AS [Id]
	,[Individual].IndividualCustomerNumber	AS [CustomerNumber]
	,[Individual].[FirstName]				AS [FirstName]
	,[Individual].[LastName]				AS [LastName]
	,[Individual].[SearchName]				AS [SearchName]
	,[Individual].[HIN]						AS [HIN]
	,[Individual].[Postcode]				AS [Postcode]
	,[Individual].[isDeleted]				AS [isDeleted]


	-- Splits at Id - Transaction
	,[Trans].[Id]				AS [Id]
	,[Trans].[SequenceNumber]	AS [SequenceNumber]
	,[Trans].[ContractNote]		AS [ContractNote]
	--,[Trans].[PortfolioId]		AS [PortfolioId]	-- The GUID is not meant to be run in the query
	--,[Trans].[CompanyId]		AS [CompanyId]			-- The GUID is not meant to be run in the query
	,[Trans].[Date]				AS [Date]
	--,[Trans].[TypeId]			AS [TypeId]				-- The GUID is not meant to be run in the query
	,[Trans].[Quantity]			AS [Quantity]
	,[Trans].[UnitPrice]		AS [UnitPrice]
	,[Trans].[TradeValue]		AS [TradeValue]
	,[Trans].[Brokerage]		AS [Brokerage]
	,[Trans].[TotalValue]		AS [TotalValue]
	,[Trans].[IsDeleted]		AS [IsDeleted]

	-- Splits at Id - TransactionType
	,[Type].[Id]				AS [Id]			
	,[Type].[Name]				AS [Name]
	,[Type].[isDeleted]			AS [isDeleted]
	,[Type].[isIncrease]		AS [isIncrease]
	,[Type].[isDecrease]		AS [isDecrease]

	-- Splits at Id - Company
	,[Company].[Id]				AS [Id]
	,[Company].[ASXCode]		AS [ASXCode]
	,[Company].[Name]			AS [Name]
	--,[Company].[SectorId]		AS [SectorId]	-- The GUID is not meant to be run in the query
	,[Company].[isLICS]			AS [isLICS]
	,[Company].[isA-REIT]		AS [isA-REIT]
	,[Company].[isETP]			AS [isETP]
	,[Company].[isIndices]		AS [isIndices]
	,[Company].[isABFund]		AS [isABFund]
	,[Company].[isDerivative]	AS [isDerivative]
	,[Company].[Notes]			AS [Notes]


	-- Splits at Id - Sector
	,[Sector].[Id]				AS [Id]
	,[Sector].[Name]			AS [Name]


FROM
	[dbo].[Portfolio] [Portfolio]
	INNER JOIN [dbo].[ConnectorIndividualsPortfolios] [Connect] ON [Connect].PortfolioId = [Portfolio].[Id]
	INNER JOIN [dbo].[Individual] [Individual] ON [Individual].[Id] = [Connect].[IndividualId]
	INNER JOIN [dbo].[TradingTransaction] [Trans] ON [Trans].[PortfolioId] = [Portfolio].[Id]
	INNER JOIN [dbo].[TradingTransactionType] [Type] ON [Type].[Id] = [Trans].[TradingTransactionTypeId]
	INNER JOIN [dbo].[TradingEntity] [Company] ON [Company].[Id] = [Trans].[TradingEntityId]
	INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].[Id] = [Company].[SectorId]	

ORDER BY
	[Portfolio].PortfolioCustomerNumber
	,[Trans].[Date]

END