USE BENASXDATABASE
GO

CREATE TABLE [dbo].[ShareTransactionTypes](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Type]					VARCHAR(200)		NOT NULL
 ,CONSTRAINT [PK_ShareTransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC)
 ON [PRIMARY]) ON [PRIMARY]


INSERT INTO [dbo].[TransactionTypes]([Type])
VALUES
	('Buy'), ('Sell'), ('DRP'), ('Other')

