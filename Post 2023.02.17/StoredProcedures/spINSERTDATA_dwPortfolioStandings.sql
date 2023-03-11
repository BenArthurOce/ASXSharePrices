USE [BENASXDATABASE]
GO

CREATE TYPE [dbo].[PortfolioList] AS TABLE (
    [PortfolioName]		NVARCHAR(100)		 NOT NULL
)
GO

CREATE PROCEDURE spINSERTDATA_dwPortfolioStandings
	(
		 @in_PortfolioList [PortfolioList] READONLY
		,@in_StartDate INT
		,@in_EndDate INT
	)
AS
BEGIN
    SET NOCOUNT ON


	DECLARE @myCounter INT = 0;
	DECLARE @myMax INT = (SELECT COUNT(*) FROM @in_PortfolioList)
	DECLARE @myValue VARCHAR(50);
	DECLARE @PortfolioId UNIQUEIDENTIFIER;

	WHILE @myCounter < @myMax
		BEGIN

			--PRINT 'CHECK 1'
			SET @myValue = (SELECT [PortfolioName] FROM
				  (SELECT (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) [index] , [PortfolioName] from @in_PortfolioList) R 
				   ORDER BY R.[index] OFFSET @myCounter 
				   ROWS FETCH NEXT 1 ROWS ONLY);


			PRINT 'CHECK 2'
			SET @PortfolioId = (SELECT TOP 1 [Id] FROM [dbo].[Portfolio] WHERE [Portfolio].[Name] = @myValue)
			PRINT 'CHECK 3'
			PRINT @PortfolioId

			INSERT INTO [dbo].[DW_PortfolioStandings] ([PortfolioId], [DateKey], [EntityId], [SharesOwned], [CostBase], [CostPerShare], [CurrentPrice], [MarketValue], [ProfitLoss], [ProfitLossPct], [WeightPct])


			SELECT 
				 @myValue			AS [PortfolioId]
				,[Dates].[DateKey]		AS [DateKey]
				,[func].*
			FROM [dbo].[Dates] [Dates]

			CROSS APPLY (
				SELECT *
				FROM [dbo].[funRETURN_PortfolioValueOnDate4] (@myValue, [Dates].[DateKey])
			) AS [func]
			WHERE [Dates].[DateKey] BETWEEN @in_StartDate AND @in_EndDate

			OPTION (maxrecursion 30000);
			--PRINT 'CHECK 4'

		SET @myCounter = @myCounter + 1
		END

END

/*
DROP PROC [dbo].[spINSERTDATA_dwPortfolioStandings]
DROP TYPE [dbo].[PortfolioList]
*/