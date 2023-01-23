USE [BENASXDATABASE]
GO

CREATE PROC spQueryTransactionTypes

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT [Types].[Type]
	FROM [dbo].[ShareTransactionTypes] [Types]

END