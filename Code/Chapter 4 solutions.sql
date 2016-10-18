--4-1.1
SELECT AddressLine1 + '  (' + City + ' ' + PostalCode + ') ' 
FROM Person.Address; 

 --4-1.2
SELECT ProductID, ISNULL(Color, 'No Color') AS Color, Name 
FROM Production.Product;   

--4-1.3
SELECT ProductID, Name + ISNULL(': ' + Color,'') AS Description 
FROM Production.Product;

--4-1.4
SELECT CAST(ProductID AS VARCHAR) + ': ' +  Name AS IDName 
FROM Production.Product;    
SELECT CONVERT(VARCHAR, ProductID) + ': ' + Name AS IDName 
FROM Production.Product; 

--4-2.1
SELECT SpecialOfferID, Description,     MaxQty - MinQty AS Diff 
FROM Sales.SpecialOffer; 

--4-2.2
SELECT SpecialOfferID, Description, MinQty * DiscountPct AS Discount 
FROM Sales.SpecialOffer; 

--4-2.3
SELECT SpecialOfferID, Description,     
	ISNULL(MaxQty,10) * DiscountPct AS Discount 
FROM Sales.SpecialOffer; 

--4-3.1
SELECT LEFT(AddressLine1,10) AS Address10 
FROM Person.Address;    
SELECT SUBSTRING(AddressLine1,1,10) AS Address10 
FROM Person.Address;   

 --4-3.2
SELECT SUBSTRING(AddressLine1,10,6) AS Address10to15 
FROM Person.Address; 

--4-3.3
SELECT UPPER(FirstName) AS FirstName,     
	UPPER(LastName) AS LastName 
FROM Person.Person; 

--4-3.4
--Step 1 
SELECT ProductNumber, CHARINDEX('-',ProductNumber) 
FROM Production.Product;    
--Step 2 
SELECT ProductNumber,     
	SUBSTRING(ProductNumber,CHARINDEX('-',ProductNumber)+1,25) AS ProdNumber 
FROM Production.Product;  
 
--4-4.1
SELECT SalesOrderID, OrderDate, ShipDate,      
	DATEDIFF(day,OrderDate,ShipDate) AS NumberOfDays 
FROM Sales.SalesOrderHeader;   

--4-4.2
SELECT CONVERT(VARCHAR(12),OrderDate,111) AS OrderDate,     
	CONVERT(VARCHAR(12), ShipDate,111) AS ShipDate 
FROM Sales.SalesOrderHeader; 

 --4-4.3
SELECT SalesOrderID, OrderDate,     
	DATEADD(m,6,OrderDate) AS Plus6Months 
FROM Sales.SalesOrderHeader

--4-4.4
SELECT SalesOrderID, OrderDate, YEAR(OrderDate) AS OrderYear,     
	MONTH(OrderDate) AS OrderMonth 
FROM Sales.SalesOrderHeader;  
SELECT SalesOrderID, OrderDate, DATEPART(yyyy,OrderDate) AS OrderYear,     
	DATEPART(m,OrderDate) AS OrderMonth 
FROM Sales.SalesOrderHeader;   

--4-4.5
 SELECT SalesOrderID, OrderDate,      
	DATEPART(yyyy,OrderDate) AS OrderYear,      
	DATENAME(m,OrderDate) AS OrderMonth  
FROM Sales.SalesOrderHeader;   

 --4-5.1
SELECT SalesOrderID, ROUND(SubTotal,2) AS SubTotal 
FROM Sales.SalesOrderHeader; 

--4-5.2
SELECT SalesOrderID, ROUND(SubTotal,0) AS SubTotal 
FROM Sales.SalesOrderHeader

--4-5.3
SELECT SQRT(SalesOrderID) AS OrderSQRT 
FROM Sales.SalesOrderHeader; 

--4-5.4
SELECT CAST(RAND() * 10 AS INT) + 1;   

--4-6.1
SELECT BusinessEntityID,     
	CASE BusinessEntityID % 2     
	WHEN 0 THEN 'Even' ELSE 'Odd' END 
FROM HumanResources.Employee; 

--4-6.2
SELECT SalesOrderID, OrderQty,     
	CASE WHEN OrderQty BETWEEN 0 AND 9            
	THEN 'Under 10'        
	WHEN OrderQty BETWEEN 10 AND 19            
	THEN '10-19'        
	WHEN OrderQty BETWEEN 20 AND 29            
	THEN '20-29'        
	WHEN OrderQty BETWEEN 30 AND 39            
	THEN '30-39'        
	ELSE '40 and over' end AS range 
FROM Sales.SalesOrderDetail; 



--4-6.3
SELECT COALESCE(Title + ' ','') + FirstName +     
	COALESCE(' ' + MiddleName,'') + ' ' + LastName  +
	COALESCE(', ' + Suffix,'') 
FROM Person.Person; 

--4-6.4
SELECT SERVERPROPERTY('Edition'),     
	SERVERPROPERTY('InstanceName'),     
	SERVERPROPERTY('MachineName'); 

--4-7.1
--one possible solution. 
SELECT SalesOrderID, OrderDate 
FROM Sales.SalesOrderHeader 
WHERE YEAR(OrderDate) = 2005;  

--4-7.2
SELECT SalesOrderID, OrderDate 
FROM Sales.SalesOrderHeader 
ORDER BY MONTH(OrderDate), YEAR(OrderDate); 

--4-7.3
SELECT PersonType, FirstName, MiddleName, LastName 
FROM Person.Person 
ORDER BY CASE WHEN PersonType IN ('IN','SP','SC')      
THEN LastName ELSE FirstName END;       





   

