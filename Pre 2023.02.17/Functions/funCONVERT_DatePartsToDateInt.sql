CREATE FUNCTION funCONVERT_DatePartsToDateInt
	(
		  @year_in	INT
		 ,@month_in INT
		 ,@day_in	INT
	)
RETURNS VARCHAR(8)

BEGIN 
	
	DECLARE
		  @year_out		VARCHAR(4) = FORMAT(
										CAST(@year_in AS NUMERIC)
										,'0000')

		 ,@month_out	VARCHAR(2) = FORMAT(
										CAST(@month_in AS NUMERIC)
										,'00')

		 ,@day_out		VARCHAR(2) = FORMAT(
										CAST(@day_in AS NUMERIC)
										,'00')

	RETURN
		CONCAT(@year_out,@month_out,@day_out)
END 