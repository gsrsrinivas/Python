begin -- insert script 
/* ------------------------------------------------------------------------
-- dbo.Cash_15Minutes_Stocks, dbo.Master_Stocks_In_Segments, dbo.Analyse_15Minutes_Stocks
------------------------------------------------------------------------ */

begin -- print start time
DECLARE @StartTime DATETIME = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
end

begin -- add and update new stocks in master table 
print 'add and update new stocks in master table'
insert into dbo.Master_Stocks_In_Segments (Symbol,Segments,Stock_Name)
select distinct cs.symbol,cs.segments,cs.stock_name from dbo.Cash_15Minutes_Stocks cs
where NOT EXISTS (SELECT 1
from dbo.Master_Stocks_In_Segments ms WHERE ms.Symbol = cs.Symbol)
;
print 'update the sno in master table'
update sis set Sno = rn from dbo.Master_Stocks_In_Segments sis inner join 
(	select Symbol,row_number() over(order by len(segments) desc) as rn
	from dbo.Master_Stocks_In_Segments 
) b on sis.Symbol = b.Symbol
;
end 

begin -- insert into analyse stocks
declare @Batch_No bigint;
DECLARE @cols NVARCHAR(MAX), @query NVARCHAR(MAX);

select @Batch_No = MAX(Batch_No) from dbo.Cash_15Minutes_Stocks;
-- Explicit LOB type enforcement inside STRING_AGG
SELECT @cols = STRING_AGG(CAST(QUOTENAME(REPLACE(indicator, ' ', '_') + '_' + REPLACE(timeline, ' ', '_') + '_' + REPLACE(direction, ' ', '_')) AS NVARCHAR(MAX)), ',')
              WITHIN GROUP (ORDER BY indicator)
FROM (
    SELECT DISTINCT indicator, timeline, direction
    FROM Cash_15Minutes_Stocks
    WHERE Batch_No = @Batch_No 
) AS temp;

print 'deleting the current batch records from analyse 15minutes stocks table'
delete from dbo.Analyse_15Minutes_Stocks where Batch_No = @Batch_No;

-- Build final query
SET @query = '
WITH cte AS (
    SELECT *, REPLACE(indicator, '' '', ''_'') + ''_'' + REPLACE(timeline, '' '', ''_'') + ''_'' + REPLACE(direction, '' '', ''_'') AS ind_direction
    FROM dbo.Cash_15Minutes_Stocks
    WHERE Batch_No = ' + cast(@Batch_No as varchar) + '
),
source as (
	select symbol, ind_direction
	, 1 as sno
	, MAX(stock_name) as stock_name
	, MAX(Percent_Change) as Percent_Change
	, MAX(price) as price
	, MAX(volume) as volume
	, MAX(Batch_No) as batch_no
	, SYSDATETIME() as created_date
	from cte
	group by symbol, ind_direction
)
insert into dbo.Analyse_15Minutes_Stocks (Symbol,Stock_Name,Percent_Change,Price,Volume,Batch_No,Created_Date,' + @cols + ')
SELECT * 
FROM source
PIVOT (
    MAX(sno)
    FOR ind_direction IN (' + @cols + ')
) AS pivoted
order by symbol;';
print 'inserting the records into the analyse 15minutes stocks table'
EXEC sp_executesql @query;

print 'update the few columns in analyse stocks table'
update a set Industry = b.Industry, ISIN_Code = b.ISIN_Code, a.Series = b.Series
,a.Segments = b.Segments,a.Segments_Order = b.sector_order,a.Segments_Sum = b.sector_sum
,a.Segments_Length = len(b.Segments)
from dbo.Analyse_15Minutes_Stocks a inner join dbo.Master_Stocks_In_Segments b 
on a.Symbol = b.Symbol and a.Batch_No = @Batch_No

end

begin -- script execution time calculation 
--DECLARE @StartTime DATETIME = GETDATE();
DECLARE	 @EndTime DATETIME = GETDATE();
DECLARE	 @DurationMs INT = DATEDIFF(MILLISECOND, @StartTime, @EndTime);
-- Break down into components
DECLARE	 @Hours INT = @DurationMs / 3600000
		,@Minutes INT = (@DurationMs % 3600000) / 60000
		,@Seconds INT = (@DurationMs % 60000) / 1000
		,@Milliseconds INT = @DurationMs % 1000;
-- Format as hh:mm:ss.mmm

PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
PRINT 'Script ended at  : ' + CONVERT(VARCHAR, @EndTime, 121);
PRINT 'Duration (ms)    : ' + CAST(@DurationMs AS VARCHAR);
PRINT 'Duration         : ' + CAST(CAST(DATEADD(MILLISECOND, @DurationMs, '00:00:00.000') AS TIME) as VARCHAR)

end
/*
select top 2500 * from dbo.Analyse_15Minutes_Stocks
-- where Batch_No = (select max(batch_no) from dbo.Analyse_15Minutes_Stocks) 
order by 1 desc;
*/
end
