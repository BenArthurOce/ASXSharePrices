--spQueryDummyTransactions2

USE [BENASXDATABASE]
GO

CREATE PROC spQueryDummyTransactions2

AS
BEGIN

	SET NOCOUNT ON ;



SELECT

	-- Splits at Id - Transaction
	 [Trans].[Id]				AS [Id]
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
	,[Sector].[Name]			AS [SectorName]


FROM
	[dbo].[DummyShareTransaction] [Trans]
	INNER JOIN [dbo].[DummyShareTransactionType] [Type] ON [Type].Id = [Trans].TypeId
	INNER JOIN [dbo].[DummyTradingCompany] [Company] ON [Company].Id = [Trans].[CompanyId]
	INNER JOIN [dbo].[DummyTradingSector] [Sector] ON [Sector].Id = [Company].SectorId

ORDER BY
	[Trans].SequenceNumber



END
