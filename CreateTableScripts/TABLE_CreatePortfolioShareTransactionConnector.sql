USE BENASXDATABASE
GO

CREATE TABLE [dbo].[PortfolioShareTransactionConnector](
	  [PortfolioId]				UNIQUEIDENTIFIER	
	 ,[ShareTransactionId]		UNIQUEIDENTIFIER
	 ,CONSTRAINT [PK_PortfolioShareTransactionId] PRIMARY KEY ([PortfolioId], [ShareTransactionId])

	 ,CONSTRAINT [FK_Portfolio]
			FOREIGN KEY ([PortfolioId]) 
			REFERENCES [Portfolio] ([Id])

	,CONSTRAINT [FK_ShareTransaction]
			FOREIGN KEY ([ShareTransactionId]) 
			REFERENCES [ShareTransaction] ([Id])	 
	 )

DECLARE
	@BensPorfolioExample UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = 'Ben Portfolio Account 1')


INSERT INTO [dbo].[PortfolioShareTransactionConnector] (PortfolioId, ShareTransactionId)
VALUES

(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 1)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 2)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 3)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 4)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 5)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 6)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 7)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 8)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 9)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 10)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 11)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 12)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 13)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 14)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 15)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 16)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 17)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 18)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 19)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 20)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 21)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 22)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 23)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 24)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 25)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 26)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 27)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 28)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 29)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 30)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 31)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 32)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 33)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 34)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 35)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 36)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 37)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 38)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 39)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 40)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 41)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 42)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 43)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 44)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 45)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 46)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 47)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 48)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 49)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 50)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 51)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 52)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 53)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 54)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 55)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 56)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 57)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 58)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 59)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 60)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 61)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 62)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 63)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 64)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 65)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 66)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 67)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 68)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 69)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 70)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 71)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 72)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 73)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 74)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 75)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 76)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 77)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 78)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 79)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 80)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 81))