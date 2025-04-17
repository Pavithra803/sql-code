
CREATE DATABASE SAP_APPROVAL;


USE SAP_APPROVAL;

-- Masters Table 

--T 1 Mst Com
CREATE TABLE Mst_Company (
    Com_ID INT IDENTITY(1,1) PRIMARY KEY,
    Com_code INT,
    Com_Name NVARCHAR(255),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);
  

--T 2 Mst Plant

CREATE TABLE Mst_Plant (
    Plant_ID INT IDENTITY(1,1) PRIMARY KEY,
    Com_ID INT FOREIGN KEY REFERENCES Mst_Company(Com_ID),
    Plant_Code INT, 
    Plant_Name NVARCHAR(255),
    Short_Name NVARCHAR(50),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 3 Mst Dept

CREATE TABLE Mst_Department (
    Dept_ID INT IDENTITY(1,1) PRIMARY KEY,
    Dept_Code NVARCHAR(50),
    Dept_Name NVARCHAR(255),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 4 Mst Material Type 

CREATE TABLE Mst_Material_Type (
    Mat_ID INT IDENTITY(1,1) PRIMARY KEY,  
    Mat_Type NVARCHAR(50), 
    Active_Status BIT ,  
    Created_By INT,  
    Created_On DATETIME ,  
    Modified_By INT ,  
    Modified_On DATETIME  
);
--T 5 Mst Material

CREATE TABLE Mst_Material (
    Material_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Material_Code NVARCHAR(50),
    Description NVARCHAR(255),
    Material_Type NVARCHAR(4),
    Rate DECIMAL(6,2), 
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);




--T 6 Mst Storage  Location

CREATE TABLE Mst_Storage_Location (
    SLoc_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Storage_Code INT,  
    SLoc_Name NVARCHAR(50),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 7 Mst Cost Center

CREATE TABLE Mst_Cost_Center (
    CostCenter_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    CostCenter_Code INT,
    CostCenter_Name NVARCHAR(50),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 8 Mst Role

CREATE TABLE Mst_Role (
    Role_ID INT IDENTITY(1,1) PRIMARY KEY,   
    Role_Name NVARCHAR(255),       
    Active_Status BIT ,    
    Created_By INT,                         
    Created_On DATETIME ,
    Modified_By INT,                         
    Modified_On DATETIME 
);

--T 9 Mst User

/*CREATE TABLE Mst_Login_User (
    User_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Employee_ID NVARCHAR(10),
    User_Name NVARCHAR(255),
    Dept_ID INT FOREIGN KEY REFERENCES Mst_Department(Dept_ID),
    User_Email NVARCHAR(255),
    Role_ID INT,
    User_Level INT,
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);*/
CREATE TABLE Mst_Login_User (
    User_ID INT IDENTITY(1,1) PRIMARY KEY,
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Employee_ID NVARCHAR(10),
    User_Name NVARCHAR(255),
    Dept_ID INT FOREIGN KEY REFERENCES Mst_Department(Dept_ID),
    User_Email NVARCHAR(255),
    Role_ID INT FOREIGN KEY REFERENCES Mst_Role(Role_ID),  -- foreign key
    User_Level INT,
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


--T 10 Mst Movement type

CREATE TABLE Mst_Movement_Type (
    Movement_ID INT IDENTITY(1,1) PRIMARY KEY,
    Movement_Code INT,
    Movement_Name NVARCHAR(255),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


--T 11 Mst Movt List Item

CREATE TABLE Mst_Movement_List_Item (
    Movt_List_ID INT IDENTITY(1,1) PRIMARY KEY,
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Movement_List_Code INT,
    Movement_List_Name NVARCHAR(250),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 12 Mst Vendor

CREATE TABLE Mst_Vendor (
    Vendor_ID INT IDENTITY(1,1) PRIMARY KEY,
    Vendor_Code INT,
    Vendor_Name NVARCHAR(255),
    Vendor_Address NVARCHAR(255),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

--T 13 Mst Customer

CREATE TABLE Mst_Customer (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Code INT,
    Customer_Name NVARCHAR(255),
    Customer_Address NVARCHAR(255),
    Active_Status BIT,
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);

-- Transaction Table 

--T 1 Trn  Doc

/*CREATE TABLE Trn_Document (
    Doc_ID INT IDENTITY(1,1) PRIMARY KEY,
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Movement_Name NVARCHAR(255),
    Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);*/

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


--T 2 Trn 309 Movt

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


--T 3 Trn 202 movt

CREATE TABLE Trn_202_Movement (
    Trn_202_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT FOREIGN KEY REFERENCES Trn_Document(Doc_ID),
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID),
    Material_ID INT FOREIGN KEY REFERENCES Mst_Material(Material_ID),
    Quantity INT,
    SLoc_ID INT FOREIGN KEY REFERENCES Mst_Storage_Location(SLoc_ID),
    CostCenter_ID INT FOREIGN KEY REFERENCES Mst_Cost_Center(CostCenter_ID),
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Valuation_Type NVARCHAR(50),
    Batch NVARCHAR(50),
    Rate_Unit DECIMAL(6,2),
    Remark NVARCHAR(255),
    User_ID INT FOREIGN KEY REFERENCES Mst_Login_User(User_ID),
    Approval_Status VARCHAR(50),
    SAP_Transaction_Status VARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


-- T 4  Trn Appl History

/*CREATE TABLE Trn_Appl_History (
    Trn_Appl_His_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT FOREIGN KEY REFERENCES Trn_Document(Doc_ID),
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Approver_ID INT FOREIGN KEY REFERENCES Mst_Login_User(User_ID),
    Appr_Comment NVARCHAR(255),
    Appr_Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME ,
    Modified_By INT ,
    Modified_On DATETIME 
);*/


CREATE TABLE Trn_Appl_History (
    Trn_Appl_His_ID INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT FOREIGN KEY REFERENCES Trn_Document(Doc_ID),
    Plant_ID INT FOREIGN KEY REFERENCES Mst_Plant(Plant_ID), -- Added here
    Movement_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Approver_ID INT FOREIGN KEY REFERENCES Mst_Login_User(User_ID),
    Approver_Comment NVARCHAR(255),
    Approver_Status NVARCHAR(50),
	Ticket_Status NVARCHAR(50),
    Created_By INT,
    Created_On DATETIME,
    Modified_By INT,
    Modified_On DATETIME
);


/*
-- T 5  Trn 309 Approval Status
CREATE TABLE Trn_309_Approval_Status (
    Trn309ApplStatus_Id INT IDENTITY(1,1) PRIMARY KEY,
    Doc_ID INT FOREIGN KEY REFERENCES Trn_Document(Doc_ID),
    Approver_ID INT FOREIGN KEY REFERENCES Mst_Login_User(User_ID),
    Creation_Date DATETIME,
    Movt_type_ID INT FOREIGN KEY REFERENCES Mst_Movement_Type(Movement_ID),
    Approval_I NVARCHAR(50),
    Approval_II NVARCHAR(50),
    Approval_III NVARCHAR(50),
    Approval_IV NVARCHAR(50),
    Approval_V NVARCHAR(50),
    MRPC NVARCHAR(50),

    Task_Status NVARCHAR(50),
    Created_By INT,            -- Assuming it's a User ID
    Created_On DATETIME,
    Modified_By INT,           -- Assuming it's a User ID
    Modified_On DATETIME
);


*/

DROP TABLE Trn_Appl_History;

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



--T M 1
INSERT INTO Mst_Company (Com_code, Com_Name, Active_Status, Created_By, Created_On)
VALUES 
(),(),();

--T M 2
INSERT INTO Mst_Plant (Com_ID, Plant_Code, Plant_Name, Short_Name, Active_Status, Created_By, Created_On)
VALUES 
(),();

--T M 3
INSERT INTO Mst_Department (Dept_Code, Dept_Name, Active_Status, Created_By, Created_On)
VALUES
(),(),();

--T M 4
INSERT INTO Mst_Material_Type (Mat_Type, Active_Status, Created_By, Created_On) 
VALUES (),();

--T M 5
INSERT INTO Mst_Material (Plant_ID, Material_Code, Description, Material_Type, Rate, Active_Status, Created_By, Created_On)
VALUES 
(),();

--T M 6

INSERT INTO Mst_Storage_Location (Plant_ID, Storage_Code, SLoc_Name, Active_Status, Created_By, Created_On)
VALUES
(),(),();

--T M 7

INSERT INTO Mst_Cost_Center (Plant_ID, CostCenter_Code, CostCenter_Name, Active_Status, Created_By, Created_On)
VALUES 
(),(),();

--T M 8

INSERT INTO Mst_Role (Role_Name, Active_Status, Created_By, Created_On)
VALUES 
((),(),();

--T M 9
INSERT INTO Mst_Login_User (Plant_ID, Employee_ID, User_Name, Dept_ID, User_Email, Role_ID, User_Level, Active_Status, Created_By, Created_On)
VALUES
(),(),();

--T M 10

INSERT INTO Mst_Movement_Type (Movement_Code, Movement_Name, Active_Status, Created_By, Created_On)
VALUES
(),(),();

--T M 11

INSERT INTO Mst_Movement_List_Item (Movement_ID, Movement_List_Code, Movement_List_Name, Active_Status, Created_By, Created_On)
VALUES 
(),();


--T M 12

INSERT INTO Mst_Vendor (Vendor_Code, Vendor_Name, Vendor_Address, Active_Status, Created_By, Created_On)
VALUES 
(),(),();

--T M 13

INSERT INTO Mst_Customer (Customer_Code, Customer_Name, Customer_Address, Active_Status, Created_By, Created_On)
VALUES 
(),(),();

--T T 1

INSERT INTO Trn_Document (Plant_ID, Movement_ID, Movement_Name, Status, Created_By, Created_On)
VALUES 
(),(),();


--T T 2

INSERT INTO Trn_309_Movement 
(Doc_ID, Plant_ID, Movement_ID, From_Mat_ID, From_Qty, From_SLoc_ID, From_Valuation_Type, From_Batch, From_Rate_Per_Unit, To_Mat_ID, To_Qty, 
To_SLoc_ID, To_Valuation_Type, To_Batch, To_Rate_Per_Unit, Remark, Approval_Status, SAP_Transaction_Status, Created_By, Created_On) 
VALUES
(),(),();


	
	--upload templete (inset,bulk)

	CREATE PROCEDURE UploadTrn309Movt
    @Data NVARCHAR(MAX),  -- JSON string input containing multiple records to insert
    @CreatedBy INT         -- The ID of the user creating the records
AS
BEGIN
    -- Declare temporary table to hold parsed data from JSON
    DECLARE @ParsedData AS TABLE (
        PlantCode NVARCHAR(50),
        FromMaterialCode NVARCHAR(50),
        FromQty INT,
        FromSLocCode NVARCHAR(50),
        FromValuationType NVARCHAR(50),
        FromBatch NVARCHAR(50),
        FromRatePerUnit DECIMAL(6, 2),
        ToMaterialCode NVARCHAR(50),
        ToQty INT,
        ToSLocCode NVARCHAR(50),
        ToValuationType NVARCHAR(50),
        ToBatch NVARCHAR(50),
        ToRatePerUnit DECIMAL(6, 2),
        Remark NVARCHAR(255)
    );

    -- Parse the JSON data and insert into the temporary table
    INSERT INTO @ParsedData (PlantCode, FromMaterialCode, FromQty, FromSLocCode, FromValuationType, FromBatch, FromRatePerUnit, 
                            ToMaterialCode, ToQty, ToSLocCode, ToValuationType, ToBatch, ToRatePerUnit, Remark)
    SELECT 
        PlantCode,
        FromMaterialCode,
        FromQty,
        FromSLocICode,
        FromValuationType,
        FromBatch,
        FromRatePerUnit,
        ToMaterialCode,
        ToQty,
        ToSLocCode,
        ToValuationType,
        ToBatch,
        ToRatePerUnit,
        Remark
    FROM OPENJSON(@Data)
    WITH (
        PlantCode NVARCHAR(50),
        FromMaterialCode NVARCHAR(50),
        FromQty INT,
        FromSLocCode NVARCHAR(50),
        FromValuationType NVARCHAR(50),
        FromBatch NVARCHAR(50),
        FromRatePerUnit DECIMAL(6, 2),
        ToMaterialCode NVARCHAR(50),
        ToQty INT,
        ToSLocCode NVARCHAR(50),
        ToValuationType NVARCHAR(50),
        ToBatch NVARCHAR(50),
        ToRatePerUnit DECIMAL(6, 2),
        Remark NVARCHAR(255)
    );

    -- Declare variables to hold Plant, Material  and Sloc IDs
    DECLARE @PlantID INT, @FromMatID INT, @ToMatID INT,  FromSLocID INT, ToSLocID INT;

    -- Cursor to loop through the parsed data
    DECLARE cur CURSOR FOR
    SELECT PlantCode, FromMaterialCode, FromQty, FromSLocCode, FromValuationType, FromBatch, FromRatePerUnit, 
           ToMaterialCode, ToQty, ToSLocCode, ToValuationType, ToBatch, ToRatePerUnit, Remark
    FROM @ParsedData;

    OPEN cur;

    -- Process each row from the cursor
    FETCH NEXT FROM cur INTO @PlantCode, @FromMaterialCode, @FromQty, @FromSLocCode, @FromValuationType, @FromBatch, @FromRatePerUnit, 
                            @ToMaterialCode, @ToQty, @ToSLocCode, @ToValuationType, @ToBatch, @ToRatePerUnit, @Remark;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Retrieve the corresponding Plant ID based on the Plant Code
        SELECT @PlantID = Plant_ID
        FROM Mst_Plant
        WHERE Plant_Code = @PlantCode;

        -- Retrieve the From Material ID based on the From Material Code
        SELECT @FromMatID = Material_ID
        FROM Mst_Material
        WHERE Material_Code = @FromMaterialCode;

        -- Retrieve the To Material ID based on the To Material Code
        SELECT @ToMatID = Material_ID
        FROM Mst_Material
        WHERE Material_Code = @ToMaterialCode;

		
		-- Retrieve the From Storage Location ID and Storage Code based on the From SLoc ID
		SELECT @FromSLocID = SLoc_ID
		FROM Mst_Storage_Location
		WHERE SLoc_ID = @FromSLocCode;

		-- Retrieve the To Storage Location ID and Storage Code based on the To SLoc ID
		SELECT @ToSLocID = SLoc_ID
		FROM Mst_Storage_Location
		WHERE SLoc_ID = @ToSLocCode;

        -- Insert the data into the Trn_309_Movement table
        INSERT INTO Trn_309_Movement 
        (Plant_ID, From_Mat_ID, From_Qty, 
        From_SLoc_ID, From_Valuation_Type, From_Batch, From_Rate_Per_Unit,
        To_Mat_ID, To_Qty, To_SLoc_ID, To_Valuation_Type, 
        To_Batch, To_Rate_Per_Unit, Remark,
        Created_By, Created_On)
        VALUES
        (@PlantID, @FromMatID, @FromQty, 
        @FromSLocID, @FromValuationType, @FromBatch, @FromRatePerUnit,
        @ToMatID, @ToQty, @ToSLocID, @ToValuationType, 
        @ToBatch, @ToRatePerUnit, @Remark, @CreatedBy, GETDATE());

        -- Fetch the next record from the cursor
        FETCH NEXT FROM cur INTO @PlantCode, @FromMaterialCode, @FromQty, @FromSLocCode, @FromValuationType, @FromBatch, @FromRatePerUnit, 
                                @ToMaterialCode, @ToQty, @ToSLocCode, @ToValuationType, @ToBatch, @ToRatePerUnit, @Remark;
        END

    -- Close and deallocate the cursor
    CLOSE cur;
    DEALLOCATE cur;

    -- Return success message
    SELECT 'Records successfully uploaded' AS Message;
    
    -- Optionally, you can return the data inserted or a summary of the data
    SELECT 
        P.Plant_Code, 
        M.Material_Code AS From_Material_Code, 
        T.From_Qty, 
        S.Storage_Code AS From_SLoc_Code, 
        T.From_Valuation_Type, 
        T.From_Batch,
        T.From_Rate_Per_Unit, 
        M2.Material_Code AS To_Material_Code, 
        T.To_Qty, 
        S2.Storage_Code AS To_SLoc_Code, 
        T.To_Valuation_Type, 
        T.To_Batch,
        T.To_Rate_Per_Unit,
        T.Remark,
        T.Created_On AS Date 
    FROM Trn_309_Movement T
    INNER JOIN Mst_Material M ON T.From_Mat_ID = M.Material_ID
    INNER JOIN Mst_Material M2 ON T.To_Mat_ID = M2.Material_ID
    INNER JOIN Mst_Storage_Location S ON T.From_SLoc_ID = S.SLoc_ID
    INNER JOIN Mst_Storage_Location S2 ON T.To_SLoc_ID = S2.SLoc_ID
    INNER JOIN Mst_Plant P ON T.Plant_ID = P.Plant_ID
    WHERE T.Created_By = @CreatedBy 
    ORDER BY T.Created_On DESC;
END;


-- T T 3

INSERT INTO Trn_202_Movement (Doc_ID, Plant_ID, Material_ID, Quantity, SLoc_ID, CostCenter_ID, Movement_ID, Valuation_Type, 
Batch, Rate_Unit, Remark, User_ID, Approval_Status, SAP_Transaction_Status, Created_By, Created_On)
VALUES 
(),(),();

--T T 4

INSERT INTO Trn_Appl_History (Doc_ID, Plant_ID, Movement_ID, Approver_ID, Appr_Comment, Appr_Status, Created_By, Created_On)
VALUES 
(),(),();
