--8-1.1
SELECT ProductID, ProductSubcategoryID,        
	ROW_NUMBER() OVER(PARTITION BY ProductSubCategoryID    
		ORDER BY ProductID) AS RowNum    
FROM Production.Product    
WHERE ProductSubcategoryID IS NOT NULL;  

--8-1.2
SELECT CustomerID, SUM(TotalDue) AS TotalSales,        
	NTILE(10) OVER(ORDER BY SUM(TotalDue)) AS CustBucket    
FROM Sales.SalesOrderHeader    
WHERE OrderDate BETWEEN '2005/1/1' AND '2005/12/31'    
GROUP BY CustomerID;   
--8-2.1
SELECT SalesOrderID, OrderDate, TotalDue, CustomerID,        
	AVG(TotalDue) OVER() AS AvgTotalF    
FROM Sales.SalesOrderHeader;  
 
--8-2.2
SELECT SalesOrderID, OrderDate, TotalDue, CustomerID,        
	AVG(TotalDue) OVER() AS AvgTotal,        
	AVG(TotalDue) OVER(PARTITION BY CustomerID) AS AvgCustTotal    
FROM Sales.SalesOrderHeader;   

--8-3.1
SELECT SalesOrderID, ProductID, LineTotal,        
	SUM(LineTotal) OVER(PARTITION BY ProductID            
	ORDER BY SalesOrderID         
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)            
	AS RunningTotal   
FROM Sales.SalesOrderDetail;  
 
--8-4
CREATE TABLE #Stock (Symbol VARCHAR(4), TradingDate DATE,        
	OpeningPrice MONEY, ClosingPrice MONEY);    
INSERT INTO #Stock(Symbol, TradingDate, OpeningPrice, ClosingPrice)    
VALUES ('A','2014/01/02',5.03,4.90),        
	('B','2014/01/02',10.99,11.25),        
	('C','2014/01/02',23.42,23.44),        
	('A','2014/01/03',4.93,5.10),        
	('B','2014/01/03',11.25,11.25),        
	('C','2014/01/03',25.15,25.06),        
	('A','2014/01/06',5.15,5.20),        
	('B','2014/01/06',11.30,11.12),        
	('C','2014/01/06',25.20,26.00);  
 
--8-4.1
SELECT Symbol, TradingDate, OpeningPrice, ClosingPrice,        
	ClosingPrice - LAG(ClosingPrice)     
	OVER(PARTITION BY Symbol ORDER BY TradingDate)     
	AS ClosingPriceChange    
FROM #Stock ; 

--8-4.2
SELECT Symbol, TradingDate, OpeningPrice, ClosingPrice,        
	ClosingPrice - LAG(ClosingPrice,1,ClosingPrice)        
	OVER(PARTITION BY Symbol ORDER BY TradingDate)       
	AS ClosingPriceChange    
FROM #Stock;       





  
 