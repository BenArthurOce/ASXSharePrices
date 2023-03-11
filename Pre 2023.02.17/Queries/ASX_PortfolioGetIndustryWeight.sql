DECLARE @MyPortfolio TABLE (
					 ASXCode VARCHAR(10)
					,SharesHeld INT
					)
INSERT INTO @MyPortfolio 
	VALUES 
		 ('4DS', 15000)
		,('ANZ', 438)
		,('AVZ', 510)
		,('BEN', 560)
		,('CBA', 86)
		,('EML', 500)
		,('GNE', 1000)
		,('HLO', 700)
		,('IMM', 14700)
		,('INA', 3347)
		,('KMD', 2200)
		,('MNS', 24500)
		,('NAB', 588)
		,('QAN', 400)
		,('QBE', 387)
		,('RCE', 800)
		,('TNE', 878)
		,('WBC', 484)
		,('XRO', 74)
DECLARE
	 @StartDate INT = 20220101
	,@EndDate INT = 20221028
;

WITH [PortfolioData] AS
	(
		SELECT
			 SUM([Prices].PriceClose * [Portfolio].SharesHeld) 		AS 'HoldingValue'
			,[Companies].GICsIndustryGroup							AS 'Industry'
		FROM
			[ASXSharePrices] [Prices]
			INNER JOIN @MyPortfolio [Portfolio] ON [Portfolio].ASXCode = [Prices].ASXCode
			INNER JOIN [ASXCompanies] [Companies] ON [Companies].ASXCode = [Prices].ASXCode
		WHERE
			[Prices].ASXDate = @EndDate
		GROUP BY
			[Companies].GICsIndustryGroup
	)


SELECT 
	 [PortfolioData].Industry											AS 'Industry'
	,CAST([PortfolioData].HoldingValue AS MONEY)						AS 'Value'
	,ROUND([PortfolioData].HoldingValue * 100 / [CrsJoin].Summed,2)		AS 'Percent'

FROM
	[PortfolioData]
	CROSS JOIN (SELECT SUM([PortfolioData].HoldingValue) AS 'Summed' FROM [PortfolioData]) [CrsJoin]
