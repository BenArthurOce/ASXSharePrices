
CREATE TABLE [dbo].[DW_PortfolioStandings](
	 [Id]					INT	IDENTITY(1,1)	NOT NULL
	,[PortfolioId]			UNIQUEIDENTIFIER	NOT NULL 
	,[DateKey]				INT					NOT NULL
	,[EntityId]				UNIQUEIDENTIFIER	NOT NULL
	,[SectorId]				UNIQUEIDENTIFIER	NOT NULL
	,[SharesOwned]			INT					NOT NULL
	,[CostBase]				DECIMAL(18, 2)		NOT NULL
	,[CostPerShare]			DECIMAL(18, 3)		NOT NULL
	,[CurrentPrice]			FLOAT				NOT NULL
	,[MarketValue]			FLOAT				NOT NULL
	,[ProfitLoss]			DECIMAL(18, 2)		NOT NULL
	,[ProfitLossPct]		DECIMAL(18, 2)		NOT NULL
	,[WeightPct]			DECIMAL(18, 2)		NOT NULL
	,CONSTRAINT [PK_dwPortfolioStandings] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
)

