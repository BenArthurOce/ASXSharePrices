
--================================================================================================
--====================== CREATE TRANSACTION TYPES AND TRANSACTIONS================================
--================================================================================================



--Create Transaction Types
--================================
USE BENASXDATABASE
GO

CREATE TABLE [dbo].[ShareTransactionType](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Name]					VARCHAR(50)			NOT NULL
 ,[isDeleted]				BIT					NOT NULL
 ,CONSTRAINT [PK_TransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC)
 ON [PRIMARY]) ON [PRIMARY]

INSERT INTO [dbo].[ShareTransactionType]([Name], [isDeleted])
VALUES
	('Buy', 0), ('Sell', 0), ('DRP', 0), ('Other', 0)


--Create Share Transactions
--================================
CREATE TABLE [dbo].[ShareTransaction](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[SequenceNumber]	INT	IDENTITY(1,1)	NOT NULL 
	,[ContractNote]		INT
	,[ASXCode]			VARCHAR(200)		NOT NULL
	,[Date]				INT					NOT NULL
	,[TypeId]			UNIQUEIDENTIFIER	NOT NULL
	,[Quantity]			INT					NOT NULL
	,[UnitPrice]		DECIMAL(10,4)		NOT NULL
	,[TradeValue]		DECIMAL(10,4)		NOT NULL		
	,[Brokerage]		DECIMAL(10,2)		NOT NULL
	,[TotalValue]		DECIMAL(10,4)		NOT NULL
	,[IsIncrease]		BIT
	,CONSTRAINT [PK_ShareTransactionId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
	,CONSTRAINT [FK_ShareTransactionTypeId]
		FOREIGN KEY([TypeId])
		REFERENCES [ShareTransactionType]([Id])
	)


--================================================================================================
--============== CREATE TABLE OF DUMMY DATA, SORT IT AND THEN IMPUT IT IN=========================
--================================================================================================


CREATE TABLE [dbo].[ShareTransactionTEMP](
	 [ContractNote]		INT
	,[ASXCode]			VARCHAR(200)		NOT NULL
	,[Date]				INT					NOT NULL
	,[TypeId]			UNIQUEIDENTIFIER	NOT NULL
	,[Quantity]			INT					NOT NULL
	,[UnitPrice]		DECIMAL(10,4)		NOT NULL
	,[TradeValue]		DECIMAL(10,4)		NOT NULL		
	,[Brokerage]		DECIMAL(10,2)		NOT NULL
	,[TotalValue]		DECIMAL(10,4)		NOT NULL
	,[IsIncrease]		BIT
	,CONSTRAINT [FK_ShareTransactionTypeTEMPId]
		FOREIGN KEY([TypeId])
		REFERENCES [ShareTransactionType]([Id]))


--Input The Share Purchase and Sell data (not DRP)
--================================
INSERT INTO [dbo].[ShareTransactionTEMP]
	([ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease])

VALUES
	(96626059, 'CBA', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 175, 61.44, 10752, 29.95, 10781.95, 1),
	(96640705, 'BEN', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 6.29, 3145, 19.95, 3164.95, 1),
	(96641173, 'WTC', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 300, 12.6237, 3787.11, 19.95, 3807.06, 1),
	(96642745, 'TCL', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 72, 11.77, 847.44, 11, 858.44, 1),
	(96642747, 'NAB', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 49, 17.08, 836.92, 11, 847.92, 1),
	(96642748, 'JHX', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 39, 21.84, 851.76, 11, 862.76, 1),
	(96642895, 'APA', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 92, 9.09, 836.28, 11, 847.28, 1),
	(96642899, 'CSL', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 3, 298.63, 895.89, 11, 906.89, 1),
	(96642971, 'GMG', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 64, 13.1128, 839.22, 11, 850.22, 1),
	(96645733, 'QAN', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 400, 2.97, 1188, 19.95, 1207.95, 1),
	(96646679, 'NHF', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 300, 3.8, 1140, 19.95, 1159.95, 1),
	(96647215, 'CWN', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 7.28, 3640, 19.95, 3659.95, 1),
	(96658477, 'NAB', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 17.1073, 8553.67, 19.95, 8573.62, 1),
	(96658706, 'WBC', 20200316, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 450, 16.93, 7618.5, 19.95, 7638.45, 1),
	(96770737, 'CBA', 20200317, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 30, 65.5, 1965, 19.95, 1984.95, 1),
	(96914231, 'HLO', 20200319, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 700, 1.2, 840, 10, 850, 1),
	(97332546, 'APT', 20200326, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 98, 19.88, 1948.24, 19.95, 1968.19, 1),
	(97367951, 'EML', 20200327, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 2.2, 1100, 19.95, 1119.95, 1),
	(97571692, 'CSL', 20200331, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 3, 314.66, 943.98, 10, 933.98, 0),
	(97593905, 'WTC', 20200331, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 300, 17, 5100, 19.95, 5080.05, 0),
	(97727066, 'CPU', 20200402, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 500, 9.65, 4825, 19.95, 4844.95, 1),
	(97944147, 'CPU', 20200407, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 500, 10.985, 5492.5, 19.95, 5472.55, 0),
	(97979314, 'ANZ', 20200408, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 380, 15.95, 6061, 19.95, 6080.95, 1),
	(97989405, 'CWN', 20200408, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 500, 8.02, 4010, 19.95, 3990.05, 0),
	(97989759, 'LNK', 20200408, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 1570, 3.18, 4992.6, 19.95, 5012.55, 1),
	(98156390, 'TCL', 20200414, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 72, 12.41, 893.52, 10, 883.52, 0),
	(98176671, 'CBA', 20200414, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 205, 62, 12710, 29.95, 12680.05, 0),
	(98178418, 'INA', 20200414, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 2280, 3.075, 7011, 19.95, 7030.95, 1),
	(98187840, 'VGL', 20200414, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 4800, 1.1575, 5555.78, 19.95, 5575.73, 1),
	(98217477, 'APT', 20200415, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 98, 27.01, 2646.98, 19.95, 2627.03, 0),
	(98232003, 'NHF', 20200415, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 300, 5.045, 1513.5, 19.95, 1493.55, 0),
	(98299549, 'LNK', 20200416, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 1570, 3.5102, 5510.99, 19.95, 5491.04, 0),
	(98415844, 'IMM', 20200417, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 18000, 0.165, 2970, 19.95, 2989.95, 1),
	(98417120, 'URW', 20200417, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 1000, 4.91, 4910, 19.95, 4929.95, 1),
	(98536451, 'CBA', 20200421, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 82, 59.9, 4911.8, 19.95, 4931.75, 1),
	(105179095, 'VGL', 20200827, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 4800, 1.4072, 6754.47, 19.95, 6734.52, 0),
	(105424002, 'TNE', 20200901, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 878, 7.937, 6968.7, 19.95, 6988.65, 1),
	(106207007, 'QBE', 20200915, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 375, 9.35, 3506.25, 19.95, 3526.2, 1),
	(111720366, 'KMD', 20210112, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 2200, 1.18, 2595.98, 19.95, 2615.93, 1),
	(112686693, 'APA', 20210128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 92, 9.6918, 891.65, 10, 881.65, 0),
	(112689701, 'IMM', 20210128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 7500, 0.42, 3150, 19.95, 3169.95, 1),
	(116730347, 'RCE', 20210409, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 800, 1.17, 936, 10, 946, 1),
	(119735488, 'IMM', 20210622, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 18000, 0.57, 10260, 29.95, 10230.05, 0),
	(120038073, 'TECH', 20210630, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 110, 95.57, 10512.7, 29.95, 10542.65, 1),
	(123342493, 'MNS', 20210914, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 6500, 0.36, 2340, 19.95, 2359.95, 1),
	(125882681, 'NEW', 20211104, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 4000, 0.8175, 3270, 19.95, 3289.95, 1),
	(125882851, 'SKI', 20211104, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 1100, 2.835, 3118.5, 19.95, 3138.45, 1),
	(125882969, 'GNE', 20211104, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 1000, 3.12, 3120, 19.95, 3139.95, 1),
	(125925627, '4DS', 20211105, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 15000, 0.0685, 1027.5, 19.95, 1047.45, 1),
	(126017909, 'TECH', 20211108, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 110, 103.7168, 11408.85, 29.95, 11378.9, 0),
	(126018035, 'MNS', 20211108, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 18000, 0.665, 11970, 29.95, 11999.95, 1),
	(127915087, 'IMM', 20211224, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 7200, 0.49, 3528, 19.95, 3547.95, 1),
	(128451058, 'AVZ', 20220112, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 510, 0.965, 492.15, 10, 502.15, 1),
	(129297108, 'NEW', 20220128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 4000, 0.815, 3260, 19.95, 3240.05, 0),
	(129297231, 'URW', 20220128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 1000, 5.125, 5125, 19.95, 5105.05, 0),
	(129297295, 'JHX', 20220128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 39, 45.671, 1781.17, 19.95, 1761.22, 0),
	(129297364, 'GMG', 20220128, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Sell'), 64, 22.55, 1443.2, 19.95, 1423.25, 0),
	(130259157, 'XRO', 20220223, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 74, 100.31, 7422.94, 19.95, 7442.89, 1),
	(130649857, 'INA', 20220303, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'Buy'), 1000, 5.0672, 5067.24, 19.95, 5087.19, 1)


--Input The DRP Data
--================================
INSERT INTO [dbo].[ShareTransactionTEMP]
	([ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease])

VALUES
	('INA', 20210325, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 23, 4.8484, 111.5132, 0, 111.5132, 1),
	('BEN', 20210331, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 14, 9.72, 136.08, 0, 136.08, 1),
	('WBC', 20210625, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 10, 25.98, 259.8, 0, 259.8, 1),
	('ANZ', 20210701, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 9, 27.91, 251.19, 0, 251.19, 1),
	('NAB', 20210702, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 12, 26.65, 319.8, 0, 319.8, 1),
	('INA', 20210923, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 20, 6.244, 124.88, 0, 124.88, 1),
	('QBE', 20210924, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 3, 11.84, 35.52, 0, 35.52, 1),
	('CBA', 20210929, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 1, 101, 101, 0, 101, 1),
	('BEN', 20210930, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 14, 9.49, 132.86, 0, 132.86, 1),
	('NAB', 20211215, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 13, 28, 364, 0, 364, 1),
	('ANZ', 20211216, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 10, 27.68, 276.8, 0, 276.8, 1),
	('WBC', 20211221, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 12, 22.34, 268.08, 0, 268.08, 1),
	('INA', 20220324, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 24, 5.06, 121.44, 0, 121.44, 1),
	('CBA', 20220330, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 2, 97.95, 195.9, 0, 195.9, 1),
	('BEN', 20220331, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 15, 9.7, 145.5, 0, 145.5, 1),
	('QBE', 20220412, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 6, 11.12, 66.72, 0, 66.72, 1),
	('WBC', 20220624, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 12, 23.96, 287.52, 0, 287.52, 1),
	('ANZ', 20220701, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 11, 25.52, 280.72, 0, 280.72, 1),
	('NAB', 20220705, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 14, 31.35, 438.9, 0, 438.9, 1),
	('QBE', 20220923, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 3, 12.12, 36.36, 0, 36.36, 1),
	('BEN', 20220926, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 17, 8.55, 145.35, 0, 145.35, 1),
	('CBA', 20220929, (SELECT [Id] FROM [ShareTransactionType] WHERE [Name] = 'DRP'), 1, 96.44, 96.44, 0, 96.44, 1)


--================================================================================================
--============== COPY DATA FROM TEMP TABLE TO MAIN TABLE, DELETE THE TEMP TABLE===================
--================================================================================================


--Transfer the Data from the temp table
INSERT INTO [dbo].[ShareTransaction]
	([ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease])

SELECT
	[ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease]
FROM
	[dbo].[ShareTransactionTEMP] [TEMP]
ORDER BY
	[TEMP].[Date], [TEMP].ContractNote

-- After transfering the temp data, delete it.
DROP TABLE [dbo].[ShareTransactionTEMP]



