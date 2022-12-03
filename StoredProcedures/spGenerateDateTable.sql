USE [BENASXDATABASE]
GO

CREATE PROC spGenerateDateTable
	(
		 @in_StartDate	DATE
		,@in_EndDate	DATE
	)
AS
BEGIN

DECLARE @StartDate		DATE = @in_StartDate
DECLARE @EndDate		DATE = @in_EndDate
SET DATEFIRST 1;

;WITH DateList AS
(
    SELECT		
				1														AS [n]					--0
				--=====DATE AND DATE KEY=====
				,[dbo].[funCONVERT_DatePartsToDateInt](
				 YEAR(@StartDate)
				,MONTH(@StartDate)
				,DAY(@StartDate)
				)														AS [DateKey]			--1
				,@StartDate												AS [Date]				--1

				--=====DAY=====
				,DATENAME(DD, @StartDate)								AS [DayInt]				--2
				,FORMAT(
					CAST(DATENAME(DD, @StartDate) AS NUMERIC)
					,'00')												AS [DayInt00]			--3
				,[dbo].[funRETURN_OrdinalFromNumber](
					DATENAME(DD, @StartDate))							AS [DayOrdinal]			--4



				--=====WEEKDAY=====
				,DATEPART(WEEKDAY, @StartDate) 							AS [WeekDayInt]			--5
				,DATENAME(DW, @StartDate)								AS [WeekdayFull]		--6
				,LEFT(DATENAME(DW, @StartDate),3)						AS [WeekdayAbv]			--7
				,CASE
					WHEN DATEPART(WEEKDAY, @StartDate)  <= 5 THEN 1
					ELSE 0 END											AS [IsWeekday]			--8
				,CASE
					WHEN DATEPART(WEEKDAY, @StartDate)  >= 6 THEN 1
					ELSE 0 END											AS [IsWeekEnd]			--9


				--=====MONTH=====
				,MONTH(@StartDate)										AS [MonthInt]			--10
				,FORMAT(
					CAST(MONTH(@StartDate) AS NUMERIC)
					,'00')												AS [MonthInt00]			--11
				,DATENAME(MM, @StartDate)								AS [MonthStringFull]	--12
				,LEFT(DATENAME(MM, @StartDate),3)						AS [MonthStringAbv]		--13


				--=====YEAR=====
				,DATENAME(YY, @StartDate)								AS [YearCalendar]		--14
				,[dbo].[funRETURN_FinancialYearFromDate](
					@StartDate)											AS [YearFinancial]		--15
				,CASE
					WHEN (YEAR(@StartDate) % 400 = 0) THEN 1
					ELSE 0 END											AS [IsLeapYear]			--16


				--=====QUARTER=====
				,CHOOSE(
					MONTH(@StartDate),1,1,1,2,2,2,3,3,3,4,4,4
					)													AS [QuarterCalendarInt]	--17
				,CHOOSE(
					MONTH(@StartDate),3,3,3,4,4,4,1,1,1,2,2,2
					)													AS [QuarterFinancialInt]--18
				

				--=====DAY INFORMATION=====
				,DAY(EOMONTH(@StartDate))								AS [DaysInMonth]		--19
				,DATENAME(DY, @StartDate)								AS [DayOfYear]			--20
				,DATEDIFF(
					DAY
					,@StartDate
					,DATEFROMPARTS(YEAR(@StartDate),12,31)
						)												AS [DaysLeftInYear]		--21
				

				--=====COMBINED STRINGS=====
				,LEFT([dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(@StartDate)
					,MONTH(@StartDate)
					,DAY(@StartDate)
					),6)												AS [YearMonthInt]		--22
				,CONCAT(
					 DATENAME(MM, @StartDate)
					,YEAR(@StartDate)									
					)													AS [MonthYearFull]		--23		
				,CONCAT(
					 LEFT(DATENAME(MM, @StartDate),3)
					,YEAR(@StartDate)
					)													AS [MonthYearAbv]		--24
				,CONCAT(
					 YEAR(@StartDate)
					,DATENAME(MM, @StartDate)
					)													AS [YearMonthFull]		--25
				,CONCAT(
					 YEAR(@StartDate)
					,LEFT(DATENAME(MM, @StartDate),3)
					)													AS [YearMonthAbv]		--26
				,CONCAT(
					 DATENAME(DW, @StartDate)
					,', '
					,DATEPART(DAY, @StartDate)
					,[dbo].[funRETURN_OrdinalFromNumber](
						DAY(@StartDate))
					,' of '
					,DATENAME(MM, @StartDate)
					,' '
					,DATENAME(YY, @StartDate)
					)													AS [FullDayStringLong]	--27


    UNION ALL
    SELECT		
				[n] + 1																	AS [n]				--0 

				--=====DATE AND DATE KEY=====
				,[dbo].[funCONVERT_DatePartsToDateInt](
				 YEAR(DATEADD(DD, [n], @StartDate))
				,MONTH(DATEADD(DD, [n], @StartDate))
				,DAY(DATEADD(DD, [n], @StartDate))
				)																		AS [DateKey]		--1
				,DATEADD(DD, [n], @StartDate)											AS [Date]			--1


				--=====DAY=====
				,DATENAME(DD, DATEADD(DD, [n], @StartDate))								AS [DayInt]			--2
				,FORMAT(
					CAST(DATENAME(DD, DATEADD(DD, [n], @StartDate)) AS NUMERIC)
					,'00')																AS [DayInt00]		--3
				,[dbo].[funRETURN_OrdinalFromNumber](
					DATENAME(DD, DATEADD(DD, [n], @StartDate)))							AS [DayOrdinal]		--4


				--=====WEEKDAY=====
				,DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate)) 						AS [WeekDayInt]		--5
				,DATENAME(DW, DATEADD(DD, [n], @StartDate))								AS [WeekdayFull]	--6			
				,LEFT(DATENAME(DW, DATEADD(DD, [n], @StartDate)),3)						AS [WeekdayAbv]		--7
				,CASE
					WHEN DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate))  <= 5 THEN 1
					ELSE 0 END															AS [IsWeekday]		--8
				,CASE
					WHEN DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate))  >= 6 THEN 1
					ELSE 0 END															AS [IsWeekEnd]		--9


				--=====MONTH=====
				,MONTH(DATEADD(DD, [n], @StartDate))									AS [MonthInt]		--10
				,FORMAT(
					CAST(MONTH(DATEADD(DD, [n], @StartDate)) AS NUMERIC)
					,'00')																AS [MonthInt00]		--11
				,DATENAME(MM, DATEADD(DD, [n], @StartDate))								AS [MonthStringFull]--12
				,LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)						AS [MonthStringAbv]	--13


				--=====YEAR=====
				,DATENAME(YY, DATEADD(DD, [n], @StartDate))								AS [YearCalendar]	--14
				,[dbo].[funRETURN_FinancialYearFromDate](
					DATEADD(DD, [n], @StartDate))										AS [YearFinancial]	--15
				,CASE
					WHEN (YEAR(DATEADD(DD, [n], @StartDate)) % 400 = 0) THEN 1
					ELSE 0 END															AS [IsLeapYear]		--16


				--=====QUARTER=====
				,CHOOSE(
					MONTH(DATEADD(DD, [n], @StartDate)),1,1,1,2,2,2,3,3,3,4,4,4
					)																	AS [QuarterCalendarInt]	--17
				,CHOOSE(
					MONTH(DATEADD(DD, [n], @StartDate)),3,3,3,4,4,4,1,1,1,2,2,2
					)																	AS [QuarterFinancialInt]--18


				--=====DAY INFORMATION=====
				,DAY(EOMONTH(DATEADD(DD, [n], @StartDate)))								AS [DaysInMonth]		--19
				,DATENAME(DY, DATEADD(DD, [n], @StartDate))								AS [DayOfYear]			--20
				,DATEDIFF(
					DAY
					,DATEADD(DD, [n], @StartDate)
					,DATEFROMPARTS(YEAR(DATEADD(DD, [n], @StartDate)),12,31)
						)																AS [DaysLeftInYear]		--21


				--=====COMBINED STRINGS=====
				,LEFT([dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(DATEADD(DD, [n], @StartDate))
					,MONTH(DATEADD(DD, [n], @StartDate))
					,DAY(DATEADD(DD, [n], @StartDate))
					),6)												AS [YearMonthInt]	--22
				,CONCAT(
					 DATENAME(MM, DATEADD(DD, [n], @StartDate))
					,YEAR(DATEADD(DD, [n], @StartDate))									
					)													AS [MonthYearFull]	--23
				,CONCAT(
					 LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)
					,YEAR(DATEADD(DD, [n], @StartDate))
					)													AS [MonthYearAbv]	--24
				,CONCAT(
					 YEAR(DATEADD(DD, [n], @StartDate))
					,DATENAME(MM, DATEADD(DD, [n], @StartDate))
					)													AS [YearMonthFull]	--25
				,CONCAT(
					 YEAR(DATEADD(DD, [n], @StartDate))
					,LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)
					)													AS [YearMonthAbv]	--26
				,CONCAT(
					 DATENAME(DW, DATEADD(DD, [n], @StartDate))
					,', '
					,DATEPART(DAY, DATEADD(DD, [n], @StartDate))
					,[dbo].[funRETURN_OrdinalFromNumber](
						DAY(DATEADD(DD, [n], @StartDate)))
					,' of '
					,DATENAME(MM, DATEADD(DD, [n], @StartDate))
					,' '
					,DATENAME(YY, DATEADD(DD, [n], @StartDate))
					)													AS [FullDayStringLong]	--27
				
    FROM DateList
	WHERE DATEADD(DD, [n], @StartDate) < @EndDate
)
SELECT * FROM DateList OPTION (MAXRECURSION 20000)

END