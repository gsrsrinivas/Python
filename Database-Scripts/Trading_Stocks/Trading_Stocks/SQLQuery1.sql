
SELECT [Symbol], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Order Execution Time], [Period], [Account], [Trade Value], [Comments]
FROM [_TS].[Shares];

SELECT [Symbol], [ISIN], [Trade Date], [Exchange], [Segment], [Series], [Trade Type], [Auction], [Quantity], [Price], [Trade ID], [Order ID], [Order Execution Time], [Period], [Account], NULL AS [Trade Value], NULL AS [Comments]
FROM dbo.TradeBook;

--update dbo.TradeBook 
--set [Order Execution Time] = replace([Order Execution Time],'Oc ','Oct')
SELECT CONVERT(date, [Order Execution Time], 120) AS FormattedDate from dbo.TradeBook 
order by 1 asc
select * into _ts.shares_bkp_2026_06_25 from [_TS].[Shares]


