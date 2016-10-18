--9-1.1
SELECT ProductID, Name    
FROM Production.Product    
WHERE Name LIKE 'Chain%';   

--9-1.2
SELECT ProductID, Name    
FROM Production.Product    
WHERE Name LIKE '%Paint%';   

--9-1.3
SELECT ProductID, Name    
FROM Production.Product    
WHERE Name NOT LIKE '%Paint%';   

--9-1.4
SELECT BusinessEntityID,            
	FirstName, MiddleName,         
	LastName    
FROM Person.Person    
WHERE MiddleName LIKE '%[EB]%';   


--9-1.5
SELECT FirstName    
FROM Person.Person    
WHERE LastName LIKE 'Ja%es';       
SELECT FirstName    
FROM Person.Person    
WHERE LastName LIKE 'Ja_es';   

--9-2.1
SELECT SalesOrderID, OrderDate, TotalDue, CreditCardID    
FROM Sales.SalesOrderHeader    
WHERE OrderDate >= '2006/01/01'        
	AND OrderDate < '2007/01/01'        
	AND (TotalDue > 1000 OR CreditCardID IS NOT NULL);   


--9-2.2
SELECT SUB.Name AS [SubCategory Name],        
	P.Name AS [Product Name], ProductID, Color    
FROM Production.Product P    
JOIN Production.ProductSubcategory SUB        
	ON P.ProductSubcategoryID = SUB.ProductSubcategoryID    
WHERE (SUB.Name LIKE '%mountain%' OR P.name like '%mountain%')        
	AND Color = 'Silver';   

--9-3.1
SELECT ProductID, Comments    
FROM Production.ProductReview    
WHERE CONTAINS(Comments,'socks');   

--9-3.2
SELECT Title, FileName    
FROM Production.Document    
WHERE CONTAINS(*,'reflector');   


--9-3.3
SELECT Title, FileName    
FROM Production.Document    
WHERE CONTAINS(*,'reflector AND NOT seat');  

--9-3.4
SELECT Title, FileName, DocumentSummary    
FROM Production.Document    
WHERE FREETEXT(*,'replaced');       
