USE BENASXDATABASE
GO

CREATE TABLE [dbo].[Portfolio](
	 [Id]			UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[Name]			VARCHAR(200)		NOT NULL
	,CONSTRAINT [PK_PortfolioId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
 )

INSERT INTO 
	[dbo].[Portfolio] ([Name])

	VALUES
	('Ben Portfolio Account 1'), ('Dummy Portfolio 2'), ('Dummy Portfolio 3'), ('Dummy Portfolio 4'), ('Dummy Portfolio 5'), ('Dummy Portfolio 6')
