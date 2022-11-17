DECLARE @RequestCode NVARCHAR(10) = 'CBA'

CREATE TABLE #TempASXTable
(
	 ASXCode NVARCHAR(10)
	,ASXDate BIGINT
	,PriceOpen FLOAT
	,PriceHigh FLOAT
	,PriceLow FLOAT
	,PriceClose FLOAT
	,VolTraded FLOAT
)

INSERT INTO #TempASXTable

SELECT
	 [ASXSharePrices].ASXCode
	,[ASXSharePrices].ASXDate
	,[ASXSharePrices].PriceOpen
	,[ASXSharePrices].PriceHigh
	,[ASXSharePrices].PriceLow
	,[ASXSharePrices].PriceClose
	,[ASXSharePrices].VolumeTraded
FROM
	[ASXSharePrices] [ASXSharePrices]
WHERE
	[ASXSharePrices].ASXCode = @RequestCode


--SELECT * FROM #TempASXTable

SELECT	*
FROM	#TempASXTable
WHERE	PriceClose = ( SELECT MAX(PriceClose) FROM #TempASXTable)

UNION

SELECT	*
FROM	#TempASXTable
WHERE	PriceClose = ( SELECT MIN(PriceClose) FROM #TempASXTable)




DROP TABLE #TempASXTable