
DECLARE @PortfolioName NVARCHAR(100) = 'Jimmys Renewerables'
DECLARE @RequestDate INT = 20220505
DECLARE @PortfolioId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = @PortfolioName)


SELECT 

	-- Portfolio Model
	 [Portfolio].[Id]
	,[Portfolio].[PortfolioCustomerNumber] AS [PortfolioCustomerNumber]
	,[Portfolio].[Name]				AS [Name]
	,[Portfolio].[isDeleted]		AS [isDeleted]


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

	-- Entity Model
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

	-- Sector Model
	,[Sector].[Id]					AS [Id]
	,[Sector].[Name]				AS [Name]

	-- Function Values
	--,[Func].[PortfolioId]	AS [PortfolioId]
	--,[Func].[DateKey]		AS [DateKey]
	--,[Func].[EntityId]		AS [EntityId]
	--,[Func].[SectorId]		AS [SectorId]
	,[Func].[SharesOwned]	AS [SharesOwned]
	,[Func].[CostBase]		AS [CostBase]
	,[Func].[CostPerShare]	AS [CostPerShare]
	,[Func].[CurrentPrice]	AS [CurrentPrice]
	,[Func].[MarketValue]	AS [MarketValue]
	,[Func].[ProfitLoss]	AS [ProfitLoss]
	,[Func].[ProfitLossPct]	AS [ProfitLossPct]
	,[Func].[WeightPct]		AS [WeightPct]


FROM 
	[dbo].[funRETURN_PortfolioValueOnDate5] (@PortfolioName, @RequestDate) [Func]
	INNER JOIN [dbo].[Portfolio] [Portfolio]		ON [Portfolio].[Id] = [Func].[PortfolioId]
	INNER JOIN [dbo].[Dates] [Dates]				ON [Dates].[DateKey] = [Func].[DateKey]
	INNER JOIN [dbo].[TradingEntity] [Entity]		ON [Entity].[Id] = [Func].[EntityId]
	INNER JOIN [dbo].[TradingSector] [Sector]		ON [Sector].[Id] = [Func].[SectorId]

