USE BENASXDATABASE;

-- create table of Dates
CREATE TABLE [dbo].[Dates] (
 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
,[DateKey]					BIGINT NOT NULL 
--,[DateDate]					DATE NOT NULL
,[FullDayStringLong]		NVARCHAR(60) NOT NULL
,[Day]						BIGINT NOT NULL
,[Month]					BIGINT NOT NULL
,[Year]						BIGINT NOT NULL
,[DayInt]					BIGINT NOT NULL
,[MonthInt]					BIGINT NOT NULL
,[OrdinalDate]				NVARCHAR(10) NOT NULL
,[DayOfWeek]				NVARCHAR(10) NOT NULL
,[MonthAbv]					NVARCHAR(10) NOT NULL
,[MonthFull]				NVARCHAR(12) NOT NULL
--,[FullDayStringShortUK]		DATE NOT NULL
--,[FullDayStringShortUS]		DATE NOT NULL
,[DayMonthString]			NVARCHAR(15) NOT NULL
,[OrdinalDayMonthString]	NVARCHAR(15) NOT NULL
,[MonthYearInt]				BIGINT NOT NULL
,[MonthYearAbv]				NVARCHAR(25) NOT NULL
,[MonthYearFull]			NVARCHAR(25) NOT NULL
,[YearMonthInt]				BIGINT NOT NULL
,[YearMonthAbv]				NVARCHAR(25) NOT NULL
,[YearMonthFull]			NVARCHAR(25) NOT NULL
,[WeekDayNum]				BIGINT NOT NULL
,[IsWeekday]				BIT NOT NULL
,[IsWeekend]				BIT NOT NULL
,[QtrCalendar]				BIGINT NOT NULL
,[QtrFinancial]				BIGINT NOT NULL
,[YearCalendar]				BIGINT NOT NULL
,[YearFinancial]			BIGINT NOT NULL
,[IsYearCalendarLeap]		BIGINT NOT NULL
,[DaysInMonth]				BIGINT NOT NULL
,[DaysInCalYear]			BIGINT NOT NULL
,[DaysInFinYear]			BIGINT NOT NULL
,[DaysInCalYearPassed]		BIGINT NOT NULL
,[DaysInCalYearToGo]		BIGINT NOT NULL
,[DaysInFinYearPassed]		BIGINT NOT NULL
,[DaysInFinYearToGo]		BIGINT NOT NULL
,CONSTRAINT [PK_DateId] PRIMARY KEY CLUSTERED ([Id] ASC)
ON [PRIMARY]) ON [PRIMARY]


INSERT [dbo].[Dates]
  (DateKey,FullDayStringLong,Day,Month,Year,DayInt,MonthInt,OrdinalDate,DayOfWeek,MonthAbv,MonthFull,DayMonthString,OrdinalDayMonthString,MonthYearInt,MonthYearAbv,MonthYearFull,YearMonthInt,YearMonthAbv,YearMonthFull,WeekDayNum,IsWeekday,IsWeekend,QtrCalendar,QtrFinancial,YearCalendar,YearFinancial,IsYearCalendarLeap,DaysInMonth,DaysInCalYear,DaysInFinYear,DaysInCalYearPassed,DaysInCalYearToGo,DaysInFinYearPassed,DaysInFinYearToGo)
SELECT 
 DateKey,FullDayStringLong,Day,Month,Year,DayInt,MonthInt,OrdinalDate,DayOfWeek,MonthAbv,MonthFull,DayMonthString,OrdinalDayMonthString,MonthYearInt,MonthYearAbv,MonthYearFull,YearMonthInt,YearMonthAbv,YearMonthFull,WeekDayNum,IsWeekday,IsWeekend,QtrCalendar,QtrFinancial,YearCalendar,YearFinancial,IsYearCalendarLeap,DaysInMonth,DaysInCalYear,DaysInFinYear,DaysInCalYearPassed,DaysInCalYearToGo,DaysInFinYearPassed,DaysInFinYearToGo

FROM [dbo].[DatesTEMP]

DROP TABLE [dbo].[DatesTEMP]