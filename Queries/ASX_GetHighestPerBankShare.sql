--Get all the bank shares
--Return the all time highest for each share that is a bank share

SELECT
	[Names].ASXCode				AS 'ASXCode'
	,MAX([Prices].PriceClose)	AS 'HighestPrice'
FROM
	[dbo].[ASXSharePrices] [Prices]
	INNER JOIN [dbo].[ASXCompanies] [Names] ON [Names].ASXCode = [Prices].ASXCode
	INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [Prices].ASXDate
WHERE
	[Names].GICsIndustryGroup = 'Banks'
GROUP BY
	[Names].ASXCode
ORDER BY 'HighestPrice' DESC


--Repeat but what date was the highest?

SELECT
	 [DerivedTable].ASXCode
	,[DerivedTable].PriceClose
	,[DerivedTable].DateString
FROM
	(
		SELECT
			[Names].ASXCode				AS 'ASXCode'
			,[Prices].PriceClose		AS 'PriceClose'
			,[Dates].FullDayStringLong	AS 'DateString'
			,RANK() OVER (
							PARTITION BY [Names].ASXCode	
							ORDER BY [Prices].PriceClose DESC
							)			AS 'RankPos'
		FROM
			[dbo].[ASXSharePrices] [Prices]
			INNER JOIN [dbo].[ASXCompanies] [Names] ON [Names].ASXCode = [Prices].ASXCode
			INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [Prices].ASXDate
		WHERE
			[Names].GICsIndustryGroup = 'Banks'
	) AS [DerivedTable]

WHERE
	[DerivedTable].RankPos = 1
ORDER BY
	[DerivedTable].ASXCode ASC