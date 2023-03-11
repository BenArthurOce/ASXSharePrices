-- In order to use CONVERT(), we must first CAST() the bigint value into an 8 character value

SELECT TOP 100 
	 [Prices].RecordNum
	,[Prices].ASXDate
	,CAST([Prices].ASXDate AS CHAR(8))										AS 'ToChar8'
	,CONVERT(BIGINT,getdate(), 110) 										AS 'Bigint_USAFormat'
	,CONVERT(DATE,CAST([Prices].ASXDate AS VARCHAR(8)),101)					AS 'date_ToDateCast101'
	,CONVERT(DATETIME, CAST([Prices].ASXDate AS CHAR(8)), 101)				AS 'datetime_ToDateCast101'
	,CONVERT(DATE, substring(CAST([Prices].ASXDate AS CHAR(8)),1,8))		AS 'date_ToSubstringCast'
	,CONVERT(CHAR(10),[Prices].ASXDate,103)									AS 'Char10_Convert'
	,DATENAME(DW,CAST([Prices].ASXDate AS CHAR(8)))							AS 'DayWeek_Char8'

FROM
	[dbo].[ASXSharePrices] [Prices]
