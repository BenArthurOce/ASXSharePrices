CREATE INDEX IX_TradingEntity_ASXCode
ON [dbo].[TradingEntity] (ASXCode);

CREATE INDEX IX_TradingTransaction_PortfolioId
ON [dbo].[TradingTransaction] (PortfolioId);

CREATE INDEX IX_TradingTransaction_TradingEntityId
ON [dbo].[TradingTransaction] (TradingEntityId);




--IX_ASXEODPrice_ASXCode
--IX_ASXEODPrice_Date
--IX_Dates_DateKey