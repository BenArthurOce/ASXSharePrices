
--Create Transaction Types
--================================
USE BENASXDATABASE
GO

CREATE TABLE [dbo].[TransactionTypes](
  [Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
 ,[Type]					VARCHAR(200)		NOT NULL
 ,CONSTRAINT [PK_TransactionTypeId] PRIMARY KEY CLUSTERED ([Id] ASC)
 ON [PRIMARY]) ON [PRIMARY]

INSERT INTO [dbo].[TransactionTypes]([Type])
VALUES
	('Buy'), ('Sell'), ('DRP'), ('Other')


--Create Share Transactions
--================================
CREATE TABLE [dbo].[ShareTransactions](
	 [Id]				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID()
	,[ContractNote]		INT
	,[ASXCode]			VARCHAR(200)		NOT NULL
	,[Date]				INT					NOT NULL
	,[TypeId]			UNIQUEIDENTIFIER	NOT NULL
	,[Quantity]			INT					NOT NULL
	,[UnitPrice]		DECIMAL(10,4)		NOT NULL
	,[TradeValue]		DECIMAL(10,4)		NOT NULL		
	,[Brokerage]		DECIMAL(10,2)		NOT NULL
	,[TotalValue]		DECIMAL(10,4)		NOT NULL
	,[IsIncrease]		BIT					NOT NULL				
	,[IsDecrease]		BIT					NOT NULL		
	,CONSTRAINT [PK_TransactionId] PRIMARY KEY CLUSTERED ([Id] ASC) ON [PRIMARY]
	,CONSTRAINT [FK_TransactionTypeId]
		FOREIGN KEY([TypeId])
		REFERENCES [TransactionTypes]([Id])
	)

INSERT INTO [dbo].[ShareTransactions]
	([ContractNote], [ASXCode], [Date], [TypeId], [Quantity], [UnitPrice], [TradeValue], [Brokerage], [TotalValue], [IsIncrease], [IsDecrease])


VALUES
	(96626059, 'CBA', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 175, 61.44, 10752, 29.95, 10781.95, 1, 0),
	(96640705, 'BEN', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 500, 6.29, 3145, 19.95, 3164.95, 1, 0),
	(96641173, 'WTC', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 300, 12.6237, 3787.11, 19.95, 3807.06, 1, 0),
	(96642745, 'TCL', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 72, 11.77, 847.44, 11, 858.44, 1, 0),
	(96642747, 'NAB', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 49, 17.08, 836.92, 11, 847.92, 1, 0),
	(96642748, 'JHX', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 39, 21.84, 851.76, 11, 862.76, 1, 0),
	(96642895, 'APA', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 92, 9.09, 836.28, 11, 847.28, 1, 0),
	(96642899, 'CSL', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 3, 298.63, 895.89, 11, 906.89, 1, 0),
	(96642971, 'GMG', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 64, 13.1128, 839.22, 11, 850.22, 1, 0),
	(96645733, 'QAN', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 400, 2.97, 1188, 19.95, 1207.95, 1, 0),
	(96646679, 'NHF', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 300, 3.8, 1140, 19.95, 1159.95, 1, 0),
	(96647215, 'CWN', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 500, 7.28, 3640, 19.95, 3659.95, 1, 0),
	(96658477, 'NAB', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 500, 17.1073, 8553.67, 19.95, 8573.62, 1, 0),
	(96658706, 'WBC', 20200316, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 450, 16.93, 7618.5, 19.95, 7638.45, 1, 0),
	(96770737, 'CBA', 20200317, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 30, 65.5, 1965, 19.95, 1984.95, 1, 0),
	(96914231, 'HLO', 20200319, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 700, 1.2, 840, 10, 850, 1, 0),
	(97332546, 'APT', 20200326, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 98, 19.88, 1948.24, 19.95, 1968.19, 1, 0),
	(97367951, 'EML', 20200327, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 500, 2.2, 1100, 19.95, 1119.95, 1, 0),
	(97571692, 'CSL', 20200331, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 3, 314.66, 943.98, 10, 933.98, 0, 1),
	(97593905, 'WTC', 20200331, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 300, 17, 5100, 19.95, 5080.05, 0, 1),
	(97727066, 'CPU', 20200402, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 500, 9.65, 4825, 19.95, 4844.95, 1, 0),
	(97944147, 'CPU', 20200407, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 500, 10.985, 5492.5, 19.95, 5472.55, 0, 1),
	(97979314, 'ANZ', 20200408, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 380, 15.95, 6061, 19.95, 6080.95, 1, 0),
	(97989405, 'CWN', 20200408, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 500, 8.02, 4010, 19.95, 3990.05, 0, 1),
	(97989759, 'LNK', 20200408, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 1570, 3.18, 4992.6, 19.95, 5012.55, 1, 0),
	(98156390, 'TCL', 20200414, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 72, 12.41, 893.52, 10, 883.52, 0, 1),
	(98176671, 'CBA', 20200414, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 205, 62, 12710, 29.95, 12680.05, 0, 1),
	(98178418, 'INA', 20200414, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 2280, 3.075, 7011, 19.95, 7030.95, 1, 0),
	(98187840, 'VGL', 20200414, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 4800, 1.1575, 5555.78, 19.95, 5575.73, 1, 0),
	(98217477, 'APT', 20200415, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 98, 27.01, 2646.98, 19.95, 2627.03, 0, 1),
	(98232003, 'NHF', 20200415, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 300, 5.045, 1513.5, 19.95, 1493.55, 0, 1),
	(98299549, 'LNK', 20200416, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 1570, 3.5102, 5510.99, 19.95, 5491.04, 0, 1),
	(98415844, 'IMM', 20200417, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 18000, 0.165, 2970, 19.95, 2989.95, 1, 0),
	(98417120, 'URW', 20200417, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 1000, 4.91, 4910, 19.95, 4929.95, 1, 0),
	(98536451, 'CBA', 20200421, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 82, 59.9, 4911.8, 19.95, 4931.75, 1, 0),
	(105179095, 'VGL', 20200827, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 4800, 1.4072, 6754.47, 19.95, 6734.52, 0, 1),
	(105424002, 'TNE', 20200901, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 878, 7.937, 6968.7, 19.95, 6988.65, 1, 0),
	(106207007, 'QBE', 20200915, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 375, 9.35, 3506.25, 19.95, 3526.2, 1, 0),
	(111720366, 'KMD', 20210112, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 2200, 1.18, 2595.98, 19.95, 2615.93, 1, 0),
	(112686693, 'APA', 20210128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 92, 9.6918, 891.65, 10, 881.65, 0, 1),
	(112689701, 'IMM', 20210128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 7500, 0.42, 3150, 19.95, 3169.95, 1, 0),
	(116730347, 'RCE', 20210409, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 800, 1.17, 936, 10, 946, 1, 0),
	(119735488, 'IMM', 20210622, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 18000, 0.57, 10260, 29.95, 10230.05, 0, 1),
	(120038073, 'TECH', 20210630, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 110, 95.57, 10512.7, 29.95, 10542.65, 1, 0),
	(123342493, 'MNS', 20210914, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 6500, 0.36, 2340, 19.95, 2359.95, 1, 0),
	(125882681, 'NEW', 20211104, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 4000, 0.8175, 3270, 19.95, 3289.95, 1, 0),
	(125882851, 'SKI', 20211104, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 1100, 2.835, 3118.5, 19.95, 3138.45, 1, 0),
	(125882969, 'GNE', 20211104, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 1000, 3.12, 3120, 19.95, 3139.95, 1, 0),
	(125925627, '4DS', 20211105, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 15000, 0.0685, 1027.5, 19.95, 1047.45, 1, 0),
	(126017909, 'TECH', 20211108, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 110, 103.7168, 11408.85, 29.95, 11378.9, 0, 1),
	(126018035, 'MNS', 20211108, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 18000, 0.665, 11970, 29.95, 11999.95, 1, 0),
	(127915087, 'IMM', 20211224, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 7200, 0.49, 3528, 19.95, 3547.95, 1, 0),
	(128451058, 'AVZ', 20220112, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 510, 0.965, 492.15, 10, 502.15, 1, 0),
	(129297108, 'NEW', 20220128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 4000, 0.815, 3260, 19.95, 3240.05, 0, 1),
	(129297231, 'URW', 20220128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 1000, 5.125, 5125, 19.95, 5105.05, 0, 1),
	(129297295, 'JHX', 20220128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 39, 45.671, 1781.17, 19.95, 1761.22, 0, 1),
	(129297364, 'GMG', 20220128, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Sell'), 64, 22.55, 1443.2, 19.95, 1423.25, 0, 1),
	(130259157, 'XRO', 20220223, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 74, 100.31, 7422.94, 19.95, 7442.89, 1, 0),
	(130649857, 'INA', 20220303, (SELECT [Id] FROM [TransactionTypes] WHERE [Type] = 'Buy'), 1000, 5.0672, 5067.24, 19.95, 5087.19, 1, 0)





--DROP TABLE [ShareTransactions]
--DROP TABLE [TransactionTypes]

SELECT * FROM [ShareTransactions] WHERE [ASXCode] = 'CBA' ORDER BY [Date]