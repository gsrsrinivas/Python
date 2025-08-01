select * from dbo.Cash_Stocks where Batch_No = (select max(batch_no) from dbo.Cash_Stocks)
-- 20250731180015
-- 20250731205113

select sno,symbol,stock_name,bsecode,percent_change,price,volume,Indicator,TimeLine,Direction,segments,Batch_No
-- into dbo.Cash_15Minutes_Stocks_1
from dbo.Cash_15Minutes_Stocks
select count(1), Batch_No from [dbo].Cash_15Minutes_Stocks group by Batch_No

select * from Analyse_Stocks_v order by Report_Sort_Order,trading_view_order, volume_shockers desc;

select * from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
and Trade_Type_Details != ''
order by Volume_Shockers desc
;
