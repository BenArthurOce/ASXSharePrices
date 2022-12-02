CREATE FUNCTION funRETURN_OrdinalFromNumber
	(
		 @number_in INT
	)
RETURNS VARCHAR(2)

	BEGIN 
		DECLARE @value_extracted VARCHAR(5)
		SET @number_in = ISNULL(@number_in,0);

		-- Extract a 1 or 2 digit number
		IF LEN(@number_in) = 1
			BEGIN
				SET @value_extracted = RIGHT(@number_in,1)	
			END 

			ELSE
				BEGIN
					SET @value_extracted = RIGHT(@number_in,2)
				END


		-- If the number is between 10-20, return "th"
		IF @value_extracted BETWEEN 10 AND 20
			BEGIN
				RETURN 'th'
			END

			-- Otherwise, check the last digit and return accordingly
			ELSE
				BEGIN
					IF RIGHT(@value_extracted,1) = 1
						BEGIN
							RETURN 'st'
						END
					IF RIGHT(@value_extracted,1) = 2
						BEGIN
							RETURN 'nd'
						END
					IF RIGHT(@value_extracted,1) = 3
						BEGIN
							RETURN 'rd'
						END
					ELSE
						BEGIN
							RETURN 'th'
						END
				END
		RETURN 'eh'
	END		
				