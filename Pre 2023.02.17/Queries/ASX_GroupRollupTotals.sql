-- Only get banking shares. For this exercise, we do not have an industy joining table
-- rollup


SELECT
	 ISNULL([ASXSharePrices].ASXCode, 'Total') AS 'ASXCode'
	,SUM([ASXSharePrices].PriceOpen) AS 'PriceOpen'
	,SUM([ASXSharePrices].PriceHigh) AS 'PriceHigh'
	,SUM([ASXSharePrices].PriceLow) AS 'PriceLow'
	,SUM([ASXSharePrices].PriceClose) AS 'PriceClose'
	,SUM([ASXSharePrices].VolumeTraded) AS 'VolumeTraded'
	,[Dates].FullDayStringLong AS 'Date'

FROM
	[dbo].[ASXSharePrices] [ASXSharePrices]
	INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [ASXSharePrices].ASXDate
WHERE
	[ASXSharePrices].ASXCode IN ('ANZ', 'CBA', 'NAB', 'WBC', 'BEN', 'BOQ')
GROUP BY
	 [ASXSharePrices].ASXCode	-- WITH ROLLUP
	 ,[Dates].FullDayStringLong
ORDER BY
	[ASXSharePrices].ASXCode ASC