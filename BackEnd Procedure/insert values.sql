


-- Mst Com T1
INSERT INTO Mst_Company (Com_code, Com_Name, Active_Status, Created_By, Created_On)
VALUES 
	(1000, 'Rane (Madras) Limited', 1, 1, GETDATE()
);

SELECT * FROM Mst_Company;


--Mst Plant T2
INSERT INTO Mst_Plant (Com_ID, Plant_Code, Plant_Name, Short_Name, Active_Status, Created_By, Created_On)
VALUES 
	(1, 1200, 'RML - Mysore', 'P2', 1, 1, GETDATE()),
	(1, 1300, 'RML - Pondicherry', 'P3', 1, 1, GETDATE()),
	(1, 1150, 'RML - Varanavasi', 'P4', 1, 1, GETDATE()),
	(1, 1210, 'RML-Mysore Unit-1', 'P6', 1, 1, GETDATE()),
	(1, 1250, 'RML - Pantnager', 'P5', 1, 1, GETDATE()),
	(1, 1000, 'RML-HO', 'P1', 1, 1, GETDATE()
);

SELECT * FROM Mst_Plant;

--T M 3
INSERT INTO Mst_Department (Dept_Code, Dept_Name, Active_Status, Created_By, Created_On)
VALUES

	('01', 'MED/MFD - ENGINEERING', 1, 1, GETDATE()),
	('02', 'CMED/CMFD - CORPORATE MFG ENGINEERING', 1, 1, GETDATE()),
	('03', 'MTD - MACHINE TOOL DEVELOPMENT', 1, 1, GETDATE()),
	('04', 'PLE - MECH - MECHANICAL MAINENANCE', 1, 1, GETDATE()),
	('05', 'PLE - ELEC - ELECTRICAL- MAINENANCE', 1, 1, GETDATE()),
	('06', 'PLE - UTI -UTILITIES MAINTENANCE', 1, 1, GETDATE()),
	('07', 'R&D', 1, 1, GETDATE()),
	('08', 'FIN - FINANCE', 1, 1, GETDATE()),
	('09', 'IS - INFORMATION SYSTEMS', 1, 1, GETDATE()),
	('10', 'MFG / PRODN PRODUCTION', 1, 1, GETDATE()),
	('11', 'QAD - QUALITY', 1, 1, GETDATE()),
	('12', 'PMMD - PLANT MATERIALS', 1, 1, GETDATE()),
	('13', 'CMMD - CORPORATE MATERIALS', 1, 1, GETDATE()),
	('14', 'CHR - PLANT HUMAN RESOURCE', 1, 1, GETDATE()),
	('15', 'PHR - PLANT HUMAN RESOURCE', 1, 1, GETDATE()),
	('16', 'MKT - MARKETING', 1, 1, GETDATE()),
	('17', 'HEAT TREATMENT', 1, 1, GETDATE()),
	('18', 'PRODUCT NGINEERING', 1, 1, GETDATE()),
	('19', 'TOOL GRINDING PROCESS', 1, 1, GETDATE()),
	('20', 'TOOL HOLDING', 1, 1, GETDATE()),
	('21', 'RM - STORES', 1, 1, GETDATE()),
	('22', 'DIE ASTING', 1, 1, GETDATE()),
	('23', 'DIE MAINTENANCE', 1, 1, GETDATE()),
	('24', 'SCRAP WEIGHING', 1, 1, GETDATE()),
	('25', 'NEW PRODUCT DEVELOPMENT', 1, 1, GETDATE()),
	('26', 'SAFETY', 1, 1, GETDATE()),
	('27', 'CQAD', 1, 1, GETDATE()),
	('28', 'NPD', 1, 1, GETDATE()
);

SELECT * FROM Mst_Department
--------------------------------------------------------------------------------------------------
--T M 4
INSERT INTO Mst_Material_Type (Mat_Type, Active_Status, Created_By, Created_On) 
VALUES 
	('ROH', 1, 1, GETDATE()),
	('HALB', 1, 1, GETDATE()),
	('FERT', 1, 1, GETDATE()),
	('ROH', 1, 1, GETDATE()),
	('HALB', 1, 1, GETDATE()
);

SELECT * FROM Mst_Material_Type

--T M 5
INSERT INTO Mst_Material (Plant_ID, Material_Code, Description, Material_Type, Rate, Active_Status, Created_By, Created_On)
VALUES 
	(1, 'MAT001', 'Test Part No 1', 'ROH', 100.00, 1, 1, GETDATE()),
	(2, 'MAT002', 'Test Part No 2', 'HALB', 200.00, 1, 1, GETDATE()),
	(3, 'MAT003', 'Test Part No 3', 'FERT', 150.00, 1, 1, GETDATE()),
	(4, 'MAT004', 'Test Part No 4', 'ROH', 150.00, 1, 1, GETDATE()),
	(5, 'MAT005', 'Test Part No 5', 'HALB', 125.00, 1, 1, GETDATE()
);
SELECT * FROM Mst_Material

--T M 6

INSERT INTO Mst_Storage_Location (Plant_ID, Storage_Code, SLoc_Name, Active_Status, Created_By, Created_On)
VALUES
	(1, 1000, 'HO RM Stores', 1, 1, GETDATE()),
	(2, 1200, 'P2 RM Stores', 1, 1, GETDATE()),
	(3, 1300, 'P3 RM Stores', 1, 1, GETDATE()),
	(4, 1150, 'P4 RM Stores', 1, 1, GETDATE()),
	(5, 1250, 'P5 RM Stores', 1, 1, GETDATE()
);

SELECT * FROM Mst_Storage_Location

--T M 7

INSERT INTO Mst_Cost_Center (Plant_ID, CostCenter_Code, CostCenter_Name, Active_Status, Created_By, Created_On)
VALUES 

	(1, 1001000, 'Cost Center 1001000', 1, 1, GETDATE()),
	(2, 1002000, 'Cost Center 1002000', 1, 1, GETDATE()),
	(3, 1003000, 'Cost Center 1003000', 1, 1, GETDATE()),
	(4, 1001000, 'Cost Center 1001000', 1, 1, GETDATE()),
	(5, 1002000, 'Cost Center 1002000', 1, 1, GETDATE()
);

SELECT * FROM Mst_Cost_Center
--T M 8

INSERT INTO Mst_Role (Role_Name, Active_Status, Created_By, Created_On)
VALUES 
    ('Administrator', 1, 1, GETDATE()),
    ('Manager', 1, 1, GETDATE()),
    ('Employee', 1, 1, GETDATE()),
    ('Supervisor', 1, 1, GETDATE()),
    ('HR', 1, 1, GETDATE()
);

SELECT * FROM Mst_Role;

--T M 9
ALTER TABLE Mst_Login_User
ADD Password NVARCHAR(255);  -- You can adjust the size of the NVARCHAR if needed.


INSERT INTO Mst_Login_User (Plant_ID, Employee_ID, User_Name, Dept_ID, User_Email, Role_ID, User_Level, Active_Status, Created_By, Created_On,Password)
VALUES

    (1, '2001', 'User 2001', 1, 'user2001@example.com', 1, 1, 1, 1, GETDATE(),123),
    (2, '2002', 'User 2002', 2, 'user2002@example.com', 1, 1, 1, 1, GETDATE(),123),
    (3, '2003', 'User 2003', 3, 'user2003@example.com', 2, 1, 1, 1, GETDATE(),123),
    (4, '2004', 'User 2004', 4, 'user2004@example.com', 2, 1, 1, 1, GETDATE(),123),
    (5, '2005', 'User 2005', 5, 'user2005@example.com', 2, 1, 1, 1, GETDATE(),123
);

SELECT * FROM Mst_Login_User;

--T M 10

INSERT INTO Mst_Movement_Type (Movement_Code, Movement_Name, Active_Status, Created_By, Created_On)
VALUES
	(551, 'Movement type 551', 1, 1, GETDATE()),
	(201, 'Movement type 201', 1, 1, GETDATE()),
	(202, 'Movement type 202', 1, 1, GETDATE()),
	(309, 'Movement type 309', 1, 1, GETDATE()),
	(311, 'Movement type 311', 1, 1, GETDATE()
);

SELECT * FROM Mst_Movement_Type;

--T M 11

INSERT INTO Mst_Movement_List_Item (Movement_ID, Movement_List_Code, Movement_List_Name, Active_Status, Created_By, Created_On)
VALUES 

    (1, '0091', 'Shrinkage', 1, 1, GETDATE()),
    (1, '0092', 'Spoiled', 1, 1, GETDATE()),
    (2, '0001', 'For Remelting', 1, 1, GETDATE()),
    (2, '0002', 'Loan from Customer', 1, 1, GETDATE()),
    (2, '0015', 'Qty to Scrap', 1, 1, GETDATE()),
    (2, '0018', 'Service Purpose', 1, 1, GETDATE()),
    (2, '0201', 'Vendor Issue', 1, 1, GETDATE()),
    (2, '0202', '202 Wrong Entry', 1, 1, GETDATE()),
    (2, '0204', 'Qty to Remelt', 1, 1, GETDATE()),
    (3, '0001', 'For Remelting', 1, 1, GETDATE()),
    (3, '0015', 'Qty to Scrap', 1, 1, GETDATE()),
    (3, '0016', 'Return to Vendor', 1, 1, GETDATE()),
    (3, '0017', 'Scrap Stock Raise', 1, 1, GETDATE()),
    (3, '0018', 'Service Purpose', 1, 1, GETDATE()),
    (3, '0202', '201 Wrong Entry', 1, 1, GETDATE()),
    (3, '0203', 'NPD STOCK RAISE', 1, 1, GETDATE()),
    (3, '0204', 'Qty to Remelt', 1, 1, GETDATE()),
    (3, '0205', 'Dsgn,teststock rais', 1, 1, GETDATE()),
    (3, '0206', 'Salvage frmcust ret', 1, 1, GETDATE()),
    (3, '0207', 'Scrao frm Cust ret', 1, 1, GETDATE()),
    (3, '0208', 'FOC to Customer', 1, 1, GETDATE()),
    (3, '0209', 'Loan from Customer', 1, 1, GETDATE()),
    (4, '3091', 'OE to OES', 1, 1, GETDATE()),
    (4, '3092', 'Inwarding in Wrong Part Number', 1, 1, GETDATE()),
    (4, '3093', 'Part Mix Up', 1, 1, GETDATE()),
    (4, '3094', 'Non Moving Conversion', 1, 1, GETDATE()),
    (4, '3095', 'Wrong Entry During Physical Inventory', 1, 1, GETDATE()),
    (4, '3096', 'Proto Part to Regular Part', 1, 1, GETDATE()),
    (4, '3097', 'Others', 1, 1, GETDATE());


SELECT * FROM Mst_Movement_List_Item;


--T M 12

INSERT INTO Mst_Vendor (Vendor_Code, Vendor_Name, Vendor_Address, Active_Status, Created_By, Created_On)
VALUES 

    (1001, 'Vendor One', '123 Vendor St, City, Country', 1, 1, GETDATE()),
    (1002, 'Vendor Two', '456 Vendor Ave, City, Country', 1, 1, GETDATE()),
    (1003, 'Vendor Three', '789 Vendor Blvd, City, Country', 1, 1, GETDATE()),
    (1004, 'Vendor Four', '101 Vendor Road, City, Country', 1, 1, GETDATE()),
    (1005, 'Vendor Five', '202 Vendor Lane, City, Country', 1, 1, GETDATE()
);


SELECT * FROM Mst_Vendor

--T M 13

INSERT INTO Mst_Customer (Customer_Code, Customer_Name, Customer_Address, Active_Status, Created_By, Created_On)
VALUES 

    (1001, 'Customer One', '123 Customer St, City, Country', 1, 1, GETDATE()),
    (1002, 'Customer Two', '456 Customer Ave, City, Country', 1, 1, GETDATE()),
    (1003, 'Customer Three', '789 Customer Blvd, City, Country', 1, 1, GETDATE()),
    (1004, 'Customer Four', '101 Customer Road, City, Country', 1, 1, GETDATE()),
    (1005, 'Customer Five', '202 Customer Lane, City, Country', 1, 1, GETDATE()
);


SELECT * FROM Mst_Customer

--Trn Table 1

INSERT INTO Trn_Document (Plant_ID, Movement_ID, Movement_Name, Status, Created_By, Created_On)
VALUES 

    (1, 1, 'Stock Transfer', 'Active', 1, GETDATE()),
    (2, 2, 'Material Issue', 'Active', 1, GETDATE()),
    (3, 3, 'Goods Receipt', 'Inactive', 2, GETDATE()),
    (4, 4, 'Return to Vendor', 'Active', 3, GETDATE()),
    (5, 5, 'Inventory Adjustment', 'Inactive', 2, GETDATE()
);

SELECT * FROM Trn_Document

--T T 2

/*INSERT INTO Trn_309_Movement 
(Doc_ID, Plant_ID, Movement_ID, From_Mat_ID, From_Qty, From_SLoc_ID, From_Valuation_Type, From_Batch, From_Rate_Per_Unit,
To_Mat_ID, To_Qty, To_SLoc_ID, To_Valuation_Type, To_Batch, To_Rate_Per_Unit,
Remark, Approval_Status, SAP_Transaction_Status, Created_By, Created_On) 

	VALUES
	(1, 1200, 309, 'MAT001', 50, 1000, 'SUBCONTRACT', '2', 100,
	'MAT003', 50, 1000, 'SUBCONTRACT', '2', 120, 
	'test', 'Pending', 'Success', 1, GETDATE()),

	(2, 1300, 309, 'MAT002', 50, 1200, 'DOMESTIC', '2', 100,
	'MAT004', 50, 1200, 'DOMESTIC', '2', 120,
	'test', 'Pending', 'Success', 1, GETDATE()),

	(3, 1150, 309, 'MAT003', 50, 1300, 'INHOUSE', '2', 100, 
	'MAT005', 50, 1300, 'INHOUSE', '2', 120,
	'test', 'Pending', 'Success', 1, GETDATE()
);

SELECT * FROM Trn_309_Movement

DROP TABLE Trn_309_Movement;

ALTER TABLE Trn_309_Movement
ALTER COLUMN From_Mat_ID NVARCHAR(50);

ALTER TABLE Trn_309_Movement
ALTER COLUMN To_Mat_ID NVARCHAR(50);

TRUNCATE TABLE Trn_309_Movement;


INSERT INTO Trn_309_Movement 
(Doc_ID, Plant_ID, Movement_ID, From_Mat_ID, From_Qty, From_SLoc_ID, From_Valuation_Type, From_Batch, From_Rate_Per_Unit,
To_Mat_ID, To_Qty, To_SLoc_ID, To_Valuation_Type, To_Batch, To_Rate_Per_Unit,
Remark, Approval_Status, SAP_Transaction_Status, Created_By, Created_On) 
VALUES
(1, 1200, 309, 'MAT001', 50, 1, 'SUBCONTRACT', '2', 100.00,
'MAT003', 50, 5, 'SUBCONTRACT', '2', 120.00, 
'test', 'Pending', 'Success', 1, GETDATE()),

(2, 1300, 309, 'MAT002', 50, 2, 'DOMESTIC', '2', 100.00,
'MAT004', 50, 3, 'DOMESTIC', '2', 120.00,
'test', 'Pending', 'Success', 1, GETDATE()),

(3, 1150, 309, 'MAT003', 50, 4, 'INHOUSE', '2', 100.00, 
'MAT005', 50, 3, 'INHOUSE', '2', 120.00,
'test', 'Pending', 'Success', 1, GETDATE()
);
*/



CREATE TABLE Trn_309_Movement (
    Trn_309_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Movement_ID INT,
    
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
	'test', 'Pending', 'In Progress', 1, GETDATE()),

    (2, 2, 4, 2,  50, 2, 'DOMESTIC', 2, 100.00,
	 3, 100, 2, 'DOMESTIC', 3, 120.00, 
	'test', 'Pending', 'In Progress', 1, GETDATE()),

    (3, 3, 4,  3, 50, 3, 'INHOUSE', 3, 100.00,
	 4, 100, 3, 'INHOUSE', 4, 120.00, 
	'test', 'Pending', 'In Progress', 1, GETDATE()
);


--DROP TABLE Trn_309_Movement;



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
