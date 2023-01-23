USE [BENASXDATABASE]
GO

CREATE PROC spQueryASXSharePricesForOneYear_PriceOpen
	(
		 @in_ASXCode	VARCHAR(10)
		,@in_Year		BIGINT
	)
AS
BEGIN

	SET NOCOUNT ON ;

	SELECT 
		 [Dates].[DateKey]
		,[Dates].[DayInt]
		,[Dates].[MonthInt]
		,[Dates].[YearCalendar]
		,[Prices].[PriceOpen]

	FROM 
		[dbo].[AllDates] [Dates]
		LEFT JOIN [dbo].[ASXSharePrices] [Prices] ON ([Prices].ASXDate = [Dates].DateKey AND [Prices].ASXCode = @in_ASXCode)

	WHERE
	[Dates].[YearCalendar] = @in_Year

	ORDER BY
		[Dates].DateKey


END
