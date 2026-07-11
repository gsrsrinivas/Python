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
--END;