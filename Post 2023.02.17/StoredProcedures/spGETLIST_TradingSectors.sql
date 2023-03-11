USE [BENASXDATABASE]
GO

CREATE PROC spGETLIST_TradingSectors

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT [Sectors].[Name]
	FROM [dbo].[TradingSector] [Sectors]
	ORDER BY [Sectors].[Name]

END

