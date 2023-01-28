USE [BENASXDATABASE]
GO

CREATE PROC spINSERT_DocumentUploadRecord
	(
		  @in_FilePath			VARCHAR(MAX)
		 ,@in_FileName			VARCHAR(30)
		 ,@in_DateTimeUpload	DATETIME
		 ,@in_FileSizeBytes		INT
		 ,@in_RowsInFile		INT
	)
	
AS
BEGIN

	SET NOCOUNT ON ;

	INSERT INTO [dbo].[DocumentUploadHistory]([FilePath], [FileName], [DateTimeUploaded], [FileSizeBytes], [RowsInFile])
	VALUES
		(@in_FilePath, LOWER(@in_FileName), @in_DateTimeUpload, @in_FileSizeBytes, @in_RowsInFile)

END
