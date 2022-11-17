
USE BENASXDATABASE;

--CREATE TEMP TABLE AND FILL WITH DATA
--====================================

-- Create a table of Company names
CREATE TABLE [dbo].[ASXCompaniesTemp] (
  [ASXCode]					VARCHAR(10)			NOT NULL
 ,[CompanyName]				VARCHAR(200)		NOT NULL
 ,[GICsIndustryGroup]		VARCHAR(200)		NOT NULL
)

--Insert CSV Data Into Temp Table
BULK INSERT 
	[dbo].[ASXCompaniesTemp]
FROM 
	"C:\Users\vboxuser\Documents\SQL Server Management Studio\ASXSharePrices\ShareCompaniesCSV\ASX_Listed_CompaniesNoListingDate.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
GO

--CREATE MAIN TABLE AND TRANSFER DATA
--====================================

-- Create Table for share prices and include unique IDs
CREATE TABLE [dbo].[ASXCompanies] (
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[ASXCode]					VARCHAR(10)			NOT NULL
 ,[CompanyName]				VARCHAR(200)		NOT NULL
 ,[GICsIndustryGroup]		VARCHAR(200)		NOT NULL
  CONSTRAINT [PK_CompanyId] PRIMARY KEY CLUSTERED ([Id] ASC)
ON [PRIMARY]) ON [PRIMARY]

--Transfer the Data from the temp table
INSERT [dbo].[ASXCompanies]
  (ASXCode, CompanyName, GICsIndustryGroup)
SELECT 
	ASXCode, CompanyName, GICsIndustryGroup
FROM [dbo].[ASXCompaniesTemp]

-- After transfering the temp data, delete it.
DROP TABLE [dbo].[ASXCompaniesTemp]
