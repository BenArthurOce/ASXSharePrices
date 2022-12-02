DECLARE
	 @StartDate INT = 20220101
	,@EndDate INT = 20220630

SELECT
	*
FROM
	[ASXSharePrices] [Prices]
WHERE
	[Prices].ASXDate BETWEEN @StartDate AND @EndDate
ORDER BY
	 [Prices].ASXDate
	,[Prices].ASXCode