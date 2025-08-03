select top 2500 * from dbo.Analyse_Stocks
where Trading_View is not null
order by Batch_No desc,Report_Sort_Order asc