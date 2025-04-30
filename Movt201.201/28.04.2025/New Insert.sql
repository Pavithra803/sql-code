


CREATE TABLE Trn_309_Movement (
    Trn_309_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Movement_ID INT ,
    
    From_Mat_ID INT FOREIGN KEY REFERENCES Mst_Material(Material_ID),
    From_Qty INT,
    From_SLoc_ID INT FOREIGN KEY REFERENCES Mst_Storage_Location(SLoc_ID),
    From_Valuation_Type NVARCHAR(50),
    From_Batch NVARCHAR(50),
    From_Rate_Per_Unit DECIMAL(6,2),
    
    To_Mat_ID INT FOREIGN KEY REFERENCES Mst_Material(Material_ID),
    To_Qty INT,
    To_SLoc_ID INT FOREIGN KEY REFERENCES Mst_Storage_Location(SLoc_ID),
    To_Valuation_Type NVARCHAR(50),
    To_Batch NVARCHAR(50),
    To_Rate_Per_Unit DECIMAL(6,2),
    
    Remark NVARCHAR(255),
    Approval_Status NVARCHAR(50),
    SAP_Transaction_Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


INSERT INTO Trn_309_Movement 
(Doc_ID, Plant_ID, Movement_ID, From_Mat_ID, From_Qty, From_SLoc_ID, From_Valuation_Type, From_Batch, From_Rate_Per_Unit,
To_Mat_ID, To_Qty, To_SLoc_ID, To_Valuation_Type, To_Batch, To_Rate_Per_Unit,
Remark, Approval_Status, SAP_Transaction_Status, Created_By, Created_On) 
VALUES
    (1, 1, 4, 1,  50, 1, 'SUBCONTRACT', '1', 100.00,
	2, 100, 1, 'SUBCONTRACT', 2, 120.00, 
	'test', 'Level 1', 'Open ', 1, GETDATE()),

    (2, 2, 4, 2,  50, 2, 'DOMESTIC', 2, 100.00,
	 3, 100, 2, 'DOMESTIC', 3, 120.00, 
	'test', 'Level 2', 'Pending ', 1, GETDATE()),

    (3, 3, 4,  3, 50, 3, 'INHOUSE', 3, 100.00,
	 4, 100, 3, 'INHOUSE', 4, 120.00, 
	'test', 'Level 3', 'Pending ', 1, GETDATE()),

	 (4, 4, 4, 5, 30, 4, 'INHOUSE', 5, 90.00,
     6, 60, 4, 'INHOUSE', 6, 110.00,
     'Batch transfer for testing', 'Level 4', 'Pending  ', 2, GETDATE()),

    (5, 5, 4, 6, 20, 5, 'DOMESTIC', 6, 95.50,
     7, 40, 5, 'DOMESTIC', 1, 105.00,
     'Urgent requirement', 'Level 5', 'Close', 3, GETDATE()),

    (8, 6, 4, 7, 10, 6, 'SUBCONTRACT', 7, 102.00,
     8, 20, 6, 'SUBCONTRACT', 2, 125.00,
     'Final stage transfer', 'Level 5', 'Close ', 1, GETDATE()

);



(9, 3, 4, 5, 40, 3, 'SUBCONTRACT', '1', 92.00,
 6, 80, 3, 'SUBCONTRACT', '2', 115.00,
 'Rebalancing materials', 'Level 3', 'Pending', 1, GETDATE()),   

 - Row 10
(10, 4, 4, 6, 25, 4, 'DOMESTIC', '6', 99.00,
 7, 50, 4, 'DOMESTIC', '1', 108.00,
 'Final shift update', 'Level 4', 'Close', 3, GETDATE());


/*
drop table trn_309_movement

plant 1 2 3 4 5 6

doc 1 2 3 4 5 8

movt id 1 2 3 4 5

mat id 1 2 3 4 5 6 7 8

sloc 1 2 3 4 5 6

approval status Level 1 level 2 level 3 level 4 level 5 


sap transaction status close so sucess others progres



DELETE FROM Mst_Material
WHERE Material_ID IN (9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41);

select * from Trn_309_Movement

UPDATE Trn_309_Movement
SET Doc_ID = 1,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 1;

UPDATE Trn_Appl_History
SET
    Approver_Status = 'Level 2',
	Ticket_Status='Pending'
WHERE Trn_Appl_His_ID = 9;












*/

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