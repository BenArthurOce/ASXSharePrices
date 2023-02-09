USE BENASXDATABASE
GO


-- -----------------------------------
--==============================================

CREATE TABLE [dbo].[DummyShareTransactionType](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Name]					VARCHAR(50)			NOT NULL
 ,[isDeleted]				BIT					NOT NULL
 ,CONSTRAINT [PK_DummyTransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC)
 ON [PRIMARY]) ON [PRIMARY]

INSERT INTO [dbo].[DummyShareTransactionType]([Name], [isDeleted])
VALUES
	('Buy', 0), ('Sell', 0), ('DRP', 0), ('Other', 0)




-- -----------------------------------
--==============================================


--Create Share Transactions
--================================
CREATE TABLE [dbo].[DummyShareTransaction](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[SequenceNumber]	INT	IDENTITY(1,1)	NOT NULL 
	,[ContractNote]		VARCHAR(12)
	,[PortfolioId]		UNIQUEIDENTIFIER	NOT NULL
	,[CompanyId]		UNIQUEIDENTIFIER	NOT NULL
	,[Date]				INT					NOT NULL
	,[TypeId]			UNIQUEIDENTIFIER	NOT NULL
	,[Quantity]			INT					NOT NULL
	,[UnitPrice]		DECIMAL(10,4)		NOT NULL
	,[TradeValue] AS ([Quantity] * [UnitPrice])	
	,[Brokerage]		DECIMAL(10,2)		NOT NULL
	,[TotalValue] AS (([Quantity] * [UnitPrice]) + [Brokerage])
	,[IsIncrease]		BIT					NOT NULL
	,[IsDeleted]		BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_DummyShareTransactionId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]

	,CONSTRAINT [FK_DummyPortfolio_DummyShareTransaction_PortfolioId]
		FOREIGN KEY ([PortfolioId]) 
		REFERENCES [DummyPortfolio] ([Id])

	,CONSTRAINT [FK_DummyTradingCompany_DummyShareTransaction_CompanyId]
		FOREIGN KEY ([CompanyId]) 
		REFERENCES [DummyTradingCompany] ([Id])

	,CONSTRAINT [FK_DummyShareTransactionType_DummyShareTransaction_TypeId]
		FOREIGN KEY ([TypeId]) 
		REFERENCES [DummyShareTransactionType] ([Id])

	)




--Arthur Family Portfolio
INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000A0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CIA'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 50, 4.92, 29.99, 0, 0),
('DUM00000A1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PNV'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 126, 1.65, 29.99, 0, 0),
('DUM00000A2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CSR'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 67, 5.69, 29.99, 0, 0),
('DUM00000A3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CIA'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 45, 4.51, 29.99, 0, 0),
('DUM00000A4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BRG'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 75, 29.6, 29.99, 0, 0),
('DUM00000A5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'AZJ'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 99, 3.44, 29.99, 0, 0),
('DUM00000A6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PNV'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 89, 1.425, 29.99, 0, 0),
('DUM00000A7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CSR'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 61, 5.69, 29.99, 0, 0),
('DUM00000A8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BRG'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 53, 30.67, 29.99, 0, 0),
('DUM00000A9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'AZJ'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 90, 3.49, 29.99, 0, 0),
('DUM00000A10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'AZJ'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 18, 3.64, 29.99, 0, 0),
('DUM00000A11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CSR'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 32, 5.64, 29.99, 0, 0),
('DUM00000A12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ORI'), 20220208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 32, 14.85, 29.99, 0, 0)


--Bens Stock Portfolio
INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000B0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IEL'), 20210915, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 72, 32.86, 29.99, 0, 0),
('DUM00000B1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PBH'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 60, 9.84, 29.99, 0, 0),
('DUM00000B2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 135, 310.95, 29.99, 0, 0),
('DUM00000B3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IEL'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 44, 34.79, 29.99, 0, 0),
('DUM00000B4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MGF'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 108, 1.745, 29.99, 0, 0),
('DUM00000B5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BOQ'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 113, 8.73, 29.99, 0, 0),
('DUM00000B6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PBH'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 42, 7.12, 29.99, 0, 0),
('DUM00000B7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 81, 336.5, 29.99, 0, 0),
('DUM00000B8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MGF'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 76, 1.8, 29.99, 0, 0),
('DUM00000B9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BOQ'), 20220117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 102, 8.31, 29.99, 0, 0),
('DUM00000B10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BOQ'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 21, 7.82, 29.99, 0, 0),
('DUM00000B11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 39, 304.78, 29.99, 0, 0),
('DUM00000B12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NUF'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 30, 5.55, 29.99, 0, 0)

--Schutt Family Portfolio
INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000C0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TLS'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 101, 3.9, 29.99, 0, 0),
('DUM00000C1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'LNK'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 51, 4.25, 29.99, 0, 0),
('DUM00000C2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NHF'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 127, 6.74, 29.99, 0, 0),
('DUM00000C3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TLS'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 91, 3.93, 29.99, 0, 0),
('DUM00000C4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MIN'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 52, 44.92, 29.99, 0, 0),
('DUM00000C5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ILU'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 63, 9.98, 29.99, 0, 0),
('DUM00000C6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'LNK'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 41, 5.53, 29.99, 0, 0),
('DUM00000C7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NHF'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 102, 6.38, 29.99, 0, 0),
('DUM00000C8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MIN'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 32, 45.32, 29.99, 0, 0),
('DUM00000C9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ILU'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 51, 10.69, 29.99, 0, 0),
('DUM00000C10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ILU'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 11, 10.69, 29.99, 0, 0),
('DUM00000C11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NHF'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 33, 6.67, 29.99, 0, 0),
('DUM00000C12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RRL'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 33, 1.905, 29.99, 0, 0)

--Easy Investor

INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000D0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MTS'), 20210908, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 146, 4.02, 29.99, 0, 0),
('DUM00000D1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ALD'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 107, 27.36, 29.99, 0, 0),
('DUM00000D2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'COL'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 95, 16.63, 29.99, 0, 0),
('DUM00000D3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MTS'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 103, 3.96, 29.99, 0, 0),
('DUM00000D4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RWC'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 145, 5.44, 29.99, 0, 0),
('DUM00000D5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ABP'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 60, 3.53, 29.99, 0, 0),
('DUM00000D6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ALD'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 86, 30.64, 29.99, 0, 0),
('DUM00000D7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'COL'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 67, 17.74, 29.99, 0, 0),
('DUM00000D8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RWC'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 102, 6.36, 29.99, 0, 0),
('DUM00000D9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ABP'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 48, 3.75, 29.99, 0, 0),
('DUM00000D10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ABP'), 20220117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 5, 3.64, 29.99, 0, 0),
('DUM00000D11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'COL'), 20220124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 33, 16.33, 29.99, 0, 0),
('DUM00000D12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ALL'), 20220215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 30, 40.14, 29.99, 0, 0)



INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000E0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IRE'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 89, 11.73, 29.99, 0, 0),
('DUM00000E1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'DHG'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 119, 5.68, 29.99, 0, 0),
('DUM00000E2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MP1'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 101, 16.57, 29.99, 0, 0),
('DUM00000E3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IRE'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 72, 12.13, 29.99, 0, 0),
('DUM00000E4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PBH'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 62, 8.84, 29.99, 0, 0),
('DUM00000E5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RHC'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 108, 67.54, 29.99, 0, 0),
('DUM00000E6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'DHG'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 96, 5.41, 29.99, 0, 0),
('DUM00000E7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MP1'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 91, 20.59, 29.99, 0, 0),
('DUM00000E8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PBH'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 44, 7.05, 29.99, 0, 0),
('DUM00000E9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RHC'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 76, 67.25, 29.99, 0, 0),
('DUM00000E10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'RHC'), 20220117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 8, 67.34, 29.99, 0, 0),
('DUM00000E11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MP1'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 39, 13.66, 29.99, 0, 0),
('DUM00000E12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'OZL'), 20220215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 38, 25.74, 29.99, 0, 0)




INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000F0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20210908, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 77, 5, 29.99, 0, 0),
('DUM00000F1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'COH'), 20210915, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 73, 234.72, 29.99, 0, 0),
('DUM00000F2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TAH'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 140, 4.81, 29.99, 0, 0),
('DUM00000F3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 54, 4.71, 29.99, 0, 0),
('DUM00000F4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PMV'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 111, 30.17, 29.99, 0, 0),
('DUM00000F5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ZIM'), 20211103, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 92, 22.4, 29.99, 0, 0),
('DUM00000F6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'COH'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 44, 228.54, 29.99, 0, 0),
('DUM00000F7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TAH'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 98, 4.97, 29.99, 0, 0),
('DUM00000F8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PMV'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 89, 31.8, 29.99, 0, 0),
('DUM00000F9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ZIM'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 83, 21.58, 29.99, 0, 0),
('DUM00000F10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ZIM'), 20220117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 9, 23.8, 29.99, 0, 0),
('DUM00000F11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TAH'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 30, 5, 29.99, 0, 0),
('DUM00000F12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARB'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 32, 41.44, 29.99, 0, 0)


INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000G0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'WTC'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 141, 52.15, 29.99, 0, 0),
('DUM00000G1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MQG'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 61, 177.71, 29.99, 0, 0),
('DUM00000G2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CIA'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 63, 4.74, 29.99, 0, 0),
('DUM00000G3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'WTC'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 127, 53, 29.99, 0, 0),
('DUM00000G4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IAG'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 52, 4.49, 29.99, 0, 0),
('DUM00000G5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 62, 328.97, 29.99, 0, 0),
('DUM00000G6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MQG'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 43, 203.8, 29.99, 0, 0),
('DUM00000G7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CIA'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 57, 5.11, 29.99, 0, 0),
('DUM00000G8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IAG'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 47, 4.26, 29.99, 0, 0),
('DUM00000G9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 50, 328.62, 29.99, 0, 0),
('DUM00000G10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 10, 310.01, 29.99, 0, 0),
('DUM00000G11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CIA'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 39, 6.34, 29.99, 0, 0),
('DUM00000G12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ALX'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 37, 6.52, 29.99, 0, 0)



INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000H0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TYR'), 20210908, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 111, 4.08, 29.99, 0, 0),
('DUM00000H1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20210915, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 140, 4.84, 29.99, 0, 0),
('DUM00000H2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JHX'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 146, 53.81, 29.99, 0, 0),
('DUM00000H3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TYR'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 100, 3.88, 29.99, 0, 0),
('DUM00000H4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BRG'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 135, 26.81, 29.99, 0, 0),
('DUM00000H5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JBH'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 136, 46.83, 29.99, 0, 0),
('DUM00000H6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 84, 4.55, 29.99, 0, 0),
('DUM00000H7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JHX'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 117, 54.77, 29.99, 0, 0),
('DUM00000H8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BRG'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 81, 30.28, 29.99, 0, 0),
('DUM00000H9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JBH'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 82, 48.14, 29.99, 0, 0),
('DUM00000H10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JBH'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 17, 46, 29.99, 0, 0),
('DUM00000H11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'JHX'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 36, 55.3, 29.99, 0, 0),
('DUM00000H12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'LFS'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 33, 2.15, 29.99, 0, 0)


INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000I0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CWY'), 20210915, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 84, 2.57, 29.99, 0, 0),
('DUM00000I1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARG'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 107, 8.91, 29.99, 0, 0),
('DUM00000I2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VGS'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 105, 100.7, 29.99, 0, 0),
('DUM00000I3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CWY'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 76, 2.71, 29.99, 0, 0),
('DUM00000I4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IPL'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 102, 3.09, 29.99, 0, 0),
('DUM00000I5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SHL'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 89, 39.37, 29.99, 0, 0),
('DUM00000I6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARG'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 86, 9.54, 29.99, 0, 0),
('DUM00000I7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VGS'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 95, 106.01, 29.99, 0, 0),
('DUM00000I8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'IPL'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 82, 3.37, 29.99, 0, 0),
('DUM00000I9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SHL'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 72, 38.29, 29.99, 0, 0),
('DUM00000I10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SHL'), 20220208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 15, 37.89, 29.99, 0, 0),
('DUM00000I11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VGS'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 37, 98.05, 29.99, 0, 0),
('DUM00000I12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SNZ'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 39, 11.35, 29.99, 0, 0)



INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
	VALUES
('DUM00000J0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MGR'), 20210908, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 140, 3.02, 29.99, 0, 0),
('DUM00000J1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ASX'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 66, 82.88, 29.99, 0, 0),
('DUM00000J2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MCY'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 119, 6.19, 29.99, 0, 0),
('DUM00000J3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MGR'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 84, 2.85, 29.99, 0, 0),
('DUM00000J4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 120, 4.55, 29.99, 0, 0),
('DUM00000J5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARB'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 99, 48.78, 29.99, 0, 0),
('DUM00000J6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ASX'), 20211103, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 53, 88.11, 29.99, 0, 0),
('DUM00000J7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MCY'), 20211124, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 96, 5.72, 29.99, 0, 0),
('DUM00000J8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 96, 4.77, 29.99, 0, 0),
('DUM00000J9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARB'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 60, 51.86, 29.99, 0, 0),
('DUM00000J10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ARB'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 6, 51.34, 29.99, 0, 0),
('DUM00000J11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MCY'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 30, 5.73, 29.99, 0, 0),
('DUM00000J12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'HLS'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 31, 4.99, 29.99, 0, 0)



INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000K0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'FPH'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 98, 29.88, 29.99, 0, 0),
('DUM00000K1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SUL'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 101, 11.49, 29.99, 0, 0),
('DUM00000K2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BHP'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 71, 37.59, 29.99, 0, 0),
('DUM00000K3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'FPH'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 59, 29.36, 29.99, 0, 0),
('DUM00000K4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ELD'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 86, 12, 29.99, 0, 0),
('DUM00000K5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NUF'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 131, 5.16, 29.99, 0, 0),
('DUM00000K6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SUL'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 81, 13.35, 29.99, 0, 0),
('DUM00000K7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BHP'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 50, 40.69, 29.99, 0, 0),
('DUM00000K8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ELD'), 20211231, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 52, 12.26, 29.99, 0, 0),
('DUM00000K9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NUF'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 105, 4.86, 29.99, 0, 0),
('DUM00000K10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NUF'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 11, 4.58, 29.99, 0, 0),
('DUM00000K11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BHP'), 20220215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 32, 48.18, 29.99, 0, 0),
('DUM00000K12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'PTM'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 32, 2.42, 29.99, 0, 0)


INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000L0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'QUB'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 91, 3.27, 29.99, 0, 0),
('DUM00000L1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'YAL'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 98, 4, 29.99, 0, 0),
('DUM00000L2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SGM'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 150, 14.05, 29.99, 0, 0),
('DUM00000L3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'QUB'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 82, 3.21, 29.99, 0, 0),
('DUM00000L4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SUN'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 139, 11.11, 29.99, 0, 0),
('DUM00000L5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 68, 333.12, 29.99, 0, 0),
('DUM00000L6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'YAL'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 89, 2.59, 29.99, 0, 0),
('DUM00000L7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SGM'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 90, 15.42, 29.99, 0, 0),
('DUM00000L8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SUN'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 98, 11.56, 29.99, 0, 0),
('DUM00000L9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 48, 320.58, 29.99, 0, 0),
('DUM00000L10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 10, 316.76, 29.99, 0, 0),
('DUM00000L11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SGM'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 35, 18.46, 29.99, 0, 0),
('DUM00000L12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BWP'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 38, 3.98, 29.99, 0, 0)


INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000M0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TPG'), 20210922, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 135, 6.6, 29.99, 0, 0),
('DUM00000M1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ASX'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 110, 80.89, 29.99, 0, 0),
('DUM00000M2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MFG'), 20211006, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 56, 32.52, 29.99, 0, 0),
('DUM00000M3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'TPG'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 108, 6.91, 29.99, 0, 0),
('DUM00000M4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'EVT'), 20211020, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 106, 15.6, 29.99, 0, 0),
('DUM00000M5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 117, 327.48, 29.99, 0, 0),
('DUM00000M6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'ASX'), 20211201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 99, 90.37, 29.99, 0, 0),
('DUM00000M7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MFG'), 20211215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 45, 28.78, 29.99, 0, 0),
('DUM00000M8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'EVT'), 20220110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 85, 14.05, 29.99, 0, 0),
('DUM00000M9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220201, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 94, 320.58, 29.99, 0, 0),
('DUM00000M10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VTS'), 20220215, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 10, 311.95, 29.99, 0, 0),
('DUM00000M11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MFG'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 38, 17.74, 29.99, 0, 0),
('DUM00000M12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'SGM'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 31, 18.46, 29.99, 0, 0)


INSERT INTO [dbo].[DummyShareTransaction]
	([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsIncrease], [IsDeleted])
VALUES
('DUM00000N0', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MFG'), 20210929, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 148, 35.7, 29.99, 0, 0),
('DUM00000N1', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CAR'), 20211013, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 128, 24.56, 29.99, 0, 0),
('DUM00000N2', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'WTC'), 20211027, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 145, 53, 29.99, 0, 0),
('DUM00000N3', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'MFG'), 20211110, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 104, 34.27, 29.99, 0, 0),
('DUM00000N4', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VUK'), 20211117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 115, 3.16, 29.99, 0, 0),
('DUM00000N5', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NAB'), 20211208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 97, 28.63, 29.99, 0, 0),
('DUM00000N6', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'CAR'), 20211222, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 103, 25.17, 29.99, 0, 0),
('DUM00000N7', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'WTC'), 20220117, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 131, 54.09, 29.99, 0, 0),
('DUM00000N8', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'VUK'), 20220208, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 69, 3.78, 29.99, 0, 0),
('DUM00000N9', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NAB'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 78, 29.37, 29.99, 0, 0),
('DUM00000N10', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'NAB'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'SELL'), 16, 29.37, 29.99, 0, 0),
('DUM00000N11', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'WTC'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 30, 45.64, 29.99, 0, 0),
('DUM00000N12', (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks'), (SELECT [Id] FROM [DummyTradingCompany] WHERE [ASXCode] = 'BOQ'), 20220301, (SELECT [Id] FROM [DummyShareTransactionType] WHERE [Name] = 'BUY'), 38, 8.05, 29.99, 0, 0)