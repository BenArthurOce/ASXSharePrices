USE [BENASXDATABASE]
GO

CREATE PROC spQueryPortfolios

AS
BEGIN

	SET NOCOUNT ON ;

	SELECT 
		 [Portfolios].[Name]			AS [Name]


	FROM 
		[dbo].[Portfolio] [Portfolios]


	WHERE
	[Portfolios].[isDeleted] = 0

	ORDER BY
		[Portfolios].[Name]


END
