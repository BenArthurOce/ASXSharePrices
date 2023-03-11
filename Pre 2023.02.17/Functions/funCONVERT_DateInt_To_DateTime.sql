CREATE FUNCTION funCONVERT_DateInt_To_DateTime
	(
		 @date_in INT
	)
RETURNS DATE

BEGIN 
	
	DECLARE 
		 @year		VARCHAR(4) = SUBSTRING(CAST(@date_in AS NVARCHAR(8)),1,4)
		,@month		VARCHAR(2) = SUBSTRING(CAST(@date_in AS NVARCHAR(8)),5,2)
		,@day		VARCHAR(2) = SUBSTRING(CAST(@date_in AS NVARCHAR(8)),7,2)
		,@date_out	DATE

	SET
		@date_out = DATEFROMPARTS(@year, @month, @day)

	RETURN
		@date_out
END 