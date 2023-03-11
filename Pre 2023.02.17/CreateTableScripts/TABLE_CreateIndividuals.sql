USE BENASXDATABASE
GO

CREATE TABLE [dbo].[Individuals](
	 [Id]			UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[FirstName]	VARCHAR(40)			NOT NULL
	,[LastName]		VARCHAR(40)			NOT NULL
	,[Hin]			INT					NOT NULL
	,[Email]		VARCHAR(50)			NOT NULL
	,CONSTRAINT [PK_PortfolioId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
 )

INSERT INTO 
	[dbo].[Portfolio] ([Name])

	VALUES
	('Ben Portfolio Account 1'), ('Dummy Portfolio 2'), ('Dummy Portfolio 3'), ('Dummy Portfolio 4'), ('Dummy Portfolio 5'), ('Dummy Portfolio 6')
