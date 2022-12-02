DECLARE @StartDate		DATE = '2000-01-01'
DECLARE @EndDate		DATE = '2005-02-27'

;WITH DateList AS
(
    SELECT		 @StartDate					AS 'DateDate'
				,YEAR(@StartDate)			AS 'Year'
				,MONTH(@StartDate)			AS 'Month'
				,DAY(@StartDate)			AS 'Day'
    UNION ALL
    SELECT		 dateadd(DD, 1, DateDate)	AS 'DateDate'
				,YEAR(DateDate)				AS 'Year'
				,MONTH(DateDate)			AS 'Month'
				,DAY(DateDate)				AS 'Day'
    FROM DateList
	WHERE DateDate < @EndDate
)
SELECT * FROM DateList OPTION (MAXRECURSION 5000)