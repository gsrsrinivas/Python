SELECT len(Trade_Type_Details),*
FROM Analyse_Stocks
WHERE Batch_No IN (SELECT DISTINCT TOP 1 batch_no
	FROM Analyse_Stocks ORDER BY batch_no DESC)
-- and LEN(Trade_Type_Details) > 10
ORDER BY Batch_No DESC, len(Trade_Type_Details) ASC
;
