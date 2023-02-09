USE [BENASXDATABASE]
GO

CREATE PROC spQueryDummyTransactions

AS
BEGIN

	SET NOCOUNT ON ;

SELECT
	-- Splits at Id - Transaction
	 [Trans].[Id]				AS [Id]
	,[Trans].[SequenceNumber]	AS [SequenceNumber]
	,[Trans].[PortfolioId]		AS [PortfolioId]
	,[Trans].[CompanyId]		AS [CompanyId]
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

FROM
	[dbo].[DummyShareTransaction] [Trans]
	INNER JOIN [dbo].[DummyShareTransactionType] [Type] ON [Type].Id = [Trans].TypeId

	ORDER BY
	[Trans].SequenceNumber

END
