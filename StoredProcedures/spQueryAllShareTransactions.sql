USE [BENASXDATABASE]
GO

CREATE PROC spQueryAllShareTransactions

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT
		   [Transaction].[Id]
		  ,[Transaction].[ContractNote]
		  ,[Transaction].[ASXCode]
		  ,[Transaction].[Date]
		  ,[Type].[Name] [Type]
		  ,[Transaction].[Quantity]
		  ,[Transaction].[UnitPrice]
		  ,[Transaction].[TradeValue]
		  ,[Transaction].[Brokerage]
		  ,[Transaction].[TotalValue]
		  ,[Transaction].[IsIncrease]

	FROM 
		[dbo].[ShareTransaction] [Transaction]
		INNER JOIN [dbo].[ShareTransactionType] [Type] ON [Type].[Id] = [Transaction].[TypeId]

	ORDER BY
		 [Transaction].[Date]
		,[Transaction].[ContractNote]

END