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
			 [Prices].ASXCode				AS 'ASXCode'
			,[Prices].ASXDate				AS 'ASXDate'
			,[Prices].PriceClose			AS 'PriceClose'
			,[Portfolio].SharesHeld			AS 'SharesHeld'
			,	[Prices].PriceClose * 
				[Portfolio].SharesHeld 		AS 'HoldingValue'
		FROM
			[ASXSharePrices] [Prices]
			INNER JOIN @MyPortfolio [Portfolio] ON [Portfolio].ASXCode = [Prices].ASXCode
		WHERE
			[Prices].ASXDate BETWEEN @StartDate AND @EndDate
	)


SELECT 
	 [PortfolioData].ASXDate							AS 'Date'
	,CAST(SUM([PortfolioData].HoldingValue) AS MONEY)	AS 'Value'
FROM
	[PortfolioData]
GROUP BY
	[PortfolioData].ASXDate
ORDER BY
	[PortfolioData].ASXDate
