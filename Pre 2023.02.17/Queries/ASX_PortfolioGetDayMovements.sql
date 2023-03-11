DECLARE @StartDate DATE = '2022-01-01'
DECLARE @EndDate DATE = '2022-02-15'

;
WITH [RunningPortfolioTotals] AS
(
	SELECT
		 1										AS [n]
		,@StartDate								AS [DateDateFmt]
		,[dbo].[funCONVERT_Date_To_DateInt](
			@StartDate)							AS [DateIntFmt]
		,0										AS [Balance]
		

	UNION ALL

	SELECT
		 [n] + 1								AS [n]
		,DATEADD(DD, [n], @StartDate)			AS [DateDateFmt]
		,[dbo].[funCONVERT_Date_To_DateInt](
			DATEADD(DD, [n], @StartDate))		AS [DateIntFmt]	
		,[dbo].[funRETURN_PortfolioValueOnDate]([DateIntFmt]) AS [Balance]

	FROM
		[RunningPortfolioTotals]

	WHERE 
		DATEADD(DD, [n], @StartDate) < @EndDate
)

SELECT
	 [RunningPortfolioTotals].DateDateFmt
	,FORMAT([RunningPortfolioTotals].Balance, 'C')
FROM [RunningPortfolioTotals]
OPTION (MAXRECURSION 20000)