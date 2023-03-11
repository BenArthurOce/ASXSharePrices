USE [BENASXDATABASE]
GO

CREATE PROC spGetPrices

AS
BEGIN

	SET NOCOUNT ON ;

SELECT
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
	[dbo].[ASXSharePrices] [Prices]


	INNER JOIN [dbo].[DummyTradingCompany] [Company] ON [Company].Id = [Prices].c
	INNER JOIN [dbo].[DummyTradingSector] [Sector] ON [Sector].Id = [Company].SectorId

