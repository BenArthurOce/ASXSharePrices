
-- Correlated Subqueries
-- Relies on the outer query to be executed to provide values
-- Correlated query will be executed for every record returned by outer query

USE BENASXDATABASE

SELECT
	 [Prices_outer].RecordNum
	,[Prices_outer].ASXCode
	,[Names_outer].CompanyName
	,[Prices_outer].ASXDate
	,[Prices_outer].VolumeTraded
	,[Names_outer].GICsIndustryGroup
FROM
	[dbo].[ASXSharePrices] [Prices_outer]
	INNER JOIN [dbo].[ASXCompanies] [Names_outer] ON [Names_outer].ASXCode = [Prices_outer].ASXCode

WHERE
	[Names_outer].GICsIndustryGroup =
		(
		SELECT [Names_outer].GICsIndustryGroup
		FROM [dbo].[ASXSharePrices] [Prices_inner]
		WHERE [Prices_inner].RecordNum = [Prices_outer].RecordNum 
		AND [Names_outer].GICsIndustryGroup = 'Banks'
		AND [Prices_outer].ASXDate = 20220124
		)
ORDER BY
	[Prices_outer].VolumeTraded

