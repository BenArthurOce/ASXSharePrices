--================================================================================================
--====================== TABLE OF DATE REFERENCES / INFO =========================================
--================================================================================================
USE BENASXDATABASE;


-- Create table of TEMP Dates
--=====================================
CREATE TABLE [dbo].[Temp_Dates] (               
 [DateKey]				INT NOT NULL			-- 01	(Date in a YYMMDD format)
,[Date]					DATE NOT NULL			-- 02	(Date in a YYYY-MM-DD format)
,[DayInt]				INT NOT NULL			-- 03	(The Numerical value of the Day from the Date. Ranges from 1 to 31)
,[DayInt00]				NVARCHAR(2) NOT NULL	-- 04	(Takes the above Day and adds a leading '0' if the value is single digit)
,[DayOrdinal]			NVARCHAR(2) NOT NULL	-- 05	(Takes the Day and determines if its the first(st), second(nd), third(rd), fourth(th) etc) 
,[WeekDayInt]			INT NOT NULL			-- 06	(Displays numerical value for what day of the week it is. Monday=1, Sunday=7)
,[WeekdayFull]			NVARCHAR(9) NOT NULL	-- 07	(Displays the full Name of the weekday)
,[WeekdayAbv]			NVARCHAR(3) NOT NULL	-- 08	(Displays the first three characters of the weekday)
,[IsWeekday]			BIT NOT NULL			-- 09	(A bool value to display if the date is on Monday, Tuesday, Wednesday, Thursday or Friday)
,[IsWeekEnd]			BIT NOT NULL			-- 10	(A bool value to display if the date is on a Saturday or Sunday)
,[MonthInt]				INT NOT NULL			-- 11	(The Numerical value of the Month from the Date. Ranges from 1 to 12)
,[MonthInt00]			NVARCHAR(2) NOT NULL	-- 12	(Takes the above Month and adds a leading '0' if the value is single digit)
,[MonthStringFull]		NVARCHAR(9) NOT NULL	-- 13	(Displays the full name of the month that the date is in)
,[MonthStringAbv]		NVARCHAR(3) NOT NULL	-- 14	(Displays the first three characters of the month that the date is in)
,[YearCalendar]			INT NOT NULL			-- 15	(A Numerical value for the current year according to standard calendars - 1st Jan is the new year)
,[YearFinancial]		INT NOT NULL			-- 16	(A Numerical value for the current year according to financial calendars - 1st July is the new year)
,[IsLeapYear]			INT NOT NULL			-- 17	(A bool value that returns yes if the year is divisable by 4 with no remainders)
,[QuarterCalendarInt]	INT NOT NULL			-- 18	()
,[QuarterFinancialInt]	INT NOT NULL			-- 19	()
,[DaysInMonth]			INT NOT NULL			-- 20	(Numerical value showing how many days are in the month regarding [11], [12], [13], [14])
,[DayOfYear]			INT NOT NULL			-- 21	(Numerical value showing how many days since 31st Dec)
,[DaysLeftInYear]		INT NOT NULL			-- 22	(Numerical value showing the amount of days until 1st Jan)
,[YearMonthInt]			INT NOT NULL			-- 23	()
,[MonthYearStringFull]	NVARCHAR(25) NOT NULL	-- 24	(A Comination of [13] and [15] - The full month followed by the year)
,[MonthYearStringAbv]	NVARCHAR(7) NOT NULL	-- 25	(A Comination of [14] and [15] - The shortened month followed by the year
,[MonthAbvYearString]	NVARCHAR(5) NOT NULL	-- 26	(MMM-YY format ie:Mar95)
,[YearMonthStringFull]	NVARCHAR(13) NOT NULL	-- 27	(A Comination of [15] and [13] - the year followed by the full month)
,[YearMonthStringAbv]	NVARCHAR(7) NOT NULL	-- 28	(A Comination of [15] and [14] - The year followed by the shortened month)
,[FullDateStringLong]	NVARCHAR(35) NOT NULL	-- 29
)


-- Create table of Dates (Includes unique ID)
--=====================================
CREATE TABLE [dbo].[Dates] (
 --[Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 [DateKey]				INT NOT NULL			-- 01
,[Date]					DATE NOT NULL			-- 02
,[DayInt]				INT NOT NULL			-- 03
,[DayInt00]				NVARCHAR(2) NOT NULL	-- 04
,[DayOrdinal]			NVARCHAR(2) NOT NULL	-- 05
,[WeekDayInt]			INT NOT NULL			-- 06
,[WeekdayFull]			NVARCHAR(9) NOT NULL	-- 07
,[WeekdayAbv]			NVARCHAR(3) NOT NULL	-- 08
,[IsWeekday]			BIT NOT NULL			-- 09
,[IsWeekEnd]			BIT NOT NULL			-- 10
,[MonthInt]				INT NOT NULL			-- 11
,[MonthInt00]			NVARCHAR(2) NOT NULL	-- 12
,[MonthStringFull]		NVARCHAR(9) NOT NULL	-- 13
,[MonthStringAbv]		NVARCHAR(3) NOT NULL	-- 14
,[YearCalendar]			INT NOT NULL			-- 15
,[YearFinancial]		INT NOT NULL			-- 16
,[IsLeapYear]			INT NOT NULL			-- 17
,[QuarterCalendarInt]	INT NOT NULL			-- 18
,[QuarterFinancialInt]	INT NOT NULL			-- 19
,[DaysInMonth]			INT NOT NULL			-- 20
,[DayOfYear]			INT NOT NULL			-- 21
,[DaysLeftInYear]		INT NOT NULL			-- 22
,[YearMonthInt]			INT NOT NULL			-- 23
,[MonthYearStringFull]	NVARCHAR(25) NOT NULL	-- 24
,[MonthYearStringAbv]	NVARCHAR(7) NOT NULL	-- 25
,[MonthAbvYearString]	NVARCHAR(5) NOT NULL	-- 26
,[YearMonthStringFull]	NVARCHAR(13) NOT NULL	-- 27
,[YearMonthStringAbv]	NVARCHAR(7) NOT NULL	-- 28
,[FullDateStringLong]	NVARCHAR(35) NOT NULL	-- 29
,CONSTRAINT [PK_DateKey] PRIMARY KEY CLUSTERED ([DateKey] ASC)
ON [PRIMARY]) ON [PRIMARY]


DECLARE @StartDate		DATE = '1995-01-01'
DECLARE @EndDate		DATE = '2050-12-31'
SET DATEFIRST 1;


-- Create all dates with recursive CTE
--=====================================
;WITH DateList AS
(
    SELECT		
				1														AS [n]					--00
				--=====DATE AND DATE KEY=====
				,[dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(@StartDate)
					,MONTH(@StartDate)
					,DAY(@StartDate)
				)														AS [DateKey]			--01
				,@StartDate												AS [Date]				--02

				--=====DAY=====
				,DATENAME(DD, @StartDate)								AS [DayInt]				--03
				,FORMAT(
					CAST(DATENAME(DD, @StartDate) AS INT)
					,'00')												AS [DayInt00]			--04
				,[dbo].[funRETURN_OrdinalFromNumber](
					DATENAME(DD, @StartDate))							AS [DayOrdinal]			--05



				--=====WEEKDAY=====
				,DATEPART(WEEKDAY, @StartDate) 							AS [WeekDayInt]			--06
				,DATENAME(DW, @StartDate)								AS [WeekdayFull]		--07
				,LEFT(DATENAME(DW, @StartDate),3)						AS [WeekdayAbv]			--08
				,CASE
					WHEN DATEPART(WEEKDAY, @StartDate)  <= 5 THEN 1
					ELSE 0 END											AS [IsWeekday]			--09
				,CASE
					WHEN DATEPART(WEEKDAY, @StartDate)  >= 6 THEN 1
					ELSE 0 END											AS [IsWeekEnd]			--10


				--=====MONTH=====
				,MONTH(@StartDate)										AS [MonthInt]			--11
				,FORMAT(
					CAST(MONTH(@StartDate) AS NUMERIC)
					,'00')												AS [MonthInt00]			--12
				,DATENAME(MM, @StartDate)								AS [MonthStringFull]	--13
				,LEFT(DATENAME(MM, @StartDate),3)						AS [MonthStringAbv]		--14


				--=====YEAR=====
				,DATENAME(YY, @StartDate)								AS [YearCalendar]		--15
				,[dbo].[funRETURN_FinancialYearFromDate](
					@StartDate)											AS [YearFinancial]		--16
				,CASE
					WHEN (YEAR(@StartDate) % 400 = 0) THEN 1
					ELSE 0 END											AS [IsLeapYear]			--17


				--=====QUARTER=====
				,CHOOSE(
					MONTH(@StartDate),1,1,1,2,2,2,3,3,3,4,4,4
					)													AS [QuarterCalendarInt]	--18
				,CHOOSE(
					MONTH(@StartDate),3,3,3,4,4,4,1,1,1,2,2,2
					)													AS [QuarterFinancialInt]--19
				

				--=====DAY INFORMATION=====
				,DAY(EOMONTH(@StartDate))								AS [DaysInMonth]		--20
				,DATENAME(DY, @StartDate)								AS [DayOfYear]			--21
				,DATEDIFF(
					DAY
					,@StartDate
					,DATEFROMPARTS(YEAR(@StartDate),12,31)
						)												AS [DaysLeftInYear]		--22
				

				--=====COMBINED STRINGS=====
				,LEFT([dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(@StartDate)
					,MONTH(@StartDate)
					,DAY(@StartDate)
					),6)												AS [YearMonthInt]		--23
				,CONCAT(
					 DATENAME(MM, @StartDate)
					,YEAR(@StartDate)									
					)													AS [MonthYearStringFull]	--24	
				,CONCAT(
					 LEFT(DATENAME(MM, @StartDate),3)
					,YEAR(@StartDate)
					)													AS [MonthYearStringAbv]		--25
				,CONCAT(
					 LEFT(DATENAME(MM, @StartDate),3)
					,RIGHT(YEAR(@StartDate)+ 0,2)
					)													AS [MonthAbvYearString]		--26
				,CONCAT(
					 YEAR(@StartDate)
					,DATENAME(MM, @StartDate)
					)													AS [YearMonthStringFull]	--27
				,CONCAT(
					 YEAR(@StartDate)
					,LEFT(DATENAME(MM, @StartDate),3)
					)													AS [YearMonthStringAbv]		--28
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
					)													AS [FullDateStringLong]	--29


    UNION ALL
    SELECT		
				[n] + 1																	AS [n]				--0 

				--=====DATE AND DATE KEY=====
				,[dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(DATEADD(DD, [n], @StartDate))
					,MONTH(DATEADD(DD, [n], @StartDate))
					,DAY(DATEADD(DD, [n], @StartDate))
				)																		AS [DateKey]		--01
				,DATEADD(DD, [n], @StartDate)											AS [Date]			--02


				--=====DAY=====
				,DATENAME(DD, DATEADD(DD, [n], @StartDate))								AS [DayInt]			--03
				,FORMAT(
					CAST(DATENAME(DD, DATEADD(DD, [n], @StartDate)) AS INT)
					,'00')																AS [DayInt00]		--04
				,[dbo].[funRETURN_OrdinalFromNumber](
					DATENAME(DD, DATEADD(DD, [n], @StartDate)))							AS [DayOrdinal]		--05


				--=====WEEKDAY=====
				,DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate)) 						AS [WeekDayInt]		--06
				,DATENAME(DW, DATEADD(DD, [n], @StartDate))								AS [WeekdayFull]	--07
				,LEFT(DATENAME(DW, DATEADD(DD, [n], @StartDate)),3)						AS [WeekdayAbv]		--08
				,CASE
					WHEN DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate))  <= 5 THEN 1
					ELSE 0 END															AS [IsWeekday]		--09
				,CASE
					WHEN DATEPART(WEEKDAY, DATEADD(DD, [n], @StartDate))  >= 6 THEN 1
					ELSE 0 END															AS [IsWeekEnd]		--10


				--=====MONTH=====
				,MONTH(DATEADD(DD, [n], @StartDate))									AS [MonthInt]		--11
				,FORMAT(
					CAST(MONTH(DATEADD(DD, [n], @StartDate)) AS NUMERIC)
					,'00')																AS [MonthInt00]		--12
				,DATENAME(MM, DATEADD(DD, [n], @StartDate))								AS [MonthStringFull]--13
				,LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)						AS [MonthStringAbv]	--14


				--=====YEAR=====
				,DATENAME(YY, DATEADD(DD, [n], @StartDate))								AS [YearCalendar]	--15
				,[dbo].[funRETURN_FinancialYearFromDate](
					DATEADD(DD, [n], @StartDate))										AS [YearFinancial]	--16
				,CASE
					WHEN (YEAR(DATEADD(DD, [n], @StartDate)) % 400 = 0) THEN 1
					ELSE 0 END															AS [IsLeapYear]		--17


				--=====QUARTER=====
				,CHOOSE(
					MONTH(DATEADD(DD, [n], @StartDate)),1,1,1,2,2,2,3,3,3,4,4,4
					)																	AS [QuarterCalendarInt]	--18
				,CHOOSE(
					MONTH(DATEADD(DD, [n], @StartDate)),3,3,3,4,4,4,1,1,1,2,2,2
					)																	AS [QuarterFinancialInt]--19


				--=====DAY INFORMATION=====
				,DAY(EOMONTH(DATEADD(DD, [n], @StartDate)))								AS [DaysInMonth]		--20
				,DATENAME(DY, DATEADD(DD, [n], @StartDate))								AS [DayOfYear]			--21
				,DATEDIFF(
					DAY
					,DATEADD(DD, [n], @StartDate)
					,DATEFROMPARTS(YEAR(DATEADD(DD, [n], @StartDate)),12,31)
						)																AS [DaysLeftInYear]		--22


				--=====COMBINED STRINGS=====
				,LEFT([dbo].[funCONVERT_DatePartsToDateInt](
					 YEAR(DATEADD(DD, [n], @StartDate))
					,MONTH(DATEADD(DD, [n], @StartDate))
					,DAY(DATEADD(DD, [n], @StartDate))
					),6)												AS [YearMonthInt]	--23
				,CONCAT(
					 DATENAME(MM, DATEADD(DD, [n], @StartDate))
					,YEAR(DATEADD(DD, [n], @StartDate))									
					)													AS [MonthYearStringFull] --24
				,CONCAT(
					 LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)
					,YEAR(DATEADD(DD, [n], @StartDate))
					)													AS [MonthYearStringAbv]	--25
				,CONCAT(
					 LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)
					,RIGHT(YEAR(DATEADD(DD, [n], @StartDate))+ 0,2)
					)													AS [MonthAbvYearString] --26
				,CONCAT(
					 YEAR(DATEADD(DD, [n], @StartDate))
					,DATENAME(MM, DATEADD(DD, [n], @StartDate))
					)													AS [YearMonthStringFull] --27
				,CONCAT(
					 YEAR(DATEADD(DD, [n], @StartDate))
					,LEFT(DATENAME(MM, DATEADD(DD, [n], @StartDate)),3)
					)													AS [YearMonthStringAbv]	--28
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
					)													AS [FullDateStringLong]	--29
				
    FROM DateList
	WHERE DATEADD(DD, [n], @StartDate) < @EndDate
)



-- Populate the Temp date table with data from the recursive CTE
--================================================================
INSERT INTO [dbo].[Temp_Dates]
([DateKey], [Date], [DayInt], [DayInt00], [DayOrdinal], [WeekDayInt], [WeekdayFull], [WeekdayAbv], [IsWeekday], [IsWeekEnd], [MonthInt], [MonthInt00], [MonthStringFull], [MonthStringAbv], [YearCalendar], [YearFinancial], [IsLeapYear], [QuarterCalendarInt], [QuarterFinancialInt], [DaysInMonth], [DayOfYear], [DaysLeftInYear], [YearMonthInt], [MonthYearStringFull], [MonthYearStringAbv], [MonthAbvYearString], [YearMonthStringFull], [YearMonthStringAbv], [FullDateStringLong])

SELECT 
	[DateKey], [Date], [DayInt], [DayInt00], [DayOrdinal], [WeekDayInt], [WeekdayFull], [WeekdayAbv], [IsWeekday], [IsWeekEnd], [MonthInt], [MonthInt00], [MonthStringFull], [MonthStringAbv], [YearCalendar], [YearFinancial], [IsLeapYear], [QuarterCalendarInt], [QuarterFinancialInt], [DaysInMonth], [DayOfYear], [DaysLeftInYear], [YearMonthInt], [MonthYearStringFull], [MonthYearStringAbv], [MonthAbvYearString], [YearMonthStringFull], [YearMonthStringAbv], [FullDateStringLong]
FROM 
	DateList OPTION (MAXRECURSION 30000)



-- Copy the Data from Temp to the actual table to generate IDs
--================================================================
INSERT [dbo].[Dates]
  (DateKey, Date, DayInt, DayInt00, DayOrdinal, WeekDayInt, WeekdayFull, WeekdayAbv, IsWeekday, IsWeekEnd, MonthInt, MonthInt00, MonthStringFull, MonthStringAbv, YearCalendar, YearFinancial, IsLeapYear, QuarterCalendarInt, QuarterFinancialInt, DaysInMonth, DayOfYear, DaysLeftInYear, YearMonthInt, MonthYearStringFull, MonthYearStringAbv, MonthAbvYearString, YearMonthStringFull, YearMonthStringAbv, FullDateStringLong)
SELECT 
	DateKey, Date, DayInt, DayInt00, DayOrdinal, WeekDayInt, WeekdayFull, WeekdayAbv, IsWeekday, IsWeekEnd, MonthInt, MonthInt00, MonthStringFull, MonthStringAbv, YearCalendar, YearFinancial, IsLeapYear, QuarterCalendarInt, QuarterFinancialInt, DaysInMonth, DayOfYear, DaysLeftInYear, YearMonthInt, MonthYearStringFull, MonthYearStringAbv, MonthAbvYearString, YearMonthStringFull, YearMonthStringAbv, FullDateStringLong
FROM [dbo].[Temp_Dates]


CREATE NONCLUSTERED INDEX IX_Dates_DateKey
ON dbo.Dates (DateKey)

-- Delete the temp table once data is transfered over
--================================================================
DROP TABLE [dbo].[Temp_Dates]


SELECT * FROM [dbo].[Dates]