SELECT 
tr.Txn_Type, tr.Segment,tr.Symbol, 
sum(tr.Buy_Qty) AS Buy_Qty,sum(tr.Buy_Value) AS Buy_Value, 
sum(tr.Buy_Value) / sum(tr.Buy_Qty) AS Buy_Rate,
tr.Sell_Date, sum(tr.Sell_Qty) AS Sell_Qty, sum(tr.Sell_Value) AS Sell_Value, 
sum(tr.Sell_Value) / sum(tr.Sell_Qty) AS Sell_Rate,sum(tr.Profit_Loss_Amt) AS Profit_Loss_Amt, max(tr.Total_days) AS Total_Days,sum(tr.Turnover) AS Turnover,
tr.ISIN, tr.Equity_Type
FROM dbo.Tax_Report tr
-- WHERE Symbol IN ('COALINDIA','DCM','NTPC','RECLTD','YASHO')
-- AND tr.Sell_Date = '2024-04-08 00:00:00.000'
group BY tr.Symbol, tr.Txn_Type, tr.Segment,tr.Sell_Date,tr.ISIN, tr.Equity_Type
;



