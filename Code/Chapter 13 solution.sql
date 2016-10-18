--13-1
IF OBJECT_ID('dbo.Demo') IS NOT NULL BEGIN           
	DROP TABLE dbo.Demo;    
END;    
GO    
CREATE TABLE dbo.Demo(ID INT PRIMARY KEY, Name VARCHAR(25)); 

--13-1.1
BEGIN TRAN        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES (1,'Test1');           
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES(2,'Test2');    
COMMIT TRAN;  

--13-1.2
BEGIN TRAN        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES(3,'Test3');        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES('a','Test4');    
COMMIT TRAN;    
GO    
SELECT ID,Name    
FROM dbo.Demo;   
  
--13-2.1
BEGIN TRY        
	INSERT INTO HumanResources.Department
		( Name, GroupName, ModifiedDate)        
		VALUES ('Engineering','Research and Development', GETDATE());    
END TRY    
BEGIN CATCH        
	SELECT ERROR_NUMBER() AS ErrorNumber, 
		ERROR_MESSAGE() AS ErrorMessage,            
		ERROR_SEVERITY() AS ErrorSeverity;    
END CATCH;   

--13-2.2

BEGIN TRY        
INSERT INTO            
	HumanResources.Department(               
	Name, GroupName, ModifiedDate)        
	VALUES ('Engineering',            
		'Research and Development',           
		GETDATE());       
END TRY    
BEGIN CATCH        
	IF ERROR_NUMBER() = 2627 BEGIN            
		RAISERROR(               
			'You attempted to insert a duplicate!',  16, 1);       
	END;
END CATCH;  


 