
DECLARE @DateRequest INT = 20201207

SELECT
	 [dbo].[funCONVERT_DateInt_To_DateTime](@DateRequest)
	,SUM([Portfolio].NetQtyMovement * [Prices].PriceClose)

FROM
	[dbo].[funRETURN_PortfolioOnDate](@DateRequest) AS [Portfolio]
	INNER JOIN ASXSharePrices [Prices]	ON [Prices].ASXCode = [Portfolio].ASXCode
										AND [Prices].ASXDate = @DateRequest



DECLARE @DateRequest2 DATE = '2020-12-07'

SELECT
	 @DateRequest2
	,SUM([Portfolio].NetQtyMovement * [Prices].PriceClose)

FROM
	[dbo].[funRETURN_PortfolioOnDate]([dbo].[funCONVERT_Date_To_DateInt](@DateRequest2)) AS [Portfolio]
	INNER JOIN ASXSharePrices [Prices]	ON [Prices].ASXCode = [Portfolio].ASXCode
										AND [Prices].ASXDate = [dbo].[funCONVERT_Date_To_DateInt](@DateRequest2)