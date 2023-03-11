DECLARE
	 @StartDate INT = 20211231
	,@EndDate INT = 20220630
	,@RequiredCode NVARCHAR(6) = 'CBA'


SELECT
 [Dates].[DateKey] 
,[Dates].[Date] 
,[Prices1].[ASXCode]
,[Prices1].[PriceOpen]
,[Prices1].[PriceHigh]
,[Prices1].[PriceLow]
,[Prices1].[PriceClose]
,[Prices1].[VolumeTraded]
,COALESCE(
	-- Coalesce Argument 1
	[Prices1].[PriceOpen]

	-- Coalesce Argument 2
	,(
		SELECT TOP 1
			(([Prices2].[PriceOpen] * 1.0 / LEAD([Prices2].[PriceOpen]) OVER (PARTITION BY [Prices2].[ASXCode] ORDER BY [Prices2].[Date])) + 1) / 2 * LEAD([Prices2].[PriceOpen]) OVER (PARTITION BY [Prices2].[ASXCode] ORDER BY [Prices2].[Date])
		FROM
			[dbo].[ASXEODPrice] [Prices2] 
		WHERE
			[Prices2].[ASXCode] = [Prices1].[ASXCode] 
			AND [Prices2].[Date] > [Prices1].[Date]
			AND [Prices2].[PriceOpen] IS NOT NULL
		ORDER BY
			[Prices2].[Date] ASC
	)
	-- Coalesce Argument 3
	,(
		SELECT TOP 1
			(([Prices2].[PriceOpen] * 1.0 / LAG([Prices2].[PriceOpen]) OVER (PARTITION BY [Prices2].[ASXCode] ORDER BY [Prices2].[Date])) + 1) / 2 * LAG([Prices2].[PriceOpen]) OVER (PARTITION BY [Prices2].[ASXCode] ORDER BY [Prices2].[Date])
		FROM
			[dbo].[ASXEODPrice] [Prices2] 
		WHERE
			[Prices2].[ASXCode] = [Prices1].[ASXCode] 
			AND [Prices2].[Date] < [Prices1].[Date]
			AND [Prices2].[PriceOpen] IS NOT NULL
		ORDER BY
			[Prices2].[Date] DESC
	)
)

FROM
	[dbo].[Dates] [Dates]
	LEFT JOIN [dbo].[ASXEODPrice] [Prices1] 
		ON [Prices1].[Date] = [Dates].[DateKey] 
		AND [Prices1].[ASXCode] = @RequiredCode
WHERE
	[Dates].[DateKey] BETWEEN @StartDate AND @EndDate
ORDER BY
	 [Dates].[DateKey] 

