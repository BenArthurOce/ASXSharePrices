USE [BENASXDATABASE]
GO

CREATE PROC spInsertNewShareTransaction
	(
		 @in_PortfolioOwner VARCHAR(200)
		,@in_ContractNote INT
		,@in_ASXCode VARCHAR(20)
		,@in_Date INT
		,@in_Type VARCHAR(20)
		,@in_Quantity INT
		,@in_UnitPrice DECIMAL(10, 4)
		,@in_TradeValue DECIMAL(10, 4)
		,@in_Brokerage DECIMAL(10, 2)
		,@in_TotalValue DECIMAL(10, 4)
	)
AS
BEGIN

	SET NOCOUNT ON ;

	DECLARE
		 @PorffolioOwnerId		UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = @in_PortfolioOwner)
		,@TransactionTypeId		UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[ShareTransactionType] WHERE [ShareTransactionType].[Name] = @in_Type)

	DECLARE
		 @IsIncrease			BIT				 =  CASE
														WHEN @in_Type = 'Buy' THEN 1
														WHEN @in_Type = 'Sell' THEN 0
														WHEN @in_Type = 'DRP' THEN 1
														WHEN @in_Type = 'Other' THEN 1
													END


		IF (@PorffolioOwnerId IS NULL) OR (@TransactionTypeId IS NULL) OR (@IsIncrease IS NULL) 
		BEGIN
			RAISERROR ('Invalid PortfolioOwner Type, IncreaseType', 16, 1)
			RETURN
		END

														
	INSERT INTO [dbo].[ShareTransaction] 
		(
		 [ContractNote]			--column: 1
		,[ASXCode]				--column: 2
		,[Date]					--column: 3
		,[TypeId]				--column: 4
		,[Quantity]				--column: 5
		,[UnitPrice]			--column: 6
		,[TradeValue]			--column: 7
		,[Brokerage]			--column: 8
		,[TotalValue]			--column: 9
		,[IsIncrease]			--column: 10
		)
	VALUES
		(
		 @in_ContractNote		--column: 1
		,@in_ASXCode			--column: 2
		,@in_Date				--column: 3
		,@TransactionTypeId		--column: 4
		,@in_Quantity			--column: 5
		,@in_UnitPrice			--column: 6
		,@in_TradeValue			--column: 7
		,@in_Brokerage			--column: 8
		,@in_TotalValue			--column: 9
		,@IsIncrease			--column: 10
		);

DECLARE
	@MostRecentTransId UNIQUEIDENTIFIER	= (SELECT TOP 1 [Id] FROM [dbo].[ShareTransaction] ORDER BY SequenceNumber DESC)

	INSERT INTO [dbo].[PortfolioShareTransactionConnector] 
		(
		 [PortfolioId] 			--column: 1
		,[ShareTransactionId]	--column: 2
		)
	VALUES
		(
		 @PorffolioOwnerId 		--column: 1
		,@MostRecentTransId		--column: 2
		)
END