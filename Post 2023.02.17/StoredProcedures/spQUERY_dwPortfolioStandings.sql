USE [BENASXDATABASE]
GO


CREATE PROCEDURE spQUERY_dwPortfolioStandings
	(
		 @in_PortfolioName NVARCHAR(100)
		,@in_StartDate INT
		,@in_EndDate INT
	)

AS
BEGIN
    SET NOCOUNT ON

	DECLARE
		@PortfolioId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = @in_PortfolioName)
 
	SELECT 
		-- Function Values
		[dwPortfolio].[Id]				AS [Id]
		,[dwPortfolio].[DateKey]		AS [Date]
		--,[dwPortfolio].[PortfolioId]	AS [PortfolioId]
		--,[dwPortfolio].[DateKey]		AS [DateKey]
		--,[dwPortfolio].[EntityId]		AS [EntityId]
		--,[dwPortfolio].[SectorId]		AS [SectorId]
		,[dwPortfolio].[SharesOwned]	AS [SharesOwned]
		,[dwPortfolio].[CostBase]		AS [CostBase]
		,[dwPortfolio].[CostPerShare]	AS [CostPerShare]
		,[dwPortfolio].[CurrentPrice]	AS [CurrentPrice]
		,[dwPortfolio].[MarketValue]	AS [MarketValue]
		,[dwPortfolio].[ProfitLoss]		AS [ProfitLoss]
		,[dwPortfolio].[ProfitLossPct]	AS [ProfitLossPct]
		,[dwPortfolio].[WeightPct]		AS [WeightPct]


		-- Splits at Id - Portfolio
		,[Portfolio].[Id]						AS [Id]	
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


		-- Entity Model
		,[Entity].[Id]					AS [Id]
		,[Entity].[ASXCode]				AS [ASXCode]
		,[Entity].[Name]				AS [Name]
		--,[Entity].[SectorId]			AS [SectorId]
		,[Entity].[isLICS]				AS [isLICS]
		,[Entity].[isA-REIT]			AS [isA-REIT]
		,[Entity].[isETP]				AS [isETP]
		,[Entity].[isIndices]			AS [isIndices]
		,[Entity].[isABFund]			AS [isABFund]
		,[Entity].[isDerivative]		AS [isDerivative]
		,[Entity].[Notes]				AS [Notes]

		-- Sector Model
		,[Sector].[Id]					AS [Id]
		,[Sector].[Name]				AS [Name]


	FROM 
		[dbo].[DW_PortfolioStandings] [dwPortfolio]
		INNER JOIN [dbo].[Portfolio] [Portfolio]					ON [Portfolio].[Id] = [dwPortfolio].[PortfolioId]
		INNER JOIN [dbo].[ConnectorIndividualsPortfolios] [Connect] ON [Connect].[PortfolioId] = [Portfolio].[Id]
		INNER JOIN [dbo].[Individual] [Individual]					ON [Individual].[Id] = [Connect].[IndividualId]


		--INNER JOIN [dbo].[Dates] [Dates]				ON [Dates].[DateKey] = [dwPortfolio].[DateKey]
		INNER JOIN [dbo].[TradingEntity] [Entity]		ON [Entity].[Id] = [dwPortfolio].[EntityId]
		INNER JOIN [dbo].[TradingSector] [Sector]		ON [Sector].[Id] = [dwPortfolio].[SectorId]

	WHERE
		[Portfolio].[Id] = @PortfolioId
		AND [dwPortfolio].[DateKey]  BETWEEN @in_StartDate AND @in_EndDate

END