USE BENASXDATABASE;

--CREATE TEMP TABLE AND FILL WITH DATA
--====================================

-- Create Temp Table without Unique IDs
CREATE TABLE [dbo].[ASXSharePricesTemp](
	 [ASXCode]		VARCHAR(10)			NOT NULL
	,[ASXDate]		BIGINT				NOT NULL
	,[PriceOpen]	FLOAT				NOT NULL
	,[PriceHigh]	FLOAT				NOT NULL
	,[PriceLow]		FLOAT				NOT NULL
	,[PriceClose]	FLOAT				NOT NULL
	,[VolumeTraded]	BIGINT				null
	)

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\ASXSharePrices\CSVSharePrices\2021Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\ASXSharePrices\CSVSharePrices\2022Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

CREATE NONCLUSTERED INDEX IX_ASXSharePricesTemp_ASXDate
ON dbo.ASXSharePricesTemp (ASXDate)


CREATE NONCLUSTERED INDEX IX_ASXSharePricesTemp_ASXCode
ON dbo.ASXSharePricesTemp (ASXCode)
/*
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

*/
UPDATE [dbo].[ASXSharePricesTemp]
SET CompanyId = (SELECT [Id] FROM [dbo].[DummyTradingCompany] WHERE [DummyTradingCompany].[ASXCode] = [ASXSharePricesTemp].ASXCode)


SELECT * FROM [ASXSharePricesTemp]

-- After transfering the temp data, delete it.
