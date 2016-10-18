--Listing 15-1. OPENXML Query
--1
DECLARE @hdoc int;
DECLARE @doc varchar(1000) = N'
<Products>
<Product ProductID="32565451" ProductName="Bicycle Pump">
   <Order ProductID="32565451" SalesID="5" OrderDate="2011-07-04T00:00:00">
      <OrderDetail OrderID="10248" CustomerID="22" Quantity="12"/>
      <OrderDetail OrderID="10248" CustomerID="11" Quantity="10"/>
   </Order>
</Product>
<Product ProductID="57841259" ProductName="Bicycle Seat">
   <Order ProductID="57841259" SalesID="3" OrderDate="2011-015-16T00:00:00">
         <OrderDetail OrderID="54127" CustomerID="72" Quantity="3"/>
   </Order>
</Product>
</Products>';

--2
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc;

--3
SELECT *
FROM OPENXML(@hdoc, N'/Products/Product');

--4
EXEC sp_xml_removedocument @hdoc;


--Listing 15-2. OPENXML Query Using the WITH Clause
--1
DECLARE @hdoc int;
DECLARE @doc varchar(1000) = N'
<Products>
<Product ProductID="32565451" ProductName="Bicycle Pump">
   <Order ProductID="32565451" SalesID="5" OrderDate="2011-07-04T00:00:00">
      <OrderDetail OrderID="10248" CustomerID="22" Quantity="12"/>
      <OrderDetail OrderID="10248" CustomerID="11" Quantity="10"/>
   </Order>
</Product>
<Product ProductID="57841259" ProductName="Bicycle Seat">
   <Order ProductID="57841259" SalesID="3" OrderDate="2011-015-16T00:00:00">
      <OrderDetail OrderID="54127" CustomerID="72" Quantity="3"/>
   </Order>
</Product>
</Products>';

--2
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc;

--3
SELECT *
FROM OPENXML(@hdoc, N'/Products/Product/Order/OrderDetail')
WITH (CustomerID int '@CustomerID',
     ProductID int '../@ProductID',
     ProductName varchar(30) '../../@ProductName',
     OrderID int '@OrderID',
     Orderdate varchar(30) '../@OrderDate');

--4
EXEC sp_xml_removedocument @hdoc;

--Listing 15-3. Generating XML Using the FOR XML RAW Command
SELECT TOP(5) FirstName
FROM Person.Person
FOR XML RAW;


--Listing 15-5. Creating Element-Centric XML Using XML RAW 
SELECT TOP(5) FirstName, LastName
FROM Person.Person
FOR XML RAW ('NAME'), ELEMENTS;

--Listing 15-6. Using AUTO Mode
SELECT TOP(5) CustomerID, LastName, FirstName, MiddleName
FROM Person.Person AS Person
INNER JOIN Sales.Customer AS Customer ON Person.BusinessEntityID = Customer.PersonID
ORDER BY CustomerID
FOR XML AUTO;

--Listing 15-7. Using AUTO Mode with the ELEMENTS Option
SELECT TOP(3) CustomerID, LastName, FirstName, MiddleName
FROM Person.Person AS Person
INNER JOIN Sales.Customer AS Customer ON Person.BusinessEntityID = Customer.PersonID
ORDER BY CustomerID
FOR XML AUTO, ELEMENTS;

--Listing 15-8. Using XML FOR EXPLICIT
SELECT 1 AS Tag,
       NULL       AS Parent,
       CustomerID AS [Customer!1!CustomerID],
       NULL       AS [Name!2!FName],
       NULL       AS [Name!2!LName]
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P
ON  P.BusinessEntityID = C.PersonID
UNION
SELECT 2 AS Tag,
       1 AS Parent,
       CustomerID,
       FirstName,
       LastName
FROM Person.Person P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY [Customer!1!CustomerID], [Name!2!FName]
FOR XML EXPLICIT;

--Listing 15-9. Simple FOR XML PATH Query
SELECT TOP(3) p.FirstName, 
       p.LastName, 
       s.Bonus, 
       s.SalesYTD
FROM Person.Person p
JOIN Sales.SalesPerson s
ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY SalesYTD DESC
FOR XML PATH;


--Listing 15-10. Defining XML Hierarchy Using PATH Mode
SELECT TOP(3) p.FirstName "@FirstName", 
       p.LastName "@LastName", 
           s.Bonus "Sales/Bonus", 
           s.SalesYTD "Sales/YTD"
FROM Person.Person p
JOIN Sales.SalesPerson s
ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY s.SalesYTD DESC
FOR XML PATH;


--Listing 15-11. Simple FOR XML PATH Query with NAME Option
SELECT TOP(5) ProductID "@ProductID",
       Name "Product/ProductName",
       Color "Product/Color"
FROM Production.Product
ORDER BY ProductID 
FOR XML PATH ('Product');

--Listing 15-12. Built-in XML Data Type
USE tempdb;
GO

CREATE TABLE dbo.ProductList (ProductInfo XML);

--Listing 15-13. Using XML as a Data Type
--1
USE AdventureWorks;
GO
CREATE TABLE #CustomerList (CustomerInfo XML);

--2
DECLARE @XMLInfo XML;

--3
SET @XMLInfo = (SELECT CustomerID, LastName, FirstName, MiddleName
FROM Person.Person AS p 
INNER JOIN Sales.Customer AS c ON p.BusinessEntityID = c.PersonID 
FOR XML PATH);

--4
INSERT INTO #CustomerList(CustomerInfo)
VALUES(@XMLInfo);

--5
SELECT CustomerInfo FROM #CustomerList;
DROP TABLE #CustomerList;

--Listing 15-14. Create a Temp Table with an XML Column
--1
--DROP TABLE #Bikes
CREATE TABLE #Bikes(ProductID INT, ProductDescription XML);

--2
INSERT INTO #Bikes(ProductID, ProductDescription)
SELECT ProductID,
(SELECT ProductID, Product.Name, Color, Size, ListPrice, SC.Name AS BikeSubCategory
	FROM Production.Product AS Product
	JOIN Production.ProductSubcategory SC 
		ON Product.ProductSubcategoryID = SC.ProductSubcategoryID
	JOIN Production.ProductCategory C 
		ON SC.ProductCategoryID = C.ProductCategoryID
	WHERE Product.ProductID = Prod.ProductID
	FOR XML RAW('Product'), ELEMENTS) AS ProdXML
FROM  Production.Product AS Prod
	JOIN Production.ProductSubcategory SC 
		ON Prod.ProductSubcategoryID = SC.ProductSubcategoryID
	JOIN Production.ProductCategory C 
		ON SC.ProductCategoryID = C.ProductCategoryID
WHERE C.Name = 'Bikes';

--3
SELECT *  
FROM #Bikes;

--Listing 15-15. Using the QUERY Method
SELECT ProductID, 
    ProductDescription.query('Product/ListPrice') AS ListPrice
FROM #Bikes;



--Listing 15-16. Using the VALUE Method
SELECT ProductID, 
    ProductDescription.value('(/Product/ListPrice)[1]', 'MONEY') AS ListPrice
FROM #Bikes;

--Listing 15-17. Using the value() Method with an Attribute
DECLARE @test XML = '
<root>
<Product ProductID="123" Name="Road Bike"/>
<Product ProductID="124" Name="Mountain Bike"/>
</root>';

SELECT @test.value('(/root/Product/@Name)[2]','NVARCHAR(25)');


--Listing 15-18. Using the exist() Method
SELECT ProductID, 
    ProductDescription.value('(/Product/ListPrice)[1]', 'MONEY') AS ListPrice
FROM #Bikes
WHERE ProductDescription.exist('/Product/ListPrice[text()[1] lt 3000]') = 1;

--Listing 15-19. Using exist() with Dates
--1
DECLARE @test1 XML = '
<root>
    <Product ProductID="123" LastOrderDate="2014-06-02"/>
</root>';

--2
DECLARE @test2 XML = '
<root>
    <Product>
	    <ProductID>123</ProductID>
		<LastOrderDate>2014-06-02</LastOrderDate>
	</Product>
</root>';

--3
SELECT @test1.exist('/root/Product[(@LastOrderDate cast as xs:date?) 
    eq xs:date("2014-06-02")]'),
@test2.exist('/root/Product/LastOrderDate[(text()[1] cast as xs:date?) 
    eq xs:date("2014-06-02")]');

--Listing 15-20. Using the  MODIFY Method
--1
DECLARE @x xml =
'<Product ProductID = "521487">
  <ProductType>Paper Towels</ProductType>
  <Price>15</Price>
  <Vendor>Johnson Paper</Vendor>
  <VendorID>47</VendorID>
  <QuantityOnHand>500</QuantityOnHand>
</Product>';

--2
SELECT @x;

--3
/* inserting data into xml with the modify method */
SET @x.modify('
insert <WarehouseID>77</WarehouseID>
into (/Product)[1]');

--4
SELECT @x;
 
--5
/* updating xml with the modify method */
SET @x.modify('
replace value of (/Product/QuantityOnHand[1]/text())[1]
with "250"');

--6
SELECT @x; 

--7
/* deleting xml with the modify method */
SET @x.modify('
delete (/Product/Price)[1]');

--8
SELECT @x;

--Listing 15-21. Using the nodes() Method
--1
DECLARE @XML XML = '
<Product>
	<ProductID>749</ProductID>
	<ProductID>749</ProductID>
	<ProductID>750</ProductID>
	<ProductID>751</ProductID>
	<ProductID>752</ProductID>
	<ProductID>753</ProductID>
	<ProductID>754</ProductID>
	<ProductID>755</ProductID>
	<ProductID>756</ProductID>
	<ProductID>757</ProductID>
	<ProductID>758</ProductID>
</Product>';

--2
SELECT P.ProdID.value('.', 'INT') as ProductID
FROM @XML.nodes('/Product/ProductID') P(ProdID);



 --Namespaces
 SELECT Demographics FROM Sales.Store;

--Listing 15-22. Using a Namespace
SELECT Demographics.query('declare namespace ss = "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
<Store AnnualSales = "{ /ss:StoreSurvey/ss:AnnualSales }"
       BankName = "{ /ss:StoreSurvey/ss:BankName }" /> 
') AS Result
FROM Sales.Store;


--Listing 15-23. Splitting a String Using XML
GO
--1
DECLARE @values NVARCHAR(30) = N'Bike,Seat,Pedals,Basket';

--2
DECLARE @XML XML;

--3
SELECT @XML = '<item>' + REPLACE(@values,',','</item><item>') + '</item>';

--4
SELECT @XML;

--5
SELECT I.Product.value('.','NVARCHAR(10)') AS Item
FROM @XML.nodes('/item') AS I(Product);














