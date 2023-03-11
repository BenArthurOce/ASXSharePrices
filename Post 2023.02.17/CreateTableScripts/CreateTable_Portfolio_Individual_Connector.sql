
USE BENASXDATABASE
GO

-- -----------------------------------
--==============================================

CREATE TABLE [dbo].[Individual](
	 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[IndividualCustomerNumber]	INT					IDENTITY(1000,1) 
	,[FirstName]				VARCHAR(50)			NOT NULL
	,[LastName]					VARCHAR(50)			NOT NULL
	,[SearchName] AS [FirstName] + [LastName]
	,[HIN]						VARCHAR(13)			NOT NULL
	,[Postcode]					INT					NOT NULL
	,[isDeleted]				BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_IndividualId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY])

INSERT INTO 
	[dbo].[Individual] ([FirstName], [LastName], [HIN], [Postcode], [isDeleted])

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

CREATE TABLE [dbo].[Portfolio](
	 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[PortfolioCustomerNumber]	INT					IDENTITY(1,1) 
	,[Name]						VARCHAR(200)		NOT NULL
	,[isDeleted]				BIT					NOT NULL DEFAULT 0
	,CONSTRAINT [PK_PortfolioId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
 )

INSERT INTO 
	[dbo].[Portfolio] ([Name], [isDeleted])

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

CREATE TABLE [dbo].[ConnectorIndividualsPortfolios](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[IndividualId]		UNIQUEIDENTIFIER	NOT NULL
	,[PortfolioId]		UNIQUEIDENTIFIER	NOT NULL
	,CONSTRAINT [PK_ConnectorIndividualsPortfoliosId] PRIMARY KEY ([IndividualId], [PortfolioId])

	,CONSTRAINT [FK_Individual_Id_ConnectorIndividualsPortfolios_IndividualId]
		FOREIGN KEY ([IndividualId]) 
		REFERENCES [Individual] ([Id])

	 ,CONSTRAINT [FK_Portfolio_Id_ConnectorIndividualsPortfolios_PortfolioId]
			FOREIGN KEY ([PortfolioId]) 
			REFERENCES [Portfolio] ([Id])
	 )

INSERT INTO 
	[dbo].[ConnectorIndividualsPortfolios] ([IndividualId], [PortfolioId])

	VALUES

	--Arthur Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'BenArthur'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Arthur Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'BenettaArthur'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Arthur Family Portfolio')
	),

	--Bens Stock Portfolio
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'BenArthur'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Bens Stock Portfolio')
	),

	--Schutt Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'AnitaSchitt'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Schutt Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'RobertSchitt'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Schutt Family Portfolio')
	),

	--Easy Investor
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'RobertSchitt'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Easy Investor')
	),

	--Amantohugandkiss
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'AmandaHuginKiss'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Amantohugandkiss')
	),

	--Neds Safe Investing
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'NedFlanders'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Neds Safe Investing')
	),
	--The Crotch Family Portfolio
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'The Crotch Family Portfolio')
	),

	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'MaryCrotch'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'The Crotch Family Portfolio')
	),
	--Mike Crotch Own Portfolio 1
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 1')
	),
	--Mike Crotch Own Portfolio 2
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'MikeCrotch'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Mike Crotch Own Portfolio 2')
	),
	--Jimmys Safe Investing
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Jimmys Safe Investing')
	),
	--Jimmys Penny Stocks
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Jimmys Penny Stocks')
	),
	--Jimmys Renewerables
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'JimmyCrackalakadoo'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Jimmys Renewerables')
	),
	--A Peterson Portfolio
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'AlphaPeterson'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'A Peterson Portfolio')
	),
	--Bravo Griffith Stocks
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'BravoGriffith'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Bravo Griffith Stocks')
	),
	--Charlie Parsons Stocks
	(
		(SELECT [Id] FROM [dbo].[Individual] WHERE [SearchName] = 'CharlieParsons'),
		(SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = 'Charlie Parsons Stocks')
	)