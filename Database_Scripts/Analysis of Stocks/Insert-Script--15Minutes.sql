begin -- insert script 15 minutes 
DECLARE @StartTime DATETIME;
SET @StartTime = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
---------
-- run this script after the data is imported into database table.
-- update the batch number for the new records
begin -- update batch no 
update _sis.Cash_15Minutes_Stocks Set Batch_No =(select isnull(MAX(Batch_No)+1,1) from _sis.Cash_15Minutes_Stocks where batch_No <>CONVERT(int, FORMAT(GETDATE(), 'yyyyMMdd')))
where Batch_No = CONVERT(int, FORMAT(GETDATE(), 'yyyyMMdd'));
end
begin -- add new stocks in master table 
insert into _sis.Master_Stocks_In_Segments (Symbol,Segments,Stock_Name)
select distinct cs.symbol,cs.Segment,cs.[stock name]
from _sis.Cash_15Minutes_Stocks cs 
WHERE NOT EXISTS (SELECT 1 FROM _sis.Master_Stocks_In_Segments ms WHERE ms.Symbol = cs.Symbol)
-- where symbol in (select symbol from _sis.Cash_15Minutes_Stocks except select symbol from _sis.Master_Stocks_In_Segments)
;
end
begin -- update the sno in master table 
update sis set Sno = rn 
from _sis.Master_Stocks_In_Segments sis inner join (
	select Symbol,row_number() over(order by len(segments) desc) as rn -- ,len(segments) as maxsegments,* 
	from _sis.Master_Stocks_In_Segments
) b on sis.Symbol = b.Symbol;
end
begin -- add stocks from master table 
insert into [_sis].[Analyse_15Minutes_Stocks] (Batch_No,created_date,Stock_Name
	,[% Chg],price,volume,[Segments - Length]
	,Segments,Symbol,Industry,ISIN_Code,Series
	,[Segments - Order],[Segments - Sum])
select (select isnull(max(batch_no)+1,1) from _sis.Analyse_15Minutes_Stocks),SYSDATETIME(),a.[stock name]
	,a.[% Chg],a.price,a.volume,len(ss.Segments) as [Segments - Length]
	,ss.Segments,a.symbol,ss.Industry,ss.[ISIN Code],ss.Series
	,ss.sector_order,ss.sector_sum
from (
	select a.[stock name],a.Segment,a.Symbol,max(a.[% Chg]) as [% Chg],max(a.price) as price,max(a.volume) as volume
	from _sis.Cash_15Minutes_Stocks a
	where batch_no = (select MAX(Batch_No) from _sis.Cash_15Minutes_Stocks)
	group by a.[stock name],a.Segment,a.Symbol
) a
left join [_sis].[Master_Stocks_In_Segments] ss on ss.Symbol = a.symbol
Order by ss.Sno;
end

declare @Batch_no int,@batch_no_cs int
select @Batch_no = max(batch_no) from _sis.Analyse_15Minutes_Stocks;
select @Batch_no_cs = max(batch_no) from _sis.Cash_15Minutes_Stocks;
-- select @batch_no, @batch_no_cs

-- update indicators
begin -- macd 
update a set Macd_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Macd_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Macd_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- stochastic 
update a set Stochastic_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Stochastic_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Stochastic_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 5 13 
update a set Ema_5_13_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_5_13_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_5_13_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 13 26 
update a set Ema_13_26_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_13_26_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_13_26_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- ema 50 100 
update a set Ema_50_100_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_50_100_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_50_100_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end 
begin -- ema 100 200 
update a set Ema_100_200_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Ema_100_200_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Ema_100_200_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- adx 
update a set ADX_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set ADX_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as ADX_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- rsi 
update a set RSI_Yearly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Yearly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Yearly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Yearly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Quarterly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Quarterly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Quarterly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Quarterly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Monthly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Monthly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Monthly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Monthly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Weekly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Weekly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Weekly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Weekly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Daily_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Daily_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_Daily_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_Daily_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_4_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_4_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_4_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_4_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_1_Hourly_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_1_Hourly_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_1_Hourly_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_1_Hourly_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_15_Minutes_Crosses_Above = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_15_Minutes_Crosses_Above from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set RSI_15_Minutes_Crosses_Below = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as RSI_15_Minutes_Crosses_Below from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- upper bollinger band 3 
update a set Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- lower bollinger band 3 
update a set Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- upper bollinger band 2 
update a set Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- lower bollinger band 2 
update a set Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- volume 
update a set Volume_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Volume_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Volume_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
begin -- volume schockers 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
update a set volume__yearly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__yearly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__quarterly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__quarterly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__monthly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__monthly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__weekly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__weekly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__daily__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__daily__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__4_hourly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__4_hourly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__1_hourly__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__1_hourly__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
update a set volume__15_minutes__shockers = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as volume__15_minutes__shockers from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Shockers'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_no
;
end 
begin -- adx 
update a set Adx_Up_Tick_Yearly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Yearly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Yearly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Yearly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Quarterly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Quarterly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Quarterly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Quarterly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Monthly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Monthly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Monthly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Monthly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Weekly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Weekly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Weekly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Weekly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_Daily_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Daily_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_Daily_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_Daily_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_4_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_4_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_1_Hourly_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_1_Hourly_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Up Tick' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
update a set Adx_Down_Tick_15_Minutes_Less_Than_Equal_To = 1
from _sis.Analyse_15Minutes_Stocks a inner join (
select batch_no,symbol, 1as Adx_Up_Tick_15_Minutes_Less_Than_Equal_To from _sis.Cash_15Minutes_Stocks where batch_no = @batch_no_cs and Indicator = 'Adx Down Tick' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
where a.Batch_No = @Batch_No
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end

-- select * from _sis.Analyse_15Minutes_Stocks where Batch_No = @Batch_No order by Sno;
DECLARE @DurationMs int,@EndTime DATETIME;
SET @EndTime = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
PRINT 'Script ended at: ' + CONVERT(VARCHAR, @EndTime, 121);
set @DurationMs = DATEDIFF(MILLISECOND, @StartTime, @EndTime)
PRINT 'Duration (ms): ' + CAST(@DurationMs AS VARCHAR);
-- Break down into components
DECLARE @Hours INT = @DurationMs / 3600000;
DECLARE @Minutes INT = (@DurationMs % 3600000) / 60000;
DECLARE @Seconds INT = (@DurationMs % 60000) / 1000;
DECLARE @Milliseconds INT = @DurationMs % 1000;
-- Format as hh:mm:ss.mmm
PRINT 'Duration: ' + 
    RIGHT('00' + CAST(@Hours AS VARCHAR), 2) + ':' +
    RIGHT('00' + CAST(@Minutes AS VARCHAR), 2) + ':' +
    RIGHT('00' + CAST(@Seconds AS VARCHAR), 2) + '.' +
    RIGHT('000' + CAST(@Milliseconds AS VARCHAR), 3);
end
