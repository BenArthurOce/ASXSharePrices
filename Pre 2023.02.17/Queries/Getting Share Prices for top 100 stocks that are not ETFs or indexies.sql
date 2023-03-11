

CREATE TABLE #Top100Stocks
(
	  ASXCode NVARCHAR(10)
	 ,CompanyName NVARCHAR(300)
)

INSERT INTO #Top100Stocks
SELECT TOP 100 
	 [Prices].[ASXCode]
	,[Company].[Name]
FROM 
	[dbo].[ASXSharePrices] [Prices] 
	INNER JOIN [dbo].[TradingCompany] [Company] 
		ON [Company].ASXCode = [Prices].ASXCode 
		AND [Company].[Name] NOT LIKE '%ETF%'
		AND [Company].[Name] NOT LIKE '%S&P/ASX 200%'
		AND LEN([Prices].ASXCode) = 3
WHERE 
	[Prices].ASXDate = '20210630' 
ORDER BY [Prices].PriceClose DESC 

SELECT
	[Top100Stocks].ASXCode AS 'Code'
	,[Company].[Name] AS 'Company'
	,[2020Prices].PriceClose AS 'FY2020'
	,[2021Prices].PriceClose AS 'FY2021'
	,[2022Prices].PriceClose AS 'FY2022'
FROM #Top100Stocks [Top100Stocks]

INNER JOIN [dbo].[ASXSharePrices] [2020Prices] ON [2020Prices].ASXCode = [Top100Stocks].ASXCode AND [2020Prices].ASXDate = '20200630'
INNER JOIN [dbo].[ASXSharePrices] [2021Prices] ON [2021Prices].ASXCode = [Top100Stocks].ASXCode AND [2021Prices].ASXDate = '20210630'
INNER JOIN [dbo].[ASXSharePrices] [2022Prices] ON [2022Prices].ASXCode = [Top100Stocks].ASXCode AND [2022Prices].ASXDate = '20220630'
INNER JOIN [dbo].[TradingCompany] [Company] ON [Company].ASXCode = [Top100Stocks].ASXCode

ORDER BY [Top100Stocks].[ASXCode]



DROP TABLE #Top100Stocks
