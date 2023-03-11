CREATE FUNCTION [dbo].[funRETURN_PortfolioValueOnDate]
	(
		@date_in INT

	)
RETURNS INT
AS
BEGIN
	
	DECLARE @value_out INT = 0

	;
	WITH [ShareHoldings] AS
	(
		SELECT
			 [Trans].[ASXCode]				AS 'ASXCode'
			,SUM(
				CASE
					WHEN [Trans].IsIncrease = 1 THEN [Trans].Quantity
					WHEN [Trans].IsDecrease = 1 THEN [Trans].Quantity * -1
					END
				)AS 'SharesHeld'
		FROM
			ShareTransactions [Trans]
		WHERE
			[Trans].[Date] <= @date_in
		GROUP BY
			 [Trans].[ASXCode]

	)
	SELECT 
		@value_out = SUM([ShareHoldings].SharesHeld * [Prices].PriceClose)
	FROM 
		[ShareHoldings]
		INNER JOIN ASXSharePrices [Prices]	
				ON [Prices].ASXCode = [ShareHoldings].ASXCode
				AND [Prices].ASXDate = @date_in

	RETURN @value_out
END