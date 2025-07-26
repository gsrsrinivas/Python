begin -- reset script
DECLARE @StartTime DATETIME,@printstarttime varchar;
SET @StartTime = GETDATE();
SET @printstarttime = 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121)
RAISERROR(@printstarttime, 0, 1) WITH NOWAIT;

-- update all indicators to null values and calculate the reporting fields once again 
-- dbo.Cash_15Minutes_Stocks, dbo.Analyse_15Minutes_Stocks, dbo.Screen_Name_Values
---------------------------------------------------------------------------------------------------------------------------

begin -- length and sum column 
update a set [Segments - Length] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type - Length] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type Details - Length] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trading View] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type Details] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type Details - Sum] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type - Bullish Sum] = null from dbo.Analyse_15Minutes_Stocks a;
update a set [Trade Type - Bearish Sum] = null from dbo.Analyse_15Minutes_Stocks a;
end 
---------------------------------------------------------------------------------------------------------------------------

begin -- set all the indicators to null 
update a set Macd_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Macd_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Stochastic_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_5_13_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_13_26_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_50_100_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set Ema_100_200_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set ADX_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Yearly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Yearly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Quarterly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Quarterly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Monthly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Monthly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Weekly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Weekly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Daily_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_Daily_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_4_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_4_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_1_Hourly_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_1_Hourly_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_15_Minutes_Crosses_Above = null from dbo.Analyse_15Minutes_Stocks a;
update a set RSI_15_Minutes_Crosses_Below = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Volume_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_Yearly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_Yearly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_Quarterly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_Quarterly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_Monthly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_Monthly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_Weekly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_Weekly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_Daily_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_Daily_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_4_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_1_Hourly_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
update a set Adx_Down_Tick_15_Minutes_Less_Than_Equal_To = null from dbo.Analyse_15Minutes_Stocks a;
end 
---------------------------------------------------------------------------------------------------------------------------

begin -- set all screen values to null 
update a set a.Bullish_Single_Screen_Yearly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Triple_Screen_Strong_Correction_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Double_Screen_Strong_Correction_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bullish_Single_Screen_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_Yearly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_Quarterly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_Monthly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_Weekly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_Daily = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_4_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_1_Hourly = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Triple_Screen_Strong_Correction_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Double_Screen_Strong_Correction_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
update a set a.Bearish_Single_Screen_15_Minutes = null from dbo.Analyse_15Minutes_Stocks a;
 end 
---------------------------------------------------------------------------------------------------------------------------

begin -- update all the indicators 
update a set Macd_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Macd_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Macd_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Macd_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Stochastic_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Stochastic_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Stochastic_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Stochastic' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_5_13_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_5_13_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 5 13' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_13_26_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_13_26_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 13 26' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_50_100_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_50_100_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 50 100' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set Ema_100_200_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Ema_100_200_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'Ema 100 200' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set ADX_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set ADX_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as ADX_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'ADX' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_Yearly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Yearly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_Yearly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Yearly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_Quarterly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Quarterly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_Quarterly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Quarterly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_Monthly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Monthly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_Monthly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Monthly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_Weekly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Weekly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_Weekly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Weekly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_Daily_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Daily_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_Daily_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_Daily_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_4_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_4_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_4_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_4_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_1_Hourly_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_1_Hourly_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_1_Hourly_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_1_Hourly_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set RSI_15_Minutes_Crosses_Above = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_15_Minutes_Crosses_Above from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) b on b.symbol = a.Symbol
;
update a set RSI_15_Minutes_Crosses_Below = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as RSI_15_Minutes_Crosses_Below from dbo.Cash_15Minutes_Stocks where Indicator = 'RSI' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band3' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
;
update a set Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Upper Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Lower Bollinger Band2' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Volume_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Volume_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Volume' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_Yearly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Yearly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = 'Yearly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_Yearly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Yearly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = 'Yearly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_Quarterly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Quarterly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = 'Quarterly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_Quarterly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Quarterly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = 'Quarterly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_Monthly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Monthly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = 'Monthly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_Monthly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Monthly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = 'Monthly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_Weekly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Weekly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = 'Weekly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_Weekly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Weekly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = 'Weekly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_Daily_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Daily_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = 'Daily' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_Daily_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_Daily_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = 'Daily' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = '4 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_4_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_4_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = '4 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = '1 Hourly' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_1_Hourly_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_1_Hourly_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = '1 Hourly' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Up Tick' and TimeLine = '15 Minutes' and Direction = 'Greater Than Equal To'
) b on b.symbol = a.Symbol
;
update a set Adx_Down_Tick_15_Minutes_Less_Than_Equal_To = 1
from dbo.Analyse_15Minutes_Stocks a inner join (
select symbol, 1 as Adx_Up_Tick_15_Minutes_Less_Than_Equal_To from dbo.Cash_15Minutes_Stocks where Indicator = 'Adx Down Tick' and TimeLine = '15 Minutes' and Direction = 'Less Than Equal To'
) b on b.symbol = a.Symbol
;
end 
---------------------------------------------------------------------------------------------------------------------------

begin -- bullish - update the report Queries output in Analyse_15Minutes_Stocks 
-- **************************************************************
-- bullish single screen - child is up tick - timeframe is Yearly
update a set a.Bullish_Single_Screen_Yearly = 1
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Above = 1 -- and Adx_Quarterly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Above = 1 -- and Adx_Quarterly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Yearly_Crosses_Above = 1 -- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Yearly_Crosses_Above = 1 and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Yearly_Crosses_Above = 1 and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Yearly_Crosses_Above = 1 -- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Quarterly_Crosses_Above = 1 and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Above = 1 and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Quarterly_Crosses_Above = 1 -- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Monthly_Crosses_Above = 1 and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Monthly_Crosses_Above = 1 -- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Macd_Weekly_Crosses_Above = 1 and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Weekly_Crosses_Above = 1 and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Weekly_Crosses_Above = 1 -- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Monthly_Crosses_Above = 1 and Macd_Weekly_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_Daily_Crosses_Above = 1 and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_Daily_Crosses_Above = 1 and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_Daily_Crosses_Above = 1 -- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Above = 1 -- and Adx_15_Minutes_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_4_Hourly_Crosses_Above = 1 and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_4_Hourly_Crosses_Above = 1 and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_4_Hourly_Crosses_Above = 1 -- and Adx_1_Hourly_Crosses_Above = 1 -- and Adx_15_Minutes_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Above = 1
and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Above = 1
-- and Adx_1_Hourly_Crosses_Above = 1 -- and Adx_15_Minutes_Crosses_Above = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
and Macd_1_Hourly_Crosses_Above = 1 and Macd_15_Minutes_Crosses_Below = 1
and Rsi_1_Hourly_Crosses_Above = 1 and Rsi_15_Minutes_Crosses_Below = 1
-- and Adx_1_Hourly_Crosses_Above = 1 -- and Adx_15_Minutes_Crosses_Below = 1
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
end 
---------------------------------------------------------------------------------------------------------------------------

begin -- bearish - update the report Queries output in Analyse_15Minutes_Stocks 
-- Bearish single screen - child is down tick - timeframe is Yearly
update a set a.Bearish_Single_Screen_Yearly = 1
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
from dbo.Analyse_15Minutes_Stocks a
-- select * from dbo.Analyse_15Minutes_Stocks
where 1=1 
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
end 
---------------------------------------------------------------------------------------------------------------------------

declare @Batch_Num int
set @Batch_Num = 1

begin -- bullish -- trade type and details 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value 
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND 
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Monthly' 
where 1=1       and Bullish_Triple_Screen_Strong_Monthly > 0
;
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Weekly'
where 1=1       and Bullish_Triple_Screen_Strong_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Daily'
where 1=1       and Bullish_Triple_Screen_Strong_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_4_Hourly'
where 1=1       and Bullish_Triple_Screen_Strong_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_1_Hourly'
where 1=1       and Bullish_Triple_Screen_Strong_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_15_Minutes'
where 1=1       and Bullish_Triple_Screen_Strong_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_Monthly'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_Weekly'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_Daily'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_4_Hourly'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_1_Hourly'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND    
v.[Screen Names] = 'Bullish_Triple_Screen_Strong_Correction_15_Minutes'
where 1=1       and Bullish_Triple_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
 v.[Screen Names] = 'Bullish_Double_Screen_Strong_Quarterly'
where 1=1       and Bullish_Double_Screen_Strong_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Monthly'
where 1=1       and Bullish_Double_Screen_Strong_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Weekly'
where 1=1       and Bullish_Double_Screen_Strong_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Daily'
where 1=1       and Bullish_Double_Screen_Strong_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_4_Hourly'
where 1=1       and Bullish_Double_Screen_Strong_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_1_Hourly'
where 1=1       and Bullish_Double_Screen_Strong_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_15_Minutes'
where 1=1       and Bullish_Double_Screen_Strong_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_Quarterly'
where 1=1       and Bullish_Double_Screen_Strong_Correction_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_Monthly'
where 1=1       and Bullish_Double_Screen_Strong_Correction_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_Weekly'
where 1=1       and Bullish_Double_Screen_Strong_Correction_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_Daily'
where 1=1       and Bullish_Double_Screen_Strong_Correction_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_4_Hourly'
where 1=1       and Bullish_Double_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_1_Hourly'
where 1=1       and Bullish_Double_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Double_Screen_Strong_Correction_15_Minutes'
where 1=1       and Bullish_Double_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_Yearly'
where 1=1       and Bullish_Single_Screen_Yearly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_Quarterly'
where 1=1       and Bullish_Single_Screen_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_Monthly'
where 1=1       and Bullish_Single_Screen_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_Weekly'
where 1=1       and Bullish_Single_Screen_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_Daily'
where 1=1       and Bullish_Single_Screen_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_4_Hourly'
where 1=1       and Bullish_Single_Screen_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_1_Hourly'
where 1=1       and Bullish_Single_Screen_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bullish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bullish Sum] = isnull([Trade Type - Bullish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bullish_Single_Screen_15_Minutes'
where 1=1       and Bullish_Single_Screen_15_Minutes > 0
; 
end
begin -- bearish -- trade type and details 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Monthly'
where 1=1       and Bearish_Triple_Screen_Strong_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Weekly'
where 1=1       and Bearish_Triple_Screen_Strong_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Daily'
where 1=1       and Bearish_Triple_Screen_Strong_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_4_Hourly'
where 1=1       and Bearish_Triple_Screen_Strong_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_1_Hourly'
where 1=1       and Bearish_Triple_Screen_Strong_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_15_Minutes'
where 1=1       and Bearish_Triple_Screen_Strong_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_Monthly'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_Weekly'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_Daily'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_4_Hourly'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_1_Hourly'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Triple_Screen_Strong_Correction_15_Minutes'
where 1=1       and Bearish_Triple_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Quarterly'
where 1=1       and Bearish_Double_Screen_Strong_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Monthly'
where 1=1       and Bearish_Double_Screen_Strong_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Weekly'
where 1=1       and Bearish_Double_Screen_Strong_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Daily'
where 1=1       and Bearish_Double_Screen_Strong_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_4_Hourly'
where 1=1       and Bearish_Double_Screen_Strong_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_1_Hourly'
where 1=1       and Bearish_Double_Screen_Strong_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_15_Minutes'
where 1=1       and Bearish_Double_Screen_Strong_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_Quarterly'
where 1=1       and Bearish_Double_Screen_Strong_Correction_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_Monthly'
where 1=1       and Bearish_Double_Screen_Strong_Correction_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_Weekly'
where 1=1       and Bearish_Double_Screen_Strong_Correction_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_Daily'
where 1=1       and Bearish_Double_Screen_Strong_Correction_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_4_Hourly'
where 1=1       and Bearish_Double_Screen_Strong_Correction_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_1_Hourly'
where 1=1       and Bearish_Double_Screen_Strong_Correction_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Double_Screen_Strong_Correction_15_Minutes'
where 1=1       and Bearish_Double_Screen_Strong_Correction_15_Minutes > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_Yearly'
where 1=1       and Bearish_Single_Screen_Yearly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_Quarterly'
where 1=1       and Bearish_Single_Screen_Quarterly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_Monthly'
where 1=1       and Bearish_Single_Screen_Monthly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_Weekly'
where 1=1       and Bearish_Single_Screen_Weekly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_Daily'
where 1=1       and Bearish_Single_Screen_Daily > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_4_Hourly'
where 1=1       and Bearish_Single_Screen_4_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND  
v.[Screen Names] = 'Bearish_Single_Screen_1_Hourly'
where 1=1       and Bearish_Single_Screen_1_Hourly > 0
; 
update a set 
[Trade Type] = isnull([Trade Type],'')+'Bearish;',
[Trade Type Details] = isnull([Trade Type Details],'') + v.Description + ';'
,[Trade Type Details - Sum] = isnull([Trade Type Details - Sum],0) + v.value
,[Trade Type - Bearish Sum] = isnull([Trade Type - Bearish Sum],0) + v.value 
from dbo.Analyse_15Minutes_Stocks a JOIN dbo.[Screen_Name_Values] v ON v.Batch_No = @Batch_Num AND   
v.[Screen Names] = 'Bearish_Single_Screen_15_Minutes'
where 1=1       and Bearish_Single_Screen_15_Minutes > 0
;
end 
---------------------------------------------------------------------------------------------------------------------------

begin -- lenth of trade type and details 
update a set [Trade Type - Length] = len([Trade Type]) from dbo.Analyse_15Minutes_Stocks a
;
update a set [Trade Type Details - Length] = len([Trade Type Details]) from dbo.Analyse_15Minutes_Stocks a
;
update a set [Segments - Length] = len(a.Segments) from dbo.Analyse_15Minutes_Stocks a
;
update a set [Trading View] = case 
when isnull([Trade Type - Bullish Sum],0) - isnull([Trade Type - Bearish Sum],0) > 0 then 'Bullish' 
when isnull([Trade Type - Bullish Sum],0) - isnull([Trade Type - Bearish Sum],0) < 0 then 'Bearish' 
else NULL end
from dbo.Analyse_15Minutes_Stocks a
;
update a set [Trading View - Order] = (case when a.[Trading View] = 'Bearish' then 1 else 0 end)
from dbo.Analyse_15Minutes_Stocks a
;
update a set [Volume_Shockers - Sum] = isnull([Volume_Shockers - Sum],0) + 
(case when volume__yearly__shockers = 1 then 525600 else 0 end) +
(case when volume__quarterly__shockers = 1 then 131400 else 0 end)+
(case when volume__monthly__shockers = 1 then 43800 else 0 end)+
(case when volume__weekly__shockers = 1 then 10080 else 0 end)+
(case when volume__daily__shockers = 1 then 1440 else 0 end)+
(case when volume__4_hourly__shockers = 1 then 240 else 0 end)+
(case when volume__1_hourly__shockers = 1 then 60 else 0 end)+
(case when volume__15_minutes__shockers = 1 then 15 else 0 end)
from dbo.Analyse_15Minutes_Stocks a
;
;WITH RankedRows AS (
    select batch_no,sno,
	row_number() over (partition by Batch_No order by Batch_No desc, [Trading View - Order] asc, [Segments - Order] desc, [Volume_Shockers] desc, [Trade Type Details - Sum] desc ) as report_sort_order
	from dbo.Analyse_15Minutes_Stocks
)
UPDATE a SET [Report Sort Order] = b.report_sort_order
FROM dbo.Analyse_15Minutes_Stocks a JOIN RankedRows b
ON a.Batch_No = b.Batch_No and a.sno = b.sno
;
end 
---------------------------------------------------------------------------------------------------------------------------
DECLARE @DurationMs int,@EndTime DATETIME;
SET @EndTime = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);
PRINT 'Script ended at: ' + CONVERT(VARCHAR, @EndTime, 121);
set @DurationMs = DATEDIFF(MILLISECOND, @StartTime, @EndTime);
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
