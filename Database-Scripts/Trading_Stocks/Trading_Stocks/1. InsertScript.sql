--create procedure InsertScript as 
--begin
--SET NOCOUNT ON
/* InsertScript Instructions
---------------------------------------------------------------------------
Insert the trade order book with import tool and check
excel sheet imported as new table (tradebook) into database.
---------- instruction before running the script ----------
change the below field in select statement 
account, order_execution_time
check the new table (TradeBook) fields are matching with [Shares] table or not 
and period and account fields are fill in the new table or not
check the min record based on order_execution_time in new table and 
select the records >= min(order execution time) from new table (trade book)
---------------------------------------------------------------------------
-- checking existing table, how many records are there and in new table 
select * from _ts.Shares 
where Account = 'LD3666' and [Order Execution Time] >= '2023-04-01' 
Order by Account,[Order Execution Time] desc
;
select * from dbo.TradeBook order by [Order Execution Time] desc
;
select distinct account from _ts.Shares
/*MA4342 - 2023-12-08 00:00:00.000 -deactive
XLH244 - 2022-09-08 00:00:00.000 - deactive
LD3666 - 2024-03-28 00:00:00.000 -- active
*/

*/
BEGIN TRAN t1
;
-- DELETE from _ts.Shares where Account = 'LD3666' and [Order Execution Time] >= '2023-04-01';

INSERT INTO _ts.Shares([Symbol], [Order Execution Time], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Sno], [Period], [Account], [Trade Value], [Comments])
SELECT [Symbol], CAST([Order Execution Time] AS DATETIME2), [ISIN], CAST([Trade Date] AS DATETIME2), [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], NULL AS sno, [Period], [Account], NULL AS TradeValue, NULL AS cmts
FROM dbo.TradeBook
;
DECLARE @var INT = 0
;
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY Account ORDER BY Account, [Order Execution Time]) AS rn
	FROM _ts.Shares)
UPDATE CTE
SET sno = rn -- sno = @var, @var = @var + 1 -- , @var = sno = @var + 1
;
SELECT [Sno], [Period], [Account], [Symbol], [Order Execution Time], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Trade Value], [Comments]
FROM _ts.Shares a
WHERE Account = 'LD3666' AND [Order Execution Time] >= '2023-04-01'
ORDER BY sno ASC;
COMMIT TRAN t1
;
select * from _ts.Shares where Account = 'LD3666'
order by [trade date] DESC

--END;

