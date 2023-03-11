CREATE FUNCTION funRETURN_FinancialYearFromDate
	(
		 @date_in DATE
	)
RETURNS VARCHAR(4)

	BEGIN 

		DECLARE @Month INT = MONTH(@date_in)
		DECLARE @Year INT = YEAR(@date_in)

		IF @Month BETWEEN 1 and 6
		BEGIN
			RETURN @Year
		END

		IF @Month BETWEEN 7 and 12
		BEGIN
			RETURN @Year + 1
		END

		RETURN 0

	END