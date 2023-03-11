USE BENASXDATABASE;

--CREATE TEMP TABLE AND FILL WITH DATA
--====================================

-- Create Temp Table without Unique IDs
CREATE TABLE [dbo].[ASXSharePricesTemp](
	 [ASXCode]		VARCHAR(10)			null
	,[ASXDate]		INT					null
	,[PriceOpen]	FLOAT				null
	,[PriceHigh]	FLOAT				null
	,[PriceLow]		FLOAT				null
	,[PriceClose]	FLOAT				null
	,[VolumeTraded]	INT					null
	)

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\ASXSharePrices\CSVSharePrices\2019Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--Insert CSV Data
BULK INSERT 
	[dbo].[ASXSharePricesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\ASXSharePrices\CSVSharePrices\2020Import.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

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

--CREATE MAIN TABLE AND TRANSFER DATA
--====================================

-- Create Table for share prices and include unique IDs
CREATE TABLE [dbo].[ASXEODPrice] (
	 [Id]			UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[ASXCode]		VARCHAR(10)			NULL
	,[Date]			INT				    NULL 
	,[PriceOpen]	FLOAT				NULL
	,[PriceHigh]	FLOAT				NULL
	,[PriceLow]		FLOAT				NULL
	,[PriceClose]	FLOAT				NULL
	,[VolumeTraded]	INT					NULL
	,CONSTRAINT [PK_ASXEODPriceId] PRIMARY KEY CLUSTERED ([Id] ASC)
	ON [PRIMARY]) ON [PRIMARY]




--Transfer the Data from the temp table
INSERT [dbo].[ASXEODPrice]
  ([ASXCode], [Date], [PriceOpen], [PriceHigh], [PriceLow], [PriceClose], [VolumeTraded])
SELECT 
	ASXCode, ASXDate, PriceOpen, PriceHigh, PriceLow, PriceClose, VolumeTraded
FROM [dbo].[ASXSharePricesTemp]

-- After transfering the temp data, delete it.
DROP TABLE [dbo].[ASXSharePricesTemp]



ALTER TABLE [ASXEODPrice]
ADD CONSTRAINT [FK_Dates_DateKey_ASXEODPrice_Date]
	FOREIGN KEY ([Date])
	REFERENCES [dbo].[Dates] ([DateKey])


CREATE NONCLUSTERED INDEX IX_ASXEODPrice_Date
ON dbo.ASXEODPrice ([Date])

CREATE NONCLUSTERED INDEX IX_ASXEODPrice_ASXCode
ON dbo.ASXEODPrice ([ASXCode])

