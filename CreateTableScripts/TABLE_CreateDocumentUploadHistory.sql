-- Create Table that stores information regarding the text files uploaded
CREATE TABLE [dbo].[DocumentUploadHistory](
	-- [DocumentUploadId]			UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	 [FilePath]					VARCHAR(100)		NOT NULL
	,[FileName]					VARCHAR(100)		NOT NULL
	,[DateTimeUploaded]			DATETIME			NOT NULL
	,[FileSizeBytes]			BIGINT				NOT NULL
	,[RowsInFile]				BIGINT				NOT NULL
)

DROP TABLE [dbo].[DocumentUploadHistory]