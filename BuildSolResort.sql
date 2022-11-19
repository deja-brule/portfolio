-- SolResort developed and written by Deja Brule
-----------------------------------------------------------

-- create database 
--
IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'SolResort')
	CREATE DATABASE SolResort
GO


 


--
-- delete previous tables 
--


USE SolResort
GO
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Reservation'
	)
	DROP TABLE Reservation;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Guest'
	)
	DROP TABLE Guest;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Guest_Type'
	)
	DROP TABLE Guest_Type;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Spa_Treatment'
	)
	DROP TABLE Spa_Treatment;
-- 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Spa_Type'
	)
	DROP TABLE Spa_Type;
-- 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Room'
	)
	DROP TABLE Room;
-- 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Room_Type'
	)
	DROP TABLE Room_Type;
-- 



--
-- create tables 
--



--
CREATE TABLE Guest_Type
	(Guest_Type_ID		INT NOT NULL CONSTRAINT pk_guest_type PRIMARY KEY,
	Membership_Level	NVARCHAR(10)
	);
--
CREATE TABLE Guest
	(Guest_ID			INT NOT NULL CONSTRAINT pk_guest PRIMARY KEY,
	Guest_Type_ID		INT CONSTRAINT fk_guest_type FOREIGN KEY REFERENCES Guest_Type(Guest_Type_ID),
	Home_State			NVARCHAR(30) NOT NULL,
	Num_Kids			INT NOT NULL
	);
--
--
--
CREATE TABLE Spa_Type
	(Spa_Type_ID		INT NOT NULL CONSTRAINT pk_spa PRIMARY KEY,
	Spa_Type			NVARCHAR(20) NOT NULL
	);
--
CREATE TABLE Spa_Treatment
	(Treatment_ID		INT NOT NULL CONSTRAINT pk_treatment PRIMARY KEY, 
	Spa_Type_ID			INT CONSTRAINT fk_spa_type FOREIGN KEY REFERENCES Spa_Type(Spa_Type_ID),
	Treatment_Name		NVARCHAR(30) NOT NULL,
	Treatment_Price		INT NOT NULL
	);
--
--
--
CREATE TABLE Room_Type
	(Room_Type_ID		INT NOT NULL CONSTRAINT pk_room_type PRIMARY KEY,
	Room_Type			NVARCHAR(30) NOT NULL,
	Num_Beds			INT NOT NULL
	);
--
CREATE TABLE Room
	(Room_Number		INT NOT NULL CONSTRAINT pk_room PRIMARY KEY,
	Room_Type_ID		INT CONSTRAINT fk_room_type FOREIGN KEY REFERENCES Room_Type(Room_Type_ID),
	Room_Capacity		INT NOT NULL
	);
--
--
--
CREATE TABLE Reservation
	(Reservation_ID		INT NOT NULL CONSTRAINT pk_reservation PRIMARY KEY,
	Guest_ID			INT CONSTRAINT fk_guest FOREIGN KEY REFERENCES Guest(Guest_ID),
	Treatment_ID		INT CONSTRAINT fk_treatment FOREIGN KEY REFERENCES Spa_Treatment(Treatment_ID),
	Room_Number			INT CONSTRAINT fk_room FOREIGN KEY REFERENCES Room(Room_Number),
	CheckIn_Date		datetime NOT NULL,
	CheckOut_Date		datetime NOT NULL,
	Reservation_Price	int NOT NULL
	);
--





-- load data 


DECLARE
@data_path NVARCHAR(50);
SELECT @data_path = 'C:\resort files\';




EXECUTE (N'BULK INSERT Guest_Type FROM ''' + @data_path + N'GUEST_TYPE.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');


EXECUTE (N'BULK INSERT Guest FROM ''' + @data_path + N'GUEST.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');




EXECUTE (N'BULK INSERT Spa_Type FROM ''' + @data_path + N'SPA_TYPE.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');



EXECUTE (N'BULK INSERT Spa_Treatment FROM ''' + @data_path + N'SPA_TREATMENT.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');

EXECUTE (N'BULK INSERT Room_Type FROM ''' + @data_path + N'ROOM_TYPE.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');


EXECUTE (N'BULK INSERT Room FROM ''' + @data_path + N'ROOM.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');



EXECUTE (N'BULK INSERT Reservation FROM ''' + @data_path + N'RESERVATION.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');