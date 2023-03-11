-- Create Table that stores information regarding the text files uploaded
CREATE TABLE [dbo].[DocumentUploadHistory](
	 [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[FilePath]					VARCHAR(700)		NOT NULL
	,[FileName]					VARCHAR(30)			NOT NULL
	,[DateTimeUploaded]			DATETIME			NOT NULL
	,[FileSizeBytes]			INT					NOT NULL
	,[RowsInFile]				INT					NOT NULL
)

--DROP TABLE [dbo].[DocumentUploadHistory]