USE [BENASXDATABASE]
GO

CREATE PROC spINSERT_ShareTransactionType
	(
		 @in_TransType	VARCHAR(10)
	)
AS
BEGIN

	SET NOCOUNT ON ;

	INSERT INTO [dbo].[ShareTransactionTypes]([Type])
	VALUES
		(@in_TransType)

END