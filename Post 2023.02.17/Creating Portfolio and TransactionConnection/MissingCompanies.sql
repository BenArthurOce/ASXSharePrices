
SELECT 
	[Prices].ASXCode
	,COUNT(*) AS 'Count'
FROM 
	[ASXSharePricesTemp] [Prices] 
WHERE 
	CompanyId IS NULL
GROUP BY
	[Prices].ASXCode
ORDER BY 'Count' DESC



SELECT * FROM [ASXSharePricesTemp] [Prices] WHERE [Prices].ASXCode = 'YPB'


--NOTES:
--8/DEC/2022 (Chase Mining Corporation Limited) GOES FROM CML TO CGM ON 12 DECE


-- Chase Mining Corporation Limited (CML) into Green Critical Minerals Limited (GCM) 12/Dec/2022
-- CML COULD ALSO BE COLES MYER

--https://www2.asx.com.au/listings/how-to-list/guides-rules-and-resources/delisted-entities