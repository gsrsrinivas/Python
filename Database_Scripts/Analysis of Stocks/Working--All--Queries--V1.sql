begin
select * from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
and Trade_Type_Details != ''
order by Volume_Shockers desc
;
select coalesce(case when 1=1 then 'coalesce 1st part' else 'elsepart' end,'coalesce 2nd part') as checking
;
end
begin -- truncate tables
/*
truncate table dbo.Analyse_15Minutes_Stocks;
truncate table dbo.Analyse_Stocks;
truncate table dbo.Cash_15Minutes_Stocks;
truncate table dbo.Cash_Stocks;
*/
end
