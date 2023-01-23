-- Create Temp Table without Unique IDs
CREATE TABLE [dbo].[ASXSharePricesTemp2](
	 [ASXCode]		VARCHAR(10)			null
	,[ASXDate]		BIGINT				null
	,[PriceOpen]	FLOAT				null
	,[PriceHigh]	FLOAT				null
	,[PriceLow]		FLOAT				null
	,[PriceClose]	FLOAT				null
	,[VolumeTraded]	BIGINT				null
	)
DROP TABLE [dbo].[ASXSharePricesTemp2]