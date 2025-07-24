select top 1000 * from [_sis].[Analyse_15Minutes_Stocks_View]
where Volume_Shockers is not null
order by batch_no desc, [Report Sort Order]
select * from _sis.Analyse_15Minutes_Stocks_v
select distinct batch_no,Symbol from _sis.Analyse_Stocks_View with (nolock) where Batch_No = 63

select * from _sis.Analyse_15Minutes_Stocks order by Batch_No desc

[_sis].[Analyse_Stocks_v]