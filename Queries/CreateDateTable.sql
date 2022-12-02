DECLARE @StartDate		DATE = '2000-01-01'
DECLARE @EndDate		DATE = '2005-02-27'

;WITH DateList AS
(
    SELECT		 @StartDate					AS 'DateDate'	--1
				,DATENAME(YY, @StartDate)	AS 'YearInt'	--2
				,MONTH(@StartDate)			AS 'MonthInt'	--3
				,DATENAME(DD, @StartDate)	AS 'DayInt'		--4
				,DATENAME(DW, @StartDate)	AS 'Weekday'	--5
				,DATENAME(MM, @StartDate)	AS 'MonthFull'	--6
				,DATENAME(DY, @StartDate)	AS 'DayOfYear'	--7
				,DATENAME(QQ, @StartDate)	AS 'QuarterInt'	--8
				,CHOOSE	(
					MONTH(@StartDate)
					,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
						)					AS 'MonthAbv'	--9
				
				
    UNION ALL
    SELECT		 dateadd(DD, 1, DateDate)	AS 'DateDate'	--1	
				,DATENAME(YY, DateDate)		AS 'YearInt'	--2
				,MONTH(DateDate)			AS 'MonthInt'	--3
				,DATENAME(DD, DateDate)		AS 'DayInt'		--4
				,DATENAME(DW, DateDate)		AS 'Weekday'	--5
				,DATENAME(MM, DateDate)		AS 'MonthFull'	--6
				,DATENAME(DY, DateDate)		AS 'DayOfYear'	--7
				,DATENAME(QQ, DateDate)		AS 'QuarterInt'	--8
				,CHOOSE	(
					MONTH(DateDate)
					,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
						)					AS 'MonthAbv'	--9
				
    FROM DateList
	WHERE DateDate < @EndDate
)
SELECT * FROM DateList OPTION (MAXRECURSION 5000)