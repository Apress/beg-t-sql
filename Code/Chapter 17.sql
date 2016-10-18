--Listing 17-1. Create a table in SQL Database
--1
INSERT INTO dbo.NewTable(FirstName, LastName)
VALUES('Ken','Sanchez'),('Terri','Duffy'),('Roberto','Tamburello');

--2
SELECT ID, FirstName, LastName
FROM NewTable;

--Listing 17-2. Querying system tables
--1
SELECT * FROM sys.databases;

--2
SELECT * FROM sys.database_files;
