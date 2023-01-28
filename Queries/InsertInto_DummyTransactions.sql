

INSERT INTO [dbo].[ShareTransaction] ([ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease])
VALUES
(240115545, 'CBA', 20200916, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 175, 61.44, 10752, 29.95, 10781.95, 1),
(147783187, 'CBA', 20210113, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 200, 85.22, 17044, 19.95, 17063.95, 1),
(221285969, 'CBA', 20210129, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 200, 99.99, 19998, 19.95, 20017.95, 1),
(576811833, 'CBA', 20210129, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 300, 83, 24900, 11, 24911, 0),
(575048915, 'DMP', 20210410, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 49, 17.08, 836.92, 11, 847.92, 1),
(671278172, 'DMP', 20210623, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 39, 21.84, 851.76, 11, 862.76, 1),
(464544124, 'CBA', 20210631, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 92, 9.09, 836.28, 11, 847.28, 1),
(592097566, 'BHP', 20210915, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 50, 60, 3000, 11, 3011, 1),
(326234951, 'BHP', 20211105, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 50, 52, 2600, 11, 2611, 0),
(405405227, 'DMP', 20211105, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 88, 22, 1936, 19.95, 1955.95, 0),
(53281345, 'CBA', 20211105, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 300, 3.8, 1140, 19.95, 1159.95, 1),
(881011663, 'CBA', 20211106, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 150, 71.88, 10782, 19.95, 10801.95, 0),
(494934522, 'CBA', 20211109, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 73.66, 36830, 19.95, 36849.95, 1)

DECLARE
	@BensPorfolioExample UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = 'Dummy Portfolio 2')


INSERT INTO [dbo].[PortfolioShareTransactionConnector] (PortfolioId, ShareTransactionId)
VALUES


(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 82)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 83)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 84)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 85)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 86)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 87)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 88)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 89)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 90)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 91)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 92)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 93)),
(@BensPorfolioExample, (SELECT [Id] FROM [ShareTransaction] WHERE [ShareTransaction].[SequenceNumber] = 94))