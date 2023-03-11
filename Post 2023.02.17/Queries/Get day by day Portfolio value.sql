
WITH [PortfolioMovements] AS
(
	SELECT
		 [Standings].[PortfolioId]		AS [PortfolioId]
		,[Standings].[DateKey]			AS [DateKey]
		,SUM([Standings].[CostBase])	AS [CostBase]
		,SUM([Standings].[MarketValue]) AS [MarketValue]
	FROM 
		[dbo].[DW_PortfolioStandings] [Standings]
		INNER JOIN [dbo].[TradingEntity] [Entity] ON [Entity].[Id] = [Standings].[EntityId]
	WHERE [Standings].PortfolioId = (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = 'Jimmys Renewerables')
		AND [Standings].DateKey BETWEEN 20210101 AND 20211010
	GROUP BY
		[Standings].[PortfolioId], [Standings].[DateKey]

)

SELECT

	-- Portfolio Model
	 [Portfolio].[Id]						AS [Id]
	,[Portfolio].[PortfolioCustomerNumber]  AS [PortfolioCustomerNumber]
	,[Portfolio].[Name]						AS [Name]
	,[Portfolio].[isDeleted]				AS [isDeleted]

	-- Date Model
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

	-- Portfolio Summary
	,[PortfolioMovements].[CostBase]		AS [CostBase]
	,[PortfolioMovements].[MarketValue]		AS [MarketValue]


FROM [PortfolioMovements]
INNER JOIN [dbo].[Portfolio] [Portfolio] ON [Portfolio].[Id] = [PortfolioMovements].[PortfolioId]
INNER JOIN [dbo].[Dates] [Dates] ON [Dates].[DateKey] = [PortfolioMovements].[DateKey]
ORDER BY [PortfolioMovements].[DateKey]