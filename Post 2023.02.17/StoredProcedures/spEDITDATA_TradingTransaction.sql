


CREATE PROC [dbo].[spEDITDATA_TradingTransaction]
(
	--Original Transaction Values
	 @orig_ContactNote				VARCHAR(12)
	,@orig_PortfolioName			VARCHAR(80)
	,@orig_TradingEntityASXCode		VARCHAR(7)
	,@orig_Date						INT
	,@orig_Type						VARCHAR(15)
	,@orig_Quantity					INT
	,@orig_UnitPrice				DECIMAL(10,4)
	,@orig_TradeValue				DECIMAL(10,4)
	,@orig_Brokerage				DECIMAL(10,2)
	,@orig_TotalValue				DECIMAL(10,2)

	--New Transaction Values
	,@update_ContactNote			VARCHAR(12)
	,@update_PortfolioName			VARCHAR(80)
	,@update_TradingEntityASXCode	VARCHAR(7)
	,@update_Date					INT
	,@update_Type					VARCHAR(15)
	,@update_Quantity				INT
	,@update_UnitPrice				DECIMAL(10,4)
	,@update_TradeValue				DECIMAL(10,4)
	,@update_Brokerage				DECIMAL(10,2)
	,@update_TotalValue				DECIMAL(10,2)
)

AS
BEGIN

	SET XACT_ABORT ON

	DECLARE
		  @orig_PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @orig_PortfolioName)
		 ,@update_PortfolioNameId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Portfolio] WHERE [Portfolio].[Name] = @orig_PortfolioName)
	DECLARE
		 @orig_TradingEntityId UNIQUEIDENTIFIER = (SELECT [Id] FROM [TradingEntity] WHERE [TradingEntity].[ASXCode] = @orig_TradingEntityASXCode)
		,@update_TradingEntityId UNIQUEIDENTIFIER = (SELECT [Id] FROM [TradingEntity] WHERE [TradingEntity].[ASXCode] = @update_TradingEntityASXCode)
	DECLARE
		 @orig_TransactionTypeId UNIQUEIDENTIFIER = (SELECT [Id] FROM [TradingTransactionType] WHERE [TradingTransactionType].[Name] = @orig_Type)
		,@update_TransactionTypeId UNIQUEIDENTIFIER = (SELECT [Id] FROM [TradingTransactionType] WHERE [TradingTransactionType].[Name] = @update_Type)

	DECLARE
		 @ErrorMesssage VARCHAR(MAX)


	PRINT 'Stored Procedure:' + OBJECT_NAME(@@PROCID)
	PRINT '  Parameters:'	


	-- Find the ID of the Transaction
	DECLARE
		@TransactionToAdjust UNIQUEIDENTIFIER =
		(
			SELECT TOP 1
				 [Tran].[Id]

			FROM		[dbo].[TradingTransaction] [Tran]
			INNER JOIN	[dbo].[TradingEntity] [Entity] ON [Entity].Id = [Tran].TradingEntityId
			INNER JOIN	[dbo].[Portfolio] ON [Portfolio].Id = [Tran].PortfolioId
			INNER JOIN	[dbo].[TradingTransactionType] [Type] ON [Type].Id = [Tran].TradingTransactionTypeId

			WHERE 
				[Portfolio].[Id] = @orig_PortfolioNameId
			AND [Tran].[ContractNote] = @orig_ContactNote
			AND [Entity].[Id] = @orig_TradingEntityId
			AND [Tran].[Date] = @orig_Date
			AND [Type].[Id] = @orig_TransactionTypeId
			AND [Type].[Name] = @orig_Type
			AND [Tran].[Quantity] = @orig_Quantity
			AND [Tran].[UnitPrice] = @orig_UnitPrice
			AND [Tran].[TradeValue] = @orig_TradeValue
			AND [Tran].[Brokerage] = @orig_Brokerage
			AND [Tran].[TotalValue] = @orig_TotalValue
		)



	BEGIN TRY

		BEGIN TRANSACTION

			UPDATE [dbo].[TradingTransaction]
			SET	 
				 [ContractNote] = @update_ContactNote
				,[PortfolioId] = @update_PortfolioNameId
				,[TradingEntityId] = @update_TradingEntityId
				,[Date] = @update_Date
				,[TradingTransactionTypeId] = @update_TransactionTypeId
				,[Quantity] = @update_Quantity
				,[UnitPrice] = @update_UnitPrice
				--,[TradeValue] = @update_TradeValue
				,[Brokerage] = @update_Brokerage
				--,[TotalValue] = @update_TotalValue

			WHERE [Id] = @TransactionToAdjust

		COMMIT TRANSACTION
		PRINT '    TRANSACTION COMMITTED SUCCESSFULLY'
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('ERROR WAS FOUND. TRANSACTION ROLLBACK', 16, 1);
	END CATCH

END
