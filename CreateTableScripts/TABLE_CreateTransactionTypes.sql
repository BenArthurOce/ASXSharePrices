USE BENASXDATABASE
GO

CREATE TABLE [dbo].[TransactionTypes](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Type]					VARCHAR(200)		NOT NULL
 ,CONSTRAINT [PK_TransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC)
 ON [PRIMARY]) ON [PRIMARY]


INSERT INTO [dbo].[TransactionTypes]([Type])
VALUES
	('Buy'), ('Sell'), ('DRP'), ('Other')

