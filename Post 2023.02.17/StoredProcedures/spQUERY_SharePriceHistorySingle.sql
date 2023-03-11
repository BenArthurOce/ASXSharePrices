USE [BENASXDATABASE]
GO

CREATE PROC spQUERY_SharePriceHistorySingle
	(
		 @in_ASXCode	VARCHAR(10)
	)
AS
BEGIN

	SET NOCOUNT ON ;
	SET XACT_ABORT ON ;

	DECLARE
		@ErrorMesssage VARCHAR(MAX)

	PRINT 'Stored Procedure:' + OBJECT_NAME(@@PROCID)
	PRINT '  Parameters:'	
	PRINT CONCAT(
	'    '
	,'[@in_ASXCode = ',@in_ASXCode,'] '
	)



			SELECT 
				--Price Model
				 [Prices].[Id]					AS [Id]
				--,[Prices].[ASXCode]				AS [ASXCode]
				--,[Prices].[Date]				AS [Date]
				,[Prices].[PriceOpen]			AS [PriceOpen]
				,[Prices].[PriceHigh]			AS [PriceHigh]
				,[Prices].[PriceLow]			AS [PriceLow]
				,[Prices].[PriceClose]			AS [PriceClose]
				,[Prices].[VolumeTraded]		AS [VolumeTraded]


				--TradingEntity Model (Includes TradingSector)
				,[Entity].[Id]					AS [Id]
				,[Entity].[ASXCode]				AS [ASXCode]
				,[Entity].[Name]				AS [Name]
				--,[Entity].[SectorId]			AS [SectorId]
				,[Entity].[isLICS]				AS [isLICS]
				,[Entity].[isA-REIT]			AS [isA-REIT]
				,[Entity].[isETP]				AS [isETP]
				,[Entity].[isIndices]			AS [isIndices]
				,[Entity].[isABFund]			AS [isABFund]
				,[Entity].[isDerivative]		AS [isDerivative]
				,[Entity].[Notes]				AS [Notes]
				,[Sector].[Id]					AS [Id]
				,[Sector].[Name]				AS [Name]


				
				--Date Model
				,[Dates].[DateKey]				AS [Id]
				,[Dates].[DateKey]				AS [DateKey]
				,[Dates].[Date]					AS [DateId]
				,[Dates].[DayInt]				AS [DayInt]
				,[Dates].[DayInt00]				AS [DayInt00]
				,[Dates].[DayOrdinal]			AS [DayOrdinal]
				,[Dates].[WeekDayInt]			AS [WeekDayInt]
				,[Dates].[WeekdayFull]			AS [WeekdayFull]
				,[Dates].[WeekdayAbv]			AS [WeekdayAbv]
				,[Dates].[IsWeekday]			AS [IsWeekday]
				,[Dates].[IsWeekEnd]			AS [IsWeekEnd]
				,[Dates].[MonthInt]				AS [MonthInt]
				,[Dates].[MonthInt00]			AS [MonthInt00]
				,[Dates].[MonthStringFull]		AS [MonthStringFull]
				,[Dates].[MonthStringAbv]		AS [MonthStringAbv]
				,[Dates].[YearCalendar]			AS [YearCalendar]
				,[Dates].[YearFinancial]		AS [YearFinancial]
				,[Dates].[IsLeapYear]			AS [IsLeapYear]
				,[Dates].[QuarterCalendarInt]   AS [QuarterCalendarInt]
				,[Dates].[QuarterFinancialInt]  AS [QuarterFinancialInt]
				,[Dates].[DaysInMonth]          AS [DaysInMonth]
				,[Dates].[DayOfYear]            AS [DayOfYear]
				,[Dates].[DaysLeftInYear]       AS [DaysLeftInYear]
				,[Dates].[YearMonthInt]         AS [YearMonthInt]
				,[Dates].[MonthYearStringFull]  AS [MonthYearStringFull]
				,[Dates].[MonthYearStringAbv]   AS [MonthYearStringAbv]
				,[Dates].[MonthAbvYearString]	AS [MonthAbvYearString]
				,[Dates].[YearMonthStringFull]  AS [YearMonthStringFull]
				,[Dates].[YearMonthStringAbv]   AS [YearMonthStringAbv]
				,[Dates].[FullDateStringLong]   AS [FullDateStringLong]
				

				

			FROM 
				[dbo].[Dates] [Dates]
				INNER JOIN [dbo].[ASXEODPrice] [Prices] ON ([Prices].[Date] = [Dates].[DateKey] AND [Prices].ASXCode = @in_ASXCode)
				INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].[ASXCode] = [Prices].[ASXCode]
				INNER JOIN [dbo].[TradingSector] [Sector] ON	[Sector].[Id] = [Entity].[SectorId] 

			ORDER BY
				[Dates].DateKey
END