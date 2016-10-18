--6-1.1
SELECT ProductID, Name    
FROM Production.Product    
WHERE ProductID IN         
	(SELECT ProductID FROM Sales.SalesOrderDetail);   

--6-1.2
SELECT ProductID, Name    
FROM Production.Product    
WHERE ProductID NOT IN (        
	SELECT ProductID 
	FROM Sales.SalesOrderDetail        
	WHERE ProductID IS NOT NULL); 

--6-1.3
SELECT Color    
FROM Production.ProductColor    
WHERE Color NOT IN (        
	SELECT Color FROM Production.Product        
	WHERE Color IS NOT NULL);  
 
--6-1.4
SELECT DISTINCT Color    
FROM Production.Product AS P    
WHERE NOT EXISTS (        
	SELECT Color FROM Production.ProductColor AS PC        
	WHERE P.Color = PC.Color);   

--6-1.5
SELECT ModifiedDate    
FROM Person.Person    
UNION    
SELECT HireDate    
FROM HumanResources.Employee;   


--6-2.1
SELECT SOH.SalesOrderID, SOH.OrderDate, ProductID    
FROM Sales.SalesOrderHeader AS SOH    
INNER JOIN (        
	SELECT SalesOrderID, ProductID        
	FROM Sales.SalesOrderDetail) AS SOD        
	ON SOH.SalesOrderID = SOD.SalesOrderID;  


--6-2.2
;WITH SOD AS (        
	SELECT SalesOrderID, ProductID        
	FROM Sales.SalesOrderDetail)    
SELECT SOH.SalesOrderID, SOH.OrderDate, ProductID    
FROM Sales.SalesOrderHeader AS SOH    
INNER JOIN SOD ON SOH.SalesOrderID = SOD.SalesOrderID;   


--6-2.3
WITH SOH AS (        
	SELECT SalesOrderID, OrderDate, CustomerID        
	FROM Sales.SalesOrderHeader       
	WHERE OrderDate BETWEEN '1/1/2005' AND '12/31/2005'      
	)    
SELECT C.CustomerID, SalesOrderID, OrderDate    
FROM Sales.Customer AS C    
LEFT OUTER JOIN SOH ON C.CustomerID = SOH.CustomerID;   


 