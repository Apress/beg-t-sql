--7-1.1
SELECT COUNT(*) AS CountOfCustomers    
FROM Sales.Customer; 

--7-1.2
SELECT SUM(OrderQty) AS TotalProductsOrdered    
FROM Sales.SalesOrderDetail; 

--7-1.3
SELECT MAX(UnitPrice) AS MostExpensivePrice    
FROM Sales.SalesOrderDetail; 

--7-1.4
SELECT AVG(Freight) AS AverageFreight    
FROM Sales.SalesOrderHeader; 

--7-1.5
SELECT MIN(ListPrice) AS Minimum,        
	MAX(ListPrice) AS Maximum,        
	AVG(ListPrice) AS Average    
FROM Production.Product;   
  

 --7-2.1
SELECT SUM(OrderQty) AS TotalOrdered, ProductID    FROM Sales.SalesOrderDetail    GROUP BY ProductID; 

--7-2.2
SELECT COUNT(*) AS CountOfOrders, SalesOrderID    
FROM Sales.SalesOrderDetail    
GROUP BY SalesOrderID; 


--7-2.3
SELECT COUNT(*) AS CountOfProducts, ProductLine    
FROM Production.Product    
GROUP BY ProductLine; 

--7-2.4
SELECT CustomerID, COUNT(*) AS CountOfSales,        
	YEAR(OrderDate) AS OrderYear    
FROM Sales.SalesOrderHeader    
GROUP BY CustomerID, YEAR(OrderDate);   


--7-3.1
SELECT COUNT(*) AS CountOfDetailLines, SalesOrderID    
FROM Sales.SalesOrderDetail    
GROUP BY SalesOrderID    
HAVING COUNT(*) > 3; 


--7-3.2
SELECT SUM(LineTotal) AS SumOfLineTotal, SalesOrderID    
FROM Sales.SalesOrderDetail    
GROUP BY SalesOrderID    
HAVING SUM(LineTotal) > 1000; 


--7-3.3
SELECT ProductModelID, COUNT(*) AS CountOfProducts    
FROM Production.Product    
GROUP BY ProductModelID    
HAVING COUNT(*) = 1; 


--7-3.4
SELECT ProductModelID, COUNT(*) AS CountOfProducts, Color    
FROM Production.Product    
WHERE Color IN ('Blue','Red')    
GROUP BY ProductModelID, Color    
HAVING COUNT(*) = 1;   


--7-4.1
SELECT COUNT(DISTINCT ProductID) AS CountOFProductID    
FROM Sales.SalesOrderDetail; 


--7-4.2
SELECT COUNT(DISTINCT TerritoryID) AS CountOfTerritoryID,        
	CustomerID    
FROM Sales.SalesOrderHeader    
GROUP BY CustomerID;   


--7-5.1
SELECT COUNT(*) AS CountOfOrders, FirstName,        
	MiddleName, LastName    
FROM Person.Person AS P    
INNER JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID    
INNER JOIN Sales.SalesOrderHeader        
	AS SOH ON C.CustomerID = SOH.CustomerID    
GROUP BY FirstName, MiddleName, LastName; 


--7-5.2
SELECT SUM(OrderQty) SumOfOrderQty, P.Name, SOH.OrderDate    
FROM Sales.SalesOrderHeader AS SOH    INNER JOIN Sales.SalesOrderDetail AS SOD        ON SOH.SalesOrderID = SOD.SalesOrderDetailID    INNER JOIN Production.Product AS P ON SOD.ProductID = P.ProductID    GROUP BY P.Name, SOH.OrderDate;       

