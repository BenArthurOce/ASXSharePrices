USE [BENASXDATABASE]
GO

CREATE PROC spGETLIST_TransactionTypes

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT [Types].[Name]
	FROM [dbo].[ShareTransactionType] [Types]
	WHERE [Types].[isDeleted] = 0
	ORDER BY [Types].[Name]

END