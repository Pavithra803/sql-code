USE [Sap_Approval]
GO
/****** Object:  StoredProcedure [dbo].[GetExistingTrn309Movt]    Script Date: 15-04-2025 10:24:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetExistingTrn309Movt]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Trn_309_ID,
        P.Plant_Code,
        T.Doc_ID,
		
        -- Date formatting
        CONVERT(VARCHAR(10), T.Created_On, 103) AS Date,

        -- From side details
        M.Material_Code AS From_Material_Code,
        M.Description AS From_Description,
        T.From_Qty,
        S.Storage_Code AS From_SLoc_Code,
        T.From_Valuation_Type,
        T.From_Rate_Per_Unit,

        -- To side details
        M2.Material_Code AS To_Material_Code,
        M2.Description AS To_Description,
        T.To_Qty,
        S2.Storage_Code AS To_SLoc_Code,
        T.To_Valuation_Type,
        T.To_Rate_Per_Unit,

        -- Calculated Net Difference Price
        (T.To_Rate_Per_Unit - T.From_Rate_Per_Unit) AS Net_Difference_Price,

        -- Status and remarks
        T.Approval_Status,
        T.Remark,

		U.User_Name AS Created_By -- (user id comes to name)

    FROM Trn_309_Movement T
    INNER JOIN Mst_Material M ON T.From_Mat_ID = M.Material_ID
    INNER JOIN Mst_Material M2 ON T.To_Mat_ID = M2.Material_ID
    INNER JOIN Mst_Storage_Location S ON T.From_SLoc_ID = S.SLoc_ID
    INNER JOIN Mst_Storage_Location S2 ON T.To_SLoc_ID = S2.SLoc_ID
    INNER JOIN Mst_Plant P ON T.Plant_ID = P.Plant_ID
    LEFT JOIN Mst_Login_User U ON T.Created_By = U.Employee_ID 

    WHERE 
        CAST(T.Created_On AS DATE) BETWEEN CAST(@FromDate AS DATE) AND CAST(@ToDate AS DATE)
    ORDER BY T.Created_On DESC;
END;



DELETE FROM Trn_309_Movement
WHERE Trn_309_ID IN (11,12,13,14,15,16,17,18,19,20);

DELETE FROM Trn_309_Movement
WHERE Trn_309_ID IN (21);


DELETE FROM Trn_309_Movement
WHERE Trn_309_ID IN (25,26,27);

select * from Trn_309_Movement



DELETE FROM Trn_309_Movement
WHERE Trn_309_ID IN (11,13,15,16,17);
/*
DELETE FROM Trn_309_Movement
WHERE Trn_309_ID IN (25,26,27);

select * from Trn_309_Movement

UPDATE Trn_309_Movement
SET Doc_ID = 1,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 1;


UPDATE Trn_309_Movement
SET Doc_ID = 1,
    Movement_ID = '4',
		Approval_status='Pending',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=300
WHERE Trn_309_ID = 2;
---------------------------------

UPDATE Trn_309_Movement
SET Doc_ID = 2,
    Movement_ID = '4',
	Approval_status='Closed',
	From_Rate_Per_Unit=50,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 3;

UPDATE Trn_309_Movement
SET Doc_ID = 2,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=250
WHERE Trn_309_ID = 4;
-------------------------------------------------
UPDATE Trn_309_Movement
SET Doc_ID = 3,
    Movement_ID = '4',
	Approval_status='Sucess',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 5;

UPDATE Trn_309_Movement
SET Doc_ID = 3,
    Movement_ID = '4',
	Approval_status='Sucess',
	From_Rate_Per_Unit=10,
	To_Rate_Per_Unit=20
WHERE Trn_309_ID = 6;

UPDATE Trn_309_Movement
SET Doc_ID = 3,
    Movement_ID = '4',
	Approval_status='Pending',
	From_Rate_Per_Unit=200,
	To_Rate_Per_Unit=300
WHERE Trn_309_ID = 7;

UPDATE Trn_309_Movement
SET Doc_ID = 3,
    Movement_ID = '4',
	Approval_status='Close',
	From_Rate_Per_Unit=35,
	To_Rate_Per_Unit=80
WHERE Trn_309_ID = 8;

UPDATE Trn_309_Movement
SET Doc_ID = 3,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=500
WHERE Trn_309_ID = 9;
--------------------------------------------
UPDATE Trn_309_Movement
SET Doc_ID = 4,
    Movement_ID = '4',
	Approval_status='Pending',
	From_Rate_Per_Unit=150,
	To_Rate_Per_Unit=300
WHERE Trn_309_ID = 10;

UPDATE Trn_309_Movement
SET Doc_ID = 4,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=10,
	To_Rate_Per_Unit=20
WHERE Trn_309_ID = 12;

UPDATE Trn_309_Movement
SET Doc_ID = 4,
    Movement_ID = '4',
	Approval_status='Close',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 14;

----------------------------



UPDATE Trn_309_Movement
SET Doc_ID = 5,
    Movement_ID = '4',
	Approval_status='Sucess',
	From_Rate_Per_Unit=50,
	To_Rate_Per_Unit=270
WHERE Trn_309_ID = 18

UPDATE Trn_309_Movement
SET Doc_ID = 5,
    Movement_ID = '4',
	Approval_status='Open',
	From_Rate_Per_Unit=60,
	To_Rate_Per_Unit=200
WHERE Trn_309_ID = 19

UPDATE Trn_309_Movement
SET Doc_ID = 5,
    Movement_ID = '4',
	Approval_status='Close',
	From_Rate_Per_Unit=100,
	To_Rate_Per_Unit=150
WHERE Trn_309_ID = 20

  






*/
select * from Mst_Plant

select * from Mst_Login_User

select * from  Mst_Material_Type