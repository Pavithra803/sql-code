USE [Sap_Approval]
GO
/****** Object:  StoredProcedure [dbo].[GetTrn_309_Movement_View]    Script Date: 16-04-2025 15:50:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetTrn_309_Movement_View]
    @Trn_309_ID INT  -- Adding an input parameter to fetch data for a specific Trn_309_ID (optional)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        -- Trn_309_ID to show the transaction ID
        T.Trn_309_ID AS Trn_309_ID,  -- Including Trn_309_ID in the result set
        
        -- Plant details: Show Plant_Code instead of Plant_ID
        P.Plant_Code AS Plant_Code,  -- Plant Code from Mst_Plant
        
        -- Creation date field comes right after Plant Code (as per request)
        T.Created_On AS Date,  -- Showing Created_On as Date
        
        -- From side details
        M.Material_Code AS From_Mat_Code,
        T.From_Description AS From_Description,
        T.From_Qty AS From_Qty,
        S.Storage_Code AS From_SLoc_Code,  -- From Storage Location Code
        T.From_Rate_Per_Unit AS From_Price,
        T.From_Valuation_Type AS From_Valuation_Type,
        T.From_Batch AS From_Batch,
        
        -- To side details
        M2.Material_Code AS To_Mat_Code,
        T.To_Description AS To_Description,
        T.To_Qty AS To_Qty,
        S2.Storage_Code AS To_SLoc_Code,
        T.To_Rate_Per_Unit AS To_Price,
        T.To_Valuation_Type AS To_Valuation_Type,
        T.To_Batch AS To_Batch,
        
        -- Calculated Net Difference Price
        (T.To_Rate_Per_Unit - T.From_Rate_Per_Unit) AS Net_Difference_Price,
        
        -- Statuses and remarks
        T.Approval_Status AS Approval_Status,
        T.Remark AS Remark
        
    FROM Trn_309_Movement T
    -- Joining with Mst_Material to get Material_Code for From_Mat_ID and To_Mat_ID
    INNER JOIN Mst_Material M ON T.From_Mat_ID = M.Material_ID
    INNER JOIN Mst_Material M2 ON T.To_Mat_ID = M2.Material_ID
    
    -- Joining with Mst_Storage_Location to get Storage_Code for From and To locations
    INNER JOIN Mst_Storage_Location S ON T.From_SLoc_ID = S.SLoc_ID  -- From side Storage Location
    INNER JOIN Mst_Storage_Location S2 ON T.To_SLoc_ID = S2.SLoc_ID  -- To side Storage Location
    
    -- Joining with Mst_Plant to get Plant_Code
    INNER JOIN Mst_Plant P ON T.Plant_ID = P.Plant_ID
    
    -- Filter by Trn_309_ID if provided
    WHERE (@Trn_309_ID IS NULL OR T.Trn_309_ID = @Trn_309_ID);
END;