


select * from Trn_309_Movement

select * from Mst_Movement_List_Item
select * from Mst_Movement_Type
select * from Trn_Document

select * from Mst_Material

TRUNCATE TABLE Mst_Movement_Type;


INSERT INTO #transation (
  Plant_Code, From_Material_Code, From_Qty, From_Storage_Code, From_Valuation_Type,
  From_Batch, From_Rate_Per_Unit, To_Material_Code, To_Qty, To_Storage_Code,
  To_Valuation_Type, To_Batch, To_Rate_Per_Unit, Remark
)
VALUES
('1250', 'MAT005', '10', '1000', 'SUBCONTRACT', '1', '40', 'MAT001', '50', '1200', 'INHOUSE', '1', '40', 'Test'),
('1150', 'MAT002', '20', '1200', 'INHOUSE', '2', '30', 'MAT002', '40', '1300', 'SUBCONTRACT', '2', '30', 'Test'),
('1300', 'MAT001', '30', '1300', 'DOMESTIC', '3', '20', 'MAT003', '30', '1150', 'DOMESTIC', '3', '20', 'Test'),
('1200', 'MAT003', '40', '1150', 'SUBCONTRACT', '4', '10', 'MAT004', '20', '1250', 'SUBCONTRACT', '4', '10', 'Test'),
('1250', 'MAT004', '50', '1250', 'INHOUSE', '5', '10', 'MAT005', '10', '1000', 'INHOUSE', '5', '10', 'Test');


/*
----------------FORMAT----------


INSERT INTO <table_name> (column1, column2, ...)  
VALUES (value1, value2, ...);

UPDATE <table_name>  
SET column1 = value1, column2 = value2, ...  
WHERE condition;


SELECT * FROM <table_name>;
*/
--ONE VALUSE ARE MODIFIED BY

UPDATE #transation
SET From_Qty = '60'   -- New value
WHERE Plant_Code = '1250' AND From_Material_Code = 'MAT005';

                             --update multiple columns in one statement

 ---------------/* TEST MODIFIED*?------------------- 

UPDATE Trn_309_Movement
SET 
    Doc_ID = '4',
    Movement_ID = '4',
    Remark = 'Updated Test'
WHERE 
    Plant_ID = '5' 
    AND From_Mat_ID = '5' 
    AND To_Mat_ID = '1';



select * from Trn_309_Movement

-----------------------------------------------

SELECT * FROM Mst_Company;
SELECT * FROM Mst_Plant;
SELECT * FROM Mst_Department;
SELECT * FROM Mst_Material;
SELECT * FROM Mst_Storage_Location;
SELECT * FROM Mst_Cost_Center;
SELECT * FROM Mst_Role;
SELECT * FROM Mst_Login_User;
SELECT * FROM Mst_Movement_Type;
SELECT * FROM Mst_Movement_List_Item;
SELECT * FROM Mst_Vendor;
SELECT * FROM Mst_Customer;

SELECT * FROM Trn_Document;
SELECT * FROM Trn_202_Movement;
SELECT * FROM Trn_309_Movement;
SELECT * FROM Trn_Appl_History;






DROP TABLE Mst_Plant;
DROP TABLE Mst_Department;
DROP TABLE Mst_Material;
DROP TABLE Mst_Material_Type;
DROP TABLE Mst_Storage_Location;
DROP TABLE Mst_Cost_Center;
DROP TABLE Mst_Role;
DROP TABLE Mst_Login_User;
DROP TABLE Mst_Movement_Type;
DROP TABLE Mst_Movement_List_Item;
DROP TABLE Mst_Vendor;
DROP TABLE Mst_Customer;

DROP TABLE Trn_Document;
DROP TABLE Trn_202_Movement;
DROP TABLE Trn_309_Movement;
DROP TABLE Trn_Appl_History;


TRUNCATE TABLE Trn_309_Movement;
