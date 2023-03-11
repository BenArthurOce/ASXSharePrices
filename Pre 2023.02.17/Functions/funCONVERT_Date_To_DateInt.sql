CREATE FUNCTION funCONVERT_Date_To_DateInt
	(
		 @date_in DATE
	)
RETURNS INT

BEGIN 
	
	DECLARE
		  @year_out		VARCHAR(4) = FORMAT(
										CAST(YEAR(@date_in) AS NUMERIC)
										,'0000')

		 ,@month_out	VARCHAR(2) = FORMAT(
										CAST(MONTH(@date_in) AS NUMERIC)
										,'00')

		 ,@day_out		VARCHAR(2) = FORMAT(
										CAST(DAY(@date_in) AS NUMERIC)
										,'00')

	RETURN
		CAST(CONCAT(@year_out,@month_out,@day_out) AS INT)
END 