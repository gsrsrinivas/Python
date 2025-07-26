USE [Stocks_Analysis]
GO

/****** Object:  View dbo.[Analyse_Stocks_v]    Script Date: 24-Jul-2025 9:21:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- CREATE OR ALTER view dbo.[Analyse_Stocks_v] as 
select 
[Batch_No], [Trading View],[Trade-Type-Details],[segment]
, [Symbol], [% Chg], [Price], [Volume]
, rn,[Stock_Name]
, [Trade Type Details - Sum], [Trade Type - Bullish Sum], [Trade Type - Bearish Sum]
, [Trade Type], [Trade Type - Length], [Segments - Length], [Trade Type Details - Length]
, [Segments - Order],[Segments - Sum], [Created_Date]
from (select 
      row_number() over(partition by [Batch_No], [Trading View],[Trade Type Details],[Stock_Name],[Segments],[Symbol] 
	  order by [Trading View - Order],[segments - order] desc,[Volume_Shockers - Sum] desc,[trade type details - sum] desc) as rn
	, [Sno], [Batch_No], [Trade Type Details - Sum], [Trade Type - Bullish Sum], [Trade Type - Bearish Sum], [Segments - Length]
	, [Trading View], [Trade Type], [Trade Type - Length]
	, replace([Trade Type Details],';',';'+char(13)+char(10)) as 'Trade-Type-Details'
	, [Trade Type Details], [Trade Type Details - Length], [Created_Date], [Stock_Name]
	, replace([Segments],';',';' + char(13)+ char(10))as segment
	, [Segments], [Symbol]
	, [% Chg], [Price], [Volume]
	, [Segments - Order], [Segments - Sum]
	  from dbo.Analyse_Stocks 
	  where Batch_No = (select max(batch_no) from dbo.Analyse_Stocks) 
	  --and [Trade Type - Length] > 25 
	  -- and [Segments - Length] > 10 
	  -- and volume > 10000 
	  -- and [Trade Type Details - Sum] > 10
	 
) a where rn = 1
-- order by [Trading View] desc,[Trade Type Details - Sum] desc, [Trade Type Details - Length] desc,[Segments - Length] desc,[Trade Type - Length] desc
GO


