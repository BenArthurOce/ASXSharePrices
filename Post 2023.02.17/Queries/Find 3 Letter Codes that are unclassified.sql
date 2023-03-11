
SELECT 

 [Entity].[ASXCode]
,[Entity].[Name]
,[Sector].[Name]


FROM TradingEntity [Entity]
INNER JOIN [dbo].[TradingSector] [Sector] ON [Sector].Id = [Entity].SectorId


WHERE [Sector].[Name] = 'Unspecified'

AND
	LEN([Entity].[ASXCode]) = 3
	AND [Entity].isETP = 0
	AND [Entity].isIndices = 0