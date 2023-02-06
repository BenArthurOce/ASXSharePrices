

INSERT INTO [dbo].[ShareTransaction]
	([ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease])

VALUES
	(NULL, 'SKI', 20211022, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'SELL'), 1100, 2.7675, 3044.25, 0, 3044.25, 0)



DECLARE
	@BensPorfolioExample UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = 'Ben Portfolio Account 1')

INSERT INTO [dbo].[PortfolioShareTransactionConnector] (PortfolioId, ShareTransactionId)
VALUES

(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 95))