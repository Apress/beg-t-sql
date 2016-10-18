SELECT * FROM sys.databases; 

--Listing 1-1. Script to Create the AdventureWorks2012 Database
--CHANGE FILE PATH!!!!
CREATE DATABASE AdventureWorks ON (FILENAME = '<drive>:\<file path>\AdventureWorks2012_Data.mdf') 
FOR ATTACH_REBUILD_LOG;


