DECLARE
	 @StartDate INT = 20220101
	,@EndDate INT = 20220630
	,@RequiredCode NVARCHAR(6) = 'CBA'

SELECT
	*
FROM
	[ASXEODPrice] [Prices]
WHERE
	[Prices].[Date] BETWEEN @StartDate AND @EndDate
	AND [Prices].[ASXCode] = @RequiredCode
ORDER BY
	 [Prices].[Date]
	,[Prices].[ASXCode]