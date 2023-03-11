





DECLARE @MyTableVariable AS [dbo].[StockCodeList]

INSERT INTO @MyTableVariable ([CodeName]) VALUES ('CXO'), ('JBH'), ('MFG'), ('SUN'), ('VGS'), ('WPL')



EXEC [dbo].[spQUERY_SharePricesOneMonth] @MyTableVariable