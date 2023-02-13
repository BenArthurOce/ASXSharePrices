USE [BENASXDATABASE]
GO

CREATE PROC spInsertIntoShareTransaction
(
	 @in_ContactNote		VARCHAR(10)
	,@in_PortfolioName		VARCHAR(80)
	,@in_CompanyCode		VARCHAR(7)
	,@in_Date				INT
	,@in_Type				VARCHAR(15)
	,@in_Quantity			INT
	,@in_UnitPrice			DECIMAL(10,4)
	,@in_Brokerage			DECIMAL(10,2)
)

AS
BEGIN

	DECLARE
		 @PortfolioId UNIQUEIDENTIFIER
		,@TradingCompanyId UNIQUEIDENTIFIER
		,@TransactionTypeId UNIQUEIDENTIFIER

	--Check for matching Portfolio
	IF EXISTS (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = @in_PortfolioName)
		SET @PortfolioId = (SELECT [Id] FROM [dbo].[DummyPortfolio] WHERE [Name] = @in_PortfolioName)
	ELSE
		RAISERROR('Stored Procedure Aborted. The specified portfolio does not exist', 16, 1);
		RETURN

	-- Check for matching ASX Code
	IF EXISTS (SELECT [Id] FROM [dbo].[DummyTradingCompany] WHERE [ASXCode] = @in_CompanyCode)
		SET @TradingCompanyId = (SELECT [Id] FROM [dbo].[DummyTradingCompany] WHERE [ASXCode] = @in_CompanyCode)
	ELSE
		RAISERROR('Stored Procedure Aborted. The specified ASX Code does not exist', 16, 1);
		RETURN

	-- Check Date
	IF NOT ISNUMERIC(@in_Date) = 0
	BEGIN
		RAISERROR('Stored Procedure Aborted. The input parameter "in_Date" must be a numeric value.', 16, 1);
		RETURN;
	END;

	-- Check length of input string and break up into years, months, days
	BEGIN TRY
		IF NOT LEN(@in_Date) = 8
		BEGIN
			RAISERROR('Stored Procedure Aborted. The input parameter "in_Date" must be an 8 digit int in a "YYYYMMDD" value.', 16, 1);
			RETURN;
		END;

		DECLARE 
			@date_input_string VARCHAR(8) = CONVERT(VARCHAR(8), @in_Date)

		DECLARE
			 @date_year VARCHAR(4) = LEFT(@date_input_string,4)
			,@date_month VARCHAR(2) = SUBSTRING(@date_input_string, 5, 2)
			,@date_day  VARCHAR(2) = SUBSTRING(@date_input_string, 7, 2)
	END TRY
	BEGIN CATCH
		RAISERROR('Stored Procedure Aborted. The input parameter "in_Date" must be an 8 digit int in a "YYYYMMDD" value.', 16, 1);
	END CATCH


	-- Combine into Date format and check actual date
	BEGIN TRY
		DECLARE @date_out DATE = DATEFROMPARTS(@date_year, @date_month, @date_day)
		DECLARE @date_out_string VARCHAR(20) = CONVERT(VARCHAR(20), @date_out, 120)
		IF ISDATE(@date_out_string) = 0
			BEGIN
				RAISERROR('Date value passed to stored procedure is invalid.', 16, 1);
				RETURN;
			END;
	END TRY

	BEGIN CATCH
		RAISERROR('Date value passed to stored procedure is invalid.', 16, 1);
	END CATCH

	-- Check Quantity
	IF NOT ISNUMERIC(@in_Quantity) = 0
	BEGIN
		RAISERROR('Stored Procedure Aborted. The input parameter "in_Quantity" must be a numeric value.', 16, 1);
		RETURN;
	END;

	-- Check for Matching Transaction Type
	IF EXISTS (SELECT [Id] FROM [dbo].[DummyShareTransactionType] WHERE [Name] = @in_Type)
		SET @TransactionTypeId = (SELECT [Id] FROM [dbo].[DummyShareTransactionType] WHERE [Name] = @in_Type)
	ELSE
		RAISERROR('Stored Procedure Aborted. The specified transaction type does not exist', 16, 1);
		RETURN



	BEGIN TRY

		BEGIN TRANSACTION
			INSERT INTO [dbo].[DummyShareTransaction]
				([ContractNote], [PortfolioId], [CompanyId], [Date], [TypeId], [Quantity], [UnitPrice], [Brokerage], [IsDeleted])
			VALUES
				(UPPER(@in_ContactNote), @PortfolioId, @TradingCompanyId, @in_Date, @TransactionTypeId, @in_Quantity, @in_UnitPrice, @in_Brokerage, 0)
		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		PRINT 'ERROR WAS FOUND. TRANSACTION ROLLBACK'
	END CATCH
END
