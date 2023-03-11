-- Get the top 5 highest traded shares in Mar2021

DECLARE @RequestMonthYear BIGINT = 202103;


WITH AllPricesInMonth AS
(
	SELECT
		*
	FROM
		ASXSharePrices [ASXSharePrices]
	WHERE
		[ASXSharePrices].ASXDate LIKE '%' + LTRIM(RTRIM(@RequestMonthYear)) + '%'
)
SELECT
	[AllPricesInMonth].ASXCode										AS 'ASXCode'
	,CAST(ROUND(AVG([AllPricesInMonth].PriceOpen),3) AS MONEY)		AS 'PriceOpen'
	,CAST(ROUND(AVG([AllPricesInMonth].PriceHigh),3) AS MONEY)		AS 'PriceHigh'
	,CAST(ROUND(AVG([AllPricesInMonth].PriceLow) ,3) AS MONEY)		AS 'PriceLow'
	,CAST(ROUND(AVG([AllPricesInMonth].PriceClose),3) AS MONEY)		AS 'PriceClose'
	--,FORMAT(SUM([AllPricesInMonth].VolumeTraded), '###,###,###')	AS 'VolumeTraded'
	,SUM([AllPricesInMonth].VolumeTraded) AS 'VolumeTraded'
FROM 
	AllPricesInMonth [AllPricesInMonth]
GROUP BY
	[AllPricesInMonth].ASXCode
ORDER BY
	'VolumeTraded' DESC