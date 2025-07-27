begin -- update report queries 
DECLARE @StartTime DATETIME = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);

-- update the report Queries output in table
-- dbo.Analyse_Stocks,dbo.Master_Screen_Name_Values
---------------------------------------------------------------------------------------------------------------
declare @Batch_no bigint, @batch_num bigint
set @Batch_Num = 1
select @Batch_no = max(batch_no) from dbo.Analyse_Stocks;
---------------------------------------------------------------------------------------------------------------
begin -- bullish screen 
-- bullish single screen - child is up tick - timeframe is Yearly
update a set a.Bullish_Single_Screen_Yearly = 1
-- select *
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no -- (select max(batch_no) from dbo.Analyse_Stocks)
and Macd_Yearly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Above = 1
and Stochastic_Yearly_Crosses_Above = 1
and Ema_5_13_Yearly_Crosses_Above = 1
and Ema_13_26_Yearly_Crosses_Above = 1
and Ema_50_100_Yearly_Crosses_Above = 1
and Ema_100_200_Yearly_Crosses_Above = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is Quarterly
update a set a.Bullish_Double_Screen_Strong_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Above = 1 and Adx_Quarterly_Crosses_Above = 1
and Stochastic_Yearly_Crosses_Above = 1 and Stochastic_Quarterly_Crosses_Above = 1
and Ema_5_13_Yearly_Crosses_Above = 1 and Ema_5_13_Quarterly_Crosses_Above = 1
and Ema_13_26_Yearly_Crosses_Above = 1 and Ema_13_26_Quarterly_Crosses_Above = 1
and Ema_50_100_Yearly_Crosses_Above = 1 and Ema_50_100_Quarterly_Crosses_Above = 1
and Ema_100_200_Yearly_Crosses_Above = 1 and Ema_100_200_Quarterly_Crosses_Above = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is Quarterly
update a set a.Bullish_Double_Screen_Strong_Correction_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Above = 1 and Adx_Quarterly_Crosses_Below = 1
and Stochastic_Yearly_Crosses_Above = 1 and Stochastic_Quarterly_Crosses_Below = 1
and Ema_5_13_Yearly_Crosses_Above = 1 and Ema_5_13_Quarterly_Crosses_Below = 1
and Ema_13_26_Yearly_Crosses_Above = 1 and Ema_13_26_Quarterly_Crosses_Below = 1
and Ema_50_100_Yearly_Crosses_Above = 1 and Ema_50_100_Quarterly_Crosses_Below = 1
and Ema_100_200_Yearly_Crosses_Above = 1 and Ema_100_200_Quarterly_Crosses_Below = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
;
-- bullish Single screen - parent MACD is up tick and child all indicators is up tick - timeframe is Quarterly
update a set a.Bullish_Single_Screen_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Above = 1
and Stochastic_Quarterly_Crosses_Above = 1
and Ema_5_13_Quarterly_Crosses_Above = 1
and Ema_13_26_Quarterly_Crosses_Above = 1
and Ema_50_100_Quarterly_Crosses_Above = 1
and Ema_100_200_Quarterly_Crosses_Above = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is Monthly
update a set a.Bullish_Triple_Screen_Strong_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Above = 1 and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Above = 1
and Stochastic_Yearly_Crosses_Above = 1 and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Above = 1
and Ema_5_13_Yearly_Crosses_Above = 1 and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Above = 1
and Ema_13_26_Yearly_Crosses_Above = 1 and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Above = 1
and Ema_50_100_Yearly_Crosses_Above = 1 and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Above = 1
and Ema_100_200_Yearly_Crosses_Above = 1 and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Above = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is Monthly
update a set a.Bullish_Triple_Screen_Strong_Correction_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Above = 1 and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Below = 1
and Stochastic_Yearly_Crosses_Above = 1 and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Yearly_Crosses_Above = 1 and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Below = 1
and Ema_13_26_Yearly_Crosses_Above = 1 and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Yearly_Crosses_Above = 1 and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Below = 1
and Ema_100_200_Yearly_Crosses_Above = 1 and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Below = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is Monthly
update a set a.Bullish_Double_Screen_Strong_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Above = 1
and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Above = 1
and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Above = 1
and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Above = 1
and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Above = 1
and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Above = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is Monthly
update a set a.Bullish_Double_Screen_Strong_Correction_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Below = 1
and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Below = 1
and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Below = 1
and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Below = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is Monthly
update a set a.Bullish_Single_Screen_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Above = 1
and Stochastic_Monthly_Crosses_Above = 1
and Ema_5_13_Monthly_Crosses_Above = 1
and Ema_13_26_Monthly_Crosses_Above = 1
and Ema_50_100_Monthly_Crosses_Above = 1
and Ema_100_200_Monthly_Crosses_Above = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is weekly
update a set a.Bullish_Triple_Screen_Strong_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Above = 1
and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Above = 1
and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Above = 1
and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Above = 1
and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Above = 1
and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Above = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is Weekly
update a set a.Bullish_Triple_Screen_Strong_Correction_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Above = 1 and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Below = 1
and Stochastic_Quarterly_Crosses_Above = 1 and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Above = 1 and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Below = 1
and Ema_13_26_Quarterly_Crosses_Above = 1 and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Above = 1 and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Below = 1
and Ema_100_200_Quarterly_Crosses_Above = 1 and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Below = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is weekly
update a set a.Bullish_Double_Screen_Strong_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Above = 1
and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Above = 1
and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Above = 1
and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Above = 1
and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Above = 1
and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Above = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is Weekly
update a set a.Bullish_Double_Screen_Strong_Correction_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Below = 1
and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Below = 1
and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Below = 1
and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Below = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is weekly
update a set a.Bullish_Single_Screen_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Above = 1
and Stochastic_Weekly_Crosses_Above = 1
and Ema_5_13_Weekly_Crosses_Above = 1
and Ema_13_26_Weekly_Crosses_Above = 1
and Ema_50_100_Weekly_Crosses_Above = 1
and Ema_100_200_Weekly_Crosses_Above = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is daily
update a set a.Bullish_Triple_Screen_Strong_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Above = 1
and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Above = 1
and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Above = 1
and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Above = 1
and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Above = 1
and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Above = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is daily
update a set a.Bullish_Triple_Screen_Strong_Correction_Daily = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Above = 1 and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Below = 1
and Stochastic_Monthly_Crosses_Above = 1 and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Above = 1 and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Below = 1
and Ema_13_26_Monthly_Crosses_Above = 1 and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Above = 1 and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Below = 1
and Ema_100_200_Monthly_Crosses_Above = 1 and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Below = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is daily
update a set a.Bullish_Double_Screen_Strong_Daily = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Above = 1
and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Above = 1
and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Above = 1
and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Above = 1
and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Above = 1
and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Above = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is daily
update a set a.Bullish_Double_Screen_Strong_Correction_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Below = 1
and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Below = 1
and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Below = 1
and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Below = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is daily
update a set a.Bullish_Single_Screen_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Daily_Crosses_Above = 1
-- and Adx_Daily_Crosses_Above = 1
and Stochastic_Daily_Crosses_Above = 1
and Ema_5_13_Daily_Crosses_Above = 1
and Ema_13_26_Daily_Crosses_Above = 1
and Ema_50_100_Daily_Crosses_Above = 1
and Ema_100_200_Daily_Crosses_Above = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is 4 hourly
update a set a.Bullish_Triple_Screen_Strong_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Above = 1
and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Above = 1
and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1
and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1
and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1
and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is 4 hourly
update a set a.Bullish_Triple_Screen_Strong_Correction_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Above = 1 and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Below = 1
and Stochastic_Weekly_Crosses_Above = 1 and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Above = 1 and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1
and Ema_13_26_Weekly_Crosses_Above = 1 and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Above = 1 and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1
and Ema_100_200_Weekly_Crosses_Above = 1 and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is 4 hourly
update a set a.Bullish_Double_Screen_Strong_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Above = 1
and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Above = 1
and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1
and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1
and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1
and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is 4 hourly
update a set a.Bullish_Double_Screen_Strong_Correction_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Below = 1
and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1
and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1
and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is 4 hourly
update a set a.Bullish_Single_Screen_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Above = 1
and Stochastic_4_Hourly_Crosses_Above = 1
and Ema_5_13_4_Hourly_Crosses_Above = 1
and Ema_13_26_4_Hourly_Crosses_Above = 1
and Ema_50_100_4_Hourly_Crosses_Above = 1
and Ema_100_200_4_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is 1 hourly
update a set a.Bullish_Triple_Screen_Strong_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Above = 1
and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Above = 1
and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1
and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1
and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1
and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is 1 hourly
update a set a.Bullish_Triple_Screen_Strong_Correction_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Above = 1 and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Below = 1
and Stochastic_Daily_Crosses_Above = 1 and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Above = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1
and Ema_13_26_Daily_Crosses_Above = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Above = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1
and Ema_100_200_Daily_Crosses_Above = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- bullish double screen - and parent is up tick and child is up tick - timeframe is 1 hourly
update a set a.Bullish_Double_Screen_Strong_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Above = 1
and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Above = 1
and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1
and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1
and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1
and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- bullish double screen - and parent is up tick and child is down tick - timeframe is 1 hourly
update a set a.Bullish_Double_Screen_Strong_Correction_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Below = 1
and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Below = 1
and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1
and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1
and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1
and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is 1 hourly
update a set a.Bullish_Single_Screen_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_1_Hourly_Crosses_Above = 1
and Stochastic_1_Hourly_Crosses_Above = 1
and Ema_5_13_1_Hourly_Crosses_Above = 1
and Ema_13_26_1_Hourly_Crosses_Above = 1
and Ema_50_100_1_Hourly_Crosses_Above = 1
and Ema_100_200_1_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is up tick - timeframe is 15 Minutes
update a set a.Bullish_Triple_Screen_Strong_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Above = 1 and Adx_15_Minutes_Crosses_Above = 1
and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Above = 1 and Stochastic_15_Minutes_Crosses_Above = 1
and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1 and Ema_5_13_15_Minutes_Crosses_Above = 1
and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1 and Ema_13_26_15_Minutes_Crosses_Above = 1
and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1 and Ema_50_100_15_Minutes_Crosses_Above = 1
and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1 and Ema_100_200_15_Minutes_Crosses_Above = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- bullish triple screen - grandparent is up tick and parent is up tick and child is down tick - timeframe is 15 Minutes
update a set a.Bullish_Triple_Screen_Strong_Correction_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Above = 1 and Adx_1_Hourly_Crosses_Above = 1 and Adx_15_Minutes_Crosses_Below = 1
and Stochastic_4_Hourly_Crosses_Above = 1 and Stochastic_1_Hourly_Crosses_Above = 1 and Stochastic_15_Minutes_Crosses_Below = 1
and Ema_5_13_4_Hourly_Crosses_Above = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1 and Ema_5_13_15_Minutes_Crosses_Below = 1
and Ema_13_26_4_Hourly_Crosses_Above = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1 and Ema_13_26_15_Minutes_Crosses_Below = 1
and Ema_50_100_4_Hourly_Crosses_Above = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1 and Ema_50_100_15_Minutes_Crosses_Below = 1
and Ema_100_200_4_Hourly_Crosses_Above = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1 and Ema_100_200_15_Minutes_Crosses_Below = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is up tick - timeframe is 15 Minutes
update a set a.Bullish_Double_Screen_Strong_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_1_Hourly_Crosses_Above = 1 and Adx_15_Minutes_Crosses_Above = 1
and Stochastic_1_Hourly_Crosses_Above = 1 and Stochastic_15_Minutes_Crosses_Above = 1
and Ema_5_13_1_Hourly_Crosses_Above = 1 and Ema_5_13_15_Minutes_Crosses_Above = 1
and Ema_13_26_1_Hourly_Crosses_Above = 1 and Ema_13_26_15_Minutes_Crosses_Above = 1
and Ema_50_100_1_Hourly_Crosses_Above = 1 and Ema_50_100_15_Minutes_Crosses_Above = 1
and Ema_100_200_1_Hourly_Crosses_Above = 1 and Ema_100_200_15_Minutes_Crosses_Above = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- bullish double screen - parent is up tick and child is down tick - timeframe is 15 Minutes
update a set a.Bullish_Double_Screen_Strong_Correction_15_Minutes = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_1_Hourly_Crosses_Above = 1 and Adx_15_Minutes_Crosses_Below = 1
and Stochastic_1_Hourly_Crosses_Above = 1 and Stochastic_15_Minutes_Crosses_Below = 1
and Ema_5_13_1_Hourly_Crosses_Above = 1 and Ema_5_13_15_Minutes_Crosses_Below = 1
and Ema_13_26_1_Hourly_Crosses_Above = 1 and Ema_13_26_15_Minutes_Crosses_Below = 1
and Ema_50_100_1_Hourly_Crosses_Above = 1 and Ema_50_100_15_Minutes_Crosses_Below = 1
and Ema_100_200_1_Hourly_Crosses_Above = 1 and Ema_100_200_15_Minutes_Crosses_Below = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- bullish single screen - grandparent MACD is up tick and parent MACD is up tick and child all indicators is up tick - timeframe is 15 Minutes
update a set a.Bullish_Single_Screen_15_Minutes = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_15_Minutes_Crosses_Above = 1
and Stochastic_15_Minutes_Crosses_Above = 1
and Ema_5_13_15_Minutes_Crosses_Above = 1
and Ema_13_26_15_Minutes_Crosses_Above = 1
and Ema_50_100_15_Minutes_Crosses_Above = 1
and Ema_100_200_15_Minutes_Crosses_Above = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
;
--------------------------------------------------------------------------------------------------------------- 
end 
begin -- bearish screen 
-- Bearish single screen - child is down tick - timeframe is Yearly
update a set a.Bearish_Single_Screen_Yearly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Below = 1
and Stochastic_Yearly_Crosses_Below = 1
and Ema_5_13_Yearly_Crosses_Below = 1
and Ema_13_26_Yearly_Crosses_Below = 1
and Ema_50_100_Yearly_Crosses_Below = 1
and Ema_100_200_Yearly_Crosses_Below = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is Quarterly
update a set a.Bearish_Double_Screen_Strong_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Below = 1 and Rsi_Quarterly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Below = 1 -- and Adx_Quarterly_Crosses_Below = 1
and Stochastic_Yearly_Crosses_Below = 1 and Stochastic_Quarterly_Crosses_Below = 1
and Ema_5_13_Yearly_Crosses_Below = 1 and Ema_5_13_Quarterly_Crosses_Below = 1
and Ema_13_26_Yearly_Crosses_Below = 1 and Ema_13_26_Quarterly_Crosses_Below = 1
and Ema_50_100_Yearly_Crosses_Below = 1 and Ema_50_100_Quarterly_Crosses_Below = 1
and Ema_100_200_Yearly_Crosses_Below = 1 and Ema_100_200_Quarterly_Crosses_Below = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is Quarterly
update a set a.Bearish_Double_Screen_Strong_Correction_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Below = 1 and Rsi_Quarterly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Below = 1 -- and Adx_Quarterly_Crosses_Above = 1
and Stochastic_Yearly_Crosses_Below = 1 and Stochastic_Quarterly_Crosses_Above = 1
and Ema_5_13_Yearly_Crosses_Below = 1 and Ema_5_13_Quarterly_Crosses_Above = 1
and Ema_13_26_Yearly_Crosses_Below = 1 and Ema_13_26_Quarterly_Crosses_Above = 1
and Ema_50_100_Yearly_Crosses_Below = 1 and Ema_50_100_Quarterly_Crosses_Above = 1
and Ema_100_200_Yearly_Crosses_Below = 1 and Ema_100_200_Quarterly_Crosses_Above = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - parent MACD is down tick and child all indicator are down tick - timeframe is quarterly
update a set a.Bearish_Single_Screen_Quarterly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Below = 1
and Stochastic_Quarterly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Below = 1
and Ema_13_26_Quarterly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Below = 1
and Ema_100_200_Quarterly_Crosses_Below = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is Monthly
update a set a.Bearish_Triple_Screen_Strong_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Below = 1 and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Below = 1 -- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Below = 1
and Stochastic_Yearly_Crosses_Below = 1 and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Yearly_Crosses_Below = 1 and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Below = 1
and Ema_13_26_Yearly_Crosses_Below = 1 and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Yearly_Crosses_Below = 1 and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Below = 1
and Ema_100_200_Yearly_Crosses_Below = 1 and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Below = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is Monthly
update a set a.Bearish_Triple_Screen_Strong_Correction_Monthly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Below = 1 and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Below = 1 -- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Above = 1
and Stochastic_Yearly_Crosses_Below = 1 and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Above = 1
and Ema_5_13_Yearly_Crosses_Below = 1 and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Above = 1
and Ema_13_26_Yearly_Crosses_Below = 1 and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Above = 1
and Ema_50_100_Yearly_Crosses_Below = 1 and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Above = 1
and Ema_100_200_Yearly_Crosses_Below = 1 and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Above = 1
and Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is Monthly
update a set a.Bearish_Double_Screen_Strong_Monthly = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Below = 1
and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Below = 1
and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Below = 1
and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Below = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is Monthly
update a set a.Bearish_Double_Screen_Strong_Correction_Monthly = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Above = 1
and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Above = 1
and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Above = 1
and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Above = 1
and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Above = 1
and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Above = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is monthly
update a set a.Bearish_Single_Screen_Monthly = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Below = 1
and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Below = 1
and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Below = 1
and Ema_100_200_Monthly_Crosses_Below = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is Weekly
update a set a.Bearish_Triple_Screen_Strong_Weekly = 1 
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Below = 1
and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Below = 1
and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Below = 1
and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Below = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is Weekly
update a set a.Bearish_Triple_Screen_Strong_Correction_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Below = 1 and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Below = 1 -- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Above = 1
and Stochastic_Quarterly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Above = 1
and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Above = 1
and Ema_13_26_Quarterly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Above = 1
and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Above = 1
and Ema_100_200_Quarterly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Above = 1
and Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is Weekly
update a set a.Bearish_Double_Screen_Strong_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Below = 1
and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Below = 1
and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Below = 1
and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Below = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is Weekly
update a set a.Bearish_Double_Screen_Strong_Correction_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Above = 1
and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Above = 1
and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Above = 1
and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Above = 1
and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Above = 1
and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Above = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
;
-- Bearish single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is weekly
update a set a.Bearish_Single_Screen_Weekly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Quarterly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Below = 1
and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Below = 1
and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Below = 1
and Ema_100_200_Weekly_Crosses_Below = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is daily
update a set a.Bearish_Triple_Screen_Strong_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Below = 1
and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Below = 1
and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Below = 1
and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Below = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is daily
update a set a.Bearish_Triple_Screen_Strong_Correction_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Monthly_Crosses_Below = 1 and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Below = 1 -- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Above = 1
and Stochastic_Monthly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Above = 1
and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Above = 1
and Ema_13_26_Monthly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Above = 1
and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Above = 1
and Ema_100_200_Monthly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Above = 1
and Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is daily
update a set a.Bearish_Double_Screen_Strong_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Below = 1
and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Below = 1
and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Below = 1
and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Below = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is daily
update a set a.Bearish_Double_Screen_Strong_Correction_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Above = 1
and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Above = 1
and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Above = 1
and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Above = 1
and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Above = 1
and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Above = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is daily
update a set a.Bearish_Single_Screen_Daily = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Daily_Crosses_Below = 1
-- and Adx_Daily_Crosses_Below = 1
and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Below = 1
and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Below = 1
and Ema_100_200_Daily_Crosses_Below = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is 4 hourly
update a set a.Bearish_Triple_Screen_Strong_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Below = 1
and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1
and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1
and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is 4 hourly
update a set a.Bearish_Triple_Screen_Strong_Correction_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Above = 1
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Weekly_Crosses_Below = 1 and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Below = 1 -- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Above = 1
and Stochastic_Weekly_Crosses_Below = 1 and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Above = 1
and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1
and Ema_13_26_Weekly_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1
and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1
and Ema_100_200_Weekly_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is 4 hourly
update a set a.Bearish_Double_Screen_Strong_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Below = 1
and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1
and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1
and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is 4 hourly
update a set a.Bearish_Double_Screen_Strong_Correction_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Above = 1
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Above = 1
and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Above = 1
and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Above = 1
and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Above = 1
and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Above = 1
and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is 4 hourly
update a set a.Bearish_Single_Screen_4_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Below = 1
and Stochastic_4_Hourly_Crosses_Below = 1
and Ema_5_13_4_Hourly_Crosses_Below = 1
and Ema_13_26_4_Hourly_Crosses_Below = 1
and Ema_50_100_4_Hourly_Crosses_Below = 1
and Ema_100_200_4_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is 1 hourly
update a set a.Bearish_Triple_Screen_Strong_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Below = 1
and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1
and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1
and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is 1 hourly
update a set a.Bearish_Triple_Screen_Strong_Correction_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Below = 1 and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Below = 1 -- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Above = 1
and Stochastic_Daily_Crosses_Below = 1 and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Above = 1
and Ema_5_13_Daily_Crosses_Below = 1 and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1
and Ema_13_26_Daily_Crosses_Below = 1 and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1
and Ema_50_100_Daily_Crosses_Below = 1 and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1
and Ema_100_200_Daily_Crosses_Below = 1 and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is 1 hourly
update a set a.Bearish_Double_Screen_Strong_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Below = 1
and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Below = 1
and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1
and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1
and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1
and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is 1 hourly
update a set a.Bearish_Double_Screen_Strong_Correction_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Above = 1
and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Above = 1
and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Above = 1
and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Above = 1
and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Above = 1
and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Above = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is 1 hourly
update a set a.Bearish_Single_Screen_1_Hourly = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_Daily_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_1_Hourly_Crosses_Below = 1
and Stochastic_1_Hourly_Crosses_Below = 1
and Ema_5_13_1_Hourly_Crosses_Below = 1
and Ema_13_26_1_Hourly_Crosses_Below = 1
and Ema_50_100_1_Hourly_Crosses_Below = 1
and Ema_100_200_1_Hourly_Crosses_Below = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is down tick - timeframe is 15 minutes
update a set a.Bearish_Triple_Screen_Strong_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Below = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Below = 1 -- and Adx_15_Minutes_Crosses_Below = 1
and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Below = 1 and Stochastic_15_Minutes_Crosses_Below = 1
and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1 and Ema_5_13_15_Minutes_Crosses_Below = 1
and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1 and Ema_13_26_15_Minutes_Crosses_Below = 1
and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1 and Ema_50_100_15_Minutes_Crosses_Below = 1
and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1 and Ema_100_200_15_Minutes_Crosses_Below = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- Bearish triple screen - grandparent is down tick and parent is down tick and child is up tick - timeframe is 15 minutes
update a set a.Bearish_Triple_Screen_Strong_Correction_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Below = 1 and Rsi_1_Hourly_Crosses_Below = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Below = 1 -- and Adx_1_Hourly_Crosses_Below = 1 -- and Adx_15_Minutes_Crosses_Above = 1
and Stochastic_4_Hourly_Crosses_Below = 1 and Stochastic_1_Hourly_Crosses_Below = 1 and Stochastic_15_Minutes_Crosses_Above = 1
and Ema_5_13_4_Hourly_Crosses_Below = 1 and Ema_5_13_1_Hourly_Crosses_Below = 1 and Ema_5_13_15_Minutes_Crosses_Above = 1
and Ema_13_26_4_Hourly_Crosses_Below = 1 and Ema_13_26_1_Hourly_Crosses_Below = 1 and Ema_13_26_15_Minutes_Crosses_Above = 1
and Ema_50_100_4_Hourly_Crosses_Below = 1 and Ema_50_100_1_Hourly_Crosses_Below = 1 and Ema_50_100_15_Minutes_Crosses_Above = 1
and Ema_100_200_4_Hourly_Crosses_Below = 1 and Ema_100_200_1_Hourly_Crosses_Below = 1 and Ema_100_200_15_Minutes_Crosses_Above = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is down tick - timeframe is 15 minutes
update a set a.Bearish_Double_Screen_Strong_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_1_Hourly_Crosses_Below = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_1_Hourly_Crosses_Below = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_1_Hourly_Crosses_Below = 1 -- and Adx_15_Minutes_Crosses_Below = 1
and Stochastic_1_Hourly_Crosses_Below = 1 and Stochastic_15_Minutes_Crosses_Below = 1
and Ema_5_13_1_Hourly_Crosses_Below = 1 and Ema_5_13_15_Minutes_Crosses_Below = 1
and Ema_13_26_1_Hourly_Crosses_Below = 1 and Ema_13_26_15_Minutes_Crosses_Below = 1
and Ema_50_100_1_Hourly_Crosses_Below = 1 and Ema_50_100_15_Minutes_Crosses_Below = 1
and Ema_100_200_1_Hourly_Crosses_Below = 1 and Ema_100_200_15_Minutes_Crosses_Below = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
;
-- Bearish double screen - parent is down tick and child is up tick - timeframe is 15 minutes
update a set a.Bearish_Double_Screen_Strong_Correction_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_1_Hourly_Crosses_Below = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_1_Hourly_Crosses_Below = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_1_Hourly_Crosses_Below = 1 -- and Adx_15_Minutes_Crosses_Above = 1
and Stochastic_1_Hourly_Crosses_Below = 1 and Stochastic_15_Minutes_Crosses_Above = 1
and Ema_5_13_1_Hourly_Crosses_Below = 1 and Ema_5_13_15_Minutes_Crosses_Above = 1
and Ema_13_26_1_Hourly_Crosses_Below = 1 and Ema_13_26_15_Minutes_Crosses_Above = 1
and Ema_50_100_1_Hourly_Crosses_Below = 1 and Ema_50_100_15_Minutes_Crosses_Above = 1
and Ema_100_200_1_Hourly_Crosses_Below = 1 and Ema_100_200_15_Minutes_Crosses_Above = 1
and Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
and Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
and Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1 and Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
;
-- Bearish Single screen - grandparent MACD is down tick and parent MACD is down tick and child all indicator are down tick - timeframe is 15 minutes
update a set a.Bearish_Single_Screen_15_Minutes = 1
from dbo.Analyse_Stocks a
where 1=1 and Batch_No = @Batch_no
and Macd_15_Minutes_Crosses_Below = 1 and Macd_4_Hourly_Crosses_Below = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_15_Minutes_Crosses_Below = 1
and Stochastic_15_Minutes_Crosses_Below = 1
and Ema_5_13_15_Minutes_Crosses_Below = 1
and Ema_13_26_15_Minutes_Crosses_Below = 1
and Ema_50_100_15_Minutes_Crosses_Below = 1
and Ema_100_200_15_Minutes_Crosses_Below = 1
and Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
and Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1 and Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
;
--------------------------------------------------------------------------------------------------------------- 
end 
begin -- bullish -- Trade_Type and details

update a set 
 Trade_Type = isnull(Trade_Type,'')+'Bullish;'
,Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
         AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Monthly'
where a.Batch_No = @Batch_no and Bullish_Triple_Screen_Strong_Monthly > 0
;
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Weekly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Daily'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_4_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_1_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_15_Minutes'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_Monthly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_Weekly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_Daily'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_4_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_1_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Triple_Screen_Strong_Correction_15_Minutes'
where a.Batch_No = @Batch_no  and Bullish_Triple_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Quarterly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Monthly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Weekly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Daily'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_4_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_1_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_15_Minutes'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_Quarterly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_Monthly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_Weekly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_Daily'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_4_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_1_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Double_Screen_Strong_Correction_15_Minutes'
where a.Batch_No = @Batch_no  and Bullish_Double_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_Yearly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_Yearly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_Quarterly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_Monthly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_Weekly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_Daily'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_4_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_1_Hourly'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bullish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bullish_Sum = isnull(Trade_Type_Bullish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bullish_Single_Screen_15_Minutes'
where a.Batch_No = @Batch_no  and Bullish_Single_Screen_15_Minutes > 0
; 
---------------------------------------------------------------------------------------------------------------
end
begin -- bearish -- Trade_Type and details
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Monthly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Master_Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Weekly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Daily'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_4_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_1_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_15_Minutes'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_Monthly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_Weekly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_Daily'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_4_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_1_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Triple_Screen_Strong_Correction_15_Minutes'
where a.Batch_No = @Batch_no  and Bearish_Triple_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Quarterly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Monthly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Weekly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Daily'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_4_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_1_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_15_Minutes'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_Quarterly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_Monthly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_Weekly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_Daily'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_4_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_1_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Double_Screen_Strong_Correction_15_Minutes'
where a.Batch_No = @Batch_no  and Bearish_Double_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_Yearly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_Yearly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_Quarterly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_Quarterly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_Monthly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_Monthly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_Weekly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_Weekly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_Daily'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_Daily > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_4_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_4_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num
          AND v.Screen_Names = 'Bearish_Single_Screen_1_Hourly'
where a.Batch_No = @Batch_no  and Bearish_Single_Screen_1_Hourly > 0
; 
update a set 
Trade_Type = isnull(Trade_Type,'')+'Bearish;',
Trade_Type_Details = isnull(Trade_Type_Details,'') + v.Description + ';'
,Trade_Type_Details_Sum = isnull(Trade_Type_Details_Sum,0) + v.value
,Trade_Type_Bearish_Sum = isnull(Trade_Type_Bearish_Sum,0) + v.value
from dbo.Analyse_Stocks a JOIN dbo.Screen_Name_Values v ON v.Batch_No = @Batch_Num 
         AND v.Screen_Names = 'Bearish_Single_Screen_15_Minutes'
where a.Batch_No = @Batch_no and Bearish_Single_Screen_15_Minutes > 0
;
------------------------------------------------------------------------------------------------------------------------------------------------------------ 
end 
begin -- volume shockers 
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'yearly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_yearly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'quarterly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_quarterly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'monthly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_monthly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'weekly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_weekly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'daily;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_daily_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'4_hourly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_4_hourly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'1_hourly;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_1_hourly_shockers = 1
;
update a set 
Volume_Shockers = isnull(Volume_Shockers,'')+'15_minutes;'
from dbo.Analyse_Stocks a 
where a.Batch_No = @Batch_no and volume_15_minutes_shockers = 1
;
end
begin -- length of columns 
update a set a.Trade_Type_Length = len(Trade_Type)
from dbo.Analyse_Stocks a where Batch_No = @Batch_no;
update a set a.Trade_Type_Details_Length = len(Trade_Type_Details)
from dbo.Analyse_Stocks a where Batch_No = @Batch_no;
update a set Trading_View = case
when isnull(Trade_Type_Bullish_Sum,0) - isnull(Trade_Type_Bearish_Sum,0) > 0 then 'Bullish'
when isnull(Trade_Type_Bullish_Sum,0) - isnull(Trade_Type_Bearish_Sum,0) < 0 then 'Bearish'
else NULL end
from dbo.Analyse_Stocks a where Batch_No = @Batch_no;
update a set Trading_View_Order = (case when a.Trading_View = 'Bearish' then 1 else 0 end)
from dbo.Analyse_Stocks a where Batch_No = @Batch_no;
update a set Volume_Shockers_Sum = isnull(Volume_Shockers_Sum,0) +
(case when volume_yearly_shockers = 1 then 525600 else 0 end) +
(case when volume_quarterly_shockers = 1 then 131400 else 0 end)+
(case when volume_monthly_shockers = 1 then 43800 else 0 end)+
(case when volume_weekly_shockers = 1 then 10080 else 0 end)+
(case when volume_daily_shockers = 1 then 1440 else 0 end)+
(case when volume_4_hourly_shockers = 1 then 240 else 0 end)+
(case when volume_1_hourly_shockers = 1 then 60 else 0 end)+
(case when volume_15_minutes_shockers = 1 then 15 else 0 end)
from dbo.Analyse_Stocks a where Batch_No = @Batch_No;
;WITH RankedRows AS (
    select batch_no,sno,
	row_number() over (partition by Batch_No order by Batch_No desc, Trading_View_Order asc, Segments_Order desc, Volume_Shockers desc, Trade_Type_Details_Sum desc ) as report_sort_order
	from dbo.Analyse_Stocks
)
UPDATE a SET [Report Sort Order] = b.report_sort_order
FROM dbo.Analyse_Stocks a JOIN RankedRows b
ON a.Batch_No = b.Batch_No and a.sno = b.sno
where a.Batch_No = @Batch_No;
---------------------------------------------------------------------------------------------------------------
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
PRINT 'Script end at    : ' + CONVERT(VARCHAR, @EndTime, 121);
PRINT 'Duration (ms)    : ' + CAST(@DurationMs AS VARCHAR);
PRINT 'Duration         : ' + CAST(DATEADD(MILLISECOND, @DurationMs, '00:00:00.000') AS TIME) 
  --RIGHT('00' + CAST(@Hours AS VARCHAR), 2) + ':' +
  --RIGHT('00' + CAST(@Minutes AS VARCHAR), 2) + ':' +
  --RIGHT('00' + CAST(@Seconds AS VARCHAR), 2) + '.' +
  --RIGHT('000' + CAST(@Milliseconds AS VARCHAR), 3);
end

end
