USE [BENASXDATABASE]
GO

CREATE PROC spRETURN_AllShareTransactions

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT
		   [Transactions].[Id]
		  ,[Transactions].[ContractNote]
		  ,[Transactions].[ASXCode]
		  ,[Transactions].[Date]
		  ,[Types].[Type]
		  ,[Transactions].[TypeId]
		  ,[Transactions].[Quantity]
		  ,[Transactions].[UnitPrice]
		  ,[Transactions].[TradeValue]
		  ,[Transactions].[Brokerage]
		  ,[Transactions].[TotalValue]
		  ,[Transactions].[IsIncrease]
		  ,[Transactions].[IsDecrease]
	FROM 
		[dbo].[ShareTransactions] [Transactions]
		INNER JOIN [dbo].[ShareTransactionTypes] [Types] ON [Types].[Id] = [Transactions].[TypeId]

	ORDER BY
		 [Transactions].[Date]
		,[Transactions].[ContractNote]

END