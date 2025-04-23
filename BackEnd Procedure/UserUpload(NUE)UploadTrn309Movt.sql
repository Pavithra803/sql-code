-----------------23/04 ✅ -----------------
✅

USE [Sap_Approval]
GO
/****** Object:  StoredProcedure [dbo].[UploadTrn309Movt]    Script Date: 23-04-2025 08:16:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UploadTrn309Movt]
@Created_By INT
AS
BEGIN

    -- Step 1: Validate Input Data
    SELECT t.*,
        CASE WHEN t.Plant_Code IN (SELECT Plant_Code FROM Mst_Plant WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS Plant_val,
        CASE WHEN t.From_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS From_Mat,
        CASE WHEN t.To_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS To_Mat,
        CASE WHEN t.From_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS From_SLoc,
        CASE WHEN t.To_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS To_SLoc
    INTO #t1
    FROM #transation AS t;

    -- Step 2: Map Valid Data to IDs
    SELECT 
        p.Plant_ID,
        m1.Material_ID AS From_Material_Code,
        t.From_Qty,
        s1.SLoc_ID AS From_Storage_Code,
        t.From_Valuation_Type,
        t.From_Batch,
        CAST(t.From_Rate_Per_Unit AS DECIMAL(18,2)) AS From_Rate_Per_Unit,
        m2.Material_ID AS To_Material_Code,
        t.To_Qty,
        s2.SLoc_ID AS To_Storage_Code,
        t.To_Valuation_Type,
        t.To_Batch,
        CAST(t.To_Rate_Per_Unit AS DECIMAL(18,2)) AS To_Rate_Per_Unit,
        --CAST(t.To_Rate_Per_Unit AS DECIMAL(18,2)) - CAST(t.From_Rate_Per_Unit AS DECIMAL(18,2)) AS Net_Difference_Price,
		(CAST(t.To_Rate_Per_Unit AS DECIMAL(10,2)) - CAST(t.From_Rate_Per_Unit AS DECIMAL(10,2))) AS Net_Difference_Price,
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
        AND t.To_SLoc = 'Valid';


		-- dup
		    SELECT  
        p.Plant_Code,
        m1.Material_Code AS From_Material_Code,
        t2.From_Qty,
        s1.Storage_Code AS From_Storage_Code,
        t2.From_Valuation_Type,
        t2.From_Batch,
        t2.From_Rate_Per_Unit,
        m2.Material_Code AS To_Material_Code,
        t2.To_Qty,
        s2.Storage_Code AS To_Storage_Code,
        t2.To_Valuation_Type,
        t2.To_Batch,
        t2.To_Rate_Per_Unit,
        t2.Remark,
        'Duplicates_Records' AS Status
		into #dup
    FROM #t2 t2
    INNER JOIN Mst_Plant p ON t2.Plant_ID = p.Plant_ID
    INNER JOIN Mst_Material m1 ON m1.Material_ID = t2.From_Material_Code
    INNER JOIN Mst_Material m2 ON m2.Material_ID = t2.To_Material_Code
    INNER JOIN Mst_Storage_Location s1 ON s1.SLoc_ID = t2.From_Storage_Code
    INNER JOIN Mst_Storage_Location s2 ON s2.SLoc_ID = t2.To_Storage_Code
    WHERE EXISTS (
        SELECT 1 
        FROM Trn_309_Movement m
        WHERE m.Plant_ID = t2.Plant_ID
            AND m.From_Mat_ID = t2.From_Material_Code
			AND m.From_Qty = t2.From_Qty
            --AND m.To_Mat_ID = t2.To_Material_Code
            --AND m.From_SLoc_ID = t2.From_Storage_Code
            --AND m.To_SLoc_ID = t2.To_Storage_Code
            AND CAST(m.Created_On AS DATE) = CAST(GETDATE() AS DATE)
			 );

			 --new

			     SELECT  
        p.Plant_Code,
        m1.Material_Code AS From_Material_Code,
        t2.From_Qty,
        s1.Storage_Code AS From_Storage_Code,
        t2.From_Valuation_Type,
        t2.From_Batch,
        t2.From_Rate_Per_Unit,
        m2.Material_Code AS To_Material_Code,
        t2.To_Qty,
        s2.Storage_Code AS To_Storage_Code,
        t2.To_Valuation_Type,
        t2.To_Batch,
        t2.To_Rate_Per_Unit,
        t2.Remark,
        'New_Records' AS Status

		into #new
    FROM #t2 t2
    INNER JOIN Mst_Plant p ON t2.Plant_ID = p.Plant_ID
    INNER JOIN Mst_Material m1 ON m1.Material_ID = t2.From_Material_Code
    INNER JOIN Mst_Material m2 ON m2.Material_ID = t2.To_Material_Code
    INNER JOIN Mst_Storage_Location s1 ON s1.SLoc_ID = t2.From_Storage_Code
    INNER JOIN Mst_Storage_Location s2 ON s2.SLoc_ID = t2.To_Storage_Code
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Trn_309_Movement m
        WHERE m.Plant_ID = t2.Plant_ID
            AND m.From_Mat_ID = t2.From_Material_Code
            AND m.To_Mat_ID = t2.To_Material_Code
            AND m.From_SLoc_ID = t2.From_Storage_Code
            AND m.To_SLoc_ID = t2.To_Storage_Code
            AND CAST(m.Created_On AS DATE) = CAST(GETDATE() AS DATE)
    );

    -- Step 3: Insert New Records (Skip Duplicates Created Today)
    WITH CTE_NEW AS (
        SELECT * FROM #t2
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
        Plant_ID,
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
        Remark,
        @Created_By,
        GETDATE()
    FROM CTE_NEW
    WHERE NOT EXISTS (
        SELECT 1
        FROM Trn_309_Movement t
        WHERE t.From_Mat_ID = CTE_NEW.From_Material_Code
            AND t.To_Mat_ID = CTE_NEW.To_Material_Code
            AND t.To_SLoc_ID = CTE_NEW.To_Storage_Code
            AND t.From_SLoc_ID = CTE_NEW.From_Storage_Code
            AND t.Plant_ID = CTE_NEW.Plant_ID
            AND CAST(t.Created_On AS DATE) = CAST(GETDATE() AS DATE)
    );

    -- Step 4: Output Error Records
    SELECT  
        t.Plant_Code,
        t.From_Material_Code,
        t.From_Qty,
        t.From_Storage_Code,
        t.From_Valuation_Type,
        t.From_Batch,
        t.From_Rate_Per_Unit,
        t.To_Material_Code,
        t.To_Qty,
        t.To_Storage_Code,
        t.To_Valuation_Type,
        t.To_Batch,
        t.To_Rate_Per_Unit,
        t.Remark,
        t.Plant_val,
        t.From_Mat,
        t.To_Mat,
        t.From_SLoc,
        t.To_SLoc,
        'Error_Records' AS Status
    FROM #t1 AS t
    WHERE t.Plant_val = 'Invalid'
        OR t.From_Mat = 'Invalid'
        OR t.To_Mat = 'Invalid'
        OR t.From_SLoc = 'Invalid'
        OR t.To_SLoc = 'Invalid';

    -- Step 5: Output New Records (Valid and Not Created Today)
	select * from #new

    -- Step 6: Output Duplicate Records (Same Key Exists Today)

	select * from #dup

   DROP TABLE IF EXISTS #t2,#t1,#transation,#new,#dup;
END;






-------------------------------------------------------------22/04
USE [Sap_Approval]
GO
/****** Object:  StoredProcedure [dbo].[UploadTrn309Movt]    Script Date: 17-04-2025 16:09:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UploadTrn309Movt]
@Created_By INT
AS	BEGIN

/*
-- Create the temporary table
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

-- Insert records
INSERT INTO #transation VALUES
('1150', '1000', '2', '1300', 'INHOUSE', '1', '90', '1300', '1', '1300', 'INHOUSE', '1', '100', 'test'),
('1210', '1300', '10', '1000', 'SUBCONTRACT', 'FB13', '100', '1500', '15', '1150', 'SUBCONTRACT', 'TB13', '200', 'test'),
('1200', 'MAT005', '30', '1150', 'DOMESTIC', 'FB14', '200', 'MAT004', '20', '1300', 'DOMESTIC', 'TB14', '300', 'test');




*/

-- Create a temp table to validate and map the data
SELECT t.*,
   CASE WHEN t.Plant_Code IN (SELECT Plant_Code FROM Mst_Plant WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'Plant_val',
   CASE WHEN t.From_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_Mat',
   CASE WHEN t.To_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_Mat',
   CASE WHEN t.From_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_SLoc',
   CASE WHEN t.To_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_SLoc'

INTO #t1
FROM #transation AS t;


--select * from #t1


-- Create another temporary table to map the relevant data
SELECT 
  p.Plant_ID,
  m1.Material_ID AS From_Material_Code,
  t.From_Qty,
  s1.SLoc_ID AS From_Storage_Code ,
  t.From_Valuation_Type,
  t.From_Batch,
  CAST(t.From_Rate_Per_Unit AS DECIMAL(18,2)) AS From_Rate_Per_Unit,
  m2.Material_ID AS To_Material_Code,
  t.To_Qty,
  s2.SLoc_ID AS To_Storage_Code,
  t.To_Valuation_Type,
  t.To_Batch,
  CAST(t.To_Rate_Per_Unit AS DECIMAL(18,2)) AS To_Rate_Per_Unit,
  CAST(t.To_Rate_Per_Unit AS DECIMAL(18,2)) - CAST(t.From_Rate_Per_Unit AS DECIMAL(18,2)) AS Net_Difference_Price,
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

--select * from #t2

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
	INNER JOIN Trn_309_Movement  target
    ON source.From_Material_Code = target.From_Mat_ID
    AND source.To_Material_Code = target.To_Mat_ID
	AND source.From_Storage_Code = target.From_SLoc_ID
	AND source.To_Storage_Code = target.To_SLoc_ID
    AND source.Plant_ID = target.Plant_ID
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
    Modified_By =1
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
    1,
    GETDATE()
FROM CTE_NEW AS source
WHERE NOT EXISTS (
    SELECT 1
    FROM Trn_309_Movement t
    WHERE t.From_Mat_ID= source.From_Material_Code
    AND t.To_Mat_ID = source.To_Material_Code
	AND t.To_SLoc_ID = source.To_Storage_Code
	AND t.From_SLoc_ID = source.From_Storage_Code
    AND t.Plant_ID = source.Plant_ID
);

-- Data for Invalid entries


--SELECT t.*,
--   CASE WHEN t.Plant_Code IN (SELECT Plant_Code FROM Mst_Plant WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'Plant_val',
--   CASE WHEN t.From_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_Mat',
--   CASE WHEN t.To_Material_Code IN (SELECT Material_Code FROM Mst_Material WHERE Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_Mat',
--   CASE WHEN t.From_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'From_SLoc',
--   CASE WHEN t.To_Storage_Code IN (SELECT Storage_Code FROM Mst_Storage_Location WHERE  Active_Status = 1) THEN 'Valid' ELSE 'Invalid' END AS 'To_SLoc'

--FROM #t1 AS t
--WHERE t.Plant_val = 'Invalid'
--    OR t.From_Mat = 'Invalid'
--    OR t.To_Mat = 'Invalid'
--	OR t.From_SLoc = 'InValid'
--   OR t.To_SLoc = 'InValid';


	
-- 1. New Records
SELECT  
    p.Plant_Code,
    m1.Material_Code AS From_Material_Code,
    t2.From_Qty,
    s1.Storage_Code AS From_Storage_Code,
    t2.From_Valuation_Type,
    t2.From_Batch,
    t2.From_Rate_Per_Unit,
    m2.Material_Code AS To_Material_Code,
    t2.To_Qty,
    s2.Storage_Code AS To_Storage_Code,
    t2.To_Valuation_Type,
    t2.To_Batch,
    t2.To_Rate_Per_Unit,
    t2.Remark,
    'New_Records' AS Status
	
FROM #t2 t2
INNER JOIN Mst_Plant p ON t2.Plant_ID = p.Plant_ID
INNER JOIN Mst_Material m1 ON m1.Material_ID = t2.From_Material_Code
INNER JOIN Mst_Material m2 ON m2.Material_ID = t2.To_Material_Code
INNER JOIN Mst_Storage_Location s1 ON s1.SLoc_ID = t2.From_Storage_Code
INNER JOIN Mst_Storage_Location s2 ON s2.SLoc_ID = t2.To_Storage_Code
WHERE NOT EXISTS (
    SELECT 1 
    FROM Trn_309_Movement m
    WHERE m.Plant_ID = t2.Plant_ID
    AND m.From_Mat_ID = t2.From_Material_Code
    AND m.To_Mat_ID = t2.To_Material_Code
    AND m.From_SLoc_ID = t2.From_Storage_Code
    AND m.To_SLoc_ID = t2.To_Storage_Code
);



-- 2. Error Records
SELECT  
    t.Plant_Code,
    t.From_Material_Code,
    t.From_Qty,
    t.From_Storage_Code,
    t.From_Valuation_Type,
    t.From_Batch,
    t.From_Rate_Per_Unit,
    t.To_Material_Code,
    t.To_Qty,
    t.To_Storage_Code,
    t.To_Valuation_Type,
    t.To_Batch,
    t.To_Rate_Per_Unit,
    t.Remark,
    t.Plant_val,
    t.From_Mat,
    t.To_Mat,
    t.From_SLoc,
    t.To_SLoc,
    'Error_Records' AS Status
FROM #t1 AS t
WHERE t.Plant_val = 'Invalid'
    OR t.From_Mat = 'Invalid'
    OR t.To_Mat = 'Invalid'
    OR t.From_SLoc = 'Invalid'
    OR t.To_SLoc = 'Invalid';


-- 3. Updated Records
SELECT  
    t2.Plant_ID,
    p.Plant_Code,
    m1.Material_Code AS From_Material_Code,
    t2.From_Qty,
    s1.Storage_Code AS From_Storage_Code,
    t2.From_Valuation_Type,
    t2.From_Batch,
    t2.From_Rate_Per_Unit,
    m2.Material_Code AS To_Material_Code,
    t2.To_Qty,
    s2.Storage_Code AS To_Storage_Code,
    t2.To_Valuation_Type,
    t2.To_Batch,
    t2.To_Rate_Per_Unit,
    t2.Remark,
    'Updated_Records' AS Status
FROM #t2 t2
INNER JOIN Mst_Plant p ON t2.Plant_ID = p.Plant_ID
INNER JOIN Mst_Material m1 ON m1.Material_ID = t2.From_Material_Code
INNER JOIN Mst_Material m2 ON m2.Material_ID = t2.To_Material_Code
INNER JOIN Mst_Storage_Location s1 ON s1.SLoc_ID = t2.From_Storage_Code
INNER JOIN Mst_Storage_Location s2 ON s2.SLoc_ID = t2.To_Storage_Code
WHERE EXISTS (
    SELECT 1 FROM Trn_309_Movement m
    WHERE m.From_Mat_ID = t2.From_Material_Code
    AND m.To_Mat_ID = t2.To_Material_Code
    AND m.From_SLoc_ID = t2.From_Storage_Code
    AND m.To_SLoc_ID = t2.To_Storage_Code
    AND m.Plant_ID = t2.Plant_ID
);




--select * from Trn_309_Movement
