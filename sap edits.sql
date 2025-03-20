

CREATE TABLE Trn_Document (
    Doc_ID INT IDENTITY(1,1) PRIMARY KEY,
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Movement_Name NVARCHAR(255),
    Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

DROP TABLE IF EXISTS Mst_Company;
DROP TABLE IF EXISTS Mst_Plant;
DROP TABLE IF EXISTS Mst_Department;
DROP TABLE IF EXISTS Mst_Material;
DROP TABLE IF EXISTS Mst_Storage_Location;
DROP TABLE IF EXISTS Mst_Cost_Center;

DROP TABLE IF EXISTS Mst_Login_User;
DROP TABLE IF EXISTS Mst_Movement_Type;
DROP TABLE IF EXISTS Mst_Movement_List_Item;
DROP TABLE IF EXISTS Mst_Vendor;
DROP TABLE IF EXISTS Mst_Customer;

DROP TABLE IF EXISTS Mst_Role;

DROP TABLE IF EXISTS Trn_Document;
DROP TABLE IF EXISTS Trn_202_Movement;
DROP TABLE IF EXISTS Trn_309_Movement;
DROP TABLE IF EXISTS Trn_Appl_History;

SELECT * FROM Trn_Document;

--T 7 Mst_Role - ADD

CREATE TABLE Mst_Role (
    Role_ID INT IDENTITY(1,1) PRIMARY KEY,   
    Role_Name NVARCHAR(255),       
    Active_Status BIT ,    
    Created_By INT,                         
    Created_On DATETIME ,
    Modified_By INT,                         
    Modified_On DATETIME 
);

--T T 1 Modified
CREATE TABLE Trn_Document (
    Doc_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID), -- Added here
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Movement_Name NVARCHAR(255),
    Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


--T T 4 Modified
CREATE TABLE Trn_Appl_History (
    Trn_Appl_His_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT FOREIGN KEY REFERENCES Trn_Document(Doc_ID),
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID), -- Added here
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Approver_ID INT FOREIGN KEY REFERENCES Mst_Login_User(User_ID),
    Appr_Comment NVARCHAR(255),
    Appr_Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

-- T 8 Mst User Modified
CREATE TABLE Mst_Login_User (
    User_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Employee_ID NVARCHAR(10),
    User_Name NVARCHAR(255),
    Dept_ID INT FOREIGN KEY REFERENCES Mst_Department(Dept_ID),
    User_Email NVARCHAR(255),
    Role_ID INT FOREIGN KEY REFERENCES Mst_Role(Role_ID),  -- Now a foreign key
    User_Level INT,
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


--ALTER TABLE Mst_Login_User ALTER COLUMN Role_ID INT NOT NULL;



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


SELECT * FROM Mst_Role;
SELECT * FROM Mst_Login_User;

SELECT * FROM Trn_Document;
SELECT * FROM Trn_Appl_History;

SELECT * FROM Mst_Login_User;

SELECT * FROM 
[INFORMATION_SCHEMA].COLUMNS
WHERE TABLE_NAME = 'Mst_Login_User'

