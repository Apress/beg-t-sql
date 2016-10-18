--14-1.1
IF OBJECT_ID ('dbo.testCustomer') IS NOT NULL BEGIN        
	DROP TABLE dbo.testCustomer;    
END;
GO    
CREATE TABLE dbo.testCustomer (        
	CustomerID INT NOT NULL IDENTITY,        
	FirstName VARCHAR(25), LastName VARCHAR(25),        
	Age INT, Active CHAR(1) DEFAULT 'Y',        
	CONSTRAINT ch_testCustomer_Age            
	CHECK (Age < 120),        
	CONSTRAINT ch_testCustomer_Active            
	CHECK (Active IN ('Y','N')),        
	CONSTRAINT PK_testCustomer PRIMARY KEY (CustomerID)       
	);    
GO    
INSERT INTO dbo.testCustomer(FirstName, LastName,Age)    
VALUES ('Kathy','Morgan',35),        
	('Lady B.','Kellenberger',14),        
	('Dennis','Wayne',30); 
	
	
--14-1.2
IF OBJECT_ID('dbo.testOrder') IS NOT NULL BEGIN        
	DROP TABLE dbo.testOrder;    
END;    
GO    
CREATE TABLE dbo.testOrder        
	(CustomerID INT NOT NULL,            
	OrderID INT NOT NULL IDENTITY,            
	OrderDate DATETIME DEFAULT GETDATE(),            
	RW ROWVERSION,            
	CONSTRAINT fk_testOrders               
	FOREIGN KEY (CustomerID)            
	REFERENCES dbo.testCustomer(CustomerID),            
	CONSTRAINT PK_TestOrder PRIMARY KEY (OrderID)        
	);    
GO    
INSERT INTO dbo.testOrder (CustomerID)    
VALUES (1),(2),(3);  


--14-1.3
IF OBJECT_ID('dbo.testOrderDetail') IS NOT NULL BEGIN        
DROP TABLE dbo.testOrderDetail;       
END;
GO    
CREATE TABLE dbo.testOrderDetail(        
	OrderID INT NOT NULL, ItemID INT NOT NULL,        
	Price Money NOT NULL, Qty INT NOT NULL,        
	LineItemTotal AS (Price * Qty),        
	CONSTRAINT pk_testOrderDetail            
	PRIMARY KEY (OrderID, ItemID),        
	CONSTRAINT fk_testOrderDetail            
	FOREIGN KEY (OrderID)            
	REFERENCES dbo.testOrder(OrderID)    );    
GO    
INSERT INTO dbo.testOrderDetail(OrderID,ItemID,Price,Qty)    
VALUES (1,1,10,5),(1,2,5,10); 


--14-2.1
IF OBJECT_ID('dbo.vw_Products') IS NOT NULL BEGIN       
	DROP VIEW dbo.vw_Products;    
END;    
GO    
CREATE VIEW dbo.vw_Products AS (        
	SELECT P.ProductID, P.Name, P.Color,            
	P.Size, P.Style,            
	H.StandardCost, H.EndDate, H.StartDate        
	FROM Production.Product AS P        
	INNER JOIN Production.ProductCostHistory AS H            
	ON P.ProductID = H.ProductID);    
GO    
SELECT ProductID, Name, Color, Size, Style,        
	StandardCost, EndDate, StartDate    
FROM dbo.vw_Products;  


--14-2.2
  IF OBJECT_ID('dbo.vw_CustomerTotals') IS NOT NULL BEGIN      
	DROP VIEW dbo.vw_CustomerTotals;       
  END;    
  GO    
  CREATE VIEW dbo.vw_CustomerTotals AS (        
		SELECT C.CustomerID,            
			YEAR(OrderDate) AS OrderYear,            
			MONTH(OrderDate) AS OrderMonth,
			SUM(TotalDue) AS TotalSales        
		FROM Sales.Customer AS C        
		INNER JOIN Sales.SalesOrderHeader            
		AS SOH ON C.CustomerID = SOH.CustomerID 
		GROUP BY C.CustomerID,            
			YEAR(OrderDate), MONTH(OrderDate));    
	  GO    
	  SELECT CustomerID, OrderYear,        
	  OrderMonth, TotalSales    
	  FROM dbo.vw_CustomerTotals;       
	  
--14-3.1
IF OBJECT_ID('dbo.fn_AddTwoNumbers')        
	IS NOT NULL BEGIN        
	DROP FUNCTION dbo.fn_AddTwoNumbers;    
END;    
GO    
CREATE FUNCTION dbo.fn_AddTwoNumbers        
	(@NumberOne INT, @NumberTwo INT)    
RETURNS INT AS BEGIN        
	RETURN @NumberOne + @NumberTwo;    
END;    
GO    
SELECT dbo.fn_AddTwoNumbers(1,2);


--14-3.2
IF OBJECT_ID('dbo.Trim') IS NOT NULL BEGIN        
	DROP FUNCTION dbo.Trim;    
END    
GO    
CREATE FUNCTION dbo.Trim        
	(@Expression VARCHAR(250))       
RETURNS VARCHAR(250) AS BEGIN        
	RETURN LTRIM(RTRIM(@Expression));    
END;    
GO    
SELECT '*' + dbo.Trim('  test  ') + '*';  


--14-3.3
IF OBJECT_ID('dbo.fn_RemoveNumbers')        
	IS NOT NULL BEGIN        
	DROP FUNCTION dbo.fn_RemoveNumbers;    
END;    
GO    
CREATE FUNCTION dbo.fn_RemoveNumbers        
	(@Expression VARCHAR(250))    
	RETURNS VARCHAR(250) AS BEGIN       
	RETURN REPLACE( REPLACE (REPLACE (REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE(          
		REPLACE( @Expression,'1', ''),'2', ''),'3', ''),'4', ''),'5', ''),'6', ''),'7', ''),              
		'8', ''),'9', ''),'0', '');    
END;    
GO    
SELECT dbo.fn_RemoveNumbers        
('abc 123 this is a test');   

--14-3.4
IF OBJECT_ID('dbo.fn_FormatPhone') IS NOT NULL    
BEGIN        
	DROP FUNCTION dbo.fn_FormatPhone;    
END;    
GO    
CREATE FUNCTION dbo.fn_FormatPhone        
	(@Phone VARCHAR(10))    
RETURNS VARCHAR(14) AS BEGIN        
	DECLARE @NewPhone VARCHAR(14);        
	SET @NewPhone = '(' + SUBSTRING(@Phone,1,3)            
		+ ') ';        
	SET @NewPhone = @NewPhone +            
		SUBSTRING(@Phone, 4, 3) + '-';        
	SET @NewPhone = @NewPhone +            
		SUBSTRING(@Phone, 7, 4);        
	RETURN @NewPhone;    
END;    
GO    
SELECT dbo.fn_FormatPhone('5555551234');    
 
      
--14-4.1
IF OBJECT_ID('dbo.usp_CustomerTotals')        
	IS NOT NULL BEGIN        
	DROP PROCEDURE dbo.usp_CustomerTotals;    
END;    
GO    
CREATE PROCEDURE dbo.usp_CustomerTotals AS        
	SELECT C.CustomerID,            
		YEAR(OrderDate) AS OrderYear,            
		MONTH(OrderDate) AS OrderMonth,            
		SUM(TotalDue) AS TotalSales        
	FROM Sales.Customer AS C        
	INNER JOIN Sales.SalesOrderHeader            
	AS SOH ON C.CustomerID = SOH.CustomerID        
	GROUP BY C.CustomerID, YEAR(OrderDate),            
	MONTH(OrderDate);    
GO    
EXEC dbo.usp_CustomerTotals;   


--14-3.2
IF OBJECT_ID('dbo.usp_CustomerTotals')        
	IS NOT NULL BEGIN        
		DROP PROCEDURE dbo.usp_CustomerTotals;    
	END;    
	GO    
	CREATE PROCEDURE dbo.usp_CustomerTotals        
	@CustomerID INT AS        
	SELECT C.CustomerID,            
		YEAR(OrderDate) AS OrderYear,            
		MONTH(OrderDate) AS OrderMonth,            
		SUM(TotalDue) AS TotalSales        
	FROM Sales.Customer AS C        
	INNER JOIN Sales.SalesOrderHeader            
		AS SOH ON C.CustomerID = SOH.CustomerID        
	WHERE C.CustomerID = @CustomerID        
	GROUP BY C.CustomerID,            
	YEAR(OrderDate), MONTH(OrderDate);    
GO    
EXEC dbo.usp_CustomerTotals 17910;  


--14-3.3
IF OBJECT_ID('dbo.usp_ProductSales')        
	IS NOT NULL BEGIN        
	DROP PROCEDURE dbo.usp_ProductSales;    
END;    
GO    
CREATE PROCEDURE dbo.usp_ProductSales        
		@ProductID INT,        
		@TotalSold INT = NULL OUTPUT AS           
	SELECT @TotalSold = SUM(OrderQty)        
	FROM Sales.SalesOrderDetail        
	WHERE ProductID = @ProductID;    
GO    
DECLARE @TotalSold INT;    
EXEC dbo.usp_ProductSales @ProductID = 776,        
	@TotalSold =  @TotalSold OUTPUT;    
PRINT @TotalSold;    