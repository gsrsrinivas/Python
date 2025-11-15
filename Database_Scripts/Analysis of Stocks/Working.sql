SELECT LEN(Trade_Type_Details), *
FROM Analyse_15Minutes_Stocks
WHERE Batch_No IN (SELECT DISTINCT TOP 1 batch_no
	FROM Analyse_15Minutes_Stocks
ORDER BY batch_no DESC)
-- and LEN(Trade_Type_Details) > 10
ORDER BY Batch_No DESC, LEN(Trade_Type_Details) ASC
;

select DISTINCT indicator, timeline, direction 
from dbo.Cash_Stocks
where Batch_No = (select max(Batch_No) from dbo.Cash_Stocks)

SELECT STRING_AGG(CAST(QUOTENAME(REPLACE(indicator, ' ', '_') + '_' + REPLACE(timeline, ' ', '_') + '_' + REPLACE(direction, ' ', '_')) AS NVARCHAR(MAX)), ',') WITHIN GROUP (ORDER BY indicator)
  FROM (SELECT DISTINCT indicator, timeline, direction
		FROM dbo.Cash_Stocks
	   WHERE Batch_No ='20251115120737' ) AS temp
;
select * from dbo.Analyse_Stocks 
where Symbol = 'Reliance' 
and Batch_No = (select max(batch_no) from dbo.Analyse_Stocks)

SELECT *
FROM dbo.Cash_Stocks
WHERE Symbol like 'RELIABLE' and 
indicator like 'price%emi%'
AND Batch_No = (SELECT MAX(batch_no) FROM dbo.Analyse_Stocks)

;
select * from dbo.Cash_Stocks order by 1 desc
;


select  * from dbo.Cash_Stocks 
where Indicator like 'Price%EMI%' 
-- and TimeLine like '%Hour%'
order by 1 desc



