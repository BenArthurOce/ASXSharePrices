USE BENASXDATABASE;

--CREATE TEMP TABLE AND FILL WITH DATA
--====================================

-- Create Temp Table without Unique IDs
CREATE TABLE [dbo].[ASXSharePricesTemp](
	 [RecordNum]	BIGINT				not null
	,[ASXCode]		VARCHAR(10)			null
	,[ASXDate]		BIGINT				null
	,[PriceOpen]	FLOAT				null
	,[PriceHigh]	FLOAT				null
	,[PriceLow]		FLOAT				null
	,[PriceClose]	FLOAT				null
	,[VolumeTraded]	BIGINT				null
	)

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\SharePricesCSV\2019Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\SharePricesCSV\2020Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\SharePricesCSV\2021Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\SharePricesCSV\2022Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--CREATE MAIN TABLE AND TRANSFER DATA
--====================================

-- Create Table for share prices and include unique IDs
CREATE TABLE [dbo].[ASXSharePrices] (
	 [Id]			UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[RecordNum]	BIGINT				not null
	,[ASXCode]		VARCHAR(10)			null
	,[ASXDate]		BIGINT				null
	,[PriceOpen]	FLOAT				null
	,[PriceHigh]	FLOAT				null
	,[PriceLow]		FLOAT				null
	,[PriceClose]	FLOAT				null
	,[VolumeTraded]	BIGINT				null
	,CONSTRAINT [PK_SharePriceId] PRIMARY KEY CLUSTERED ([Id] ASC)
	ON [PRIMARY]) ON [PRIMARY]

--Transfer the Data from the temp table
insert [dbo].[ASXSharePrices]
  (RecordNum, ASXCode, ASXDate, PriceOpen, PriceHigh, PriceLow, PriceClose, VolumeTraded)
select 
	RecordNum, ASXCode, ASXDate, PriceOpen, PriceHigh, PriceLow, PriceClose, VolumeTraded
from [dbo].[ASXSharePricesTemp]

-- After transfering the temp data, delete it.
DROP TABLE [dbo].[ASXSharePricesTemp]