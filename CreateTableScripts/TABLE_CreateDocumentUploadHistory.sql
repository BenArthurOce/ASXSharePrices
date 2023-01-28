-- Create Table that stores information regarding the text files uploaded
CREATE TABLE [dbo].[DocumentUploadHistory](
	 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[FilePath]					VARCHAR(MAX)		NOT NULL
	,[FileName]					VARCHAR(30)			NOT NULL
	,[DateTimeUploaded]			DATETIME			NOT NULL
	,[FileSizeBytes]			BIGINT				NOT NULL
	,[RowsInFile]				BIGINT				NOT NULL
)

--DROP TABLE [dbo].[DocumentUploadHistory]