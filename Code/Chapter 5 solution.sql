--5-1.1
SELECT E.JobTitle, E.BirthDate, P.FirstName, P.LastName    
FROM HumanResources.Employee AS E    
INNER JOIN Person.Person AS P ON        
	E.BusinessEntityID = P.BusinessEntityID;   

--5-1.2
SELECT C.CustomerID, C.StoreID, C.TerritoryID,        
	P.FirstName, P.MiddleName, P.LastName    
FROM Sales.Customer AS C    
INNER JOIN Person.Person AS P        
	ON C.PersonID = P.BusinessEntityID; 

--5-1.3
SELECT C.CustomerID, C.StoreID, C.TerritoryID,        
	P.FirstName, P.MiddleName,        
	P.LastName, S.SalesOrderID    
FROM Sales.Customer AS C    
	INNER JOIN Person.Person AS P        
ON C.PersonID = P.BusinessEntityID    
INNER JOIN Sales.SalesOrderHeader AS S        
	ON S.CustomerID = C.CustomerID;   

--5-1.4
SELECT S.SalesOrderID, SP.SalesQuota, SP.Bonus    
FROM Sales.SalesOrderHeader AS S    
INNER JOIN Sales.SalesPerson AS SP        
	ON S.SalesPersonID = SP.BusinessEntityID;   

--5-1.5
SELECT SalesOrderID, SalesQuota, Bonus, FirstName,        
	MiddleName, LastName    
FROM Sales.SalesOrderHeader AS S    
INNER JOIN Sales.SalesPerson AS SP        
	ON S.SalesPersonID = SP.BusinessEntityID    
INNER JOIN Person.Person AS P        
	ON SP.BusinessEntityID = P.BusinessEntityID;   

--5-1.6
SELECT PM.CatalogDescription, P.Color, P.Size    
FROM Production.Product AS P    
INNER JOIN Production.ProductModel AS PM        
	ON P.ProductModelID = PM.ProductModelID;   


--5-1.7
SELECT FirstName, MiddleName, LastName, Prod.Name    
FROM Sales.Customer AS C    
INNER JOIN Person.Person AS P        
	ON C.PersonID = P.BusinessEntityID    
INNER JOIN Sales.SalesOrderHeader AS SOH        
	ON C.CustomerID = SOH.CustomerID    
INNER JOIN Sales.SalesOrderDetail AS SOD        
	ON SOH.SalesOrderID = SOD.SalesOrderID    
INNER JOIN Production.Product AS Prod        
	ON SOD.ProductID = Prod.ProductID;   


--5-2.1
SELECT SalesOrderID, P.ProductID, P.Name    
FROM Production.Product AS P    
LEFT OUTER JOIN Sales.SalesOrderDetail        
	AS SOD ON P.ProductID = SOD.ProductID;   

--5-2.2
SELECT SalesOrderID, P.ProductID, P.Name    
FROM Production.Product AS P    
LEFT OUTER JOIN Sales.SalesOrderDetail        
	AS SOD ON P.ProductID = SOD.ProductID    
WHERE SalesOrderID IS NULL;   

--5-2.3
SELECT SalesOrderID, SalesPersonID, SalesYTD, SOH.SalesOrderID    
FROM Sales.SalesPerson AS SP    
LEFT OUTER JOIN Sales.SalesOrderHeader AS SOH       
	ON SP.BusinessEntityID = SOH.SalesPersonID;   

--5-2.4
SELECT SalesOrderID, SalesPersonID, SalesYTD, SOH.SalesOrderID,        
	FirstName, MiddleName, LastName    
FROM Sales.SalesPerson AS SP    
LEFT OUTER JOIN Sales.SalesOrderHeader AS SOH       
	ON SP.BusinessEntityID = SOH.SalesPersonID    
LEFT OUTER JOIN Person.Person AS P        
ON P.BusinessEntityID = SP.BusinessEntityID;   

--5-2.5
SELECT CR.CurrencyRateID, CR.AverageRate,        
	SM.ShipBase, SalesOrderID    
FROM Sales.SalesOrderHeader AS SOH    
LEFT OUTER JOIN Sales.CurrencyRate AS CR        
	ON SOH.CurrencyRateID = CR.CurrencyRateID    
LEFT OUTER JOIN Purchasing.ShipMethod AS SM        
ON SOH.ShipMethodID = SM.ShipMethodID;   


--5-2.6
SELECT SP.BusinessEntityID, P.ProductID    
FROM Sales.SalesPerson AS SP    
CROSS JOIN Production.Product AS P;   