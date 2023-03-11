USE [BENASXDATABASE]
GO

CREATE PROC spInsertIntoTradingCompany
(
	 @in_ASXCode		VARCHAR(10)
	,@in_ASXName		VARCHAR(400)
	,@in_Sector			VARCHAR(50)
	,@in_isLICS			BIT
	,@in_isAREIT		BIT
	,@in_isETP			BIT
	,@in_isIndices		BIT
	,@in_isABFund		BIT
	,@in_isDerivative	BIT
	,@in_Notes			NVARCHAR(400)
)

AS
BEGIN

	SET NOCOUNT ON ;
	SET XACT_ABORT ON;

	DECLARE
		 @SectorId UNIQUEIDENTIFIER
		,@ErrorMesssage VARCHAR(MAX)


	PRINT 'Stored Procedure:' + OBJECT_NAME(@@PROCID)
	PRINT '  Parameters:'	
	PRINT CONCAT(
	 '    '
	,'[@in_ASXCode = ',@in_ASXCode,'] '
	,'[@in_ASXName = ',@in_ASXName,'] '
	,'[@in_Sector = ',@in_Sector,'] '
	,'[@in_isLICS = ',@in_isLICS,'] '
	,'[@in_isAREIT = ',@in_isAREIT,'] '
	,'[@in_isETP = ',@in_isETP,'] '
	,'[@in_isIndices = ',@in_isIndices,'] '
	,'[@in_isABFund = ',@in_isABFund,'] '
	,'[@in_isDerivative = ',@in_isDerivative,'] '	
	,'[@in_Notes = ',@in_Notes,'] '	
	)


--------------------------------------------------------
	PRINT '  CHECKING ASX CODE LENGTH'
	IF LEN(@in_ASXCode) NOT BETWEEN 3 AND 7
		BEGIN
			SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The length of the ASX Entered was an incorrect number of characters. ','(Current length: ',LEN(@in_ASXCode),')')
			RAISERROR(@ErrorMesssage, 16, 1);
			RETURN
		END
	IF LEN(@in_ASXCode) BETWEEN 3 AND 7
		BEGIN
			PRINT '    ASX CODE LENGTH ACCEPTED'
		END


--------------------------------------------------------
	PRINT '  ATTEMPTING TO RENAME TRADING SECTOR...'
	DECLARE @returned_sector_name VARCHAR(50)
	SET @returned_sector_name =
		CASE
		WHEN @in_Sector LIKE '%Energy%' THEN 'Energy'
		WHEN @in_Sector LIKE '%Coal%' THEN 'Energy'
		WHEN @in_Sector LIKE '%Gas%' THEN 'Energy'
		WHEN @in_Sector LIKE '%Materials%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Chemical%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Construction%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Container%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Package%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Packaging%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Metal%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Mining%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Paper%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Forest%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Aluminum%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Gold%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Steel%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Silver%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Copper%' THEN 'Materials'
		WHEN @in_Sector LIKE '%Industrials%' THEN 'Industrials'
		WHEN @in_Sector LIKE '%Transportation%' THEN 'Industrials'
		WHEN @in_Sector LIKE '%Professional Services%' THEN 'Industrials'
		WHEN @in_Sector LIKE '%Capital Goods%' THEN 'Industrials'
		WHEN @in_Sector LIKE '%Discretionary%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Auto%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Casino%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Gaming%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Resort%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Cruise%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Leisure%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Resturant%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Apparel%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Retailing%' THEN 'Consumer Discretionary'
		WHEN @in_Sector LIKE '%Consumer Staples%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Food%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Staples%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Tobacco%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Household%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Personal Product%' THEN 'Consumer Staples'
		WHEN @in_Sector LIKE '%Health%' THEN 'Health Care'
		WHEN @in_Sector LIKE '%Care%' THEN 'Health Care'
		WHEN @in_Sector LIKE '%Pharm%' THEN 'Health Care'
		WHEN @in_Sector LIKE '%Bio%' THEN 'Health Care'
		WHEN @in_Sector LIKE '%Bank%' THEN 'Financials'
		WHEN @in_Sector LIKE '%Financial%' THEN 'Financials'
		WHEN @in_Sector LIKE '%Market%' THEN 'Financials'
		WHEN @in_Sector LIKE '%Mortgage%' THEN 'Financials'
		WHEN @in_Sector LIKE '%Insurance%' THEN 'Financials'
		WHEN @in_Sector LIKE '%Information Technology%' THEN 'Information Technology'
		WHEN @in_Sector LIKE '%Information%' THEN 'Information Technology'
		WHEN @in_Sector LIKE '%Software%' THEN 'Information Technology'
		WHEN @in_Sector LIKE '%Hardware%' THEN 'Information Technology'
		WHEN @in_Sector LIKE '%Semiconduct%' THEN 'Information Technology'
		WHEN @in_Sector LIKE '%Communication Services%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Media%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Entertainment%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Communication%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Advert%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Broadcast%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Publish%' THEN 'Communication Services'
		WHEN @in_Sector LIKE '%Utilities%' THEN 'Utilities'
		WHEN @in_Sector LIKE '%Utility%' THEN 'Utilities'
		WHEN @in_Sector LIKE '%Water%' THEN 'Utilities'
		WHEN @in_Sector LIKE '%Real Estate%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%Estate%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%Retail REIT%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%Office REIT%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%Residential REIT%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%Specialized REIT%' THEN 'Real Estate'
		WHEN @in_Sector LIKE '%REIT%' THEN 'Real Estate'
		ELSE 'Unknown, Other'
	END
	PRINT CONCAT('    SECTOR RETURNED IS: ',@returned_sector_name)


	PRINT '  ATTEMPTING TO MATCH TRADING SECTOR...'
	IF EXISTS (SELECT [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = @returned_sector_name)
		BEGIN
			SET @SectorId = (SELECT TOP 1 [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = @returned_sector_name);
			PRINT '    TRADING SECTOR SET';
		END

	ELSE
		BEGIN
			SET @SectorId = (SELECT TOP 1 [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = 'Unknown, Other')
			PRINT '    TRADING SECTOR SET TO: UNKNOWN/OTHER';
		END

--------------------------------------------------------
	PRINT '  ATTEMPTING TO SET TRADING ENTITY NOTES...'
		IF LEN(@in_Notes) < 1
			BEGIN
				PRINT '    NOTES SET TO NULL'
				SET @in_Notes = NULL
			END
		IF LEN(@in_Notes) > 1
			BEGIN
				PRINT '    NOTES ACCEPTED'
				SET @in_Notes = NULL
			END


--------------------------------------------------------
	PRINT '  ATTEMPTING TO INPUT TRANSACTION...'
	PRINT '    Parameters:'	
	PRINT CONCAT(
		'    '
	,'[[ASXCode] = ',@in_ASXCode,'] '
	,'[[Name] = ',@in_ASXName,'] '
	,'[[SectorId] = ',@SectorId,'] '
	,'[[isLICS] = ',@in_isLICS,'] '
	,'[[isA-REIT] = ',@in_isAREIT,'] '
	,'[[isETP] = ',@in_isETP,'] '
	,'[[isIndices] = ',@in_isIndices,'] '
	,'[[isABFund] = ',@in_isABFund,'] '
	,'[[isDerivative] = ',@in_isDerivative,'] '
	,'[[Notes] = ',@in_Notes,'] '
	)

	BEGIN TRY
		BEGIN TRANSACTION
			SET @ErrorMesssage = 'Stored Procedure Aborted. An unknown error occured'
	
			INSERT INTO [dbo].[DummyTradingCompany]
				([ASXCode], [Name], [SectorId], [isLICS], [isA-REIT], [isETP], [isIndices], [isABFund], [isDerivative], [Notes])
			VALUES
				(UPPER(@in_ASXCode), UPPER(@in_ASXName), @SectorId, @in_isLICS, @in_isAREIT, @in_isETP, @in_isIndices, @in_isABFund, @in_isDerivative, @in_Notes)

			COMMIT TRANSACTION
			PRINT '    TRANSACTION COMMITTED SUCCESSFULLY'

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR(@ErrorMesssage, 16, 1);
	END CATCH

END