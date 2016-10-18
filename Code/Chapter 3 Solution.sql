--Chapter 3 solutions


--3-1.1
SELECT CustomerID, StoreID, AccountNumber FROM Sales.Customer;

--3-1.2
SELECT Name, ProductNumber, Color FROM Production.Product; 

--3-1.3
SELECT CustomerID, SalesOrderID FROM Sales.SalesOrderHeader; 

--3-2.1
SELECT BusinessEntityID, JobTitle, LoginID FROM HumanResources.Employee WHERE JobTitle = 'Research and Development Engineer'; 

--3-2.2
SELECT FirstName, MiddleName, LastName, BusinessEntityID FROM Person.Person WHERE MiddleName = 'J'; 

--3-2.3
 USE [AdventureWorks] 
 GO 
 SELECT [ProductID]      
	,[StartDate]      
	,[EndDate]      
	,[StandardCost]      
	,[ModifiedDate] 
FROM [Production].[ProductCostHistory] 
WHERE StandardCost BETWEEN 10 and 13; 
GO   

--3-2.4
SELECT BusinessEntityID, JobTitle, LoginID FROM HumanResources.Employee WHERE JobTitle <> 'Research and Development Engineer'; 


--3-3.1
SELECT SalesOrderID, OrderDate, TotalDue FROM Sales.SalesOrderHeader WHERE OrderDate >= '2005-09-01'     AND OrderDate < '2005-10-01';

--3-3.2
SELECT SalesOrderID, OrderDate, TotalDue FROM Sales.SalesOrderHeader WHERE TotalDue >=10000 OR SalesOrderID < 43000; 

--3-4.1
SELECT ProductID, Name, Color FROM Production.Product WHERE Color IS NULL; 

--3-4.2
 SELECT ProductID, Name, Color FROM Production.Product WHERE Color <>'BLUE'; 

--3-4.3
SELECT ProductID, Name, Color 
FROM Production.Product 
WHERE Color IS NOT NULL           
	OR Size IS NOT NULL;   

--3-5.1
SELECT BusinessEntityID, LastName, FirstName, MiddleName 
FROM Person.Person 
ORDER BY LastName, FirstName, MiddleName; 

--3-5.2
SELECT BusinessEntityID, LastName, FirstName, MiddleName 
FROM Person.Person 
ORDER BY LastName DESC, FirstName DESC, MiddleName DESC;       