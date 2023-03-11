
DECLARE 
	 @input_DateStart	INT		= 20220701
	,@input_DateEnd		INT		= 20220830
	,@input_ASXCode		VARCHAR(10)	= 'CBA'

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
	,LAG([DataSet].VolumeTraded) OVER(PARTITION BY [DataSet].ASXCode ORDER BY [DataSet].TradingDate) AS 'PriorDayTrading'
FROM 
	[DataSet]
WHERE
	[DataSet].TradingDate BETWEEN @DateStart AND @DateEnd