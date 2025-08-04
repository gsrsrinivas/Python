begin -- insert script 15 minutes 
DECLARE @StartTime DATETIME= GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
---------
begin -- add new stocks in master table 
insert into dbo.Master_Stocks_In_Segments (Symbol,Segments,Stock_Name)
select distinct cs.symbol,cs.segments,cs.[stock_name]
from dbo.Cash_15Minutes_Stocks cs 
WHERE NOT EXISTS (SELECT 1 FROM dbo.Master_Stocks_In_Segments ms WHERE ms.Symbol = cs.Symbol)
;
end
begin -- update the sno in master table 
update sis set Sno = rn 
from dbo.Master_Stocks_In_Segments sis inner join (
	select Symbol,row_number() over(order by len(segments) desc) as rn -- ,len(segments) as maxsegments,* 
	from dbo.Master_Stocks_In_Segments
) b on sis.Symbol = b.Symbol;
end
begin -- add stocks from master table 
declare @batch_num bigint
select @batch_num = MAX(Batch_No) from dbo.Cash_15Minutes_Stocks;
delete from dbo.Analyse_15Minutes_Stocks where Batch_No = @batch_num;
insert into dbo.[Analyse_15Minutes_Stocks] (Batch_No,created_date,Stock_Name
	,Percent_Change,price,volume,Segments_Length
	,Segments,Symbol,Industry,ISIN_Code,Series
	,Segments_Order,Segments_Sum)
select @batch_num,SYSDATETIME(),a.[stock_name]
	,a.Percent_Change,a.price,a.volume,len(ss.Segments) as Segments_Length
	,ss.Segments,a.symbol,ss.Industry,ss.ISIN_Code,ss.Series
	,ss.sector_order,ss.sector_sum
from (
	select a.[stock_name],a.segments,a.Symbol,max(a.Percent_Change) as Percent_Change,max(a.price) as price,max(a.volume) as volume
	from dbo.Cash_15Minutes_Stocks a
	where batch_no = (select MAX(Batch_No) from dbo.Cash_15Minutes_Stocks)
	group by a.[stock_name],a.segments,a.Symbol
) a
left join dbo.[Master_Stocks_In_Segments] ss on ss.Symbol = a.symbol
Order by ss.Sno;
end

declare @Batch_no bigint
select @batch_no = max(batch_no) from dbo.Cash_15Minutes_Stocks;
-- select @batch_no

-- update indicators
begin -- macd 
update a set Macd_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Macd_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- stochastic 
update a set Stochastic_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Stochastic_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 5 13 
update a set Ema_5_13_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 13 26 
update a set Ema_13_26_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 50 100 
update a set Ema_50_100_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end 
begin -- ema 100 200 
update a set Ema_100_200_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- adx 
update a set ADX_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set ADX_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- rsi 
update a set RSI_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set RSI_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- upper bollinger band 3 
update a set Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- lower bollinger band 3 
update a set Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- upper bollinger band 2 
update a set Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- lower bollinger band 2 
update a set Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- volume 
update a set Volume_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Volume_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- volume schockers 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
update a set volume_yearly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_yearly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_quarterly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_quarterly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_monthly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_monthly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_weekly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_weekly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_daily_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_daily_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_4_hourly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_4_hourly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_1_hourly_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_1_hourly_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
update a set volume_15_minutes_shockers = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume_15_minutes_shockers from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Shockers'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_no
;
end 
begin -- adx 
update a set Adx_Up_Tick_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Up Tick' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where batch_no = @batch_no and Indicator = 'Adx Down Tick' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol and b.Batch_No = a.Batch_No
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end

begin -- script execution time calculation 
DECLARE	 @EndTime DATETIME = GETDATE();
DECLARE	 @DurationMs INT = DATEDIFF(MILLISECOND, @StartTime, @EndTime);
-- Break down into components
DECLARE	 @Hours INT = @DurationMs / 3600000
		,@Minutes INT = (@DurationMs % 3600000) / 60000
		,@Seconds INT = (@DurationMs % 60000) / 1000
		,@Milliseconds INT = @DurationMs % 1000;
-- Format as hh:mm:ss.mmm

PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
PRINT 'Script ended at: ' + CONVERT(VARCHAR, @EndTime, 121);
PRINT 'Duration (ms): ' + CAST(@DurationMs AS VARCHAR);
PRINT 'Duration: ' + 
  RIGHT('00' + CAST(@Hours AS VARCHAR), 2) + ':' +
  RIGHT('00' + CAST(@Minutes AS VARCHAR), 2) + ':' +
  RIGHT('00' + CAST(@Seconds AS VARCHAR), 2) + '.' +
  RIGHT('000' + CAST(@Milliseconds AS VARCHAR), 3);
end

-- select top 2500 * from dbo.Analyse_15Minutes_Stocks order by Sno desc;
end 