select * from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
and Trade_Type_Details != ''
order by Report_Sort_Order 
;

select * from Analyse_Stocks_v order by Report_Sort_Order;


