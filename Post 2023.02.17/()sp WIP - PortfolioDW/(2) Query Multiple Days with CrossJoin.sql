DECLARE @StartDate DATE = '2021-01-02';
DECLARE @EndDate DATE = '2022-12-10';
DECLARE @PortfolioName VARCHAR(200) = 'Bravo Griffith Stocks';


DECLARE @PortfolioId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @PortfolioName)

SELECT 
	 @PortfolioId			AS [PortfolioId]
	,[Dates].[DateKey]		AS [DateKey]
	,[func].*
FROM [dbo].[Dates] [Dates]


CROSS APPLY (
    SELECT *
    FROM [dbo].[funRETURN_PortfolioValueOnDate4] (@PortfolioName, [Dates].[DateKey])
) AS [func]
WHERE [Dates].[Date] BETWEEN @StartDate AND @EndDate

OPTION (maxrecursion 30000);
