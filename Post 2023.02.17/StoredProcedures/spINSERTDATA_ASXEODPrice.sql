USE [BENASXDATABASE]
GO

CREATE TYPE [dbo].[TempASXShareTable] AS TABLE (
	 [ASXCode]		VARCHAR(10)			NOT NULL
	,[ASXDate]		INT					NOT NULL
	,[PriceOpen]	FLOAT				NOT NULL
	,[PriceHigh]	FLOAT				NOT NULL
	,[PriceLow]		FLOAT				NOT NULL
	,[PriceClose]	FLOAT				NOT NULL
	,[VolumeTraded]	INT					NOT NULL
	)
GO

CREATE PROCEDURE spINSERTDATA_ASXEODPrice
	(
		@data [TempASXShareTable] READONLY
	)
AS
BEGIN
    SET NOCOUNT ON;

	--Transfer the Data from the temp table
	INSERT [dbo].[ASXEODPrice]
	  ([ASXCode], [Date], [PriceOpen], [PriceHigh], [PriceLow], [PriceClose], [VolumeTraded])
	SELECT 
		ASXCode, ASXDate, PriceOpen, PriceHigh, PriceLow, PriceClose, VolumeTraded
	FROM @data
END

--DROP TYPE [dbo].[TempASXShareTable]
