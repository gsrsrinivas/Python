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


select n.*,o.*
from [dbo].[Sheet1] n
inner join _ts.Shares o
on  o.[Symbol]				= n.[Symbol]
AND o.[ISIN]				= n.[ISIN]
AND o.[Trade Date]			= cast(n.[Trade Date] as datetime)
AND o.[Exchange]			= n.[Exchange]
AND o.[Segment]				= n.[Segment]
AND o.[Series]				= n.[Series]
AND o.[Trade Type]			= n.[Trade Type]
AND o.[Auction]				= cast(n.[Auction] as bit)
AND o.[Quantity]			= cast(n.[Quantity] as float)
AND o.[Price]				= cast(n.[Price] as float)
AND cast(o.[Trade ID] as varchar) = cast(n.[Trade ID] as varchar)
AND o.[Order ID]			= n.[Order ID]
AND o.[Order Execution Time] = cast(n.[Order Execution Time] as datetime)
AND o.[Sno]					= cast(n.[Sno] as float)
AND o.[Period]				= n.[Period]
AND o.[Account]				= n.[Account]
AND o.[Trade Value]			= n.[Trade Value]
AND o.[Comments]			= n.[Comments]

--end;
