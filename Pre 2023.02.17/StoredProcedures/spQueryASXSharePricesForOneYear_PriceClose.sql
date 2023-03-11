USE [BENASXDATABASE]
GO

CREATE PROC spQueryASXSharePricesForOneYear_PriceClose
	(
		 @in_ASXCode	VARCHAR(10)
		,@in_Year		BIGINT
	)
AS
BEGIN

	SET NOCOUNT ON ;

	SELECT 
		 [Dates].[DateKey]			AS [DateKey]
		,[Dates].[DayInt]			AS [DayInt]
		,[Dates].[MonthInt]			AS [MonthInt]
		,[Dates].[YearCalendar]		AS [YearCalendar]
		,[Prices].[PriceClose]		AS [Price]

	FROM 
		[dbo].[AllDates] [Dates]
		LEFT JOIN [dbo].[ASXSharePrices] [Prices] ON ([Prices].ASXDate = [Dates].DateKey AND [Prices].ASXCode = @in_ASXCode)

	WHERE
	[Dates].[YearCalendar] = @in_Year

	ORDER BY
		[Dates].DateKey


END
