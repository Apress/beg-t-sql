-- Listing 11-1. Naming Columns 
;WITH myCTE ([First Name], [Last Name], [Full Name])    AS(        
	SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName)             
	FROM Person.Person    
	)    
SELECT [First Name], [Last Name], [Full Name]    
FROM myCTE;

-- Listing 11-2. Create Data for This Section’s Examples    
USE tempdb;    
GO       
IF OBJECT_ID('dbo.Employee') IS NOT NULL BEGIN        
	DROP TABLE dbo.Employee;    
END;    
IF OBJECT_ID('dbo.Contact') IS NOT NULL BEGIN        
	DROP TABLE dbo.Contact;    
END;    
IF OBJECT_ID('dbo.JobHistory') IS NOT NULL BEGIN        
	DROP TABLE dbo.JobHistory;    
END;
CREATE TABLE [Employee](            
	[EmployeeID] [int] NOT NULL,            
	[ContactID] [int] NOT NULL,            
	[ManagerID] [int] NULL,            
	[Title] [nvarchar](50) NOT NULL);       
CREATE TABLE [Contact] (            
	[ContactID] [int] NOT NULL,            
	[FirstName] [nvarchar](50) NOT NULL,            
	[MiddleName] [nvarchar](50) NULL,            
	[LastName] [nvarchar](50) NOT NULL);       
CREATE TABLE JobHistory(        
	EmployeeID INT NOT NULL,         
	EffDate DATE NOT NULL,         
	EffSeq INT NOT NULL,        
	EmploymentStatus CHAR(1) NOT NULL,        
	JobTitle VARCHAR(50) NOT NULL,        
	Salary MONEY NOT NULL,        
	ActionDesc VARCHAR(20)     
	CONSTRAINT PK_JobHistory PRIMARY KEY CLUSTERED     
	(        
		EmployeeID, EffDate, EffSeq    
		));       
GO          
INSERT INTO dbo.Contact (ContactID, FirstName, MiddleName, LastName) VALUES             
	(1030,'Kevin','F','Brown'),            
	(1009,'Thierry','B','DHers'),            
	(1028,'David','M','Bradley'),            
	(1070,'JoLynn','M','Dobney'),            
	(1071,'Ruth','Ann','Ellerbrock'),            
	(1005,'Gail','A','Erickson'),            
	(1076,'Barry','K','Johnson'),            
	(1006,'Jossef','H','Goldberg'),            
	(1001,'Terri','Lee','Duffy'),            
	(1072,'Sidney','M','Higa'),            
	(1067,'Taylor','R','Maxwell'),            
	(1073,'Jeffrey','L','Ford'),            
	(1068,'Jo','A','Brown'),            
	(1074,'Doris','M','Hartwig'),            
	(1069,'John','T','Campbell'),            
	(1075,'Diane','R','Glimp'),            
	(1129,'Steven','T','Selikoff'),            
	(1231,'Peter','J','Krebs'),            
	(1172,'Stuart','V','Munson'),            
	(1173,'Greg','F','Alderson'),            
	(1113,'David','N','Johnson'),            
	(1054,'Zheng','W','Mu'),            
	(1007, 'Ovidiu', 'V', 'Cracium'),  
	(1052, 'James', 'R', 'Hamilton'),            
	(1053, 'Andrew', 'R', 'Hill'),            
	(1056, 'Jack', 'S', 'Richins'),            
	(1058, 'Michael', 'Sean', 'Ray'),            
	(1064, 'Lori', 'A', 'Kane'),            
	(1287, 'Ken', 'J', 'Sanchez');       
INSERT INTO dbo.Employee (EmployeeID, ContactID, ManagerID, Title) 
VALUES (1, 1209, 16,'Production Technician - WC60'),            
	(2, 1030, 6,'Marketing Assistant'),            
	(3, 1002, 12,'Engineering Manager'),            
	(4, 1290, 3,'Senior Tool Designer'),            
	(5, 1009, 263,'Tool Designer'),            
	(6, 1028, 109,'Marketing Manager'),            
	(7, 1070, 21,'Production Supervisor - WC60'),            
	(8, 1071, 185,'Production Technician - WC10'),            
	(9, 1005, 3,'Design Engineer'),            
	(10, 1076, 185,'Production Technician - WC10'),            
	(11, 1006, 3,'Design Engineer'),            
	(12, 1001, 109,'Vice President of Engineering'),            
	(13, 1072, 185,'Production Technician - WC10'),            
	(14, 1067, 21,'Production Supervisor - WC50'),            
	(15, 1073, 185,'Production Technician - WC10'),            
	(16, 1068, 21,'Production Supervisor - WC60'),            
	(17, 1074, 185,'Production Technician - WC10'),            
	(18, 1069, 21,'Production Supervisor - WC60'),            
	(19, 1075, 185,'Production Technician - WC10'),            
	(20, 1129, 173,'Production Technician - WC30'),            
	(21, 1231, 148,'Production Control Manager'),            
	(22, 1172, 197,'Production Technician - WC45'),            
	(23, 1173, 197,'Production Technician - WC45'),            
	(24, 1113, 184,'Production Technician - WC30'),            
	(25, 1054, 21,'Production Supervisor - WC10'),            
	(109, 1287, NULL, 'Chief Executive Officer'),            
	(148, 1052, 109, 'Vice President of Production'),            
	(173, 1058, 21, 'Production Supervisor - WC30'),            
	(184, 1056, 21, 'Production Supervisor - WC30'),            
	(185, 1053, 21, 'Production Supervisor - WC10'),            
	(197, 1064, 21, 'Production Supervisor - WC45'),            
	(263, 1007, 3, 'Senior Tool Designer');                  
INSERT INTO JobHistory(EmployeeID, EffDate, EffSeq, EmploymentStatus,         
	JobTitle, Salary, ActionDesc)    
VALUES  (1000,'07-31-2008',1,'A','Intern',2000,'New Hire'),        
	(1000,'05-31-2009',1,'A','Production Technician',2000,'Title Change'),        
	(1000,'05-31-2009',2,'A','Production Technician',2500,'Salary Change'),        
	(1000,'11-01-2009',1,'A','Production Technician',3000,'Salary Change'),        
	(1200,'01-10-2009',1,'A','Design Engineer',5000,'New Hire'),        
	(1200,'05-01-2009',1,'T','Design Engineer',5000,'Termination'),
	(1100,'08-01-2008',1,'A','Accounts Payable Specialist I',2500,'New Hire'),  
	(1100,'05-01-2009',1,'A','Accounts Payable Specialist II',2500,'Title Change'),        
	(1100,'05-01-2009',2,'A','Accounts Payable Specialist II',3000,'Salary Change'); 
	
-- Listing 11-3. A Query with Multiple CTEs    
  USE tempdb;    
  WITH     
	Emp AS(        
		SELECT e.EmployeeID, e.ManagerID,e.Title AS EmpTitle,            
			c.FirstName + ISNULL(' ' + c.MiddleName,'') + ' ' + c.LastName AS EmpName        
		FROM dbo.Employee AS e        
		INNER JOIN dbo.Contact AS c        
			ON e.ContactID = c.ContactID         
		),    
	Mgr AS(        
		SELECT e.EmployeeID AS ManagerID,e.Title AS MgrTitle,            
			c.FirstName + ISNULL(' ' + c.MiddleName,'') + ' ' + c.LastName AS MgrName        
		FROM dbo.Employee AS e        
		INNER JOIN dbo.Contact AS c        
			ON e.ContactID = c.ContactID         
			)    
SELECT EmployeeID, Emp.ManagerID, EmpName, EmpTitle, MgrName, MgrTitle   
FROM Emp INNER JOIN Mgr ON Emp.ManagerID = Mgr.ManagerID    
ORDER BY EmployeeID;       
	      
--USE tempdb;    
GO    
;WITH     
	Employees AS(        
		SELECT e.EmployeeID, e.ManagerID,e.Title,            
			c.FirstName + ISNULL(' ' + c.MiddleName,'') + ' ' +  c.LastName AS EmpName        
	FROM dbo.Employee AS e  
    INNER JOIN dbo.Contact AS c        
		ON e.ContactID = c.ContactID         
	)    
SELECT emp.EmployeeID, emp.ManagerID, emp.EmpName, emp.Title AS EmpTitle,        
	mgr.EmpName as MgrName, mgr.Title as MgrTitle    
FROM Employees AS Emp 
INNER JOIN Employees AS Mgr     
ON Emp.ManagerID = Mgr.EmployeeID;  

-- Listing 11-5. Joining a CTE to Another CTE 
USE tempdb;  
GO          
--1    
DECLARE @Date DATE = '05-02-2009';       
--2    
WITH EffectiveDate AS (            
		SELECT MAX(EffDate) AS MaxDate, EmployeeID            
		FROM dbo.JobHistory 
		   WHERE EffDate <= @Date            
			GROUP BY EmployeeID        
		),        
	EffectiveSeq AS (            
		SELECT MAX(EffSeq) AS MaxSeq, j.EmployeeID, MaxDate            
		FROM dbo.JobHistory AS j             
		INNER JOIN EffectiveDate AS d                 
		ON j.EffDate = d.MaxDate AND j.EmployeeID = d.EmployeeID            
		GROUP BY j.EmployeeID, MaxDate)    
SELECT j.EmployeeID, EmploymentStatus, JobTitle, Salary    
FROM dbo.JobHistory AS j     
INNER JOIN EffectiveSeq AS e ON j.EmployeeID = e.EmployeeID         
	AND j.EffDate = e.MaxDate AND j.EffSeq = e.MaxSeq;   
	
-- Listing 11-6. A Recursive CTE 
;WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node)        
	AS (SELECT EmployeeID, ManagerID, Title, 0,                 
			CONVERT(VARCHAR(30),'/') AS Node 
		FROM dbo.Employee            
		WHERE ManagerID IS NULL            
		UNION ALL            
		SELECT Emp.EmployeeID, Emp.ManagerID, Emp.Title, OrgChart.Level + 1,				
			CONVERT(VARCHAR(30), OrgChart.Node +                
			CONVERT(VARCHAR(30), Emp.ManagerID) + '/')            
		FROM dbo.Employee AS Emp            
		INNER JOIN OrgChart  ON Emp.ManagerID = OrgChart.EmployeeID        
		)    
SELECT EmployeeID, ManagerID, SPACE(Level * 3) + Title AS Title, Level, Node    
FROM OrgChart    ORDER BY Node;       
--2 Incorrectly written Recursive CTE    
;WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node)        
	AS (SELECT EmployeeID, ManagerID, Title, 0,                    
		CONVERT(VARCHAR(30),'/') AS Node            
		FROM dbo.Employee            
		WHERE ManagerID IS NOT NULL  
		UNION ALL            
		SELECT Emp.EmployeeID, Emp.ManagerID,Emp.Title, OrgChart.Level + 1,               
			CONVERT(VARCHAR(30),OrgChart.Node +                   
			CONVERT(VARCHAR,Emp.ManagerID) + '/')            
		FROM dbo.Employee AS Emp            
		INNER JOIN OrgChart  ON Emp.EmployeeID = OrgChart.EmployeeID        
		)    
SELECT EmployeeID, ManagerID, SPACE(Level * 3) + Title AS Title, Level, Node    
FROM OrgChart     
ORDER BY Node OPTION (MAXRECURSION 10);

-- Listing 11-7. Using CTEs to Manipulate Data     
--1    
USE tempdb;    
GO    
CREATE TABLE dbo.CTEExample(CustomerID INT, FirstName NVARCHAR(50),        
	LastName NVARCHAR(50), Sales Money);       
--2    
;WITH Cust AS(            
	SELECT CustomerID, FirstName, LastName             
	FROM AdventureWorks.Sales.Customer AS C             
	JOIN AdventureWorks.Person.Person AS P ON C.CustomerID = P.BusinessEntityID    
	)    
INSERT INTO dbo.CTEExample(CustomerID, FirstName, LastName)     
SELECT CustomerID, FirstName, LastName     FROM Cust;       
--3    
;WITH Totals AS (            
	SELECT CustomerID, SUM(TotalDue) AS CustTotal             
	FROM AdventureWorks.Sales.SalesOrderHeader            
	GROUP BY CustomerID)    
UPDATE C SET Sales = CustTotal     
FROM CTEExample AS C     
INNER JOIN Totals ON C.CustomerID = Totals.CustomerID;      
 --4    
 ;WITH Cust AS(            
	SELECT CustomerID, Sales             
	FROM CTEExample)    
DELETE Cust     
WHERE Sales < 10000; 


-- Listing 11-8. Using a Correlated Subquery in the SELECT List    
USE AdventureWorks;    
GO    
SELECT CustomerID, C.StoreID, C.AccountNumber,        
	(SELECT COUNT(*)          
	FROM Sales.SalesOrderHeader AS SOH         
	WHERE SOH.CustomerID = C.CustomerID) AS CountOfSales    
FROM Sales.Customer AS C    
ORDER BY CountOfSales DESC;      
--2    
SELECT CustomerID, C.StoreID, C.AccountNumber,         
	(SELECT COUNT(*) AS CountOfSales          
	FROM Sales.SalesOrderHeader AS SOH        
	WHERE SOH.CustomerID = C.CustomerID) AS CountOfSales,        
	(SELECT SUM(TotalDue)         
	FROM Sales.SalesOrderHeader AS SOH         
	WHERE SOH.CustomerID = C.CustomerID) AS SumOfTotalDue,        
	(SELECT AVG(TotalDue)         
FROM Sales.SalesOrderHeader AS SOH         
WHERE SOH.CustomerID = C.CustomerID) AS AvgOfTotalDue    
FROM Sales.Customer AS C    
ORDER BY CountOfSales DESC;     


-- Listing 11-9. Using a Derived Table 
SELECT c.CustomerID, c.StoreID, c.AccountNumber, s.CountOfSales,        
	s.SumOfTotalDue, s.AvgOfTotalDue    
FROM Sales.Customer AS c 
INNER JOIN (SELECT CustomerID, COUNT(*) AS CountOfSales,             
				SUM(TotalDue) AS SumOfTotalDue,             
				AVG(TotalDue) AS AvgOfTotalDue         
			FROM Sales.SalesOrderHeader         
			GROUP BY CustomerID) AS s     
	ON c.CustomerID = s.CustomerID;   


-- Listing 11-10. Using a Common Table Expression 
;WITH s AS         
	(SELECT CustomerID, COUNT(*) AS CountOfSales,            
		SUM(TotalDue) AS SumOfTotalDue,            
		AVG(TotalDue) AS AvgOfTotalDue         
	FROM Sales.SalesOrderHeader         
	GROUP BY CustomerID)     
SELECT c.CustomerID, c.StoreID, c.AccountNumber, s.CountOfSales,        
	s.SumOfTotalDue, s.AvgOfTotalDue    
FROM Sales.Customer AS c 
INNER JOIN s  ON c.CustomerID = s.CustomerID;  

-- Listing 11-11. Using CROSS APPLY       
--1    
SELECT SOH.CustomerID, SOH.OrderDate, SOH.TotalDue, CRT.RunningTotal     
FROM Sales.SalesOrderHeader AS SOH     
CROSS APPLY(        
	SELECT SUM(TotalDue) AS RunningTotal            
	FROM Sales.SalesOrderHeader RT            
	WHERE RT.CustomerID = SOH.CustomerID                
		AND RT.SalesOrderID <= SOH.SalesOrderID) AS CRT    
	ORDER BY SOH.CustomerID, SOH.SalesOrderID;      
--2    
SELECT Prd.ProductID, S.SalesOrderID    
FROM Production.Product AS Prd     
OUTER APPLY (      
	SELECT TOP(2) SalesOrderID       
	FROM Sales.SalesOrderDetail AS SOD      
	WHERE SOD.ProductID = Prd.ProductID      
	ORDER BY SalesOrderID) AS S     
ORDER BY Prd.ProductID;    

-- Listing 11-12. Viewing the Manipulated Data with OUTPUT    
--1    
USE tempdb;     
GO    
IF OBJECT_ID('dbo.Customers') IS NOT NULL BEGIN        
	DROP TABLE dbo.Customers;    
END;       
CREATE TABLE dbo.Customers (CustomerID INT NOT NULL PRIMARY KEY,         
	Name VARCHAR(150),PersonID INT NOT NULL)    
GO       
--2    
INSERT INTO dbo.Customers(CustomerID,Name,PersonID)    
OUTPUT inserted.CustomerID,inserted.Name    
SELECT c.CustomerID, p.FirstName + ' ' + p.LastName, c.PersonID    
FROM AdventureWorks.Sales.Customer AS c     
INNER JOIN AdventureWorks.Person.Person AS p    
	ON c.PersonID = p.BusinessEntityID; 
	
--3    
UPDATE c SET Name = p.FirstName +         
	ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName     
OUTPUT deleted.CustomerID,deleted.Name AS OldName, inserted.Name AS NewName    
FROM dbo.Customers AS c     
INNER JOIN AdventureWorks.Person.Person AS p on c.PersonID = p.BusinessEntityID;       
--4    
DELETE FROM dbo.Customers     
OUTPUT deleted.CustomerID, deleted.Name, deleted.PersonID     
WHERE CustomerID = 11000;   

-- Listing 11-13. Saving the Results of OUTPUT 
Use tempdb;    
GO    
--1    
IF OBJECT_ID('dbo.Customers') IS NOT NULL BEGIN        
	DROP TABLE dbo.Customers;    
END;       
IF OBJECT_ID('dbo.CustomerHistory') IS NOT NULL BEGIN        
	DROP TABLE dbo.CustomerHistory;    
END;       
CREATE TABLE dbo.Customers (CustomerID INT NOT NULL PRIMARY KEY,         
	Name VARCHAR(150),PersonID INT NOT NULL)       
CREATE TABLE dbo.CustomerHistory(CustomerID INT NOT NULL PRIMARY KEY,        
	OldName VARCHAR(150), NewName VARCHAR(150),         
	ChangeDate DATETIME);    
GO       
--2    
INSERT INTO dbo.Customers(CustomerID, Name, PersonID)    
SELECT c.CustomerID, p.FirstName + ' ' + p.LastName,PersonID    
FROM AdventureWorks.Sales.Customer AS c     
INNER JOIN AdventureWorks.Person.Person AS p    
	ON c.PersonID = p.BusinessEntityID;       
--3    
UPDATE c SET Name = p.FirstName +         
	ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName       
OUTPUT deleted.CustomerID,deleted.Name, inserted.Name, GETDATE()    
INTO dbo.CustomerHistory     
FROM dbo.Customers AS c     
INNER JOIN AdventureWorks.Person.Person AS p on c.PersonID = p.BusinessEntityID;       
--4    
SELECT CustomerID, OldName, NewName,ChangeDate     
FROM dbo.CustomerHistory    
ORDER BY CustomerID;    


-- Listing 11-14. Using the MERGE Statement       
USE tempdb;    
GO    
--1     
IF OBJECT_ID('dbo.CustomerSource') IS NOT NULL BEGIN        
	DROP TABLE dbo.CustomerSource;    
END;    
IF OBJECT_ID('dbo.CustomerTarget') IS NOT NULL BEGIN        
	DROP TABLE dbo.CustomerTarget;    
END;       
CREATE TABLE dbo.CustomerSource (CustomerID INT NOT NULL PRIMARY KEY,        
	Name VARCHAR(150) NOT NULL, PersonID INT NOT NULL);    
CREATE TABLE dbo.CustomerTarget (CustomerID INT NOT NULL PRIMARY KEY,        
	Name VARCHAR(150) NOT NULL, PersonID INT NOT NULL);       
--2    
INSERT INTO dbo.CustomerSource(CustomerID,Name,PersonID)    
	SELECT CustomerID,         
		p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName,         
		c.PersonID    
	FROM AdventureWorks.Sales.Customer AS c     
INNER JOIN AdventureWorks.Person.Person AS p ON c.PersonID = p.BusinessEntityID    
WHERE c.CustomerID IN (29485,29486,29487,20075);       
--3    
INSERT INTO dbo.CustomerTarget(CustomerID,Name,PersonID)    
SELECT c.CustomerID, p.FirstName  + ' ' + p.LastName, PersonID    
FROM AdventureWorks.Sales.Customer AS c     
INNER JOIN AdventureWorks.Person.Person AS p ON c.PersonID = p.BusinessEntityID    
WHERE c.CustomerID IN (29485,29486,21139);       
--4    
SELECT CustomerID, Name, PersonID    
FROM dbo.CustomerSource    ORDER BY CustomerID;           
--5    
SELECT CustomerID, Name, PersonID    
FROM dbo.CustomerTarget    
ORDER BY CustomerID;             
--6    
MERGE dbo.CustomerTarget AS t    
USING dbo.CustomerSource AS s 
ON (s.CustomerID = t.CustomerID)    
WHEN MATCHED AND s.Name <> t.Name    
	THEN UPDATE SET Name = s.Name    
WHEN NOT MATCHED BY TARGET    
	THEN INSERT (CustomerID, Name, PersonID) VALUES (CustomerID, Name, PersonID)    
WHEN NOT MATCHED BY SOURCE    
	THEN DELETE    
OUTPUT $action, DELETED.*, INSERTED.*;--semi-colon is required        
--7    
SELECT CustomerID, Name, PersonID    
FROM dbo.CustomerTarget    
ORDER BY CustomerID;         

-- Listing 11-15. Using GROUPING SETS   
USE AdventureWorks;    
GO    
--1    
SELECT NULL AS SalesOrderID, SUM(UnitPrice)AS SumOfPrice, ProductID    
FROM Sales.SalesOrderDetail    
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY ProductID    
UNION ALL    
SELECT SalesOrderID,SUM(UnitPrice), NULL     
FROM Sales.SalesOrderDetail    
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY SalesOrderID;       
--2    
SELECT SalesOrderID, SUM(UnitPrice) AS SumOfPrice,ProductID    
FROM Sales.SalesOrderDetail     
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY GROUPING SETS(SalesOrderID, ProductID);   


-- Listing 11-16. Using CUBE and ROLLUP 
--1    
SELECT COUNT(*) AS CountOfRows,         
	ISNULL(Color, CASE WHEN GROUPING(Color)=0 THEN 'UNK' ELSE 'ALL' END) AS Color,            
	ISNULL(Size,CASE WHEN GROUPING(Size) = 0 THEN 'UNK' ELSE 'ALL' END) AS Size    
FROM Production.Product    
GROUP BY CUBE(Color,Size)    
ORDER BY Size, Color;       
--2    
SELECT COUNT(*) AS CountOfRows,        
	ISNULL(Color, CASE WHEN GROUPING(Color)=0 THEN 'UNK' ELSE 'ALL' END) AS Color,            
	ISNULL(Size,CASE WHEN GROUPING(Size) = 0 THEN 'UNK' ELSE 'ALL' END) AS Size    
FROM Production.Product    
GROUP BY ROLLUP(Color,Size)    
ORDER BY Size, Color;  

-- Listing 11-17. Using CASE to Pivot Data 
 SELECT YEAR(OrderDate) AS OrderYear,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 1 THEN TotalDue ELSE 0 END),0) AS Jan,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 2 THEN TotalDue ELSE 0 END),0) AS Feb,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 3 THEN TotalDue ELSE 0 END),0) AS Mar,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 4 THEN TotalDue ELSE 0 END),0) AS Apr,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 5 THEN TotalDue ELSE 0 END),0) AS May,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 6 THEN TotalDue ELSE 0 END),0) AS Jun    
FROM Sales.SalesOrderHeader    
GROUP BY YEAR(OrderDate)    
ORDER BY OrderYear; 


-- Listing 11-18. Pivoting Results with PIVOT 
--1    
SELECT OrderYear, [1] AS Jan, [2] AS Feb, [3] AS Mar,         
	[4] AS Apr, [5] AS May, [6] AS Jun    
FROM (SELECT YEAR(OrderDate) AS OrderYear, TotalDue,        
	MONTH(OrderDate) AS OrderMonth        
FROM Sales.SalesOrderHeader) AS MonthData    
PIVOT (         
	SUM(TotalDue)        
	FOR OrderMonth IN ([1],[2],[3],[4],[5],[6])        
	) AS PivotData    
ORDER BY OrderYear;       
--2    
SELECT OrderYear, ROUND(ISNULL([1],0),0) AS Jan,         
	ROUND(ISNULL([2],0),0) AS Feb, ROUND(ISNULL([3],0),0) AS Mar,         
	ROUND(ISNULL([4],0),0) AS Apr, ROUND(ISNULL([5],0),0) AS May,         
	ROUND(ISNULL([6],0),0) AS Jun    
FROM (SELECT YEAR(OrderDate) AS OrderYear, TotalDue,         
	MONTH(OrderDate) AS OrderMonth        
FROM Sales.SalesOrderHeader) AS MonthData    
PIVOT (         
	SUM(TotalDue)        
	FOR OrderMonth IN ([1],[2],[3],[4],[5],[6])        
	) AS PivotData     
ORDER BY OrderYear;  

--Listing 11-19. Using UNPIVOT 
--1    
CREATE TABLE #pivot(OrderYear INT, Jan NUMERIC(10,2),        
	Feb NUMERIC(10,2), Mar NUMERIC(10,2),             
	Apr NUMERIC(10,2), May NUMERIC(10,2),            
	Jun NUMERIC(10,2));       
--2    
INSERT INTO #pivot(OrderYear, Jan, Feb, Mar,         
	Apr, May, Jun)    
VALUES (2006, 1462449.00, 2749105.00, 2350568.00, 1727690.00, 3299799.00, 1920507.00),           
	(2007, 1968647.00, 3226056.00, 2297693.00, 2660724.00, 3866365.00, 2852210.00),           
	(2008, 3359927.00, 4662656.00, 4722358.00, 4269365.00, 5813557.00, 6004156.00);       
--3    
SELECT * FROM #pivot;    
--4    
SELECT OrderYear, Amt, OrderMonth     
FROM (        
	SELECT OrderYear, Jan, Feb, Mar, Apr, May, Jun             
	FROM #pivot) P     
UNPIVOT (        
	Amt FOR OrderMonth IN                     
		(Jan, Feb, Mar, Apr, May, Jun)            
	) AS unpvt;  
	
	
-- Listing 11-20. Paging with T-SQL       
--1    
DECLARE @PageSize INT = 5;    
DECLARE @PageNo INT = 1;       
;WITH Products AS(        
	SELECT ProductID, P.Name, Color, Size,             
		ROW_NUMBER() OVER(ORDER BY P.Name, Color, Size) AS RowNum        
	FROM Production.Product AS P         
JOIN Production.ProductSubcategory AS S             
	ON P.ProductSubcategoryID = S.ProductSubcategoryID            
JOIN Production.ProductCategory AS C                 
	ON S.ProductCategoryID = C.ProductCategoryID             
WHERE C.Name = 'Bikes'    )     
SELECT TOP(@PageSize) ProductID, Name, Color, Size     
FROM Products     
WHERE RowNum BETWEEN (@PageNo -1) * @PageSize + 1         
	AND @PageNo * @PageSize    
ORDER BY Name, Color, Size; 
--2    
SELECT ProductID, P.Name, Color, Size    
FROM Production.Product AS P     
JOIN Production.ProductSubcategory AS S         
	ON P.ProductSubcategoryID = S.ProductSubcategoryID    
JOIN Production.ProductCategory AS C         
	ON S.ProductCategoryID = C.ProductCategoryID     
WHERE C.Name = 'Bikes'    
ORDER BY P.Name, Color, Size         
OFFSET @PageSize * (@PageNo -1) ROWS FETCH NEXT @PageSize ROWS ONLY;      

