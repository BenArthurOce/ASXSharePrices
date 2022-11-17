
SELECT *
FROM
	[dbo].[ASXSharePrices] [Prices]
	INNER JOIN [dbo].[ASXCompanies] [Names] ON [Names].ASXCode = [Prices].ASXCode
	INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [Prices].ASXDate