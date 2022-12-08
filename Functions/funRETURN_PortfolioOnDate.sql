CREATE FUNCTION funRETURN_PortfolioOnDate
	(
		 @date_in INT
	)
RETURNS TABLE
AS
RETURN

	SELECT
		 [Trans].ASXCode				AS 'ASXCode'
		,SUM(
			CASE
				WHEN [Trans].IsIncrease = 1 THEN [Trans].Quantity
				WHEN [Trans].IsDecrease = 1 THEN [Trans].Quantity * -1
				END
			)AS 'NetQtyMovement'
	FROM
		ShareTransactions [Trans]
	WHERE
		[Trans].Date <= @date_in
	GROUP BY
		[Trans].ASXCode
