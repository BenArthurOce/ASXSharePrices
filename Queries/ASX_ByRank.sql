

SELECT
	[ASXSharePrices].*
	,[Dates].FullDayStringLong AS 'Date'
FROM
	[dbo].[ASXSharePrices] [ASXSharePrices]
	INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [ASXSharePrices].ASXDate
WHERE
	[ASXSharePrices].ASXCode IN ('ANZ', 'CBA', 'NAB', 'WBC', 'BEN', 'BOQ')



SELECT 
	 in_ASXCode
	,in_RecordNum
	,in_VolumeTraded 
	--,in_Rank

FROM (
    SELECT 
		 ASXCode		AS 'in_ASXCode'
		,RecordNum		AS 'in_RecordNum'
		,VolumeTraded	AS 'in_VolumeTraded'
		,Rank()			--AS 'in_Rank'
        OVER (PARTITION BY ASXCode
            ORDER BY VolumeTraded DESC ) AS Rank
    FROM 
			[dbo].[ASXSharePrices] [ASXSharePrices]
			INNER JOIN [dbo].[Dates] [Dates] ON [Dates].DateKey = [ASXSharePrices].ASXDate
    ) rs 
WHERE 
	Rank <= 10
	AND rs.in_ASXCode IN ('ANZ', 'CBA', 'NAB', 'WBC', 'BEN', 'BOQ')