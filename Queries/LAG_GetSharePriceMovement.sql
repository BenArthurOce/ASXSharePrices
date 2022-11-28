
DECLARE 
	 @input_DateStart	INT		= 20200301
	,@input_DateEnd		INT		= 20200430
	,@input_ASXCode		VARCHAR(10)	= 'ANZ'

DECLARE
	 @DateStart			DATETIME = [dbo].[funCONVERT_DateInt_To_DateTime] (@input_DateStart)
	,@DateEnd			DATETIME = [dbo].[funCONVERT_DateInt_To_DateTime] (@input_DateEnd)	
;

WITH [DataSet] AS
(
	SELECT 
		 [dbo].[funCONVERT_DateInt_To_DateTime] ([Prices].ASXDate)		AS 'TradingDate'
		,[Prices].ASXCode		AS 'ASXCode'
		,[Prices].PriceOpen		AS 'PriceOpen'
		,[Prices].PriceHigh		AS 'PriceHigh'
		,[Prices].PriceLow		AS 'PriceLow'
		,[Prices].PriceClose	AS 'PriceClose'
		,[Prices].VolumeTraded	AS 'VolumeTraded'

	FROM
		[dbo].[ASXSharePrices] [Prices]
	WHERE
		[Prices].ASXCode = @input_ASXCode
)

SELECT 
	*
	,ROUND(
		((
			[DataSet].PriceClose
			/
			LAG([DataSet].PriceClose) OVER(PARTITION BY [DataSet].ASXCode ORDER BY [DataSet].TradingDate)
		) - 1) * 100
		,2) AS 'Movement'

FROM 
	[DataSet]
WHERE
	[DataSet].TradingDate BETWEEN @DateStart AND @DateEnd