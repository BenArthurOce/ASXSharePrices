


CREATE PROC [dbo].[spINSERTDATA_TradingTransaction]
(
	 @in_ContactNote				VARCHAR(12)
	,@in_PortfolioName				VARCHAR(80)
	,@in_TradingEntityASXCode		VARCHAR(7)
	,@in_Date						INT
	,@in_Type						VARCHAR(15)
	,@in_Quantity					INT
	,@in_UnitPrice					DECIMAL(10,4)
	,@in_Brokerage					DECIMAL(10,2)
)

AS
BEGIN

	SET XACT_ABORT ON

	DECLARE
		 @PortfolioId UNIQUEIDENTIFIER
		,@TradingEntityId UNIQUEIDENTIFIER
		,@TransactionTypeId UNIQUEIDENTIFIER
		,@ErrorMesssage VARCHAR(MAX)


	PRINT 'Stored Procedure:' + OBJECT_NAME(@@PROCID)
	PRINT '  Parameters:'	
	PRINT CONCAT(
	'    ',
	'[@in_ContactNote = ',@in_ContactNote,'] ',
	'[@in_PortfolioName = ',@in_PortfolioName,'] ',
	'[@in_TradingEntityASXCode = ',@in_TradingEntityASXCode,'] ',
	'[@in_Date = ',@in_Date,'] ',
	'[@in_Type = ',@in_Type,'] ',
	'[@in_Quantity = ',@in_Quantity,'] ',
	'[@in_UnitPrice = ',@in_UnitPrice,'] ',
	'[@in_Brokerage = ',@in_Brokerage,'] ')

	PRINT '  CHECKING PORTFOLIO MATCH...'
	IF EXISTS (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		BEGIN
			PRINT '    PORTFOLIO MATCH FOUND'
			SET @PortfolioId = (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		END
	IF NOT EXISTS (SELECT [Id] FROM [dbo].[Portfolio] WHERE [Name] = @in_PortfolioName)
		BEGIN
			RAISERROR('Stored Procedure Aborted. The specified portfolio does not exist', 16, 1);
			RETURN
		END


	PRINT '  CHECKING ASX CODE MATCH...'
	IF EXISTS (SELECT [Id] FROM [dbo].[TradingEntity] WHERE [ASXCode] = @in_TradingEntityASXCode)
		BEGIN
			PRINT '    ASX CODE MATCH FOUND'
			SET @TradingEntityId = (SELECT [Id] FROM [dbo].[TradingEntity] WHERE [ASXCode] = @in_TradingEntityASXCode)
		END
	IF NOT EXISTS (SELECT [Id] FROM [dbo].[TradingEntity] WHERE [ASXCode] = @in_TradingEntityASXCode)
		BEGIN
			RAISERROR('Stored Procedure Aborted. The specified ASX Code does not exist', 16, 1);
			RETURN
		END


	PRINT '  CHECKING DATE...'

-- Check length of input string and break up into years, months, days
	DECLARE
		@in_Date_Str VARCHAR(8) = CAST(@in_Date AS VARCHAR(8))

	DECLARE
			@date_year VARCHAR(4) = LEFT(@in_Date_Str, 4)
		,@date_month VARCHAR(2) = SUBSTRING(@in_Date_Str, 5, 2)
		,@date_day VARCHAR(2) = SUBSTRING(@in_Date_Str, 7, 2)


	IF NOT LEN(@in_Date) = 8
	BEGIN
		SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The value of @in_Date: ', CAST(@in_Date AS NVARCHAR(MAX)),' must be an 8 digit integer. ','(Current length: ',LEN(@in_Date),')')
		RAISERROR(@ErrorMesssage, 16, 1);
		RETURN
	END


	IF NOT @date_year BETWEEN 1990 AND 2200
	BEGIN
		SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The year value needs to be between 1990 and 2200. ', '(Current year: ', @date_year, ')')
		RAISERROR(@ErrorMesssage, 16, 1);
		RETURN
	END


	IF NOT @date_month BETWEEN 1 AND 12
	BEGIN
		SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The month value needs to be between 1 and 12. ', '(Current month: ', @date_month, ')')
		RAISERROR(@ErrorMesssage, 16, 1);
		RETURN
	END


	IF NOT @date_day BETWEEN 1 AND 31
	BEGIN
		SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The day value needs to be between 1 and 31. ', '(Current day: ', @date_day, ')')
		RAISERROR(@ErrorMesssage, 16, 1);
		RETURN
	END

	BEGIN TRY
		SET @ErrorMesssage = CONCAT('Stored Procedure Aborted. ', 'The date value is invalid. ', '(Current day: ', @in_Date, ')')
		DECLARE @date_out DATE = DATEFROMPARTS(@date_year, @date_month, @date_day)
		DECLARE @date_out_string VARCHAR(20) = CONVERT(VARCHAR(20), @date_out, 120)

		IF ISDATE(@date_out_string) = 0
			BEGIN
				RAISERROR(@ErrorMesssage, 16, 1);
			END;

		IF ISDATE(@date_out_string) = 1
			BEGIN
				PRINT '    DATE CHECK SUCCESSFUL'
			END;		
	END TRY
	BEGIN CATCH
		RAISERROR(@ErrorMesssage, 16, 1);
		RETURN
	END CATCH


	PRINT '  CHECKING QUANTITY...'
	IF ISNUMERIC(@in_Quantity) = 1
		BEGIN
			PRINT '    QUANTITY CHECK SUCCESSFUL'
		END
	IF ISNUMERIC(@in_Quantity) = 0
		BEGIN
			RAISERROR('Stored Procedure Aborted. The input parameter "in_Quantity" must be a numeric value.', 16, 1);
			RETURN;
		END;
	

	PRINT '  CHECKING TRANSACTION TYPE MATCH...'
	IF EXISTS (SELECT [Id] FROM [dbo].[TradingTransactionType] WHERE [Name] = @in_Type)
		BEGIN
			PRINT '    TRANSACTION TYPE MATCH FOUND'
			SET @TransactionTypeId = (SELECT [Id] FROM [dbo].[TradingTransactionType] WHERE [Name] = @in_Type)
		END
	IF NOT EXISTS (SELECT [Id] FROM [dbo].[TradingTransactionType] WHERE [Name] = @in_Type)
		BEGIN
			RAISERROR('Stored Procedure Aborted. The specified transaction type does not exist', 16, 1);
			RETURN
		END

	PRINT '  ATTEMPTING TO INPUT TRANSACTION...'
	PRINT '    Parameters:'	
	PRINT CONCAT(
	'      ',
	'([ContractNote] = ',UPPER(@in_ContactNote),') ',
	'([PortfolioId] = ',@PortfolioId,') ',
	'([TradingEntityId] = ',@TradingEntityId,') ',
	'([[Date]] = ',@in_Date,') ',
	'([TradingTransactionTypeId] = ',@TransactionTypeId,') ',
	'([Quantity] = ',@in_Quantity,') ',
	'([UnitPrice] = ',@in_UnitPrice,') ',
	'([Brokerage] = ',@in_Brokerage,') ',
	'([isDeleted] = ',0,') ')
	

	BEGIN TRY

		BEGIN TRANSACTION
			INSERT INTO [dbo].[TradingTransaction]
				([ContractNote], [PortfolioId], [TradingEntityId], [Date], [TradingTransactionTypeId], [Quantity], [UnitPrice], [Brokerage], [IsDeleted])
			VALUES
				(UPPER(@in_ContactNote), @PortfolioId, @TradingEntityId, @in_Date, @TransactionTypeId, @in_Quantity, @in_UnitPrice, @in_Brokerage, 0)
		COMMIT TRANSACTION
		PRINT '    TRANSACTION COMMITTED SUCCESSFULLY'
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('ERROR WAS FOUND. TRANSACTION ROLLBACK', 16, 1);
	END CATCH

END
