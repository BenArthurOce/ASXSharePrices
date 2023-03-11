
SELECT TOP 1 [Date] FROM	[dbo].[ASXEODPrice]  ORDER BY [Date] ASC
SELECT TOP 1 [Date] FROM	[dbo].[ASXEODPrice]  ORDER BY [Date] DESC

SELECT Top 1 [Price].[Date]
FROM [dbo].[ASXEODPrice] [Price]
ORDER BY ABS([Date] - CAST(FORMAT(GETDATE(),'yyyyMMdd') AS int))

--Last day of data owned, and 30 days before that
DECLARE 
	@lastDate INT = (SELECT TOP 1 [Date] FROM [dbo].[ASXEODPrice] ORDER BY [Date] DESC)

DECLARE
	@firstDate INT = (SELECT CONVERT(INT, CONVERT(VARCHAR(8), DATEADD(DAY, -30, CONVERT(DATE, CONVERT(VARCHAR(8), @lastDate), 112)), 112)))

PRINT @lastDate
PRINT @firstDate