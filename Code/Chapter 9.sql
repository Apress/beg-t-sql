-- Listing 9-1. Using LIKE with the Percent Sign        
--1    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Sand%';       
--2    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName NOT LIKE 'Sand%';       
--3    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE '%Z%'; 
--4    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Bec_';  


-- isting 9-2. Using Square Brackets with LIKE       
--1    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Cho[i-k]';       
--2    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Cho[ijk]';       
--3    
SELECT DISTINCT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Cho[^i]';   


-- Listing 9-3. Combining Wildcards in One Pattern 
--1    
SELECT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Ber[rg]%';       
--2    
SELECT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Ber[^r]%';   
--3    
SELECT LastName    
FROM Person.Person    
WHERE LastName LIKE 'Be%n_';     

-- Listing 9-4. Using PATINDEX       
--1    
SELECT LastName, PATINDEX('Ber[rg]%', LastName) AS Position    
FROM Person.Person   
WHERE PATINDEX('Ber[r,g]%', LastName) > 0;       
--2    
SELECT LastName, PATINDEX('%r%',LastName) Position    
FROM Person.Person    
WHERE PATINDEX('%[r]%',LastName) > 0;   


-- Listing 9-5. WHERE Clauses with Three Predicates       
--1    
SELECT BusinessEntityID,FirstName,MiddleName,LastName    
FROM Person.Person    
WHERE FirstName = 'Ken' AND LastName = 'Myer'        
	OR LastName = 'Meyer';       
--2    
SELECT BusinessEntityID,FirstName,MiddleName,LastName    
FROM Person.Person    
WHERE LastName = 'Myer' OR LastName = 'Meyer'        
	AND FirstName = 'Ken';       
--3    
SELECT BusinessEntityID,FirstName,MiddleName,LastName    
FROM Person.Person    WHERE LastName = 'Meyer'        
	AND FirstName = 'Ken' OR LastName = 'Myer'; 
	
-- Listing 9-6. Using NOT with Parentheses    
--1    
SELECT BusinessEntityID,FirstName,MiddleName,LastName    
FROM Person.Person    
WHERE FirstName='Ken' AND LastName <> 'Myer'        
	AND LastName <> 'Meyer';       
--2    
SELECT BusinessEntityID,FirstName,MiddleName,LastName    
FROM Person.Person    WHERE FirstName='Ken'        
	AND NOT (LastName = 'Myer' OR LastName = 'Meyer'); 
	
-- Listing 9-7. Using CONTAINS       
--1    
SELECT FileName    
FROM Production.Document    
WHERE CONTAINS(Document,'important');       
--2    
SELECT FileName    
FROM Production.Document    
WHERE CONTAINS(Document,' "service guidelines" ')        
	AND DocumentLevel = 2; 
	
-- Listing 9-8. Multiple Terms in CONTAINS 
--1    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS(DocumentSummary,'bicycle AND reflectors');
--2    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS(DocumentSummary,'bicycle AND NOT reflectors');       
--3    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS(DocumentSummary,'maintain NEAR bicycle AND NOT reflectors');   

-- Listing 9-9. Using Multiple Columns    
--1    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS((DocumentSummary,Document),'maintain');       
--2    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS((DocumentSummary),'maintain')            
	OR CONTAINS((Document),'maintain')       
--3    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE CONTAINS(*,'maintain');  

-- Listing 9-10. Using FREETEXT       
--1    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE FREETEXT((DocumentSummary),'provides');       
--2    
SELECT FileName, DocumentSummary    
FROM Production.Document    
WHERE DocumentSummary LIKE '%provides%'    


-- Listing 9-11. Comparing LIKE with CHARINDEX    
--1    
SET STATISTICS IO ON;    
GO    
SELECT Name    
FROM Production.Product    
WHERE CHARINDEX('Bear',Name) = 1;       
--2    
SELECT Name    
FROM Production.Product    
WHERE Name LIKE 'Bear%';       
--3    
SELECT Name, Color    
FROM Production.Product    
WHERE CHARINDEX('B',Color) = 1; 
--4    
SELECT Name, Color    
FROM Production.Product    
WHERE Color LIKE 'B%';


--   
     