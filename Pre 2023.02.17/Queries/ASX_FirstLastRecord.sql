
SELECT TOP 1 * FROM	ASXSharePrices [ASXSharePrices] ORDER BY [ASXSharePrices].RecordNum ASC
SELECT TOP 1 * FROM	ASXSharePrices [ASXSharePrices] ORDER BY [ASXSharePrices].RecordNum DESC

SELECT Top 1 [Price].[Date]
FROM [dbo].[ASXEODPrice] [Price]
ORDER BY ABS([Date] - CAST(FORMAT(GETDATE(),'yyyyMMdd') AS int))