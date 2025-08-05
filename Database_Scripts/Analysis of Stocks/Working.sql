select	*	
from	Analyse_Stocks 
where	1=1 
	and batch_no >= CONVERT(VARCHAR, GETDATE(), 112)
	and Trade_Type_Details != '' 
	and Segments_Length >10 
order by Batch_No desc
		,Trade_View desc
		,Trade_Type_Details_Sum desc
		,Volume_Shockers_Sum desc
		,Segments_Order desc
		,Report_Sort_Order asc
;