CREATE VIEW [View_ListOfBankingCompanies] AS

SELECT
	 [Names].ASXCode
	,[Names].CompanyName
	,[Names].GICsIndustryGroup
FROM
	[dbo].[ASXCompanies] [Names]
WHERE
	[Names].GICsIndustryGroup = 'Banks'
