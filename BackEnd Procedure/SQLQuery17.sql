
			-- Create the temp table trn 309 movt

CREATE TABLE #transation (
    Plant_Code VARCHAR(100) NOT NULL,
    From_Material_Code VARCHAR(100) NOT NULL,
    From_Qty VARCHAR(100) NOT NULL,
    From_Storage_Code VARCHAR(100) NOT NULL,
    From_Valuation_Type VARCHAR(100) NOT NULL,
    From_Batch VARCHAR(100) NOT NULL,
    From_Rate_Per_Unit VARCHAR(100) NOT NULL,
    To_Material_Code VARCHAR(100) NOT NULL,
    To_Qty VARCHAR(100) NOT NULL,
    To_Storage_Code VARCHAR(100) NOT NULL,
    To_Valuation_Type VARCHAR(100) NOT NULL,
    To_Batch VARCHAR(100) NOT NULL,
    To_Rate_Per_Unit VARCHAR(100) NOT NULL,
    Remark VARCHAR(100) NOT NULL
);

-- Insert data into the table
INSERT INTO #transation (
    Plant_Code,
    From_Material_Code,
    From_Qty,
    From_Storage_Code,
    From_Valuation_Type,
    From_Batch,
    From_Rate_Per_Unit,
    To_Material_Code,
    To_Qty,
    To_Storage_Code,
    To_Valuation_Type,
    To_Batch,
    To_Rate_Per_Unit,
    Remark
)
VALUES
    ('1200', 'MAT001', '50', '1000', '1000', '1', '160', 'MAT004', '100', 'SUBCONTRACT', '1000', '4', '160', 'test'),
    ('1300', 'MAT002', '40', '1200', '1200', '2', '140', 'MAT005', '80', 'DOMESTIC', '1200', '5', '140', 'test'),
    ('1150', 'MAT003', '60', '1000', '1300', '3', '150', 'MAT006', '120', 'INHOUSE', '1300', '6', '150', 'test');

-- Create a temp table to validate and map the data
SELECT t.*,
   CASE WHEN t.Plant_Code IN (SELECT Plant_Code FROM Mst_Plant WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'Plant_val',
   CASE WHEN t.From_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_Mat',
   CASE WHEN t.To_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_Mat'
   --CASE WHEN t.From_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_SLoc',
   --CASE WHEN t.To_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_SLoc'

--INTO #t1
FROM #transation AS t;

select * from Mst_Storage_Location

-- Create another temporary table to map the relevant data
SELECT 
  p.Plant_ID,
  m1.Material_ID AS From_Material_Code,
  t.From_Qty,
  s1.Storage_Code AS From_Storage_Code ,
  t.From_Valuation_Type,
  t.From_Batch,
  t.From_Rate_Per_Unit,
  m2.Material_ID AS To_Material_Code,
  t.To_Qty,
  s2.Storage_Code AS To_Storage_Code,
  t.To_Valuation_Type,
  t.To_Batch,
  t.To_Rate_Per_Unit,
  t.Remark
INTO #t2
FROM #t1 AS t
INNER JOIN Mst_Plant AS p ON p.Plant_Code = t.Plant_Code
INNER JOIN Mst_Material AS m1 ON m1.Material_Code = t.From_Material_Code
INNER JOIN Mst_Material AS m2 ON m2.Material_Code = t.To_Material_Code
INNER JOIN Mst_Storage_Location AS s1 ON s1.Storage_Code = t.From_Storage_Code
INNER JOIN Mst_Storage_Location AS s2 ON s2.Storage_Code = t.To_Storage_Code
WHERE t.Plant_val = 'Valid' 
AND t.From_Mat = 'Valid'
AND t.To_Mat = 'Valid'
AND t.From_SLoc = 'Valid'
AND t.To_SLoc = 'Valid'
;


-- UPDATING EXISTING DATA ON TRN 309 MOVT TABLE
WITH CTE_Existing AS (
    SELECT 
        source.Plant_ID,
        source.From_Material_Code,
        source.From_Qty,
        source.From_Storage_Code,
        source.From_Valuation_Type,
        source.From_Batch,
        source.From_Rate_Per_Unit,
        source.To_Material_Code,
        source.To_Qty,
        source.To_Storage_Code,
        source.To_Valuation_Type,
        source.To_Batch,
        source.To_Rate_Per_Unit,
        source.Remark
    FROM #t2 AS source
)
UPDATE Trn_309_Movement SET
    From_Qty = source.From_Qty,
    From_Valuation_Type = source.From_Valuation_Type,
    From_Batch = source.From_Batch,
    From_Rate_Per_Unit = source.From_Rate_Per_Unit,
    To_Qty = source.To_Qty,
    To_Valuation_Type = source.To_Valuation_Type,
    To_Batch = source.To_Batch,
    To_Rate_Per_Unit = source.To_Rate_Per_Unit,
    Remark = source.Remark,
    Modified_On = GETDATE(),
    Modified_By = 1
FROM Trn_309_Movement AS target
JOIN CTE_Existing AS source
    ON source.From_Material_Code = target.From_Mat_ID
    AND source.To_Material_Code = target.To_Mat_ID
	AND source.From_Storage_Code = target.From_SLoc_ID
	AND source.To_Storage_Code = target.To_SLoc_ID
    AND source.Plant_ID = target.Plant_ID;

-- INSERTING NEW DATA INTO TRN 309 MOVT TABLE
WITH CTE_NEW AS (
    SELECT
        source.Plant_ID,
        source.From_Material_Code,
        source.From_Qty,
        source.From_Storage_Code,
        source.From_Valuation_Type,
        source.From_Batch,
        source.From_Rate_Per_Unit,
        source.To_Material_Code,
        source.To_Qty,
        source.To_Storage_Code,
        source.To_Valuation_Type,
        source.To_Batch,
        source.To_Rate_Per_Unit,
        source.Remark
    FROM #t2 AS source
)
INSERT INTO Trn_309_Movement (
    Plant_ID,
    From_Mat_ID,
    From_Qty,
    From_SLoc_ID,
    From_Valuation_Type,
    From_Batch,
    From_Rate_Per_Unit,
    To_Mat_ID,
    To_Qty,
    To_SLoc_ID,
    To_Valuation_Type,
    To_Batch,
    To_Rate_Per_Unit,
    Remark,
    Created_By,
    Created_On
)
SELECT 
    source.Plant_ID,
    source.From_Material_Code,
    source.From_Qty,
    source.From_Storage_Code,
    source.From_Valuation_Type,
    source.From_Batch,
    source.From_Rate_Per_Unit,
    source.To_Material_Code,
    source.To_Qty,
    source.To_Storage_Code,
    source.To_Valuation_Type,
    source.To_Batch,
    source.To_Rate_Per_Unit,
    source.Remark,
    @Created_By,
    GETDATE()
FROM CTE_NEW AS source
WHERE NOT EXISTS (
    SELECT 1
    FROM Trn_309_Movement t
    WHERE t.From_Mat_ID= source.From_Material_Code
    AND t.To_Mat_ID = source.To_Material_Code
	AND t.To_SLoc_ID = source.To_Storage_Code
	AND t.From_Mat_ID = source.From_Storage_Code
    AND t.Plant_ID = source.Plant_ID
);

-- Data for Invalid entries
SELECT 
  p.Plant_ID,
  m1.Material_ID AS From_Material_Code,
  t.From_Qty,
  s1.Storage_Code AS From_Storage_Code ,
  t.From_Valuation_Type,
  t.From_Batch,
  t.From_Rate_Per_Unit,
  m2.Material_ID AS To_Material_Code,
  t.To_Qty,
  s2.Storage_Code AS To_Storage_Code,
  t.To_Valuation_Type,
  t.To_Batch,
  t.To_Rate_Per_Unit,
  t.Remark

 

FROM #t AS t
INNER JOIN Mst_Plant AS p ON p.Plant_Code = t.Plant_Code
INNER JOIN Mst_Material AS m1 ON m1.Material_Code = t.From_Material_Code
INNER JOIN Mst_Material AS m2 ON m2.Material_Code = t.To_Material_Code
INNER JOIN Mst_Storage_Location AS s1 ON s1.Storage_Code = t.From_Storage_Code 
INNER JOIN Mst_Storage_Location AS s2 ON s2.Storage_Code = t.To_Storage_Code
WHERE t.Plant_val = 'Invalid'
    AND t.From_Mat = 'Invalid'
    AND t.To_Mat = 'Invalid'
	AND t.From_SLoc = 'InValid'
   AND t.To_SLoc = 'InValid';

-- Cleanup temporary tables
DROP TABLE IF EXISTS #t, #t1, #t2, #transation;



select * from Mst_Storage_Location


select * from Mst_Material

select * from Trn_309_Movement

   DROP TABLE #t1;