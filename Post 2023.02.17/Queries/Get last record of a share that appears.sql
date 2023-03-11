DECLARE @StockCode NVARCHAR(6) = 'WOW';
DECLARE @DateRequested INT = 20231005


SELECT TOP 1 
	[Date]
	,[PriceOpen]
	,[PriceHigh]
	,[PriceLow]
	,[PriceClose]
	,[VolumeTraded]
FROM 
	[dbo].[ASXEODPrice] 
WHERE 
	[ASXCode] = @StockCode
	AND [Date] <= @DateRequested
ORDER BY 
	[Date] DESC
