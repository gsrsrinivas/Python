select top 1000 * from [_sis].[Analyse_15Minutes_Stocks_View]
where Volume_Shockers is not null
order by batch_no desc, [Report Sort Order]
