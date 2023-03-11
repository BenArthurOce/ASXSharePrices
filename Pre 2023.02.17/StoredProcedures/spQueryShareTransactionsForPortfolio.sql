USE [BENASXDATABASE]
GO

CREATE PROC spQueryShareTransactionsForPortfolio
	(
		 @in_PortfolioName	VARCHAR(100)
	)
AS
BEGIN

	SET NOCOUNT ON ;


	DECLARE
		@PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @in_PortfolioName)

	SELECT
		   [Transaction].[Id]				AS [Id]
		  ,[Transaction].[ContractNote]		AS [ContractNote]
		  ,[Transaction].[ASXCode]			AS [ASXCode]
		  ,[Company].[Name]					AS [CompanyName]
		  ,[Sector].[Name]					AS [CompanySector]
		  ,[Transaction].[Date]				AS [Date]
		  ,[Type].[Name]					AS [Type]
		  ,[Transaction].[Quantity]			AS [Quantity]
		  ,[Transaction].[UnitPrice]		AS [UnitPrice]
		  ,[Transaction].[TradeValue]		AS [TradeValue]
		  ,[Transaction].[Brokerage]		AS [Brokerage]
		  ,[Transaction].[TotalValue]		AS [TotalValue]
		  ,[Transaction].[IsIncrease]		AS [IsIncrease]

	FROM [ShareTransaction] [Transaction]
		INNER JOIN [PortfolioShareTransactionConnector] [Conn] ON [Conn].ShareTransactionId = [Transaction].Id
		INNER JOIN [Portfolio] [Portfolio] ON [Portfolio].Id = [Conn].PortfolioId
		INNER JOIN [ShareTransactionType] [Type] ON [Type].Id = [Transaction].TypeId
		INNER JOIN [TradingCompany] [Company] ON [Company].ASXCode = [Transaction].[ASXCode]
		INNER JOIN [TradingSector] [Sector] ON [Sector].Id = [Company].SectorId

	WHERE 
		[Portfolio].[Id] = @PortfolioNameId

	ORDER BY
		 [Transaction].[Date]
		,[Transaction].[ContractNote]
END
