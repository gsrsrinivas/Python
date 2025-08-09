select	'15mins' as TmFrm,Symbol,Trade_Type_Details,Volume_Shockers,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View,Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,Created_Date,price_action as pa -- ,Trade_Type,Series,ISIN_Code,
from	dbo.Analyse_15Minutes_Stocks 
where	1=1 
	and	batch_no >= cast(Format(getdate(),'yyyyMMdd')+'050505' as bigint)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
--order	by price_action
--		,Batch_No desc
--		,Trade_Type_Details_Sum desc
--		,Volume_Shockers_Sum desc
--		,Segments_Sum desc
--		,Trade_View desc
--		,Report_Sort_Order asc
union all 
select	'Daily',Symbol,Trade_Type_Details,Volume_Shockers,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View,Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,Created_Date,price_action as pa -- Trade_Type,Series,ISIN_Code,
from	dbo.Analyse_Stocks 
where	1=1 
	and	batch_no >= cast(Format(getdate(),'yyyyMMdd')+'050505' as bigint)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
order	by price_action
		,Batch_No desc
		,Trade_Type_Details_Sum desc
		,Volume_Shockers_Sum desc
		,Segments_Order desc
		,Trade_View desc
		--,Report_Sort_Order asc
