--create procedure sqlquery2 as begin
--SET NOCOUNT ON
 
/*
SELECT * FROM [dbo].[temp_sheet1];

insert INTO dbo.TradeBook ( Symbol, ISIN, [Trade Date], Exchange, Segment, Series, [Trade Type], Auction, Quantity, Price, [Trade ID], [Order ID], [Order Execution Time] )
SELECT * FROM [dbo].[temp_sheet1];

UPDATE dbo.TradeBook SET Auction = 1 WHERE Account is NULL;

UPDATE dbo.TradeBook SET [Order Execution Time] = REPLACE([Order Execution Time],'T',' ') WHERE account is NULL;

UPDATE TB SET [Order Execution Time] = replace(cast([Order Execution Time] AS varchar)+'.0000000','T',' ')
FROM dbo.TradeBook tb WHERE cast(tb.[Order Execution Time] AS varchar) LIKE '%T%'
;

WITH cte AS ( 
SELECT ROW_NUMBER() over(PARTITION BY tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]
 ORDER BY tb.account desc, tb.period desc,tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]) AS rn
 ,*
FROM dbo.TradeBook tb
) 
-- delete FROM cte WHERE rn = 2
SELECT * FROM cte WHERE rn = 1
ORDER BY cast([Order Execution Time] AS DATETIME2)
;
SELECT CASE 
WHEN [Order Execution Time] >= '2020-04-01' AND [Order Execution Time] <= '2021-04-01' THEN '2020-04-01 to 2021-03-31'
WHEN [Order Execution Time] >= '2021-04-01' AND [Order Execution Time] <= '2022-04-01' THEN '2021-04-01 to 2022-03-31'
WHEN [Order Execution Time] >= '2022-04-01' AND [Order Execution Time] <= '2023-04-01' THEN '2022-04-01 to 2023-03-31'
WHEN [Order Execution Time] >= '2023-04-01' AND [Order Execution Time] <= '2024-04-01' THEN '2023-04-01 to 2024-03-31'
WHEN [Order Execution Time] >= '2024-04-01' AND [Order Execution Time] <= '2025-04-01' THEN '2024-04-01 to 2025-03-31'
WHEN [Order Execution Time] >= '2025-04-01' AND [Order Execution Time] <= '2026-04-01' THEN '2025-04-01 to 2026-03-31'
END AS period,[Order Execution Time],* 
FROM dbo.TradeBook
;

UPDATE dbo.TradeBook
SET PERIOD = CASE 
WHEN [Order Execution Time] >= '2020-04-01' AND [Order Execution Time] <= '2021-04-01' THEN '2020-04-01 to 2021-03-31'
WHEN [Order Execution Time] >= '2021-04-01' AND [Order Execution Time] <= '2022-04-01' THEN '2021-04-01 to 2022-03-31'
WHEN [Order Execution Time] >= '2022-04-01' AND [Order Execution Time] <= '2023-04-01' THEN '2022-04-01 to 2023-03-31'
WHEN [Order Execution Time] >= '2023-04-01' AND [Order Execution Time] <= '2024-04-01' THEN '2023-04-01 to 2024-03-31'
WHEN [Order Execution Time] >= '2024-04-01' AND [Order Execution Time] <= '2025-04-01' THEN '2024-04-01 to 2025-03-31'
WHEN [Order Execution Time] >= '2025-04-01' AND [Order Execution Time] <= '2026-04-01' THEN '2025-04-01 to 2026-03-31'
END
WHERE period is NULL
;
UPDATE dbo.TradeBook SET Account = 'LD3666' WHERE account is NULL
;
UPDATE _ts.Shares SET Auction = 0 WHERE Auction is NULL
;
alter TABLE _TS.Shares ALTER COLUMN [Auction] int
;

WITH cte AS ( 
SELECT ROW_NUMBER() over(PARTITION BY tb.account,tb.period,tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]
 ORDER BY tb.account desc, tb.period desc,tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]) AS rn
 ,*
FROM _ts.Shares tb WHERE account <> 'MA4342'
) 
-- delete FROM cte WHERE rn = 2 AND sno IS null
SELECT * FROM cte WHERE rn = 2 AND sno IS null
ORDER BY cast([Order Execution Time] AS DATETIME2)
;
SELECT CASE 
WHEN [Order Execution Time] >= '2020-04-01' AND [Order Execution Time] <= '2021-04-01' THEN '2020-04-01 to 2021-03-31'
WHEN [Order Execution Time] >= '2021-04-01' AND [Order Execution Time] <= '2022-04-01' THEN '2021-04-01 to 2022-03-31'
WHEN [Order Execution Time] >= '2022-04-01' AND [Order Execution Time] <= '2023-04-01' THEN '2022-04-01 to 2023-03-31'
WHEN [Order Execution Time] >= '2023-04-01' AND [Order Execution Time] <= '2024-04-01' THEN '2023-04-01 to 2024-03-31'
WHEN [Order Execution Time] >= '2024-04-01' AND [Order Execution Time] <= '2025-04-01' THEN '2024-04-01 to 2025-03-31'
WHEN [Order Execution Time] >= '2025-04-01' AND [Order Execution Time] <= '2026-04-01' THEN '2025-04-01 to 2026-03-31'
END AS period,[Order Execution Time],* 
FROM _ts.Shares
;

UPDATE _ts.Shares
SET PERIOD = CASE 
WHEN [Order Execution Time] >= '2020-04-01' AND [Order Execution Time] <= '2021-04-01' THEN '2020-04-01 to 2021-03-31'
WHEN [Order Execution Time] >= '2021-04-01' AND [Order Execution Time] <= '2022-04-01' THEN '2021-04-01 to 2022-03-31'
WHEN [Order Execution Time] >= '2022-04-01' AND [Order Execution Time] <= '2023-04-01' THEN '2022-04-01 to 2023-03-31'
WHEN [Order Execution Time] >= '2023-04-01' AND [Order Execution Time] <= '2024-04-01' THEN '2023-04-01 to 2024-03-31'
WHEN [Order Execution Time] >= '2024-04-01' AND [Order Execution Time] <= '2025-04-01' THEN '2024-04-01 to 2025-03-31'
WHEN [Order Execution Time] >= '2025-04-01' AND [Order Execution Time] <= '2026-04-01' THEN '2025-04-01 to 2026-03-31'
END
;
-- SELECT DISTINCT account FROM _ts.Shares s;
WITH cte AS ( 
SELECT ROW_NUMBER() over(PARTITION BY tb.account,tb.period,tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]
ORDER BY tb.account desc, tb.period desc,tb.Symbol,tb.ISIN,tb.[Trade Date],tb.Exchange,tb.Segment,tb.Series,tb.[Trade Type],tb.Quantity,tb.Price,tb.[Trade ID],tb.[Order ID],tb.[Order Execution Time]) AS rn
 ,*
FROM _ts.Shares tb WHERE account NOT IN ('MA4342','XLH244')
) 
--delete FROM cte WHERE rn > 1 AND sno IS null
SELECT * FROM cte WHERE rn > 1 -- AND sno IS null
ORDER BY cast([Order Execution Time] AS DATETIME2)
;
SELECT count(1),CASE WHEN s.Sno is NULL THEN 1 ELSE 0 end FROM _ts.Shares s
group BY CASE WHEN s.Sno is NULL THEN 1 ELSE 0 end
*/
--end;
