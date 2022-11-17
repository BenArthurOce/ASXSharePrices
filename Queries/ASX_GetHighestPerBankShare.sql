--Get all the bank shares
--Return the all time highest for each share that is a bank share

SELECT *
FROM
	[dbo].[ASXSharePrices] [Prices]
	INNER JOIN [dbo].[ASXCompanies] [Names] ON [Names].ASXCode = [Prices].ASXCode
	INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [Prices].ASXDate
WHERE
	[Names].GICsIndustryGroup = 'Banks'