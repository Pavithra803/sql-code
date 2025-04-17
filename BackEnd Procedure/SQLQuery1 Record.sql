


CREATE PROCEDURE GetFilteredDataByDate
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Trn_309_Movement
    WHERE Created_On BETWEEN @FromDate AND @ToDate;
END;


EXEC GetFilteredDataByDate @FromDate = '2025-04-10', @ToDate = '2025-04-10';




CREATE PROCEDURE [dbo].[GetExistingTrn309Movt]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Movement_ID,
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
        Created_On,
        Modified_By,
        Modified_On
    FROM Trn_309_Movement
    WHERE CAST(Created_On AS DATE) BETWEEN CAST(@FromDate AS DATE) AND CAST(@ToDate AS DATE)
    ORDER BY Created_On DESC;
END;


EXEC [dbo].[GetExistingTrn309Movt]
    @FromDate = '2025-04-10',
    @ToDate = '2025-04-10';


EXEC GetExistingTrn309Movt