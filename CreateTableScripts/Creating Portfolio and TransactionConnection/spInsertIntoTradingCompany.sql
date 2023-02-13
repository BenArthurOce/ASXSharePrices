USE [BENASXDATABASE]
GO

CREATE PROC spInsertIntoTradingCompany
(
	 @in_ASXCode		VARCHAR(10)
	,@in_ASXName		VARCHAR(400)
	,@in_Sector			VARCHAR(50)
)

AS
BEGIN

	SET NOCOUNT ON ;

	DECLARE
		@Sector UNIQUEIDENTIFIER


	BEGIN TRY

		BEGIN TRANSACTION

			-- Look for the Trading Sector Name
			IF EXISTS
			(
				SELECT [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = @in_Sector
			)
				SET @Sector = (SELECT TOP 1 [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = @in_Sector)
			ELSE
				SET @Sector = (SELECT TOP 1 [Id] FROM [dbo].[DummyTradingSector] WHERE [Name] = 'Unknown, Other')


			-- Insert into Trading Company
			INSERT INTO [dbo].[DummyTradingCompany]
				([ASXCode], [Name], [SectorId])
			VALUES
				(UPPER(@in_ASXCode), UPPER(@in_ASXName), @Sector)

			COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		PRINT 'ERROR WAS FOUND. TRANSACTION ROLLBACK'
	END CATCH
END


