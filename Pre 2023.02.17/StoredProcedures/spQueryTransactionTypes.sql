USE [BENASXDATABASE]
GO

CREATE PROC spQueryTransactionTypes

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT [Types].[Name]
	FROM [dbo].[ShareTransactionType] [Types]
	WHERE [Types].[isDeleted] = 0
	ORDER BY [Types].[Name]

END