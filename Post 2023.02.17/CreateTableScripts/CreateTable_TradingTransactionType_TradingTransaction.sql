--================================================================================================
--====================== CREATE TRANSACTIONS AND THEIR TYPES =======================================
--================================================================================================

USE BENASXDATABASE
GO

--Create Transaction Types
--================================
CREATE TABLE [dbo].[TradingTransactionType](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Name]					VARCHAR(50)			NOT NULL
 ,[isDeleted]				BIT					NOT NULL DEFAULT 0
 ,[isIncrease]				BIT					NOT NULL
 ,[isDecrease]				BIT					NOT NULL
 ,CONSTRAINT [PK_TradingTransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]) ON [PRIMARY]

 INSERT INTO [dbo].[TradingTransactionType]([Name], [isDeleted], [isIncrease], [isDecrease])
VALUES
	('Buy', 0, 1, 0), ('Sell', 0, 0, 1), ('DRP', 0, 1, 0), ('Other', 0, 0, 0)


--Create Trading Transactions
--================================
CREATE TABLE [dbo].[TradingTransaction](
	 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[SequenceNumber]			INT	IDENTITY(1,1)	NOT NULL 
	,[ContractNote]				VARCHAR(12)
	,[PortfolioId]				UNIQUEIDENTIFIER	NOT NULL
	,[TradingEntityId]			UNIQUEIDENTIFIER	NOT NULL
	,[Date]						INT					NOT NULL
	,[TradingTransactionTypeId]	UNIQUEIDENTIFIER	NOT NULL
	,[Quantity]					INT					NOT NULL
	,[UnitPrice]				DECIMAL(10,4)		NOT NULL
	,[TradeValue] AS ([Quantity] * [UnitPrice])	
	,[Brokerage]				DECIMAL(10,2)		NOT NULL
	,[TotalValue] AS (([Quantity] * [UnitPrice]) + [Brokerage])
	,[IsDeleted]				BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_TradingTransaction] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]

	,CONSTRAINT [FK_Portfolio_Id_TradingTransaction_PortfolioId]
		FOREIGN KEY ([PortfolioId]) 
		REFERENCES [Portfolio] ([Id])

	,CONSTRAINT [FK_TradingEntity_Id_TradingTransaction_TradingEntityId]
		FOREIGN KEY ([TradingEntityId]) 
		REFERENCES [TradingEntity] ([Id])

	,CONSTRAINT [FK_TradingTransactionType_Id_TradingTransaction_TradingTransactionTypeId]
		FOREIGN KEY ([TradingTransactionTypeId]) 
		REFERENCES [TradingTransactionType] ([Id])
	)


ALTER TABLE [TradingTransaction]
ADD CONSTRAINT [FK_Dates_DateKey_TradingTransaction_Date]
	FOREIGN KEY ([Date])
	REFERENCES [dbo].[Dates] ([DateKey])