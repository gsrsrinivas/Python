--CREATE PROCEDURE AllQueries as 
--Begin
--set nocount on
/* Queries backup */
-- ########################################################################################################
begin -- Insert new records from new table Sheet1
-- ########################################################################################################
-- insert into Stocks_db._TS.Shares 
select null as period,a.* 
from Stocks_db.dbo.[Sheet1] a
left join Stocks_db._TS.Shares  b
on a.period = b.period
and a.[Trade Date] = b.[Trade Date]
where b.[Trade Date] is null
;
end
-- ########################################################################################################
begin -- problem in Zerodha transactions which are to be corrected 
-- ########################################################################################################
-- add MOLDTECH
select 
*
from _TS.Shares
where symbol = 'MOLDTECH' 
and Quantity in ('119','481')
;
-- insert into _TS.Shares values 
--( '2021-04-01 to 2022-04-01','MOLDTECH','INE835B01035','2022-03-24','NSE','EQ','EQ','SELL','0','119','87','50818240','1200000002572284','2022-03-24T00:00:00'),
--( '2021-04-01 to 2022-04-01','MOLDTECH','INE835B01035','2022-03-24','NSE','EQ','EQ','SELL','0','481','86.35','50818240','1200000002572284','2022-03-24T00:00:00')
;
-- ########################################################################################################
-- update TCS
select 
* 
from _TS.Shares
where Symbol = 'TCS'
and [Order Execution Time] = '2022-07-14T15:02:43'
;
--update _TS.Shares
--set Quantity = 1
--where Symbol = 'TCS' and [Order Execution Time] = '2022-07-14T15:02:43'
;
end
-- ########################################################################################################
begin -- number generation table creation
;WITH cteN(Number) AS
(
  SELECT 
  ROW_NUMBER() OVER (ORDER BY s1.[object_id]) - 1
  FROM sys.all_columns AS s1
  CROSS JOIN sys.all_columns AS s2
)
SELECT 
[Number] -- INTO [dbo].[Numbers]
FROM cteN WHERE [Number] <= 500000;
/*
CREATE UNIQUE CLUSTERED INDEX CIX_Number ON dbo.Numbers([Number])
WITH 
(
  FILLFACTOR = 100,      -- in the event server default has been changed
  DATA_COMPRESSION = ROW -- if Enterprise & table large enough to matter
);
*/
select 
* 
from _TS.Numbers;
-- ########################################################################################################
end
-- ########################################################################################################
select 
-- Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],[Order ID],[Order Execution Time]
period,* 
from _TS.Shares 
order by [Order Execution Time]
;
select 
[Order Execution Time],Period
--,reverse(PERIOD) as reverse_Period ,CHARINDEX('-',reverse(PERIOD)) as period_charindex
--,SUBSTRING(reverse(PERIOD),0,CHARINDEX('-',reverse(PERIOD))) as substring_period
--,reverse(REPLACE(reverse(PERIOD), SUBSTRING(reverse(PERIOD),0,CHARINDEX('-',reverse(PERIOD))),'10'))
,left(period,len(period)-CHARINDEX('-',reverse(PERIOD))+1) + '25'  as left_period
from _TS.Shares
where 1=1
-- and [Order Execution Time] = '2020-11-10 10:18:39.0000000'
-- and period like '%2023-12-01%'
order by [Order Execution Time]
;
select * 
-- update _TS.Shares  set period = 'Tradebook for Equity from 2022-01-01 to 2023-01-01'
-- left(period,len(period)-CHARINDEX('-',reverse(PERIOD))+1) + '25'  
from _TS.Shares
where -- period like '%2023-12-01%'
[Order Execution Time] in('2022-01-19 11:35:52.0000000','2022-01-21 13:29:45.0000000')
;
select * 
from _TS.Shares;
--
-- truncate table _TS.Shares;
-- insert into _TS.Shares (Period,Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],[Order ID],[Order Execution Time])
select 
Period,Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],[Order ID],[Order Execution Time]
from _TS.[Shares]
;
select 
[Trade date],sum(Quantity),[Trade Type]
from Stocks_db._TS.Shares where symbol = 'Idea'
group by [Trade Date],[Trade Type]
;
select 
symbol,[Trade Type],Quantity,Price
from Stocks_db._TS.Shares 
where upper(symbol) = 'tcs'
;
select * 
from _TS.[Shares]  
where Period like '%2023-10-12%'
order by [Order Execution Time] desc
;
select * 
from Stocks_db._TS.Shares where period like '%2023-10-07%'
;
SELECT 
'''%' + CONVERT(VARCHAR,GETDATE(),106) + '%'''
;
-- 
-- truncate table _TS.Shares;
--insert into _TS.Shares (Symbol,a.ISIN,a.[Trade Date],a.Exchange,a.Segment,a.Series,a.[Trade Type],a.Auction,a.Quantity,a.Price,a.[Trade ID],a.[Order ID],a.[Order Execution Time],a.period)
select 
*,'2023-10-07' 
from [dbo].[Sheet1]
;
select * 
from _TS.[Shares]
;
-- 
-- insert into _TS.Shares(Symbol,a.ISIN,a.[Trade Date],a.Exchange,a.Segment,a.Series,a.[Trade Type],a.Auction,a.Quantity,a.Price,a.[Trade ID],a.[Order ID],a.[Order Execution Time],a.Period)
select  
a.Symbol,a.ISIN,a.[Trade Date],a.Exchange,a.Segment,a.Series,a.[Trade Type],a.Auction,a.Quantity,a.Price,a.[Trade ID],a.[Order ID],a.[Order Execution Time],a.Period
from _TS.[Shares] a
left join [dbo].[Sheet1] b 
on a.symbol = b.Symbol 
and a.[Order Execution Time] = b.[Order Execution Time]
where a.symbol like '%NIFTY%' and a.symbol is null
;
select * 
-- Symbol,a.ISIN,a.[Trade Date],a.Exchange,a.Segment,a.Series,a.[Trade Type],a.Auction,a.Quantity,a.Price,a.[Trade ID],a.[Order ID],a.[Order Execution Time],a.Period
from _TS.Shares a
right join [dbo].[Sheet1] b 
on a.symbol = b.Symbol 
and a.[Order Execution Time] = b.[Order Execution Time]
where -- a.symbol like '%NIFTY%' and 
a.symbol is null
;
select 
Symbol,a.ISIN,a.[Trade Date],a.Exchange,a.Segment,a.Series,a.[Trade Type],a.Auction,a.Quantity,a.Price,a.[Trade ID],a.[Order ID],a.[Order Execution Time],a.period
from  _TS.Shares a
;
select 
'new',count(1) from  _TS.Shares
union all
select 
'old',count(1) from  [dbo].[Sheet1]
;
select * 
from [dbo].Sheet1
;
-- 
-- Period,Symbol,ISIN,Trade Date,Exchange,Segment,Series,Trade Type,Auction,Quantity,Price,Trade ID,Order ID,Order Execution Time
-- period,Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],[Order ID],[Order Execution Time]
select 
Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],[Order ID],[Order Execution Time]
from [dbo].[Sheet1]
;

-- ALTER SCHEMA _ts TRANSFER dbo.Numbers;


select * from 
(select sum(quantity) as buy_quantity,Account, symbol,[Trade Type]
from _TS.Shares 
where [Trade Type] = 'buy'
-- symbol = 'TCS'
group by account,symbol, [Trade Type]
) a
left join (
select sum(quantity) as sell_quantity,Account, symbol,[Trade Type]
from _TS.Shares 
where [Trade Type] = 'sell'
-- symbol = 'TCS'
group by account,symbol, [Trade Type]
) b
on a.Account = b.Account
and a.Symbol = b.Symbol
where sell_quantity <> buy_quantity
;

select * from _TS.Shares where account = 'XLH244'
--insert into _TS.Shares  select * from [dbo].[Sheet1]

select * from [dbo].[Sheet1];
select * from [dbo].[Ledger]; 
select * from _TS.Shares where account = 'MA4342';
select 
Symbol,null,[Trade Date],Exchange,null   ,null  ,null       ,null   ,null     ,Price,[Trade ID],null    ,[Trade Date]        ,null,null  ,null ,null         ,null
from [dbo].[TradeBook];

select * from [dbo].[Sheet1];

-- Symbol,null,[Trade Date],Exchange,null   ,null  ,scrip       ,null   ,Qty     ,Price,[Trade ID],null    ,[Trade Date]        ,null,null  ,Account,null         ,null
-- Symbol,ISIN,[Trade Date],Exchange,Segment,Series,[Trade Type],Auction,Quantity,Price,[Trade ID],Order ID,Order Execution Time,Sno ,Period,Account,[Trade Value],Comments


select * from _TS.Shares where account = 'MA4342' order by [trade date] desc


select * from [dbo].[TradeBook]

select distinct account from _TS.Shares

select * from [dbo].[Sheet1]

select * from [_TS].[Shares] 
where Account = 'LD3666'
order by Account,[Order Execution Time]
;

select * from [dbo].[TradeBook];

select * from Stocks_db._TS.Shares;
select * from [dbo].[Charges];
select * from [dbo].[Dividends];
select * from [dbo].[Ledger];

-- import header format
-- Symbol,ISIN,Trade Date,Exchange,Segment,Series,Trade Type,Auction,Quantity,Price,Trade ID,Order ID,Order Execution Time,Sno,Period,Account,Trade Value,Comments

select * from _TS.Shares 
order by Account, [Order Execution Time] asc
;

declare @var int = 1
;with CTE as (
select *, ROW_NUMBER() over(Partition by Account 
order by Account,[Order Execution Time] asc ) as rn
from _ts.Shares 
) 
update CTE set sno = rn 
-- sno = @var, @var = @var + 1 
-- ,@var = sno = @var + 1


SELECT n.*, o.*
FROM [dbo].[Sheet1] n
	 INNER JOIN _ts.Shares o ON o.[Symbol]				= n.[Symbol]
	 AND o.[ISIN]				= n.[ISIN]
	 AND o.[Trade Date]			= CAST(n.[Trade Date] AS DATETIME)
	 AND o.[Exchange]			= n.[Exchange]
	 AND o.[Segment]				= n.[Segment]
	 AND o.[Series]				= n.[Series]
	 AND o.[Trade Type]			= n.[Trade Type]
	 AND o.[Auction]				= CAST(n.[Auction] AS BIT)
	 AND o.[Quantity]			= CAST(n.[Quantity] AS FLOAT)
	 AND o.[Price]				= CAST(n.[Price] AS FLOAT)
	 AND CAST(o.[Trade ID] AS VARCHAR) = CAST(n.[Trade ID] AS VARCHAR)
	 AND o.[Order ID]			= n.[Order ID]
	 AND o.[Order Execution Time] = CAST(n.[Order Execution Time] AS DATETIME)
	 AND o.[Sno]					= CAST(n.[Sno] AS FLOAT)
	 AND o.[Period]				= n.[Period]
	 AND o.[Account]				= n.[Account]
	 AND o.[Trade Value]			= n.[Trade Value]
	 AND o.[Comments]			= n.[Comments]
;

--create procedure [Trade-log-Query] as begin
--SET NOCOUNT ON

SELECT (ROUND(SUM(x.Sell_price) - SUM(x.Pur_Price), 2)) - (ROUND((SUM(x.Pur_Price) * 10 * x.[Number of Days]/365)/ 100, 2)) AS profit_over_interest1, x.Symbol, x.Pur_Date, x.Pur_Price, SUM(x.BuyQuantity) AS BuyQty, SUM(x.Pur_Price) AS Total_Pur_Value, x.Sell_Date, x.Sell_Price, SUM(x.SellQuantity) AS SellQty, SUM(x.Sell_Price) AS Total_Sell_value, x.[Number of Days], ROUND(SUM(x.Sell_price) - SUM(x.Pur_Price), 2) AS [Profit or Loss], ROUND((SUM(x.Pur_Price) * 10 * x.[Number of Days]/365)/ 100, 2) AS [interest calculation]
FROM (SELECT a.row_num, a.Symbol, a.Trade_Date AS Pur_Date, a.Price AS Pur_Price
-- ,a.Buy_Average_Price
, a.SingleQuantity AS BuyQuantity, b.Trade_Date AS Sell_Date, b.Price AS Sell_Price
-- ,b.Sell_Average_Price
, b.SingleQuantity AS SellQuantity, DATEDIFF("d", a.Trade_Date, b.Trade_Date)+1 AS [number of days]
	FROM (SELECT ROW_NUMBER() OVER (PARTITION BY symbol ORDER BY symbol, Trade_Type, Trade_Date, Order_execution_Time, price) AS row_num, 1 AS SingleQuantity, *
		--,avg(Price) over(partition by symbol,Trade_Type order by symbol,Trade_Type) as Buy_Average_Price
		FROM Stocks_db.dbo.Shares_Transaction st
		JOIN master.dbo.spt_values t2 ON t2.type = 'P' AND t2.number < st.Quantity
		WHERE Trade_Type = 'Buy' -- and Symbol = 'ANANDRATHI'
	) a
	LEFT JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY symbol ORDER BY symbol, Trade_Type, Trade_Date, Order_execution_Time, price) AS row_num, 1 AS SingleQuantity, *
		--,avg(Price) over(partition by symbol,Trade_Type order by symbol,Trade_Type) as Sell_Average_Price
		FROM Stocks_db.dbo.Shares_Transaction st
		JOIN master.dbo.spt_values t2 ON t2.type = 'P' AND t2.number < st.Quantity
		WHERE Trade_Type = 'Sell'
	-- and Symbol = 'ANANDRATHI'
	) b ON a.row_num = b.row_num
		AND a.Symbol = b.Symbol) x
GROUP BY x.Symbol, x.Pur_Date, x.Pur_Price, x.Sell_Date, x.Sell_Price, x.[number of days]
ORDER BY x.Symbol, x.Pur_Date, x.Pur_Price, x.Sell_Date, x.Sell_Price, x.[number of days]

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

--END;

-- Symbol,ISIN,Trade_Date,Exchange,Segment,Series,Trade_Type,Auction,Quantity,Price,Trade_ID,Order_ID,Order_Execution_Time

SELECT * FROM dbo.Shares_Transaction

SELECT [Symbol], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Order Execution Time], [Period], [Account], [Trade Value], [Comments]
FROM [_TS].[Shares];

SELECT [Symbol], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Order Execution Time], [Period], [Account], NULL AS [Trade Value], NULL AS [Comments]
FROM dbo.TradeBook;

SELECT account, MAX([Order Execution Time])
FROM Stocks_db._TS.Shares
GROUP BY Account
ORDER BY 2 DESC;
/*
account	date
XG14162	2026-06-18 09:07:59
LD3666	2026-06-02 09:17:05
MA4342	2023-12-08 00:00:00
XLH244	2022-09-08 11:28:17
*/






--end;
