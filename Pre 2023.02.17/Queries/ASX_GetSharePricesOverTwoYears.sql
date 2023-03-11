	DECLARE
		 @in_ASXCode	VARCHAR(10)		= 'CBA'
		,@in_FirstYear	BIGINT			= 2020

	DECLARE
		 @in_SecondYear BIGINT			= @in_FirstYear + 1

	SELECT 
		 [Dates].[DateKey]
		,[Dates].[DayInt]
		,[Dates].[MonthInt]
		,[Dates].[YearCalendar]
		,[Prices].PriceClose

	FROM 
		[dbo].[AllDates] [Dates]
		LEFT JOIN [dbo].[ASXSharePrices] [Prices] ON ([Prices].ASXDate = [Dates].DateKey AND [Prices].ASXCode = @in_ASXCode)

	WHERE
	[Dates].[YearCalendar] BETWEEN @in_FirstYear and @in_SecondYear

	ORDER BY
		[Dates].DateKey
