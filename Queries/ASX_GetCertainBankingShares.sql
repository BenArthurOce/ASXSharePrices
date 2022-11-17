-- Only get banking shares. For this exercise, we do not have an industy joining table

SELECT
	*
	,[ASXSharePrices].Id
	,[ASXSharePrices].RecordNum
	,[ASXSharePrices].ASXCode
	,[ASXSharePrices].ASXDate
	,[ASXSharePrices].PriceOpen
	,[ASXSharePrices].PriceHigh
	,[ASXSharePrices].PriceLow
	,[ASXSharePrices].PriceClose
	,[ASXSharePrices].VolumeTraded
FROM
	ASXSharePrices [ASXSharePrices]
WHERE
	[ASXSharePrices].ASXCode IN ('ANZ', 'CBA', 'NAB', 'WBC', 'BEN', 'BOQ')