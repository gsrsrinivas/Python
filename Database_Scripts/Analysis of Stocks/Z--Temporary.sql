select * from dbo.Analyse_Stocks 
where batch_no =  20250725085552 -- 20250725102550 
and [Trading View] is not null
order by Batch_No desc;

-- delete from dbo.Analyse_Stocks where Batch_No in (20250725103420,20250725110948)
-- select distinct batch_no from dbo.Analyse_Stocks order by 1 desc;

select * from dbo.Analyse_15Minutes_Stocks -- where [Trading View] is not null
order by Batch_No desc
;
