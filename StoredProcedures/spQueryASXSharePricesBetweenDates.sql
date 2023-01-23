USE [BENASXDATABASE]
GO

CREATE PROC spQueryASXSharePricesBetweenDates
	(
		 @in_ASXCode	VARCHAR(10)
		,@in_StartDate	BIGINT
		,@in_EndDate	BIGINT
	)
AS
BEGIN

	SET NOCOUNT ON ;

	SELECT *
	FROM [dbo].[ASXSharePrices] [Prices]
	WHERE ([Prices].ASXDate BETWEEN @in_StartDate AND @in_EndDate) AND ([Prices].ASXCode = @in_ASXCode)
	ORDER BY [Prices].ASXDate
			,[Prices].ASXCode;

END