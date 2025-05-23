﻿USE [Sap_Approval]
GO
/****** Object:  StoredProcedure [dbo].[GetTrn_309_Movement]   get detauls transtion/ 
	 Script Date: 10-04-2025 18:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetTrn_309_Movement]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Trn_309_ID,
        P.Plant_Code, 
		T.Doc_ID,
        
        -- From side details
        M.Material_Code AS From_Material_Code,
        M.Description AS From_Description,  
        T.From_Qty,
        S.Storage_Code AS From_SLoc_Code,  
        T.From_Valuation_Type,
        T.From_Batch,
        T.From_Rate_Per_Unit,
        
        -- To side details
        M2.Material_Code AS To_Material_Code,
        M2.Description AS To_Description, 
        T.To_Qty,
        S2.Storage_Code AS To_SLoc_Code,  
        T.To_Valuation_Type,
        T.To_Batch,
        T.To_Rate_Per_Unit,
        
        -- Calculated Net Difference Price
        (T.To_Rate_Per_Unit - T.From_Rate_Per_Unit) AS Net_Difference_Price,
        
        -- Statuses and remarks
        T.Approval_Status,
        T.Remark,
         
        T.Created_On AS Date  -- Add this if you have a column named 'Movement_Date' or similar
    FROM Trn_309_Movement T
    -- Joining with Mst_Material to get Material_Code and Description
    INNER JOIN Mst_Material M ON T.From_Mat_ID = M.Material_ID
    INNER JOIN Mst_Material M2 ON T.To_Mat_ID = M2.Material_ID
    
    -- Joining with Mst_Storage_Location to get Storage_Code
    INNER JOIN Mst_Storage_Location S ON T.From_SLoc_ID = S.SLoc_ID
    INNER JOIN Mst_Storage_Location S2 ON T.To_SLoc_ID = S2.SLoc_ID
    
    -- Joining with Mst_Plant to get Plant_Code
    INNER JOIN Mst_Plant P ON T.Plant_ID = P.Plant_ID;
END;
