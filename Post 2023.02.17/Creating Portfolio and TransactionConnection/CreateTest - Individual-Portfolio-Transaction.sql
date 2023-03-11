
USE BENASXDATABASE
GO

-- -----------------------------------
--==============================================

CREATE TABLE [dbo].[DummyIndividual](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[CustomerNumber]	INT					IDENTITY(1000,1) 
	,[FirstName]		VARCHAR(50)			NOT NULL
	,[LastName]			VARCHAR(50)			NOT NULL
	,[SearchName] AS [FirstName] + [LastName]
	,[HIN]				VARCHAR(13)			NOT NULL
	,[Postcode]			INT					NOT NULL
	,[isDeleted]		BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_DummyIndividualId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY])


INSERT INTO 
	[dbo].[DummyIndividual] ([FirstName], [LastName], [HIN], [Postcode], [isDeleted])

	VALUES
	 ('Ben', 'Arthur', 1000000000000, 3216, 0)
	,('Benetta', 'Arthur', 1000000000000, 3216, 0)
	,('Anita', 'Schitt',1000000000000, 5723, 0)
	,('Robert', 'Schitt',1000000000000, 4870, 0)
	,('Amanda', 'HuginKiss',1000000000000, 2872, 0)
	,('Ned', 'Flanders',1000000000000, 4005, 0)
	,('Mike', 'Crotch',1000000000000, 3175, 0)
	,('Mary', 'Crotch',1000000000000, 7004, 0)
	,('Jimmy', 'Crackalakadoo', 1000000000000, 3305, 0)
	,('Alpha', 'Peterson', 1000000000000, 4627, 0)
	,('Bravo', 'Griffith', 1000000000000, 5440, 0)
	,('Charlie', 'Parsons', 100000000000, 6375, 0)


-- -----------------------------------
--==============================================

CREATE TABLE [dbo].[DummyPortfolio](
	 [Id]					UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[PortfolioIdNumber]	INT					IDENTITY(1,1) 
	,[Name]					VARCHAR(200)		NOT NULL
	,[isDeleted]			BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_DummyPortfolioId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
 )

INSERT INTO 
	[dbo].[DummyPortfolio] ([Name], [isDeleted])

	VALUES
	 ('Arthur Family Portfolio', 0)
	,('Bens Stock Portfolio', 0)
	,('Schutt Family Portfolio', 0)
	,('Easy Investor', 0)
	,('Amantohugandkiss', 0)
	,('Neds Safe Investing', 0)
	,('The Crotch Family Portfolio', 0)
	,('Mike Crotch Own Portfolio 1', 0)
	,('Mike Crotch Own Portfolio 2', 0)
	,('Jimmys Safe Investing', 0)
	,('Jimmys Penny Stocks', 0)
	,('Jimmys Renewerables', 0)
	,('A Peterson Portfolio', 0)
	,('Bravo Griffith Stocks', 0)
	,('Charlie Parsons Stocks', 0)


-- -----------------------------------
--==============================================

CREATE TABLE [dbo].[DummyConnectorIndividualsPortfolios](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[DummyIndividualId]		UNIQUEIDENTIFIER	NOT NULL
	,[DummyPortfolioId]		UNIQUEIDENTIFIER	NOT NULL
	,CONSTRAINT [PK_DummyConnectorIndividualsPortfoliosId] PRIMARY KEY ([DummyIndividualId], [DummyPortfolioId])

	,CONSTRAINT [FK_DummyIndividual_DummyConnectorIndividualsPortfolios_Id]
		FOREIGN KEY ([DummyIndividualId]) 
		REFERENCES [DummyIndividual] ([Id])

	 ,CONSTRAINT [FK_DummyPortfolio_DummyConnectorIndividualsPortfolios_Id]
			FOREIGN KEY ([DummyPortfolioId]) 
			REFERENCES [DummyPortfolio] ([Id])
	 )

INSERT INTO 
	[dbo].[DummyConnectorIndividualsPortfolios] ([DummyIndividualId], [DummyPortfolioId])

	VALUES

	--Arthur Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'BenArthur'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'BenettaArthur'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Arthur Family Portfolio')
	),

	--Bens Stock Portfolio
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'BenArthur'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bens Stock Portfolio')
	),

	--Schutt Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'AnitaSchitt'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'RobertSchitt'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Schutt Family Portfolio')
	),

	--Easy Investor
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'RobertSchitt'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Easy Investor')
	),

	--Amantohugandkiss
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'AmandaHuginKiss'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Amantohugandkiss')
	),

	--Neds Safe Investing
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'NedFlanders'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Neds Safe Investing')
	),
	--The Crotch Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'MaryCrotch'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'The Crotch Family Portfolio')
	),
	--Mike Crotch Own Portfolio 1
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1')
	),
	--Mike Crotch Own Portfolio 2
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2')
	),
	--Jimmys Safe Investing
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Safe Investing')
	),
	--Jimmys Penny Stocks
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Penny Stocks')
	),
	--Jimmys Renewerables
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Jimmys Renewerables')
	),
	--A Peterson Portfolio
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'AlphaPeterson'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'A Peterson Portfolio')
	),
	--Bravo Griffith Stocks
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'BravoGriffith'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Bravo Griffith Stocks')
	),
	--Charlie Parsons Stocks
	(
		(SELECT [Id] FROM [dbo].[DummyIndividual] WHERE [SearchName] = 'CharlieParsons'),
		(SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = 'Charlie Parsons Stocks')
	)