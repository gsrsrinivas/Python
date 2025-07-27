EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

exec sp_rename 'Analyse_15Minutes_Stocks.[Report Sort Order]'          ,Report_Sort_Order        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trading View]'               ,Trading_View             ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trading View - Order]'       ,Trading_View_Order       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Segments - Order]'           ,Segments_Order           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Volume_Shockers - Sum]'      ,Volume_Shockers_Sum      ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details]'         ,Trade_Type_Details       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details - Sum]'   ,Trade_Type_Details_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Percent_Change'                      ,Percent_Change           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type]'                 ,Trade_Type               ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Length]'        ,Trade_Type_Length        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Bullish Sum]'   ,Trade_Type_Bullish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Bearish Sum]'   ,Trade_Type_Bearish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details - Length]',Trade_Type_Details_Length,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Segments - Length]'          ,Segments_Length          ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Segments - Sum]'             ,Segments_Sum             ,'column';


sno -- Sno
% Cng - Percent_change
segments - segments
