-- execute TradeFinalQuery 1
select  
	COALESCE(NULLIF(x.Symbol, NULL), '') as Symbol
	,COALESCE(NULLIF(x.Pur_Price, NULL), '') as Pur_Price
	,COALESCE(NULLIF(sum(x.BuyQuantity), NULL), '') as BuyQty
	,COALESCE(NULLIF(x.Sell_Price, NULL), '') as Sell_Price
	,COALESCE(NULLIF(sum(x.SellQuantity), NULL), '') as SellQty
	,COALESCE(NULLIF(FORMAT(CAST(x.Pur_Date AS DATETIME), 'dd MMM yyyy'), 'NULL'), '') AS Pur_Date
	--,COALESCE(NULLIF(x.Pur_Date, NULL), '') as Pur_Date
	,COALESCE(NULLIF(FORMAT(CAST(x.Sell_Date AS DATETIME), 'dd MMM yyyy'), 'NULL'), '') AS Sell_Date
	--,COALESCE(NULLIF(x.Sell_Date, NULL), '') as Sell_Date
	,COALESCE(NULLIF(x.Account, 'NULL'), '') as Account
	,COALESCE(NULLIF(x.Buy_Exchange, 'NULL'), '') as Buy_Exchange
	,COALESCE(NULLIF(x.Sell_Exchange, 'NULL'), '') as Sell_Exchange
	,COALESCE(NULLIF(case when x.buy_segment = 'FO' then 'Opt' else x.buy_segment end, 'NULL'), '') as buy_segment
	,COALESCE(NULLIF(case when x.sell_segment = 'FO' then 'Opt' else x.buy_segment end, 'NULL'), '') as sell_segment
	,COALESCE(NULLIF(sum(x.Pur_Price), NULL), '') as Total_Pur_Value
	,COALESCE(NULLIF(sum(x.Sell_Price), NULL), '') as Total_Sell_value
	--,COALESCE(NULLIF(x.Buy_Average_Price, NULL), '') as Buy_Average_Price
	--,COALESCE(NULLIF(x.Sell_Average_Price, NULL), '') as Sell_Average_Price
	,COALESCE(NULLIF(x.[Number of Days], NULL), '') as [Number of Days]
	,COALESCE(NULLIF(round((sum(x.Pur_Price) * 10 * x.[Number of Days]/365)/ 100, 2), NULL), '') as [interest calculation]
	,COALESCE(NULLIF((round(sum(x.Sell_price) - sum(x.Pur_Price),2)) - (round((sum(x.Pur_Price) * 10 * x.[Number of Days]/365)/ 100, 2)), NULL), '') as profit_over_interest
	,COALESCE(NULLIF(round(sum(x.Sell_price) - sum(x.Pur_Price),2), NULL), '') as [Profit or Loss]
from 
(
	select 
		a.row_num
		,a.Account as Account
		,a.Symbol
		,a.[Trade Date] as Pur_Date
		,a.Price as Pur_Price
		,a.Exchange as Buy_Exchange
		--,a.Buy_Average_Price
		,a.SingleQuantity as BuyQuantity
		,b.[Trade Date] as Sell_Date 
		,b.Price as Sell_Price
		--,b.Sell_Average_Price
		,b.Exchange as Sell_Exchange
		,b.SingleQuantity as SellQuantity
		,datediff("d",a.[Trade Date],b.[Trade Date])+1 as [number of days]
		,a.Segment as buy_segment
		,b.Segment as sell_segment
	from 
	(
		select ROW_NUMBER() over(partition by Account,Symbol,[Trade Type] order by Account,Symbol,[Trade Type],[Trade Date],[Order Execution Time],price) as row_num
			,1 as SingleQuantity,st.Account
			,st.Symbol,st.ISIN,st.[Trade Date],st.Exchange,st.Segment,st.Series,st.[Trade Type],st.Auction,st.Quantity,st.Price,st.[Trade ID],st.[Order ID],st.[Order Execution Time]
			--,avg(Price) over(partition by symbol,[Trade Type] order by symbol,[Trade Type]) as Buy_Average_Price
		from Stocks_db._TS.Shares st JOIN Stocks_db._TS.Numbers t2 ON t2.number < st.Quantity
		where upper(st.[Trade Type]) = 'BUY' 
		--and Symbol not like '%NIFTY%' 
		--and st.Account = 'MA4342' 
		-- and Symbol = 'BSE' 
	) a
	LEFT JOIN 
	(
		select ROW_NUMBER() over(partition by Account,Symbol,[Trade Type] order by Account,Symbol,[Trade Type],[Trade Date],[Order Execution Time],price) as row_num
			,1 as SingleQuantity,st.Account
			,st.Symbol,st.ISIN,st.[Trade Date],st.Exchange,st.Segment,st.Series,st.[Trade Type]
			,st.Auction,st.Quantity,st.Price,st.[Trade ID],st.[Order ID],st.[Order Execution Time]
			--,avg(Price) over(partition by symbol,[Trade Type] order by symbol,[Trade Type]) as Sell_Average_Price
		from Stocks_db._TS.Shares st JOIN Stocks_db._TS.Numbers t2 ON t2.number < st.Quantity
		where upper(st.[Trade Type]) = 'SELL' 
		--and Symbol not like '%NIFTY%' 
		--and st.Account = 'MA4342' 
		-- and Symbol = 'BSE' 
	) b
	on a.Symbol = b.Symbol
	and a.row_num = b.row_num
	and a.Account = b.Account
) x --where x.symbol like '%NIFTY%'
group by x.Account,x.Symbol,x.Pur_Date,x.Pur_Price,x.Sell_Date,x.Sell_Price,x.[number of days],x.Buy_Exchange,x.Sell_Exchange,x.buy_segment,x.sell_segment --,x.Buy_Average_Price,x.Sell_Average_Price
order by x.Account desc,x.Symbol,x.Pur_Date,x.Pur_Price,x.Sell_Date,x.Sell_Price,x.[number of days],x.Buy_Exchange,x.Sell_Exchange,x.buy_segment,x.sell_segment --,x.Buy_Average_Price,x.Sell_Average_Price
;
