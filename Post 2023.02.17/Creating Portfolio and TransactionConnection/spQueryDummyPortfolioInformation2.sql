CREATE PROC spQueryDummyPortfolioInformation2
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




FROM
	[dbo].[DummyPortfolio] [Portfolio]
	INNER JOIN [dbo].[DummyConnectorIndividualsPortfolios] [Connect] ON [Connect].[DummyPortfolioId] = [Portfolio].[Id]
	INNER JOIN [dbo].[DummyIndividual] [Individual] ON [Individual].[Id] = [Connect].[DummyIndividualId]


ORDER BY
	[Portfolio].PortfolioIdNumber

END