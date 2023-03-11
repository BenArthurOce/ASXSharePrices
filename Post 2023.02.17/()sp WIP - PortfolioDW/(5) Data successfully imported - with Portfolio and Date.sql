DECLARE @StartDate DATE = '2019-01-02';
DECLARE @EndDate DATE = '2022-12-10';

DECLARE @MyList [dbo].[PortfolioList];
INSERT INTO @MyList VALUES ('Bravo Griffith Stocks')
INSERT INTO @MyList VALUES ('Mike Crotch Own Portfolio 2')
INSERT INTO @MyList VALUES ('Jimmys Safe Investing')
INSERT INTO @MyList VALUES ('Mike Crotch Own Portfolio 1')
INSERT INTO @MyList VALUES ('The Crotch Family Portfolio')
INSERT INTO @MyList VALUES ('Schutt Family Portfolio')
INSERT INTO @MyList VALUES ('Easy Investor')
INSERT INTO @MyList VALUES ('A Peterson Portfolio')
INSERT INTO @MyList VALUES ('Charlie Parsons Stocks')
INSERT INTO @MyList VALUES ('Jimmys Penny Stocks')
INSERT INTO @MyList VALUES ('Arthur Family Portfolio')
INSERT INTO @MyList VALUES ('Amantohugandkiss')
INSERT INTO @MyList VALUES ('Bens Stock Portfolio')
INSERT INTO @MyList VALUES ('Neds Safe Investing')
INSERT INTO @MyList VALUES ('Jimmys Renewerables')


DECLARE @COUNTER INT = 0;
DECLARE @MAX INT = (SELECT COUNT(*) FROM @MyList)
DECLARE @VALUE VARCHAR(50);
DECLARE @PortfolioId UNIQUEIDENTIFIER


WHILE @COUNTER < @MAX
BEGIN

	SET @VALUE = (SELECT [PortfolioName] FROM
			(SELECT (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) [index] , [PortfolioName] from @MyList) R 
			ORDER BY R.[index] OFFSET @COUNTER 
			ROWS FETCH NEXT 1 ROWS ONLY);

	INSERT INTO [dbo].[DW_PortfolioStandings] ([PortfolioId], [DateKey], [EntityId], [SectorId], [SharesOwned], [CostBase], [CostPerShare], [CurrentPrice], [MarketValue], [ProfitLoss], [ProfitLossPct], [WeightPct])

	SELECT 
		 [func].*
	FROM [dbo].[Dates] [Dates]

	CROSS APPLY (
		SELECT *
		FROM [dbo].[funRETURN_PortfolioValueOnDate5] (@VALUE, [Dates].[DateKey])
	) AS [func]
	WHERE [Dates].[Date] BETWEEN @StartDate AND @EndDate
	OPTION (maxrecursion 30000);


	SET @COUNTER = @COUNTER + 1

END
