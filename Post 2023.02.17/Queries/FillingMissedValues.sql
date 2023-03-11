DECLARE
	 @StartDate INT = 20211231
	,@EndDate INT = 20220630
	,@RequiredCode NVARCHAR(6) = 'CBA';

WITH [MyCTE] AS
(
	SELECT
	 [Dates].[DateKey] 
	,[Dates].[Date] 
	,[Prices1].[ASXCode]
	,[Prices1].[PriceOpen]
	,[Prices1].[PriceHigh]
	,[Prices1].[PriceLow]
	,[Prices1].[PriceClose]
	,[Prices1].[VolumeTraded]
	FROM
		[dbo].[Dates] [Dates]
		LEFT JOIN [dbo].[ASXEODPrice] [Prices1] 
			ON [Prices1].[Date] = [Dates].[DateKey] 
			AND [Prices1].[ASXCode] = @RequiredCode
	WHERE
		[Dates].[DateKey] BETWEEN @StartDate AND @EndDate
)

SELECT 
	[MyCTE].[DateKey]
	,[MyCTE].[Date]
	,[MyCTE].[ASXCode]
	,ISNULL([PriceOpen], (SELECT TOP 1 [p].[PriceOpen] FROM [ASXEODPrice] [p] WHERE [p].[Date] < [MyCTE].[DateKey] AND [p].[ASXCode] = @RequiredCode AND [p].[PriceOpen] IS NOT NULL ORDER BY [p].[Date] DESC))

FROM 
    [MyCTE] [MyCTE]
ORDER BY [MyCTE].[Date]
