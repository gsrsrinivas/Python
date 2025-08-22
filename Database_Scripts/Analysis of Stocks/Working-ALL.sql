begin transaction
-- all the running queries are stored  

begin
select 1
/*'screen explanation 
-- trend indication explanation
------------------------------------------------------------------------------------------------------------------------------------------------------
begin -- bullish screen 
-- Bullish_Single_Screen_Yearly                       ;                                  child all indicators are up tick - period Yearly 
-- Bullish_Single_Screen_Quarterly                    ;             parent MACD up tick, child all indicators are up tick - period Quarterly
-- Bullish_Single_Screen_Monthly                      ; grandparent,parent MACD up tick, child all indicators are up tick - period Monthly
-- Bullish_Single_Screen_Weekly                       ; grandparent,parent MACD up tick, child all indicators are up tick - period weekly
-- Bullish_Single_Screen_Daily                        ; grandparent,parent MACD up tick, child all indicators are up tick - period daily
-- Bullish_Single_Screen_4_Hourly                     ; grandparent,parent MACD up tick, child all indicators are up tick - period 4 hourly
-- Bullish_Single_Screen_15_Minutes                   ; grandparent,parent MACD up tick, child all indicators are up tick - period 15 Minutes
-- Bullish_Single_Screen_1_Hourly                     ; grandparent,parent MACD up tick, child all indicators are up tick - period 1 hourly

-- Bullish_Double_Screen_Strong_Quarterly             ; parent,child up tick - period Quarterly
-- Bullish_Double_Screen_Strong_Monthly               ; parent,child up tick - period Monthly
-- Bullish_Double_Screen_Strong_Weekly                ; parent,child up tick - period weekly
-- Bullish_Double_Screen_Strong_Daily                 ; parent,child up tick - period daily
-- Bullish_Double_Screen_Strong_4_Hourly              ; parent,child up tick - period 4 hourly
-- Bullish_Double_Screen_Strong_1_Hourly              ; parent,child up tick - period 1 hourly
-- Bullish_Double_Screen_Strong_15_Minutes            ; parent,child up tick - period 15 Minutes

-- Bullish_Double_Screen_Strong_Correction_Quarterly  ; parent up tick, child down tick - period Quarterly
-- Bullish_Double_Screen_Strong_Correction_Monthly    ; parent up tick, child down tick - period Monthly
-- Bullish_Double_Screen_Strong_Correction_Weekly     ; parent up tick, child down tick - period Weekly
-- Bullish_Double_Screen_Strong_Correction_Daily      ; parent up tick, child down tick - period daily
-- Bullish_Double_Screen_Strong_Correction_4_Hourly   ; parent up tick, child down tick - period 4 hourly
-- Bullish_Double_Screen_Strong_Correction_1_Hourly   ; parent up tick, child down tick - period 1 hourly
-- Bullish_Double_Screen_Strong_Correction_15_Minutes ; parent up tick, child down tick - period 15 Minutes

-- Bullish_Triple_Screen_Strong_Weekly                ; grandparent,parent,child up tick - period weekly
-- Bullish_Triple_Screen_Strong_Daily                 ; grandparent,parent,child up tick - period daily
-- Bullish_Triple_Screen_Strong_4_Hourly              ; grandparent,parent,child up tick - period 4 hourly
-- Bullish_Triple_Screen_Strong_1_Hourly              ; grandparent,parent,child up tick - period 1 hourly
-- Bullish_Triple_Screen_Strong_15_Minutes            ; grandparent,parent,child up tick - period 15 Minutes

-- Bullish_Triple_Screen_Strong_Correction_Weekly     ; grandparent,parent up tick, child down tick - period Weekly
-- Bullish_Triple_Screen_Strong_Correction_Daily      ; grandparent,parent up tick, child down tick - period daily
-- Bullish_Triple_Screen_Strong_Correction_4_Hourly   ; grandparent,parent up tick, child down tick - period 4 hourly
-- Bullish_Triple_Screen_Strong_Correction_1_Hourly   ; grandparent,parent up tick, child down tick - period 1 hourly
-- Bullish_Triple_Screen_Strong_Correction_15_Minutes ; grandparent,parent up tick, child down tick - period 15 Minutes
end
-------------------------------------------------------------------------------------------------------------------------------------------------------

begin -- bearish screen
-- Bearish_Single_Screen_Yearly                       ;                                     child all indicators are down tick - period Yearly
-- Bearish_Single_Screen_Quarterly                    ;              parent MACD down tick, child all indicators are down tick - period quarterly
-- Bearish_Single_Screen_Monthly                      ; grandparent, parent MACD down tick, child all indicators are down tick - period monthly
-- Bearish_Single_Screen_Weekly                       ; grandparent, parent MACD down tick, child all indicators are down tick - period weekly
-- Bearish_Single_Screen_Daily                        ; grandparent, parent MACD down tick, child all indicators are down tick - period daily
-- Bearish_Single_Screen_4_Hourly                     ; grandparent, parent MACD down tick, child all indicators are down tick - period 4 hourly
-- Bearish_Single_Screen_1_Hourly                     ; grandparent, parent MACD down tick, child all indicators are down tick - period 1 hourly
-- Bearish_Single_Screen_15_Minutes                   ; grandparent, parent MACD down tick, child all indicators are down tick - period 15 minutes

-- Bearish_Double_Screen_Strong_Quarterly             ; parent,child down tick - period Quarterly
-- Bearish_Double_Screen_Strong_Monthly               ; parent,child down tick - period Monthly
-- Bearish_Double_Screen_Strong_Weekly                ; parent,child down tick - period Weekly
-- Bearish_Double_Screen_Strong_Daily                 ; parent,child down tick - period daily
-- Bearish_Double_Screen_Strong_4_Hourly              ; parent,child down tick - period 4 hourly
-- Bearish_Double_Screen_Strong_1_Hourly              ; parent,child down tick - period 1 hourly
-- Bearish_Double_Screen_Strong_15_Minutes            ; parent,child down tick - period 15 minutes

-- Bearish_Double_Screen_Strong_Correction_Quarterly  ; parent down tick, child up tick - period Quarterly
-- Bearish_Double_Screen_Strong_Correction_Monthly    ; parent down tick, child up tick - period Monthly
-- Bearish_Double_Screen_Strong_Correction_Weekly     ; parent down tick, child up tick - period Weekly
-- Bearish_Double_Screen_Strong_Correction_Daily      ; parent down tick, child up tick - period daily
-- Bearish_Double_Screen_Strong_Correction_4_Hourly   ; parent down tick, child up tick - period 4 hourly
-- Bearish_Double_Screen_Strong_Correction_1_Hourly   ; parent down tick, child up tick - period 1 hourly
-- Bearish_Double_Screen_Strong_Correction_15_Minutes ; parent down tick, child up tick - period 15 minutes

-- Bearish_Triple_Screen_Strong_Monthly               ; grandparent,parent,child down tick - period Monthly
-- Bearish_Triple_Screen_Strong_Weekly                ; grandparent,parent,child down tick - period Weekly
-- Bearish_Triple_Screen_Strong_Daily                 ; grandparent,parent,child down tick - period daily
-- Bearish_Triple_Screen_Strong_4_Hourly              ; grandparent,parent,child down tick - period 4 hourly
-- Bearish_Triple_Screen_Strong_1_Hourly              ; grandparent,parent,child down tick - period 1 hourly
-- Bearish_Triple_Screen_Strong_15_Minutes            ; grandparent,parent,child down tick - period 15 minutes

-- Bearish_Triple_Screen_Strong_Correction_Monthly    ; grandparent,parent down tick, child up tick - period Monthly
-- Bearish_Triple_Screen_Strong_Correction_Weekly     ; grandparent,parent down tick, child up tick - period Weekly
-- Bearish_Triple_Screen_Strong_Correction_Daily      ; grandparent,parent down tick, child up tick - period daily
-- Bearish_Triple_Screen_Strong_Correction_4_Hourly   ; grandparent,parent down tick, child up tick - period 4 hourly
-- Bearish_Triple_Screen_Strong_Correction_1_Hourly   ; grandparent,parent down tick, child up tick - period 1 hourly
-- Bearish_Triple_Screen_Strong_Correction_15_Minutes ; grandparent,parent down tick, child up tick - period 15 minutes
end 
------------------------------------------------------------------------------------------------------------------------------------------------------
 ' */
end

begin
-- shrink databases -- shrink database log file
	USE Stocks_Analysis;
	ALTER DATABASE Stocks_Analysis SET RECOVERY SIMPLE;
	DBCC SHRINKFILE (Stocks_Analysis_log, 1); -- Shrinks to 1MB
        
	USE Stocks_db;
	ALTER DATABASE Stocks_db SET RECOVERY SIMPLE;
	DBCC SHRINKFILE (Stocks_db_log, 1); -- Shrinks to 1MB
end

begin
-- C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\
DECLARE @Batch_No INT
SELECT @Batch_No = MAX(Batch_No) FROM Stocks_Analysis.dbo.Analyse_Stocks;

-- Step 1: Create a temp table to hold all MACD crosses
SELECT 
    cs.Symbol,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Yearly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_Yearly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Yearly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_Yearly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Quarterly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_Quarterly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Quarterly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_Quarterly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Monthly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_Monthly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Monthly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_Monthly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Weekly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_Weekly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Weekly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_Weekly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Daily' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_Daily_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = 'Daily' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_Daily_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '4 Hourly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_4_Hourly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '4 Hourly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_4_Hourly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '1 Hourly' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_1_Hourly_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '1 Hourly' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_1_Hourly_Crosses_Below,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '15 Minutes' AND Direction = 'Crosses Above' THEN 1 ELSE 0 END AS Macd_15_Minutes_Crosses_Above,
    CASE WHEN Indicator = 'Macd' AND TimeLine = '15 Minutes' AND Direction = 'Crosses Below' THEN 1 ELSE 0 END AS Macd_15_Minutes_Crosses_Below
INTO #MacdIndicators
FROM Stocks_Analysis.dbo.Cash_Stocks cs;

-- Step 2: Update Analyse_Stocks in a single pass
UPDATE a
SET 
    Macd_Yearly_Crosses_Above = b.Macd_Yearly_Crosses_Above,
    Macd_Yearly_Crosses_Below = b.Macd_Yearly_Crosses_Below,
    Macd_Quarterly_Crosses_Above = b.Macd_Quarterly_Crosses_Above,
    Macd_Quarterly_Crosses_Below = b.Macd_Quarterly_Crosses_Below,
    Macd_Monthly_Crosses_Above = b.Macd_Monthly_Crosses_Above,
    Macd_Monthly_Crosses_Below = b.Macd_Monthly_Crosses_Below,
    Macd_Weekly_Crosses_Above = b.Macd_Weekly_Crosses_Above,
    Macd_Weekly_Crosses_Below = b.Macd_Weekly_Crosses_Below,
    Macd_Daily_Crosses_Above = b.Macd_Daily_Crosses_Above,
    Macd_Daily_Crosses_Below = b.Macd_Daily_Crosses_Below,
    Macd_4_Hourly_Crosses_Above = b.Macd_4_Hourly_Crosses_Above,
    Macd_4_Hourly_Crosses_Below = b.Macd_4_Hourly_Crosses_Below,
    Macd_1_Hourly_Crosses_Above = b.Macd_1_Hourly_Crosses_Above,
    Macd_1_Hourly_Crosses_Below = b.Macd_1_Hourly_Crosses_Below,
    Macd_15_Minutes_Crosses_Above = b.Macd_15_Minutes_Crosses_Above,
    Macd_15_Minutes_Crosses_Below = b.Macd_15_Minutes_Crosses_Below
FROM Stocks_Analysis.dbo.Analyse_Stocks a
INNER JOIN #MacdIndicators b ON a.Symbol = b.Symbol
WHERE a.Batch_No = @Batch_no;

-- Cleanup
-- remove the table #MacdIndicators 

select Batch_No, Created_Date, trade_view, Trade_View_Order, Segments, Segments_Order, Other_Setups, Volume_Shockers_Sum, Trade_Type_Details, Trade_Type_Details_Sum, Industry, Stock_Name, Symbol, Percent_Change, Price, Volume, Series, Trade_Type, Trade_Type_Length, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type_Details_Length, Segments_Length, Segments_Sum, price_action, ISIN_Code, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers, Report_Sort_Order
into Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_temp
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks

EXEC sp_rename 'Stocks_Analysis.dbo.Analyse_15Minutes_Stocks', 'Analyse_15Minutes_Stocks_Old12';

------------------------------------------------------------------------------------------------------------------------------
-- insert into Stocks_Analysis.dbo.Analyse_Stocks_New (Batch_No, Created_Date, Symbol, trade_view, Trade_View_Order, Segments, Segments_Order, Other_Setups, Volume_Shockers_Sum, Trade_Type_Details, Trade_Type_Details_Sum, Industry, Stock_Name, Percent_Change, Price, Volume, Series, Trade_Type, Trade_Type_Length, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type_Details_Length, Segments_Length, Segments_Sum, price_action, ISIN_Code, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers, Report_Sort_Order )
select Batch_No, Created_Date, Symbol, trade_view, Trade_View_Order, Segments, Segments_Order, Other_Setups, Volume_Shockers_Sum, Trade_Type_Details, Trade_Type_Details_Sum, Industry, Stock_Name, Percent_Change, Price, Volume, Series, Trade_Type, Trade_Type_Length, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type_Details_Length, Segments_Length, Segments_Sum, price_action, ISIN_Code, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers, Report_Sort_Order
from Stocks_Analysis.dbo.Analyse_Stocks
order by Batch_No, Created_Date, Report_Sort_Order
;
EXEC sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks_Analysis.dbo.Analyse_Stocks_old12', 'Analyse_Stocks_old12';
;
------------------------------------------------------------------------------------------------------------------------------
-- all the query are stored for future use --
use Stocks_Analysis;
------------------------------------------------------------------------------------------------------------------------------
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_v 
order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
;
select * from Stocks_Analysis.dbo.Analyse_Stocks_v 
order by trade_view desc,Trade_Type_Details_Sum desc
;
------------------------------------------------------------------------------------------------------------------------------
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_v 
order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
;
select * from Stocks_Analysis.dbo.Analyse_Stocks_v 
order by trade_view desc,Trade_Type_Details_Sum desc
;
------------------------------------------------------------------------------------------------------------------------------
select Batch_No, trade_view,segments,Trade_Type_Details,Segments, Symbol, Percent_Change, Price, Volume
,rn,Stock_Name, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type, Trade_Type_Length, Segments_Length, Trade_Type_Details_Length, Created_Date

from (
	select row_number() over(partition by Batch_No, trade_view,Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn,
	Sno, Batch_No, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Segments_Length, trade_view, Trade_Type, Trade_Type_Length, replace(Trade_Type_Details,';',';'+char(13)+char(10)) as 'Trade-Type-Details',Trade_Type_Details, Trade_Type_Details_Length, Created_Date, Stock_Name,replace(Segments,';',';' + char(13)+ char(10))as segment, Segments, Symbol, Percent_Change, Price, Volume

	--from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
	 from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)	 	
	and Segments_Length > 5 and Trade_Type_Details_Sum > 10 and Segments_Length > 25 and volume >1000
	--and Symbol in ('BSE','ARE&M','AXISBANK','COALINDIA','HAL','IREDA','OLAELEC','RELIANCE','SHREEGANES-X','SWSOLAR','TVSSCS','VBL','NIFTY50-INDEX','DEEPAKNTR','DLF','MUKTAARTS','WEBELSOLAR','COLPAL','REDINGTON','BHARATFORG','MUTHOOTFIN')
) a where rn = 1
order by trade_view desc,Trade_Type_Details_Sum desc,volume desc,Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
;
------------------------------------------------------------------------------------------------------------------------------
select Batch_No, trade_view,Trade_Type_Details,Segments, Symbol, Percent_Change, Price, Volume
,rn,Stock_Name, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type, Trade_Type_Length, Segments_Length, Trade_Type_Details_Length, Created_Date
from (
	select row_number() over(partition by Batch_No, trade_view, Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn,
	Sno, Batch_No, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Segments_Length, trade_view, Trade_Type, Trade_Type_Length, Trade_Type_Details, Trade_Type_Details_Length, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume
	from 
	Stocks_Analysis.dbo.Analyse_Stocks 
	-- Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
	where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks) 
	and Segments_Length > 5 and Trade_Type_Details_Sum > 10 and Segments_Length > 25 and volume >10000
) a where rn = 1
order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
;
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
select * from Stocks_Analysis.dbo.Analyse_Stocks_v;
select * from Stocks_Analysis.dbo.Master_Segments;
select * 
from 
(select distinct symbol,STRING_AGG(Segments,'; ') as Segments from 
( select distinct symbol,segments from Stocks_Analysis.dbo.Analyse_Stocks ) a
group by symbol) a
;

select segments,count(1) from Stocks_Analysis.dbo.Analyse_Stocks group by segments; ;
select distinct symbol from Stocks_Analysis.dbo.Analyse_Stocks where Segments = 'cash' ;
select distinct symbol from Stocks_Analysis.dbo.Cash_Stocks;
select distinct symbol from Stocks_Analysis.dbo.Analyse_Stocks where lower(Segments) = 'cash';
select * from Stocks_Analysis.dbo.Master_Segments;
------------------------------------------------------------------------------------------------------------------------------
--
select * 
-- update a set Stock_Name = b.stock_name
from Stocks_Analysis.dbo.master_segments a
inner join Stocks_Analysis.dbo.Cash_Stocks b
on a.symbol = b.symbol
;
select  distinct b.stock_name,a.*
from Stocks_Analysis.dbo.master_segments a
inner join Stocks_Analysis.dbo.Cash_Stocks b
on a.symbol = b.symbol
;

select a.*,b.Macd_Yearly_Crosses_Above
from Stocks_Analysis.dbo.master_segments a
left join (select symbol, 1 as Macd_Yearly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks 
where Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) b on a.Symbol = b.symbol
;
select a.*,m1.Macd_Yearly_Crosses_Above,m2.Macd_Yearly_Crosses_Below,m3.Macd_Quarterly_Crosses_Above,m4.Macd_Quarterly_Crosses_Above,m5.Macd_Monthly_Crosses_Above,m6.Macd_Monthly_Crosses_Above,m7.Macd_Weekly_Crosses_Above,m8.Macd_Weekly_Crosses_Above,m9.Macd_Daily_Crosses_Above,m10.Macd_Daily_Crosses_Above,m11.Macd_4Hourly_Crosses_Above,m12.Macd_4Hourly_Crosses_Above,m13.Macd_1Hourly_Crosses_Above,m14.Macd_1Hourly_Crosses_Above,m15.Macd_15Minutes_Crosses_Above,m16.Macd_15Minutes_Crosses_Above
from Stocks_Analysis.dbo.master_segments a
left join (select symbol, 1 as Macd_Yearly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Above'
) m1 on m1.symbol = a.Symbol
left join (select symbol, 1 as Macd_Yearly_Crosses_Below from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Yearly' and Direction = 'Crosses Below'
) m2 on m2.symbol = a.Symbol
left join (select symbol, 1 as Macd_Quarterly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Above'
) m3 on m3.symbol = a.Symbol
left join (select symbol, 1 as Macd_Quarterly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Quarterly' and Direction = 'Crosses Below'
) m4 on m4.symbol = a.Symbol
left join (select symbol, 1 as Macd_Monthly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Above'
) m5 on m5.symbol = a.Symbol
left join (select symbol, 1 as Macd_Monthly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Monthly' and Direction = 'Crosses Below'
) m6 on m6.symbol = a.Symbol
left join (select symbol, 1 as Macd_Weekly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Above'
) m7 on m7.symbol = a.Symbol
left join (select symbol, 1 as Macd_Weekly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Weekly' and Direction = 'Crosses Below'
) m8 on m8.symbol = a.Symbol
left join (select symbol, 1 as Macd_Daily_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Above'
) m9 on m9.symbol = a.Symbol
left join (select symbol, 1 as Macd_Daily_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = 'Daily' and Direction = 'Crosses Below'
) m10 on m10.symbol = a.Symbol
left join (select symbol, 1 as Macd_4Hourly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Above'
) m11 on m11.symbol = a.Symbol
left join (select symbol, 1 as Macd_4Hourly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '4 Hourly' and Direction = 'Crosses Below'
) m12 on m12.symbol = a.Symbol
left join (select symbol, 1 as Macd_1Hourly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Above'
) m13 on m13.symbol = a.Symbol
left join (select symbol, 1 as Macd_1Hourly_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '1 Hourly' and Direction = 'Crosses Below'
) m14 on m14.symbol = a.Symbol
left join (select symbol, 1 as Macd_15Minutes_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Above'
) m15 on m15.symbol = a.Symbol
left join (select symbol, 1 as Macd_15Minutes_Crosses_Above from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'Macd' and TimeLine = '15 Minutes' and Direction = 'Crosses Below'
) m16 on m16.symbol = a.Symbol
;


select distinct symbol,STRING_AGG(Segments,', ') from 
( select distinct symbol,segments from Stocks_Analysis.dbo.Analyse_Stocks ) a
group by symbol
;

select distinct a.sno,a.stock_name,a.symbol, a.price, a.Percent_Change, a.volume from Stocks_Analysis.dbo.Analyse_Stocks a where symbol = 'DANGEE'
;
select '
Adx Down Tick
Ema 50 100
Adx
Upper Bollinger Band3
Stochastic
Adx Up Tick
Lower Bollinger Band2
Ema 13 26
Ema 5 13
Rsi
Volume
Upper Bollinger Band2
Macd
Ema 100 200
Lower Bollinger Band3
'

select * from Stocks_Analysis.dbo.Analyse_Stocks
where Macd_Monthly_Crosses_Above = 1 and 
Stochastic_Monthly_Crosses_Above = 1 and 
Rsi_Monthly_Crosses_Above = 1 and 
Ema_5_13_Monthly_Crosses_Above = 1 and 
Ema_13_26_Monthly_Crosses_Above = 1 and 
Ema_50_100_Monthly_Crosses_Above = 1 and 
Ema_100_200_Monthly_Crosses_Above = 1 and 
Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To = 1 and 
Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To = 1 and 
Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To = 1 and 
Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To = 1 and
Adx_Monthly_Crosses_Above = 1 and 
Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To = 1 and 
Volume_Monthly_Greater_Than_Equal_To = 1
;

select * 
-- update sis set Sno = rn 
from Stocks_Analysis.dbo.master_segments sis inner join (
select row_number() over(order by len(segments) desc) as rn, 
len(segments) as maxsegments,* 
from Stocks_Analysis.dbo.master_segments
) b
on sis.Symbol = b.Symbol
;
select count(1),Batch_No from Stocks_Analysis.dbo.Cash_Stocks
group by Batch_No
order by Batch_No
;
select * from Stocks_Analysis.dbo.Cash_Stocks
;
select  Batch_No, Created_Date, Symbol, Segments, Stock_Name, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To
from Analyse_Stocks
;

select	distinct isnull(cs.Batch_No+1,1),SYSDATETIME(),a.Symbol,a.Segments,a.Stock_Name
,cs.Percent_Change,cs.price,cs.volume
from Stocks_Analysis.dbo.master_segments a 
join Stocks_Analysis.dbo.Cash_Stocks cs on a.Symbol = cs.symbol
where cs.Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Cash_Stocks)
;
select * from Stocks_Analysis.dbo.Analyse_Stocks order by Batch_No desc
;
select distinct cs.symbol, ss.Symbol 
from Stocks_Analysis.dbo.Cash_Stocks cs
left join master_segments ss on cs.symbol = ss.Symbol
where Batch_No = 8 and ss.Symbol is null
;
select distinct symbol from master_segments
;
select distinct symbol from Stocks_Analysis.dbo.Cash_Stocks where Indicator = 'all'
order by Batch_No desc
;
------------------------
select * 
--update a set a.Bearish_Quarterly = 1 
from Stocks_Analysis.dbo.Analyse_Stocks a
where 1=1 and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
and Macd_Yearly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1 and Macd_Quarterly_Crosses_Below = 1
and Rsi_Quarterly_Crosses_Below = 1 and Adx_Quarterly_Crosses_Below = 1 and Stochastic_Quarterly_Crosses_Below = 1
and Ema_5_13_Quarterly_Crosses_Below = 1 and Ema_13_26_Quarterly_Crosses_Below = 1
and Ema_50_100_Quarterly_Crosses_Below = 1 and Ema_100_200_Quarterly_Crosses_Below = 1
;
select * 
--update a set a.Bearish_Monthly = 1 
from Stocks_Analysis.dbo.Analyse_Stocks a
where 1=1 and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
and Macd_Monthly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1 and Macd_Monthly_Crosses_Below = 1
and Rsi_Monthly_Crosses_Below = 1 and Adx_Monthly_Crosses_Below = 1 and Stochastic_Monthly_Crosses_Below = 1
and Ema_5_13_Monthly_Crosses_Below = 1 and Ema_13_26_Monthly_Crosses_Below = 1
and Ema_50_100_Monthly_Crosses_Below = 1 and Ema_100_200_Monthly_Crosses_Below = 1
;

select *
--update a set a.Bulish_Weekly = 1 
from Stocks_Analysis.dbo.Analyse_Stocks a
where 1=1 and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1
and Rsi_Weekly_Crosses_Below = 1 and Adx_Weekly_Crosses_Below = 1 and Stochastic_Weekly_Crosses_Below = 1
and Ema_5_13_Weekly_Crosses_Below = 1 and Ema_13_26_Weekly_Crosses_Below = 1
and Ema_50_100_Weekly_Crosses_Below = 1 and Ema_100_200_Weekly_Crosses_Below = 1
;
select *
-- update a set a.Bearish_Daily = 1 
from Stocks_Analysis.dbo.Analyse_Stocks a
where 1=1 and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
and Macd_Monthly_Crosses_Below = 1 and Macd_Weekly_Crosses_Below = 1 and Macd_Daily_Crosses_Below = 1
and Rsi_Daily_Crosses_Below = 1 and Adx_Daily_Crosses_Below = 1 and Stochastic_Daily_Crosses_Below = 1
and Ema_5_13_Daily_Crosses_Below = 1 and Ema_13_26_Daily_Crosses_Below = 1
and Ema_50_100_Daily_Crosses_Below = 1 and Ema_100_200_Daily_Crosses_Below = 1
;
-- slightely bullish stocks on daily timeframe
-- side ways trending stocks on daily timeframe
----------------------------------
--insert into Stocks_Analysis.dbo.Analyse_Stocks(Batch_No, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, price, volume, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To)
--select Batch_No, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, price, volume, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To
--from Stocks_Analysis.dbo.Analyse_Stocks_1

select Batch_No, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, price, volume, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To
from Stocks_Analysis.dbo.Analyse_Stocks
;
select * from Stocks_Analysis.dbo.Master_Segments order by sno;

select *
-- update sis set Sno = rn 
from Stocks_Analysis.dbo.Master_Segments sis inner join (
select row_number() over(order by len(segments) desc) as rn, 
len(segments) as maxsegments,* 
from Stocks_Analysis.dbo.Master_Segments
) b
on sis.Symbol = b.Symbol
;

select Batch_No, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To
from Stocks_Analysis.dbo.Analyse_Stocks
;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from Stocks_Analysis.dbo.Analyse_Stocks
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_Monthly = 350 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_Monthly = 1
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_Weekly = 340 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_Weekly = 1
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_Daily = 330 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_Daily = 1
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_4_Hourly = 320 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_4_Hourly = 1
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_1_Hourly = 310 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_1_Hourly = 1
;
select * 
-- update a set a.Bullish_Triple_Screen_Strong_15_Minutes = 310 
from Stocks_Analysis.dbo.Analyse_Stocks a where a.Bullish_Triple_Screen_Strong_15_Minutes = 1
;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * 
-- update a set a.Trade_Type_Details_Sum= isnull(Bullish_Triple_Screen_Strong_Monthly,0)+isnull(Bullish_Triple_Screen_Strong_Weekly,0)+isnull(Bullish_Triple_Screen_Strong_Daily,0)+isnull(Bullish_Triple_Screen_Strong_4_Hourly,0)+isnull(Bullish_Triple_Screen_Strong_1_Hourly,0)+isnull(Bullish_Triple_Screen_Strong_15_Minutes,0)
from Stocks_Analysis.dbo.Analyse_Stocks a ;
update a set a.Segments_Length = len(a.Segments) from Stocks_Analysis.dbo.Analyse_Stocks a ;
select * from Stocks_Analysis.dbo.Analyse_Stocks a 
where Batch_No >=10 and a.Trade_Type_Details_Sum > 0 and a.Segments_Length > 10
order by a.Trade_Type_Details_Sum desc,a.Segments_Length desc,Batch_No desc
;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * 
from Stocks_Analysis.dbo.Analyse_Stocks
where Trade_Type_Details_Sum > 10 and Segments_Length > 10
and Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)
order by Batch_No desc,Trade_Type_Details_Sum desc;

select distinct Batch_No,Trade_Type_Details_Sum,Stock_Name,Segments,Symbol,Percent_Change,Price,Volume
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
where Trade_Type_Details_Sum > 10 and Segments_Length > 10
and Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
order by Batch_No desc,Trade_Type_Details_Sum desc;


select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bullish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bullish - Strong Triple Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bullish_Triple_Screen_Strong_Monthly > 0 or 
Bullish_Triple_Screen_Strong_Weekly > 0 or
Bullish_Triple_Screen_Strong_Daily > 0 or
Bullish_Triple_Screen_Strong_4_Hourly > 0 or
Bullish_Triple_Screen_Strong_1_Hourly > 0 or
Bullish_Triple_Screen_Strong_15_Minutes > 0
;

select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bullish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bullish - Strong Triple Screen Correction;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bullish_Triple_Screen_Strong_Correction_Monthly > 0 or
Bullish_Triple_Screen_Strong_Correction_Weekly > 0 or
Bullish_Triple_Screen_Strong_Correction_Daily > 0 or
Bullish_Triple_Screen_Strong_Correction_4_Hourly > 0 or
Bullish_Triple_Screen_Strong_Correction_1_Hourly > 0 or
Bullish_Triple_Screen_Strong_Correction_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bullish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bullish - Strong Double Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bullish_Double_Screen_Strong_Quarterly > 0 or
Bullish_Double_Screen_Strong_Monthly > 0 or
Bullish_Double_Screen_Strong_Weekly > 0 or
Bullish_Double_Screen_Strong_Daily > 0 or
Bullish_Double_Screen_Strong_4_Hourly > 0 or
Bullish_Double_Screen_Strong_1_Hourly > 0 or
Bullish_Double_Screen_Strong_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bullish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bullish - Strong Double Screen Correction;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bullish_Double_Screen_Strong_Correction_Quarterly > 0 or
Bullish_Double_Screen_Strong_Correction_Monthly > 0 or
Bullish_Double_Screen_Strong_Correction_Weekly > 0 or
Bullish_Double_Screen_Strong_Correction_Daily > 0 or
Bullish_Double_Screen_Strong_Correction_4_Hourly > 0 or
Bullish_Double_Screen_Strong_Correction_1_Hourly > 0 or
Bullish_Double_Screen_Strong_Correction_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bullish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bullish - Single Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bullish_Single_Screen_Yearly > 0 or
Bullish_Single_Screen_Quarterly > 0 or
Bullish_Single_Screen_Monthly > 0 or
Bullish_Single_Screen_Weekly > 0 or
Bullish_Single_Screen_Daily > 0 or
Bullish_Single_Screen_4_Hourly > 0 or
Bullish_Single_Screen_1_Hourly > 0 or
Bullish_Single_Screen_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bearish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bearish - Strong Triple Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bearish_Triple_Screen_Strong_Monthly > 0 or
Bearish_Triple_Screen_Strong_Weekly > 0 or
Bearish_Triple_Screen_Strong_Daily > 0 or
Bearish_Triple_Screen_Strong_4_Hourly > 0 or
Bearish_Triple_Screen_Strong_1_Hourly > 0 or
Bearish_Triple_Screen_Strong_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bearish;', Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bearish - Strong Triple Screen Correction;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bearish_Triple_Screen_Strong_Correction_Monthly > 0 or
Bearish_Triple_Screen_Strong_Correction_Weekly > 0 or
Bearish_Triple_Screen_Strong_Correction_Daily > 0 or
Bearish_Triple_Screen_Strong_Correction_4_Hourly > 0 or
Bearish_Triple_Screen_Strong_Correction_1_Hourly > 0 or
Bearish_Triple_Screen_Strong_Correction_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bearish;',Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bearish - Strong Double Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bearish_Double_Screen_Strong_Quarterly > 0 or
Bearish_Double_Screen_Strong_Monthly > 0 or
Bearish_Double_Screen_Strong_Weekly > 0 or
Bearish_Double_Screen_Strong_Daily > 0 or
Bearish_Double_Screen_Strong_4_Hourly > 0 or
Bearish_Double_Screen_Strong_1_Hourly > 0 or
Bearish_Double_Screen_Strong_15_Minutes > 0 
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bearish;',Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bearish - Strong Double Screen Correction;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bearish_Double_Screen_Strong_Correction_Quarterly > 0 or
Bearish_Double_Screen_Strong_Correction_Monthly > 0 or
Bearish_Double_Screen_Strong_Correction_Weekly > 0 or
Bearish_Double_Screen_Strong_Correction_Daily > 0 or
Bearish_Double_Screen_Strong_Correction_4_Hourly > 0 or
Bearish_Double_Screen_Strong_Correction_1_Hourly > 0 or
Bearish_Double_Screen_Strong_Correction_15_Minutes > 0
;
select * 
-- update a set Trade_Type = isnull(Trade_Type,'') + 'Bearish;',Trade_Type_Details = isnull(Trade_Type_Details,'') + 'Bearish - Single Screen;'
from Stocks_Analysis.dbo.Analyse_Stocks a where 
Bearish_Single_Screen_Yearly > 0 or
Bearish_Single_Screen_Quarterly > 0 or
Bearish_Single_Screen_Monthly > 0 or
Bearish_Single_Screen_Weekly > 0 or
Bearish_Single_Screen_Daily > 0 or
Bearish_Single_Screen_4_Hourly > 0 or
Bearish_Single_Screen_1_Hourly > 0 or
Bearish_Single_Screen_15_Minutes > 0 
;
-- insert into Stocks_Analysis.dbo.Analyse_15Minutes_Stocks ( Batch_No, Trade_Type_Details_Sum, Segments_Length,Trade_Type, Trade_Type_Details, Trade_Type_Length, Trade_Type_Details_Length, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To)
select Batch_No, Trade_Type_Details_Sum, Segments_Length,Trade_Type, Trade_Type_Details, Trade_Type_Length, Trade_Type_Details_Length, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
;
select 
((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bullish', ''))) / LEN('Bullish')) as Bullish_Type
,((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bearish', ''))) / LEN('Bearish')) as Bearish_Type
,case when ((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bullish', ''))) / LEN('Bullish') ) -
((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bearish', ''))) / LEN('Bearish')) > 0 then 'Bullish' else 'Bearish' end as TradingView
,*
from Stocks_Analysis.dbo.Analyse_Stocks
where Trade_Type_Details_Sum > 10 and Segments_Length > 10
and Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)
order by Batch_No desc,Trade_Type_Details_Sum desc,Trade_Type_Length desc, Trade_Type_Details_Length desc;
;

-- insert into Stocks_Analysis.dbo.Analyse_Stocks (Batch_No, Trade_Type_Details_Sum, Segments_Length, Trade_Type, Trade_Type_Length, Trade_Type_Details, Trade_Type_Details_Length, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, trade_view)
select Batch_No, Trade_Type_Details_Sum, Segments_Length, Trade_Type, Trade_Type_Length, Trade_Type_Details, Trade_Type_Details_Length, Created_Date, Stock_Name, Segments, Symbol, Percent_Change, Price, Volume, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, trade_view
from Stocks_Analysis.dbo.Analyse_Stocks
;

select a.Sno, b.rn, a.Batch_No,b.batchno
-- update a set Batch_No = b.batchno
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a
inner join (
select ROW_NUMBER() over(partition by created_date order by created_date,Sno) as rn,
dense_rank() over(order by created_date) as batchno, Created_Date,Symbol,Sno
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks -- order by Created_Date
) b on a.Sno = b.Sno
;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * -- rn,Batch_No,trade_view,Trade_Type_Details, Stock_Name,Segments,Symbol,Percent_Change,Price,Volume
from (
	select row_number() over(partition by Batch_No, trade_view, Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn,*
	from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks) 
	and Segments_Length > 10 and Trade_Type_Details_Sum > 10
) a where rn = 1
order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
;
select rn,Batch_No,trade_view,Trade_Type_Details, Stock_Name,Segments,Symbol,Percent_Change,Price,Volume
from (
	select row_number() over(partition by Batch_No, trade_view, Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn ,*
	from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks) 
	and Segments_Length > 5 and Trade_Type_Details_Sum > 10 and volume >10000
) a where rn = 1
order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * 
-- update a set trade_view = case
-- when (((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bullish', ''))) / LEN('Bullish') ) - ((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bearish', ''))) / LEN('Bearish')))
-- > 0 then 'Bullish' 
-- when (((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bullish', ''))) / LEN('Bullish') ) - ((LEN(Trade_Type) - LEN(REPLACE(Trade_Type, 'Bearish', ''))) / LEN('Bearish')))
-- < 0 then 'Bearish' else NULL end
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a
;
--------------------------------------------------------------------------------------------------------------------------------
select a.Symbol,b.sno,c.Sector,d.Industry,e.ISIN_Code,f.Company_Name,g.Series
from (select distinct symbol from Stocks_Analysis.dbo.master_segments) a
left join (
	select Symbol, STRING_AGG(sno, '; ') as sno 
	from (select distinct symbol,sno from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) b
on a.Symbol = b.Symbol
left join (
	select Symbol, STRING_AGG(Sector, '; ') as Sector
	from (select distinct symbol,Sector from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) c
on a.Symbol = c.Symbol
left join (
	select Symbol, STRING_AGG(Industry, '; ') as Industry
	from (select distinct symbol,Industry from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) d
on a.Symbol = d.Symbol
left join (
	select Symbol, STRING_AGG(ISIN_Code, '; ') as ISIN_Code
	from (select distinct symbol,ISIN_Code from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) e
on a.Symbol = e.Symbol
left join (
	select Symbol, STRING_AGG(Stock_Name, '; ') as Company_Name
	from (select distinct symbol,Stock_Name from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) f
on a.Symbol = f.Symbol
left join (
	select Symbol, STRING_AGG(Series, '; ') as Series
	from (select distinct symbol,Series from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) g
on a.Symbol = g.Symbol
--------------------------------------------------------------------------------------------------------------------------------
-- Example Usage:
SELECT Stocks_Analysis.dbo.InitCap('this is a test string');
--------------------------------------------------------------------------------------------------------------------------------
-- Example Usage:
SELECT Stocks_Analysis.dbo.InitCapWithSpaces('this  is a  test string');
select '
output
This  Is A  Test String
this  is a  test string
'
--------------------------------------------------------------------------------------------------------------------------------
SELECT value FROM STRING_SPLIT('apple,banana,orange', ',');
--------------------------------------------------------------------------------------------------------------------------------
select distinct replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace
(replace(replace(replace(replace(replace(replace(
replace(segments,'nifty',' nifty ')
,'_',' '),'birla',' Birla '),'bank',' Bank '),'large',' Large '),'mid',' Mid '),'small',' Small '),'cap',' Cap ')
,'equal',' Equal '),'weighted',' Weighted '),'markets',' Markets '),'select',' Select '),'financail',' Financail ')
,'india',' India '),'manufacturing ',' Manufacturing '),'infrastructure',' Infrastructure '),'service',' Service ')
,'health',' Health '),'care',' Care '),'',''),'Cap ital','capital'),'Groups',' Groups')
-- replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(sector,'nifty','Nifty '),'aditya','Aditya ')
from Stocks_Analysis.dbo.master_segments;

select distinct 
Stocks_Analysis.dbo.InitCapWithSpaces(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(sector,'5',' 5'),'20',' 20'),'25',' 25'),'30',' 30'),'15',' 15'),'50',' 50'),'100',' 100'),'150',' 150'),'200',' 200'),'250',' 250'),'400',' 400'),'500',' 500'),'aditya',' aditya'),'Age',' Age'),'and',' and'),'auto',' auto'),'Automotive',' Automotive'),'bank',' bank'),'birla',' birla'),'cap',' cap'),'Capital',' Capital'),'care',' care'),'Chemicals',' Chemicals'),'commodities',' commodities'),'consumer',' consumer'),'Consumption',' Consumption'),'Core',' Core'),'Corporate',' Corporate'),'cpse',' cpse'),'durables',' durables'),'E-Commerce',' E-Commerce'),'energy',' energy'),'Equal',' Equal'),'Ev',' Ev'),'exbank',' exbank'),'financail',' financail'),'finance',' finance'),'financial',' financial'),'fmcg',' fmcg'),'gas',' gas'),'Groups',' Groups'),'health',' health'),'Housing',' Housing'),'India',' India'),'indiadigital',' indiadigital'),'infra',' infra'),'Infrastructure',' Infrastructure'),'Internet',' Internet'),'InvITs',' InvITs'),'IPO',' IPO'),'it',' it'),'large',' large'),'Liquid',' Liquid'),'logistics',' logistics'),'MAATR',' MAATR'),'mahindra',' mahindra'),'Manufacturing',' Manufacturing'),'market',' market'),'Markets',' Markets'),'media',' media'),'metal',' metal'),'micro',' micro'),'mid',' mid'),'midcap',' midcap'),'mnc',' mnc'),'mobility',' mobility'),'Multi',' Multi'),'Multicap',' Multicap'),'New',' New'),'next',' next'),'nifty',' nifty'),'non-cyclical',' non-cyclical'),'oil',' oil'),'pharma',' pharma'),'private',' private'),'pse',' pse'),'PSU',' PSU'),'Railways',' Railways'),'realty',' realty'),'REITs',' REITs'),'Rural',' Rural'),'Select',' Select'),'Service',' Service'),'services',' services'),'small',' small'),'sme',' sme'),'tata',' tata'),'telecom',' telecom'),'total',' total'),'Tourism',' Tourism'),'transportation',' transportation'),'Weighted',' Weighted'),'  ',' '))
from Stocks_Analysis.dbo.master_segments
--------------------------------------------------------------------------------------------------------------------------------
select a.Symbol,c.Sector,d.Industry,e.ISIN_Code,f.Company_Name,g.Series
-- into Stocks_Analysis.dbo.master_segments_distinct
from (select distinct symbol from Stocks_Analysis.dbo.master_segments) a
left join (
	select Symbol, STRING_AGG(Stocks_Analysis.dbo.InitCapWithSpaces(replace(segments,'nifty','Nifty ')), '; ') as Sector
	from (select distinct symbol,segments from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) c
on a.Symbol = c.Symbol
left join (
	select Symbol, STRING_AGG(Stocks_Analysis.dbo.InitCapWithSpaces(Industry), '; ') as Industry
	from (select distinct symbol,Industry from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) d
on a.Symbol = d.Symbol
left join (
	select Symbol, STRING_AGG(ISIN_Code, '; ') as ISIN_Code
	from (select distinct symbol,ISIN_Code from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) e
on a.Symbol = e.Symbol
left join (
	select Symbol, STRING_AGG(Stock_Name, '; ') as Company_Name
	from (select distinct symbol,Stock_Name from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) f
on a.Symbol = f.Symbol
left join (
	select Symbol, STRING_AGG(Series, '; ') as Series
	from (select distinct symbol,Series from Stocks_Analysis.dbo.master_segments) a
	group by Symbol) g
on a.Symbol = g.Symbol
;
--------------------------------------------------------------------------------------------------------------------------------
select a.Symbol,a.Segments,a.Stock_Name
from Stocks_Analysis.dbo.Master_Segments a

--------------------------------------------------------------------------------------------------------------------------------
;WITH CTE AS (
    SELECT
		symbol,
        ROW_NUMBER() OVER (ORDER BY len(Segments) desc) AS sno
    FROM Stocks_Analysis.dbo.Master_Segments
)
-- UPDATE Stocks_Analysis.dbo.Master_Segments SET sno = CTE.sno
select *
FROM Stocks_Analysis.dbo.Master_Segments
JOIN CTE
ON Stocks_Analysis.dbo.Master_Segments.Symbol = CTE.Symbol;
--------------------------------------------------------------------------------------------------------------------------------
-- update a set Industry = b.Industry ,ISIN_Code = b.ISIN_Code ,Series = b.Series
select * 
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a
inner join Stocks_Analysis.dbo.Master_Segments b
on a.Symbol = b.Symbol;
--------------------------------------------------------------------------------------------------------------------------------
select distinct segments from (
	select symbol,segments
	,STRING_AGG(segments, ';') WITHIN GROUP (ORDER BY segments) AS SortedString 
	,len(segments) as len_of_segments
	from Stocks_Analysis.dbo.Master_Segments
	where len(segments)  > 14
	group by symbol,segments
-- order by 4
) a ;

--------------------------------------------------------------------------------------------------------------------------------
select distinct segments,len(segments)
-- ,ltrim(rtrim(STUFF(segments, 1, 1, ''))) as SegmentedFormated
from Stocks_Analysis.dbo.Master_Segments
where len(segments) > 5 
order by len(segments);
--------------------------------------------------------------------------------------------------------------------------------
SELECT STUFF(segments, 1, 1, '') AS ModifiedString FROM Master_Segments;
--------------------------------------------------------------------------------------------------------------------------------
SELECT distinct trim(value) AS SplitValue
FROM Stocks_Analysis.dbo.Master_Segments
CROSS APPLY STRING_SPLIT(segments, ';')
order by 1;
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
select * 
-- update a set Segments = b.Segments 
from Stocks_Analysis.dbo.Analyse_Stocks a
inner join Stocks_Analysis.dbo.Master_Segments b
on a.Symbol = b.Symbol;

--------------------------------------------------------------------------------------------------------------------------------
-- update Stocks_Analysis.dbo.Master_Segments set Segments = replace(segments,'  ',' ');
--------------------------------------------------------------------------------------------------------------------------------
select * from Stocks_Analysis.dbo.Master_Segments
--------------------------------------------------------------------------------------------------------------------------------
select a.Symbol,a.Segments,b.Segments,b.sector_order,b.sector_sum
-- update a set a.Segments = b.Segments,a.sector_order = b.sector_order,a.sector_sum = b.sector_sum
from Stocks_Analysis.dbo.Analyse_Stocks a
inner join Stocks_Analysis.dbo.Master_Segments b
on a.Symbol = b.Symbol;
--------------------------------------------------------------------------------------------------------------------------------
select distinct symbol,indicator,timeline,direction, segments,batch_no 
from Stocks_Analysis.dbo.Cash_Stocks 
where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Cash_Stocks)
and indicator like 'Price action%' and timeline = 'daily'
order by symbol,timeline, indicator,direction
;

select STRING_AGG(cast(replace(replace(indicator,'price action ',''),' candle','') as int), '; ') 
within group (order by symbol,cast(replace(replace(indicator,'price action ',''),' candle','') as int),
timeline,direction,segment,batch_no) as indicator_aggregate
,symbol,timeline,direction,segments,batch_no
from Stocks_Analysis.dbo.Cash_Stocks 
where  Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Cash_Stocks) 
and indicator like '%price action%' 
and timeline = 'yearly' 
and Direction like 'greater than%'
group by symbol,timeline,direction,segments,batch_no

-- update a set indicator = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Indicator,'year','candle'),'quarter','candle'),'month','candle'),'week','candle'),'day','candle'),'hour','candle'),'minute','candle'),'4 candle','candle'),'1 candle','candle'),'15 candle','candle')
select *
from Stocks_Analysis.dbo.Cash_Stocks
where  1=1 
and batch_no = ( select max(Batch_No) from Stocks_Analysis.dbo.Cash_Stocks )
and indicator like 'Price Action%'
-- and (indicator like '0%' or indicator like '1%' or indicator like '2%' or indicator like '3%' or indicator like '4%' or indicator like '5%' or indicator like '6%' or indicator like '7%' or indicator like '8%' or indicator like '9%')
-- and direction like '%than equal to%' 
order by 1;

select * from Stocks_Analysis.dbo.Cash_15Minutes_Stocks
where batch_no = ( select max(Batch_No) from Stocks_Analysis.dbo.Cash_15Minutes_Stocks );

select * from Stocks_Analysis.dbo.Analyse_Stocks;
--------------------------------------------------------------------------------------------------------------------------------
;WITH AggregatedValues AS (
    SELECT 
        symbol,
        timeline,
        direction,
        segments,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        direction,
        segments,
        batch_no,
        adjusted_value
    FROM AggregatedValues
),
Formatted AS (
    SELECT 
        symbol,
        batch_no,
        timeline,
        direction,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY adjusted_value) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            ELSE 5
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, batch_no, timeline, direction
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(
        CONCAT(
            '', 
            timeline, '-', 
            REPLACE(REPLACE(REPLACE(direction, 
                'greater than equal to', '>='), 
                'less than equal to', '<='), 
                'equal to', '='), 
            ' - ', value_list, ''
        ), 
        ' '
    ) WITHIN GROUP (ORDER BY timeline_order, direction) AS price_action_aggregate
FROM Formatted
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        direction,
        segments,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        direction,
        segments,
        batch_no,
        adjusted_value
    FROM AdjustedValues
),
Formatted AS (
    SELECT 
        symbol,
        batch_no,
        timeline,
        direction,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY adjusted_value) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            ELSE 5
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, batch_no, timeline, direction
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(
        CONCAT(
            '', 
            timeline, ' ', 
            REPLACE(REPLACE(REPLACE(direction, 
                'greater than equal to', '>='), 
                'less than equal to', '<='), 
                'equal to', '='), 
            ' ', value_list, ''
        ), 
        ' '
    ) WITHIN GROUP (ORDER BY timeline_order, direction) AS price_action_aggregate
FROM Formatted
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
/*combine the greater than and less than value at each timeline ie., yearly 1,2,3,-4,-5,6,-8,10,-11 here minus appended number will give me that less than or equal to and positive number will give me the greater than equal to*/
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY adjusted_value) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            ELSE 5
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(
        CONCAT('', timeline, ' ', value_list, ''), 
        ' '
    ) WITHIN GROUP (ORDER BY timeline_order) AS price_action_aggregate
FROM Formatted
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(
        CONCAT('', timeline, ' ', value_list, ''), 
        ' '
    ) WITHIN GROUP (ORDER BY timeline_order) AS price_action_aggregate
FROM Formatted
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 'less'
            WHEN direction LIKE 'greater than equal to%' THEN 'greater'
            ELSE NULL
        END AS direction_type,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        direction_type,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        direction_type,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no, direction_type
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(
        CONCAT('', timeline, ' ', direction_type, ' ', value_list, ''), 
        ' '
    ) WITHIN GROUP (ORDER BY timeline_order, direction_type) AS price_action_aggregate
FROM Formatted
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 'less'
            WHEN direction LIKE 'greater than equal to%' THEN 'greater'
            ELSE NULL
        END AS direction_type,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Formatted AS (
    SELECT 
        symbol,
        batch_no,
        timeline,
        direction_type,
        COUNT(*) AS value_count,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
    GROUP BY symbol, batch_no, timeline, direction_type
),
Combined AS (
    SELECT 
        symbol,
        batch_no,
        timeline_order,
        timeline,
        STRING_AGG(
            CONCAT(timeline, ' (', value_count, ') ', value_list), 
            ' ; '
        ) AS timeline_line
    FROM Formatted
    GROUP BY symbol, batch_no, timeline, timeline_order
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(timeline_line, CHAR(10)) 
        WITHIN GROUP (ORDER BY timeline_order) AS price_action_aggregate
FROM Combined
GROUP BY symbol, batch_no;
--------------------------------------------------------------------------------------------------------------------------------
-- ==============================================================================================================================
-- final query for price action
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 'less'
            WHEN direction LIKE 'greater than equal to%' THEN 'greater'
            ELSE NULL
        END AS direction_type,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Formatted AS (
    SELECT 
        symbol,
        batch_no,
        timeline,
        direction_type,
        COUNT(*) AS value_count,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
    GROUP BY symbol, batch_no, timeline, direction_type
),
Pivoted AS (
    SELECT 
        symbol,
        batch_no,
        timeline,
        timeline_order,
        MAX(CASE WHEN direction_type = 'greater' THEN 
            CONCAT(timeline, ' +(', value_count, ') ', value_list) END) AS greater_line,
        MAX(CASE WHEN direction_type = 'less' THEN 
            CONCAT(timeline, ' -(', value_count, ') ', value_list) END) AS less_line
    FROM Formatted
    GROUP BY symbol, batch_no, timeline, timeline_order
),
Combined AS (
    SELECT 
        symbol,
        batch_no,
        timeline_order,
        CONCAT_WS(' ; ', greater_line, less_line) AS timeline_line
    FROM Pivoted
)
SELECT 
    symbol,
    batch_no,
    STRING_AGG(timeline_line, ' ;; ') 
        WITHIN GROUP (ORDER BY timeline_order) AS price_action_aggregate
FROM Combined
GROUP BY symbol, batch_no;
--==============================================================================================================================
-- alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add price_action varchar(max)
--------------------------------------------------------------------------------------------------------------------------------
-- price action 
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 1=1
        -- AND batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')

),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
), 
Price_Action_Final as ( 
	SELECT 
		symbol,
		batch_no,
		replace('{' + STRING_AGG(
			CONCAT('"', timeline,'" : ', value_list, ','), 
			' '
		) WITHIN GROUP (ORDER BY timeline_order) + '}',',}','}') AS price_action_aggregate 
	FROM Formatted
	GROUP BY symbol, batch_no
)
select * 
-- Update a set a.price_action = price_action_aggregate
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a join Price_Action_Final b 
on a.Symbol = b.symbol and a.Batch_No = b.batch_no
;
--------------------------------------------------------------------------------------------------------------------------------
-- select batch_no, symbol, created_date, price_action from Stocks_Analysis.dbo.Analyse_Stocks
DECLARE @json NVARCHAR(MAX) = '{"yearly" : 0, -1, 2, -3, 4, 5, -6, -7, 8, 9, -10, 11, -12, -13, -14, -15, 16, -17, 18, -19, "quarterly" : 0, -1, -2, -3, -4, -5, 6, 7, 8, -9, -10, 11, -12, -13, 14, -15, 16, 17, 18, 19, 20, -21, -22, -23, -24, 25, 26, -27, -28, -29, 30, "monthly" : 0, 1, 2, -3, -4, 5, -6, 7, -8, -9, -10, 11, 12, -13, -14, -15, -16, 17, 18, 19, -20, 21, -22, 23, 24, -25, 26, -27, -28, -29, -30, "weekly" : 0, 1, -2, -3, -4, 5, -6, -7, 8, 9, -10, 11, -12, 13, -14, 15, -16, -17, -18, 19, 20, -21, 22, -23, 24, -25, -26, 27, 28, 29, -30, "daily" : 0, -1, -2, -3, 4, -5, -6, 7, 8, 9, 10, -11, -12, -13, 14, -15, -16, 17, -18, 19, 20, -21, -22, -23, -24, -25, 26, 27, 28, 29, 30, "4 hourly" : 0, 1, -2, -3, -4, -5, 6, 7, 8, -9, 10, -11, -12, -13, -14, 15, -16, 17, -18, 19, 20, -21, -22, 23, 24, -25, -26, -27, -28, 29, 30, "1 hourly" : 0, 1, 2, -3, 4, 5, 6, -7, 8, 9, -10, -11, -12, -13, -14, 15, -16, -17, 18, -19, -20, 21, -22, -23, -24, -25, 26, 27, -28, 29, 30, "15 minute" : 0, 1, 2, -3, 4, 5, -6, 7, 8, -9, -10, -11, -12, -13, 14, 15, -16, 17, -18, -19, 20, 21, 22, -23, 24, -25, -26, 27, -28, 29, 30}';
SELECT 
    [outer_Json.key] AS Timeframe,
    [inner_Json.value] AS Value
FROM OPENJSON(@json) AS outerJson
CROSS APPLY OPENJSON(outerJson.value) AS innerJson;
;
--------------------------------------------------------------------------------------------------------------------------------
-- price action 
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 1=1
        -- AND batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')

),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
), 
Price_Action_Final as ( 
	SELECT 
		symbol,
		batch_no,
		replace('{' + STRING_AGG(
			CONCAT('"', timeline,'" : ', value_list, ','), 
			' '
		) WITHIN GROUP (ORDER BY timeline_order) + '}',',}','}') AS price_action_aggregate 
	FROM Formatted
	GROUP BY symbol, batch_no
)
select * 
-- Update a set a.price_action = price_action_aggregate
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a join Price_Action_Final b 
on a.Symbol = b.symbol and a.Batch_No = b.batch_no
;
--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Stocks_Analysis.dbo.Analyse_15Minutes_Stocks__Price_Action_table (Row_id,Batch_no,symbol, Timeframe, Value)
SELECT ROW_NUMBER() OVER (PARTITION BY s.batch_no,s.symbol ORDER BY [outer_Json.key],abs(innerJson.value)) AS Row_Id,
	s.Batch_no,s.symbol,
    [outer_Json.key] AS Timeframe,
    innerJson.value AS Value
FROM Stocks_Analysis.dbo.Analyse_15Minutes_Stocks s
CROSS APPLY OPENJSON(s.price_action) AS outerJson
CROSS APPLY OPENJSON(outerJson.value) AS innerJson
order by 3,4,5,abs(innerJson.value)
;
--------------------------------------------------------------------------------------------------------------------------------
SELECT top 1000
    p.Batch_No,
	p.trade_view,
	p.symbol,	
    p.Price,
	p.Percent_Change,
	p.Volume,
    c.timeframe,
    c.value,
	p.Stock_Name,
	p.created_date
FROM Stocks_Analysis.dbo.Analyse_15Minutes_Stocks p
INNER JOIN Stocks_Analysis.dbo.Analyse_15Minutes_Stocks__Price_Action_table c 
ON p.batch_no = c.batch_no AND p.symbol = c.symbol;
--------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM Stocks_Analysis.dbo.Cash_15Minutes_Stocks
WHERE SYMBOL like 'ADANIPORTS'
;
select Symbol,Stock_Name,* from Stocks_Analysis.dbo.Master_Segments
;
--------------------------------------------------------------------------------------------------------------------------------
;with cte as (
	select distinct Trade_Type_Details as ttd,trim(value) as value ,replace(replace(replace(Trade_Type_Details,'; ',';'),'(',''),')','') as ttds
	from Stocks_Analysis.dbo.Analyse_Stocks cross apply STRING_SPLIT(replace(replace(Trade_Type_Details,'(',''),')',''), ';')
	where Batch_No = 13 and Trade_Type_Details is not null
) 
select * from cte a left join Stocks_Analysis.dbo.ScreenSort b
on a.value = replace(b.name,'_',' ')
where trim(a.value) <> ''
order by a.ttd,b.[order]
;
--------------------------------------------------------------------------------------------------------------------------------
-- this is working as expected
;WITH SplitSignals AS (
    SELECT distinct
        batch_no,sno,Trade_Type_Details,
        TRIM(value) AS Signal
    FROM Stocks_Analysis.dbo.Analyse_Stocks
    CROSS APPLY STRING_SPLIT(replace(replace(replace(Trade_Type_Details,'; ',';'),'(',''),')',''), ';')
    WHERE value <> '' -- and Batch_No = 18 and sno = 43439
) 
,OrderedSignals AS (
    SELECT TOP 100 PERCENT
        batch_no,sno,ss.[order],Trade_Type_Details,
        Signal
    FROM SplitSignals Ps -- ParsedSignals ps
    LEFT JOIN Stocks_Analysis.dbo.ScreenSort ss 
	ON ps.Signal = replace(ss.Name,'_',' ')
	order by batch_no,sno,ss.[order]
)
,final as (
SELECT 
    Batch_No,Sno,Trade_Type_Details,
    STRING_AGG(Signal, '; ') WITHIN GROUP (ORDER BY Batch_No,Sno,[order] ASC)  AS SortedSignalString
FROM OrderedSignals
GROUP BY Batch_No,Sno,Trade_Type_Details
) 
select * from final
;
--------------------------------------------------------------------------------------------------------------------------------
-- select * from Stocks_Analysis.dbo.ScreenSort; Stocks_Analysis.dbo.Analyse_Stocks
;WITH SplitSignals AS (
    SELECT distinct
        batch_no,sno,Trade_Type_Details,
        TRIM(value) AS Signal
    FROM Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
    CROSS APPLY STRING_SPLIT(replace(replace(replace(Trade_Type_Details,'; ',';'),'(',''),')',''), ';')
    WHERE value <> '' -- and Batch_No = 18 and sno = 43439
) 
,OrderedSignals AS (
    SELECT TOP 100 PERCENT
        batch_no,sno,ss.[order],Trade_Type_Details,
        Signal
    FROM SplitSignals Ps -- ParsedSignals ps
    LEFT JOIN Stocks_Analysis.dbo.ScreenSort ss 
	ON ps.Signal = replace(ss.Name,'_',' ')
	order by batch_no,sno,ss.[order]
)
,final as (
SELECT 
    Batch_No,Sno,Trade_Type_Details,
    STRING_AGG(Signal, '; ') WITHIN GROUP (ORDER BY Batch_No,Sno,[order] ASC)  AS SortedSignalString
FROM OrderedSignals
GROUP BY Batch_No,Sno,Trade_Type_Details
)
select * 
-- update a set Trade_Type_Details = SortedSignalString
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a
inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
;

select top 1000 * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Trade_Type_Details is not null
;

--------------------------------------------------------------------------------------------------------------------------------
select top 1000 * from Stocks_Analysis.dbo.Analyse_Stocks with (nolock) order by Batch_No desc;
select top 100 * from Stocks_Analysis.dbo.Analyse_Stocks
select * from Stocks_Analysis.dbo.Master_Screen_Name_Values

update  Stocks_Analysis.dbo.Analyse_Stocks
set Trade_Type = null
,Trade_Type_Details = null


select * from Stocks_Analysis.dbo.ScreenSort

select distinct Trade_Type_Details from Stocks_Analysis.dbo.Analyse_Stocks;
select  * from Stocks_Analysis.dbo.ScreenSort;
--------------------------------------------------------------------------------------------------------------------------------

select top 1000 * from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = 22
order by Trade_Type_Details_Length desc;

--------------------------------------------------------------------------------------------------------------------------------
select top 10000 * from Stocks_Analysis.dbo.Analyse_Stocks 
where segments like '%Nifty 50%' 
and batch_no = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)
order by Batch_No desc,Trade_Type_Details_Sum desc;

select top 1000 * from Stocks_Analysis.dbo.cash_stocks 
where Direction = 'Shockers'
order by batch_no desc,sno ;

select * from Stocks_Analysis.dbo.Master_Screen_Name_Values;

select distinct top 10 batch_no,created_date from Stocks_Analysis.dbo.Analyse_Stocks order by 1 desc

select top 1000 * from Stocks_Analysis.dbo.Analyse_Stocks order by Batch_No desc

/*
alter table Stocks_Analysis.dbo.Analyse_Stocks add volume__shockers varchar(255);
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__quarterly__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__monthly__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__weekly__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__daily__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__4_hourly__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__1_hourly__shockers bit null;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add volume__15_minutes__shockers bit null;
*/
--------------------------------------------------------------------------------------------------------------------------------
--select top 1000 volume__shockers,* from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
--where volume__shockers is not null
--order by Batch_No desc
;
select * from Stocks_Analysis.dbo.Master_Segments
order by sector_order desc,sector_sum desc
;
select * from Stocks_Analysis.dbo.master_segments
;
select * from Stocks_Analysis.dbo.Sector_Table
;
SELECT TOP (1000) 
	   Sno
      ,Batch_No
      ,Created_Date      
      ,trade_view
	  ,Industry
      ,Segments
      ,Trade_Type_Details
      ,Trade_Type_Details_Sum
      ,Stock_Name
      ,Symbol
      ,Percent_Change
      ,Price
      ,Volume
      ,volume__shockers
      ,ISIN_Code
      ,price_action
      ,Trade_Type
      ,Trade_Type_Length
      ,Trade_Type_Details_Length
      ,Segments_Length
      ,Trade_Type_Bullish_Sum
      ,Trade_Type_Bearish_Sum
      ,sector_order
      ,sector_sum
      ,Series

	  ,*
  FROM Stocks_Analysis.Stocks_Analysis.dbo.Analyse_Stocks
  where volume__shockers is not null
order by Batch_No desc, Segments_Length desc, Trade_Type_Details_Sum desc

--------------------------------------------------------------------------------------------------------------------------------
select 
Sno,Batch_No,Created_Date,trade_view,Trade_View_Order,Segments,Segments_Order,Other_Setups,Volume_Shockers_Sum,Trade_Type_Details,Trade_Type_Details_Sum,Industry,Stock_Name,Symbol,Percent_Change,Price,Volume,Series,Trade_Type,Trade_Type_Length,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum,Trade_Type_Details_Length,Segments_Length,Segments_Sum,price_action,ISIN_Code
,Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers
into Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_new
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
;
--------------------------------------------------------------------------------------------------------------------------------
select row_number() over (partition by Batch_No order by 
Batch_No desc, 
Trade_View_Order asc,
Other_Setups desc,
Segments_Order desc,
Trade_Type_Details_Sum desc
	) as report_sort_order
,Sno, Batch_No, Created_Date,Symbol, trade_view, Trade_View_Order, Segments, Segments_Order, Other_Setups, Volume_Shockers_Sum, Trade_Type_Details, Trade_Type_Details_Sum, Industry, Stock_Name, Percent_Change, Price, Volume, Series, Trade_Type, Trade_Type_Length, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type_Details_Length, Segments_Length, Segments_Sum, price_action, ISIN_Code, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers
--into Stocks_Analysis.dbo.Analyse_Stocks_new
from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = 52 and Other_Setups is not null
order by batch_no desc
;
--------------------------------------------------------------------------------------------------------------------------------
select *, 
-- update a set Volume_Shockers_Sum =
isnull(Volume_Shockers_Sum,0) +
(case when volume_yearly_shockers = 1 then 525600 else 0 end) +
(case when volume_quarterly_shockers = 1 then 131400 else 0 end)+
(case when volume_monthly_shockers = 1 then 43800 else 0 end)+
(case when volume_weekly_shockers = 1 then 10080 else 0 end)+
(case when volume_daily_shockers = 1 then 1440 else 0 end)+
(case when volume_4_hourly_shockers = 1 then 240 else 0 end)+
(case when volume_1_hourly_shockers = 1 then 60 else 0 end)+
(case when volume_15_minutes_shockers = 1 then 15 else 0 end)
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a
where Batch_No = @Batch_No
;
--------------------------------------------------------------------------------------------------------------------------------
begin
select top 10000 Symbol from Stocks_Analysis.dbo.Analyse_Stocks_v order by Batch_No desc;
-- create or alter view Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_v as 
select Batch_No, trade_view,Trade-Type-Details,segment/*,Trade_Type_Details,Segments*/, Symbol, Percent_Change, Price, Volume
,rn,Stock_Name, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type, Trade_Type_Length, Segments_Length, Trade_Type_Details_Length, Created_Date
,Segments_Order,Segments_Sum,price_action
from (
	select row_number() over(partition by Batch_No, trade_view,Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn,
	Sno, Batch_No, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Segments_Length, trade_view, Trade_Type, Trade_Type_Length, replace(Trade_Type_Details,';',';'+char(13)+char(10)) as 'Trade-Type-Details',Trade_Type_Details, Trade_Type_Details_Length, Created_Date, Stock_Name,replace(Segments,';',';' + char(13)+ char(10))as segment, Segments, Symbol, Percent_Change, Price, Volume
	,Segments_Order,Segments_Sum,price_action
	from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
	-- from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)	 	
	and Segments_Length > 5 and Trade_Type_Details_Sum > 10 and Segments_Length > 25 and volume >1000
	--and Symbol in ('BSE','ARE&M','AXISBANK','COALINDIA','HAL','IREDA','OLAELEC','RELIANCE','SHREEGANES-X','SWSOLAR','TVSSCS','VBL','NIFTY50-INDEX','DEEPAKNTR','DLF','MUKTAARTS','WEBELSOLAR','COLPAL','REDINGTON','BHARATFORG','MUTHOOTFIN')
) a where rn = 1
-- order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
-- create view Stocks_Analysis.dbo.Analyse_Stocks_v as 
select Batch_No, trade_view,Trade-Type-Details,segment/*,Trade_Type_Details,Segments*/, Symbol, Percent_Change, Price, Volume
,rn,Stock_Name, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type, Trade_Type_Length
,Segments_Length, Trade_Type_Details_Length, Created_Date
,Segments_Order,Segments_Sum,price_action
from (
	select row_number() over(partition by Batch_No, trade_view,Trade_Type_Details,Stock_Name, Segments, Symbol order by Sno desc) as rn,
	Sno, Batch_No, Trade_Type_Details_Sum, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Segments_Length, trade_view
	, Trade_Type, Trade_Type_Length, replace(Trade_Type_Details,';',';'+char(13)+char(10)) as 'Trade-Type-Details',Trade_Type_Details
	, Trade_Type_Details_Length, Created_Date, Stock_Name,replace(Segments,';',';' + char(13)+ char(10))as segment, Segments, Symbol
	, Percent_Change, Price, Volume
	,Segments_Order,Segments_Sum,price_action
	--from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
	 from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)
	 and Trade_Type_Length > 25 and Segments_Length > 10
	 and volume > 10000 and Trade_Type_Details_Sum > 10
	--and Symbol in ('BSE','ARE&M','AXISBANK','COALINDIA','HAL','IREDA','OLAELEC','RELIANCE','SHREEGANES-X','SWSOLAR','TVSSCS','VBL','NIFTY50-INDEX','DEEPAKNTR','DLF','MUKTAARTS','WEBELSOLAR','COLPAL','REDINGTON','BHARATFORG','MUTHOOTFIN')
) a where rn = 1
-- order by trade_view desc,Trade_Type_Details_Sum desc, Trade_Type_Details_Length desc,Segments_Length desc,Trade_Type_Length desc
end
--------------------------------------------------------------------------------------------------------------------------------
begin -- updating the report sort order column
select row_number() over (partition by Batch_No order by Batch_No desc, Trade_View_Order asc, Segments_Order desc, Other_Setups desc, Trade_Type_Details_Sum desc ) as report_sort_order
,Sno, Batch_No, Created_Date,Symbol, trade_view, Trade_View_Order, Segments, Segments_Order, Other_Setups, Volume_Shockers_Sum, Trade_Type_Details, Trade_Type_Details_Sum, Industry, Stock_Name, Percent_Change, Price, Volume, Series, Trade_Type, Trade_Type_Length, Trade_Type_Bullish_Sum, Trade_Type_Bearish_Sum, Trade_Type_Details_Length, Segments_Length, Segments_Sum, price_action, ISIN_Code, Bullish_Triple_Screen_Strong_Monthly, Bullish_Triple_Screen_Strong_Weekly, Bullish_Triple_Screen_Strong_Daily, Bullish_Triple_Screen_Strong_4_Hourly, Bullish_Triple_Screen_Strong_1_Hourly, Bullish_Triple_Screen_Strong_15_Minutes, Bullish_Triple_Screen_Strong_Correction_Monthly, Bullish_Triple_Screen_Strong_Correction_Weekly, Bullish_Triple_Screen_Strong_Correction_Daily, Bullish_Triple_Screen_Strong_Correction_4_Hourly, Bullish_Triple_Screen_Strong_Correction_1_Hourly, Bullish_Triple_Screen_Strong_Correction_15_Minutes, Bullish_Double_Screen_Strong_Quarterly, Bullish_Double_Screen_Strong_Monthly, Bullish_Double_Screen_Strong_Weekly, Bullish_Double_Screen_Strong_Daily, Bullish_Double_Screen_Strong_4_Hourly, Bullish_Double_Screen_Strong_1_Hourly, Bullish_Double_Screen_Strong_15_Minutes, Bullish_Double_Screen_Strong_Correction_Quarterly, Bullish_Double_Screen_Strong_Correction_Monthly, Bullish_Double_Screen_Strong_Correction_Weekly, Bullish_Double_Screen_Strong_Correction_Daily, Bullish_Double_Screen_Strong_Correction_4_Hourly, Bullish_Double_Screen_Strong_Correction_1_Hourly, Bullish_Double_Screen_Strong_Correction_15_Minutes, Bullish_Single_Screen_Yearly, Bullish_Single_Screen_Quarterly, Bullish_Single_Screen_Monthly, Bullish_Single_Screen_Weekly, Bullish_Single_Screen_Daily, Bullish_Single_Screen_4_Hourly, Bullish_Single_Screen_1_Hourly, Bullish_Single_Screen_15_Minutes, Bearish_Triple_Screen_Strong_Monthly, Bearish_Triple_Screen_Strong_Weekly, Bearish_Triple_Screen_Strong_Daily, Bearish_Triple_Screen_Strong_4_Hourly, Bearish_Triple_Screen_Strong_1_Hourly, Bearish_Triple_Screen_Strong_15_Minutes, Bearish_Triple_Screen_Strong_Correction_Monthly, Bearish_Triple_Screen_Strong_Correction_Weekly, Bearish_Triple_Screen_Strong_Correction_Daily, Bearish_Triple_Screen_Strong_Correction_4_Hourly, Bearish_Triple_Screen_Strong_Correction_1_Hourly, Bearish_Triple_Screen_Strong_Correction_15_Minutes, Bearish_Double_Screen_Strong_Quarterly, Bearish_Double_Screen_Strong_Monthly, Bearish_Double_Screen_Strong_Weekly, Bearish_Double_Screen_Strong_Daily, Bearish_Double_Screen_Strong_4_Hourly, Bearish_Double_Screen_Strong_1_Hourly, Bearish_Double_Screen_Strong_15_Minutes, Bearish_Double_Screen_Strong_Correction_Quarterly, Bearish_Double_Screen_Strong_Correction_Monthly, Bearish_Double_Screen_Strong_Correction_Weekly, Bearish_Double_Screen_Strong_Correction_Daily, Bearish_Double_Screen_Strong_Correction_4_Hourly, Bearish_Double_Screen_Strong_Correction_1_Hourly, Bearish_Double_Screen_Strong_Correction_15_Minutes, Bearish_Single_Screen_Yearly, Bearish_Single_Screen_Quarterly, Bearish_Single_Screen_Monthly, Bearish_Single_Screen_Weekly, Bearish_Single_Screen_Daily, Bearish_Single_Screen_4_Hourly, Bearish_Single_Screen_1_Hourly, Bearish_Single_Screen_15_Minutes, Macd_Yearly_Crosses_Above, Macd_Yearly_Crosses_Below, Macd_Quarterly_Crosses_Above, Macd_Quarterly_Crosses_Below, Macd_Monthly_Crosses_Above, Macd_Monthly_Crosses_Below, Macd_Weekly_Crosses_Above, Macd_Weekly_Crosses_Below, Macd_Daily_Crosses_Above, Macd_Daily_Crosses_Below, Macd_4_Hourly_Crosses_Above, Macd_4_Hourly_Crosses_Below, Macd_1_Hourly_Crosses_Above, Macd_1_Hourly_Crosses_Below, Macd_15_Minutes_Crosses_Above, Macd_15_Minutes_Crosses_Below, Stochastic_Yearly_Crosses_Above, Stochastic_Yearly_Crosses_Below, Stochastic_Quarterly_Crosses_Above, Stochastic_Quarterly_Crosses_Below, Stochastic_Monthly_Crosses_Above, Stochastic_Monthly_Crosses_Below, Stochastic_Weekly_Crosses_Above, Stochastic_Weekly_Crosses_Below, Stochastic_Daily_Crosses_Above, Stochastic_Daily_Crosses_Below, Stochastic_4_Hourly_Crosses_Above, Stochastic_4_Hourly_Crosses_Below, Stochastic_1_Hourly_Crosses_Above, Stochastic_1_Hourly_Crosses_Below, Stochastic_15_Minutes_Crosses_Above, Stochastic_15_Minutes_Crosses_Below, Ema_5_13_Yearly_Crosses_Above, Ema_5_13_Yearly_Crosses_Below, Ema_5_13_Quarterly_Crosses_Above, Ema_5_13_Quarterly_Crosses_Below, Ema_5_13_Monthly_Crosses_Above, Ema_5_13_Monthly_Crosses_Below, Ema_5_13_Weekly_Crosses_Above, Ema_5_13_Weekly_Crosses_Below, Ema_5_13_Daily_Crosses_Above, Ema_5_13_Daily_Crosses_Below, Ema_5_13_4_Hourly_Crosses_Above, Ema_5_13_4_Hourly_Crosses_Below, Ema_5_13_1_Hourly_Crosses_Above, Ema_5_13_1_Hourly_Crosses_Below, Ema_5_13_15_Minutes_Crosses_Above, Ema_5_13_15_Minutes_Crosses_Below, Ema_13_26_Yearly_Crosses_Above, Ema_13_26_Yearly_Crosses_Below, Ema_13_26_Quarterly_Crosses_Above, Ema_13_26_Quarterly_Crosses_Below, Ema_13_26_Monthly_Crosses_Above, Ema_13_26_Monthly_Crosses_Below, Ema_13_26_Weekly_Crosses_Above, Ema_13_26_Weekly_Crosses_Below, Ema_13_26_Daily_Crosses_Above, Ema_13_26_Daily_Crosses_Below, Ema_13_26_4_Hourly_Crosses_Above, Ema_13_26_4_Hourly_Crosses_Below, Ema_13_26_1_Hourly_Crosses_Above, Ema_13_26_1_Hourly_Crosses_Below, Ema_13_26_15_Minutes_Crosses_Above, Ema_13_26_15_Minutes_Crosses_Below, Ema_50_100_Yearly_Crosses_Above, Ema_50_100_Yearly_Crosses_Below, Ema_50_100_Quarterly_Crosses_Above, Ema_50_100_Quarterly_Crosses_Below, Ema_50_100_Monthly_Crosses_Above, Ema_50_100_Monthly_Crosses_Below, Ema_50_100_Weekly_Crosses_Above, Ema_50_100_Weekly_Crosses_Below, Ema_50_100_Daily_Crosses_Above, Ema_50_100_Daily_Crosses_Below, Ema_50_100_4_Hourly_Crosses_Above, Ema_50_100_4_Hourly_Crosses_Below, Ema_50_100_1_Hourly_Crosses_Above, Ema_50_100_1_Hourly_Crosses_Below, Ema_50_100_15_Minutes_Crosses_Above, Ema_50_100_15_Minutes_Crosses_Below, Ema_100_200_Yearly_Crosses_Above, Ema_100_200_Yearly_Crosses_Below, Ema_100_200_Quarterly_Crosses_Above, Ema_100_200_Quarterly_Crosses_Below, Ema_100_200_Monthly_Crosses_Above, Ema_100_200_Monthly_Crosses_Below, Ema_100_200_Weekly_Crosses_Above, Ema_100_200_Weekly_Crosses_Below, Ema_100_200_Daily_Crosses_Above, Ema_100_200_Daily_Crosses_Below, Ema_100_200_4_Hourly_Crosses_Above, Ema_100_200_4_Hourly_Crosses_Below, Ema_100_200_1_Hourly_Crosses_Above, Ema_100_200_1_Hourly_Crosses_Below, Ema_100_200_15_Minutes_Crosses_Above, Ema_100_200_15_Minutes_Crosses_Below, Adx_Yearly_Crosses_Above, Adx_Yearly_Crosses_Below, Adx_Quarterly_Crosses_Above, Adx_Quarterly_Crosses_Below, Adx_Monthly_Crosses_Above, Adx_Monthly_Crosses_Below, Adx_Weekly_Crosses_Above, Adx_Weekly_Crosses_Below, Adx_Daily_Crosses_Above, Adx_Daily_Crosses_Below, Adx_4_Hourly_Crosses_Above, Adx_4_Hourly_Crosses_Below, Adx_1_Hourly_Crosses_Above, Adx_1_Hourly_Crosses_Below, Adx_15_Minutes_Crosses_Above, Adx_15_Minutes_Crosses_Below, Rsi_Yearly_Crosses_Above, Rsi_Yearly_Crosses_Below, Rsi_Quarterly_Crosses_Above, Rsi_Quarterly_Crosses_Below, Rsi_Monthly_Crosses_Above, Rsi_Monthly_Crosses_Below, Rsi_Weekly_Crosses_Above, Rsi_Weekly_Crosses_Below, Rsi_Daily_Crosses_Above, Rsi_Daily_Crosses_Below, Rsi_4_Hourly_Crosses_Above, Rsi_4_Hourly_Crosses_Below, Rsi_1_Hourly_Crosses_Above, Rsi_1_Hourly_Crosses_Below, Rsi_15_Minutes_Crosses_Above, Rsi_15_Minutes_Crosses_Below, Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band3_Daily_Less_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band3_Daily_Less_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To, Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To, Upper_Bollinger_Band2_Daily_Less_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To, Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To, Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To, Lower_Bollinger_Band2_Daily_Less_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To, Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To, Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To, Volume_Yearly_Greater_Than_Equal_To, Volume_Yearly_Less_Than_Equal_To, Volume_Quarterly_Greater_Than_Equal_To, Volume_Quarterly_Less_Than_Equal_To, Volume_Monthly_Greater_Than_Equal_To, Volume_Monthly_Less_Than_Equal_To, Volume_Weekly_Greater_Than_Equal_To, Volume_Weekly_Less_Than_Equal_To, Volume_Daily_Greater_Than_Equal_To, Volume_Daily_Less_Than_Equal_To, Volume_4_Hourly_Greater_Than_Equal_To, Volume_4_Hourly_Less_Than_Equal_To, Volume_1_Hourly_Greater_Than_Equal_To, Volume_1_Hourly_Less_Than_Equal_To, Volume_15_Minutes_Greater_Than_Equal_To, Volume_15_Minutes_Less_Than_Equal_To, Adx_Up_Tick_Yearly_Greater_Than_Equal_To, Adx_Down_Tick_Yearly_Less_Than_Equal_To, Adx_Up_Tick_Quarterly_Greater_Than_Equal_To, Adx_Down_Tick_Quarterly_Less_Than_Equal_To, Adx_Up_Tick_Monthly_Greater_Than_Equal_To, Adx_Down_Tick_Monthly_Less_Than_Equal_To, Adx_Up_Tick_Weekly_Greater_Than_Equal_To, Adx_Down_Tick_Weekly_Less_Than_Equal_To, Adx_Up_Tick_Daily_Greater_Than_Equal_To, Adx_Down_Tick_Daily_Less_Than_Equal_To, Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_4_Hourly_Less_Than_Equal_To, Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To, Adx_Down_Tick_1_Hourly_Less_Than_Equal_To, Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To, Adx_Down_Tick_15_Minutes_Less_Than_Equal_To, volume__yearly__shockers, volume__quarterly__shockers, volume__monthly__shockers, volume__weekly__shockers, volume__daily__shockers, volume__4_hourly__shockers, volume__1_hourly__shockers, volume__15_minutes__shockers
from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = 52 -- and Other_Setups is not null
;

;WITH RankedRows AS (
    select batch_no,sno,
	row_number() over (partition by Batch_No order by Batch_No desc, Trade_View_Order asc, Segments_Order desc, Other_Setups desc, Trade_Type_Details_Sum desc ) as report_sort_order
	from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
)
select * 
-- UPDATE a SET Report_Sort_Order = b.report_sort_order
FROM Stocks_Analysis.dbo.Analyse_15Minutes_Stocks a JOIN RankedRows b
ON a.Batch_No = b.Batch_No and a.sno = b.sno
where a.Batch_No = 52
;
end 
---------------------------------------------------------------------------------------------
select top 1000 Report_Sort_Order as rso,* from Stocks_Analysis.dbo.Analyse_Stocks
where Other_Setups is not null
order by Batch_No desc, Report_Sort_Order asc
---------------------------------------------------------------------------------------------
select top 1000 * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_View
where Other_Setups is not null
order by batch_no desc, Report_Sort_Order
;
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_v
;
select distinct batch_no,Symbol from Stocks_Analysis.dbo.Analyse_Stocks_View with (nolock) where Batch_No = 63
;
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks order by Batch_No desc
;
select distinct Symbol from Stocks_Analysis.dbo.Analyse_Stocks_v
;
select distinct batch_no from Stocks_Analysis.dbo.Cash_Stocks 
order by 1
;
end

begin
-- purge the records from cash stocks tables 
select distinct batch_no from Stocks_Analysis.dbo.Cash_15Minutes_Stocks
order by 1
;
-- delete from Stocks_Analysis.dbo.Cash_15Minutes_Stocks where Batch_No < 38
;
select count(1) from Stocks_Analysis.dbo.Cash_15Minutes_Stocks
;

select distinct batch_no from Stocks_Analysis.dbo.Cash_Stocks
order by 1
;
-- delete from Stocks_Analysis.dbo.Cash_Stocks where Batch_No < 43
;
select count(1) from Stocks_Analysis.dbo.Cash_Stocks
;
end

begin
-- purge the records from analyse stocks tables 
select distinct batch_no from Stocks_Analysis.dbo.Analyse_Stocks order by 1
;
delete from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No <=(select 70-15)
;
select count(1) from Stocks_Analysis.dbo.Analyse_Stocks
;

select distinct batch_no from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks order by 1
;
delete from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks where Batch_No <=(select 54-15)
;
select count(1) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
;
end

begin
select *
--DELETE 
FROM Stocks_Analysis.dbo.Analyse_Stocks             where Batch_No <= (select count(distinct Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks) - 15;
select *
--DELETE 
FROM Stocks_Analysis.dbo.Analyse_15Minutes_Stocks   where Batch_No <= (select count(distinct Batch_No) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks) - 15;
select *
--DELETE 
FROM Stocks_Analysis.dbo.Cash_Stocks                where Batch_No <= (select count(distinct Batch_No) from Stocks_Analysis.dbo.Cash_Stocks) - 15;
select *
--DELETE 
FROM Stocks_Analysis.dbo.Cash_15Minutes_Stocks      where Batch_No <= (select count(distinct Batch_No) from Stocks_Analysis.dbo.Cash_15Minutes_Stocks) - 15;
end

begin
-- shrink the log file of the database 
USE Stocks_Analysis;

ALTER DATABASE Stocks_Analysis SET RECOVERY SIMPLE;
DBCC SHRINKFILE (Stocks_Analysis_log, 1); -- Shrinks to 1MB
-- ALTER DATABASE Stocks_Analysis SET RECOVERY FULL
;
SELECT name, recovery_model_desc FROM sys.databases --WHERE name = 'Stocks_Analysis';
end

begin
select distinct batch_no from Stocks_Analysis.dbo.Analyse_Stocks
;
select distinct Batch_No from Stocks_Analysis.dbo.Analyse_Stocks order by 1 desc
;
select distinct Batch_No from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks order by 1 desc
;
select distinct Batch_No from Stocks_Analysis.dbo.Cash_Stocks order by Batch_No desc
;
select distinct Batch_No from Stocks_Analysis.dbo.Cash_15Minutes_Stocks order by Batch_No desc
;
select CONVERT(VARCHAR, SYSDATETIME(), 120), SYSDATETIME()
SELECT FORMAT(GETDATE(), 'yyyyMMddHHmmss'),
    FORMAT(GETDATE(), 'yyyyMMddHHmmss') + 
    RIGHT('000' + CAST(DATEPART(MILLISECOND, GETDATE()) AS VARCHAR), 3) AS FormattedDateTime
, getdate(),FORMAT(DATEADD(HOUR, 23, GETDATE()), 'yyyyMMddHHmmss')

-- UPDATE Stocks_Analysis.dbo.Analyse_15Minutes_Stocks SET batch_no = FORMAT(DATEADD(HOUR, batch_no, GETDATE()), 'yyyyMMddHHmmss')
-- WHERE batch_no BETWEEN 0 AND 100
--update Stocks_Analysis.dbo.Cash_Stocks set Batch_No = 20250724191010
--where Batch_No >= 20250724190000 
--;
end

begin
-- find the sizes of tables 
SELECT 
    t.NAME AS TableName,
    SUM(p.rows) AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB,
    SUM(a.used_pages) * 8 AS UsedSpaceKB,
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
where t.NAME like 'z%' 
GROUP BY 
    t.NAME
ORDER BY 
    TotalSpaceKB DESC;

-- change the schema of the tables
SELECT 'ALTER SCHEMA dbo TRANSFER Stocks_Analysis.dbo.' + name 
FROM sys.objects 
WHERE type = 'U' AND SCHEMA_NAME(schema_id) = 'dbo';
end

begin
DELETE FROM Stocks_Analysis.dbo.Cash_Stocks WHERE batch_no NOT IN (SELECT distinct TOP 15 batch_no FROM Stocks_Analysis.dbo.Cash_Stocks ORDER BY batch_no DESC);
end

begin
select * from Stocks_Analysis.dbo.Analyse_Stocks 
where batch_no =  20250725085552 -- 20250725102550 
and trade_view is not null
order by Batch_No desc;
-- delete from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No in (20250725103420,20250725110948)
-- select distinct batch_no from Stocks_Analysis.dbo.Analyse_Stocks order by 1 desc;
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks -- where trade_view is not null
order by Batch_No desc
;
select * from (select distinct top 3 batch_no,'Cash_Stocks' as tblname from Cash_Stocks order by 1 desc) a
union all
select * from (select distinct top 3 batch_no,'Analyse_Stocks' as tblname from Analyse_Stocks order by 1 desc) b
;
end

begin
with cse as (
select *, indicator + '_' + timeline + '_' + replace(direction,' ','_') as ind_direction
from Cash_Stocks 
where Batch_No = (select max(batch_no) from Cash_Stocks)
)
select distinct ind_direction from cse

select * from (
select batch_no, symbol,ind_direction,sno
from cse) as source
pivot( max(sno) for ind_direction in ([01])) as pivoted
end

begin
WITH cse AS (
    SELECT *,
           indicator + '_' + timeline + '_' + REPLACE(direction, ' ', '_') AS ind_direction
    FROM Cash_Stocks
    WHERE Batch_No = (SELECT MAX(Batch_No) FROM Cash_Stocks)
),
source AS (
    SELECT symbol, ind_direction, MAX(sno) AS sr_value
    FROM cse
    GROUP BY symbol, ind_direction
)
SELECT *
FROM source
PIVOT (
    MAX(sr_value)
    FOR ind_direction IN (adx_daily_crosses_above, adx_quarterly_crosses_above)  -- Add more as needed
) AS pivoted;
end

begin
DECLARE @cols NVARCHAR(MAX), @query NVARCHAR(MAX);

-- Explicit LOB type enforcement inside STRING_AGG
SELECT @cols = STRING_AGG(CAST(QUOTENAME(REPLACE(indicator, ' ', '_') + '_' + REPLACE(timeline, ' ', '_') + '_' + REPLACE(direction, ' ', '_')) AS NVARCHAR(MAX)), ',')
              WITHIN GROUP (ORDER BY indicator)
FROM (
    SELECT DISTINCT indicator, timeline, direction
    FROM Cash_Stocks
    WHERE Batch_No = (SELECT MAX(Batch_No) FROM Cash_Stocks)
) AS temp;

-- Build final query
SET @query = '
WITH cse AS (
    SELECT *,
           REPLACE(indicator, '' '', ''_'') + ''_'' + REPLACE(timeline, '' '', ''_'') + ''_'' + REPLACE(direction, '' '', ''_'') AS ind_direction
    FROM Cash_Stocks
    WHERE Batch_No = (SELECT MAX(Batch_No) FROM Cash_Stocks)
),
source as (
	select symbol, ind_direction
	, 1 as sno
	, MAX(stock_name) as stock_name
	, MAX(bsecode) as bsecode
	, MAX(Percent_Change) as percent_change
	, MAX(price) as price
	, MAX(volume) as volume
	, MAX(Segment) as segment
	, MAX(Batch_No) as batch_no
	from cse
	group by symbol, ind_direction
)
SELECT * 
FROM source
PIVOT (
    MAX(sno)
    FOR ind_direction IN (' + @cols + ')
) AS pivoted
order by symbol';

EXEC sp_executesql @query;
end

begin
USE tempdb;

EXEC sp_helpfile;
DBCC SHRINKFILE (temp9, EMPTYFILE);
ALTER DATABASE tempdb REMOVE FILE temp9;

use Stocks_Analysis;

EXEC sp_helpfile;
DBCC SHRINKFILE (Stocks_Analysis_log, EMPTYFILE);
end

begin

select count(1),batch_no from Analyse_Stocks -- where Trade_Type_Details_Sum is not null
group by Batch_No
;
end

begin

select * from (select distinct top 30 batch_no,'Cash_Stocks' as tblname from Cash_Stocks order by 1 desc) a
union all
select * from (select distinct top 30 batch_no,'Analyse_Stocks' as tblname from Analyse_Stocks order by 1 desc) b
;

select * from Analyse_Stocks where Batch_No = 20250726145435
order by Batch_No desc;
select * from Stocks_Analysis.dbo.Analyse_Stocks_v;
end

begin
EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';


exec sp_rename 'analyse_15minutes_stocks.volume__yearly__shockers','volume_yearly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__quarterly__shockers','volume_quarterly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__monthly__shockers','volume_monthly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__weekly__shockers','volume_weekly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__daily__shockers','volume_daily_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__4_hourly__shockers','volume_4_hourly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__1_hourly__shockers','volume_1_hourly_shockers', 'COLUMN';
exec sp_rename 'analyse_15minutes_stocks.volume__15_minutes__shockers','volume_15_minutes_shockers', 'COLUMN';
end

begin
select * from Analyse_Stocks_v order by 1;
;
select top 10 * from Analyse_Stocks
;
select * from Cash_Stocks 
where batch_no = ( select max(batch_no) from Cash_Stocks)
order by batch_no desc
;
select * from 
Stocks_Analysis.dbo.Master_Segments a
inner join Analyse_Stocks_v b on a.Symbol = b.Symbol
;
end

begin
select * from Stocks_Analysis.dbo.Cash_Stocks 
where Batch_No = (select max(batch_no) from Cash_Stocks)
order by Batch_No desc
;


;WITH cte AS (
    SELECT *, REPLACE(indicator, ' ', '_') + '_' + REPLACE(timeline, ' ', '_') + '_' + REPLACE(direction, ' ', '_') AS ind_direction
    FROM Stocks_Analysis.dbo.Cash_Stocks
    WHERE Batch_No = 20250727075455
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
insert into Stocks_Analysis.dbo.Analyse_Stocks (Symbol,Stock_Name,Percent_Change,Price,Volume,Batch_No,Created_Date,adx_quarterly_crosses_below,adx_1_hourly_crosses_below,adx_4_hourly_crosses_below,adx_weekly_crosses_above,adx_weekly_crosses_below,adx_quarterly_crosses_above,adx_monthly_crosses_below,adx_daily_crosses_above,adx_monthly_crosses_above,adx_15_minutes_crosses_above,adx_4_hourly_crosses_above,adx_daily_crosses_below,adx_yearly_crosses_above,adx_1_hourly_crosses_above,adx_yearly_crosses_below,adx_15_minutes_crosses_below,adx_down_tick_15_minutes_less_than_equal_to,adx_down_tick_1_hourly_less_than_equal_to,adx_down_tick_4_hourly_less_than_equal_to,adx_down_tick_monthly_less_than_equal_to,adx_down_tick_quarterly_less_than_equal_to,adx_down_tick_daily_less_than_equal_to,adx_down_tick_weekly_less_than_equal_to,adx_down_tick_yearly_less_than_equal_to,adx_up_tick_quarterly_greater_than_equal_to,adx_up_tick_1_hourly_greater_than_equal_to,adx_up_tick_4_hourly_greater_than_equal_to,adx_up_tick_yearly_greater_than_equal_to,adx_up_tick_daily_greater_than_equal_to,adx_up_tick_15_minutes_greater_than_equal_to,adx_up_tick_weekly_greater_than_equal_to,adx_up_tick_monthly_greater_than_equal_to,ema_100_200_monthly_crosses_above,ema_100_200_yearly_crosses_above,ema_100_200_quarterly_crosses_below,ema_100_200_daily_crosses_below,ema_100_200_1_hourly_crosses_below,ema_100_200_15_minutes_crosses_below,ema_100_200_quarterly_crosses_above,ema_100_200_weekly_crosses_below,ema_100_200_4_hourly_crosses_above,ema_100_200_daily_crosses_above,ema_100_200_15_minutes_crosses_above,ema_100_200_4_hourly_crosses_below,ema_100_200_yearly_crosses_below,ema_100_200_monthly_crosses_below,ema_100_200_weekly_crosses_above,ema_100_200_1_hourly_crosses_above,ema_13_26_weekly_crosses_above,ema_13_26_1_hourly_crosses_below,ema_13_26_15_minutes_crosses_below,ema_13_26_1_hourly_crosses_above,ema_13_26_daily_crosses_above,ema_13_26_monthly_crosses_above,ema_13_26_yearly_crosses_above,ema_13_26_quarterly_crosses_above,ema_13_26_weekly_crosses_below,ema_13_26_4_hourly_crosses_below,ema_13_26_4_hourly_crosses_above,ema_13_26_daily_crosses_below,ema_13_26_quarterly_crosses_below,ema_13_26_15_minutes_crosses_above,ema_13_26_yearly_crosses_below,ema_13_26_monthly_crosses_below,ema_5_13_weekly_crosses_below,ema_5_13_yearly_crosses_above,ema_5_13_monthly_crosses_above,ema_5_13_1_hourly_crosses_below,ema_5_13_weekly_crosses_above,ema_5_13_quarterly_crosses_below,ema_5_13_daily_crosses_above,ema_5_13_15_minutes_crosses_above,ema_5_13_daily_crosses_below,ema_5_13_1_hourly_crosses_above,ema_5_13_15_minutes_crosses_below,ema_5_13_quarterly_crosses_above,ema_5_13_4_hourly_crosses_below,ema_5_13_yearly_crosses_below,ema_5_13_monthly_crosses_below,ema_5_13_4_hourly_crosses_above,ema_50_100_yearly_crosses_above,ema_50_100_4_hourly_crosses_above,ema_50_100_quarterly_crosses_above,ema_50_100_yearly_crosses_below,ema_50_100_4_hourly_crosses_below,ema_50_100_weekly_crosses_below,ema_50_100_daily_crosses_below,ema_50_100_quarterly_crosses_below,ema_50_100_1_hourly_crosses_above,ema_50_100_monthly_crosses_below,ema_50_100_15_minutes_crosses_above,ema_50_100_daily_crosses_above,ema_50_100_15_minutes_crosses_below,ema_50_100_monthly_crosses_above,ema_50_100_weekly_crosses_above,ema_50_100_1_hourly_crosses_below,lower_bollinger_band2_15_minutes_less_than_equal_to,lower_bollinger_band2_weekly_less_than_equal_to,lower_bollinger_band2_4_hourly_greater_than_equal_to,lower_bollinger_band2_daily_less_than_equal_to,lower_bollinger_band2_monthly_greater_than_equal_to,lower_bollinger_band2_yearly_less_than_equal_to,lower_bollinger_band2_yearly_greater_than_equal_to,lower_bollinger_band2_monthly_less_than_equal_to,lower_bollinger_band2_15_minutes_greater_than_equal_to,lower_bollinger_band2_1_hourly_greater_than_equal_to,lower_bollinger_band2_quarterly_less_than_equal_to,lower_bollinger_band2_daily_greater_than_equal_to,lower_bollinger_band2_weekly_greater_than_equal_to,lower_bollinger_band2_1_hourly_less_than_equal_to,lower_bollinger_band2_quarterly_greater_than_equal_to,lower_bollinger_band2_4_hourly_less_than_equal_to,lower_bollinger_band3_weekly_greater_than_equal_to,lower_bollinger_band3_daily_greater_than_equal_to,lower_bollinger_band3_15_minutes_less_than_equal_to,lower_bollinger_band3_daily_less_than_equal_to,lower_bollinger_band3_quarterly_greater_than_equal_to,lower_bollinger_band3_4_hourly_less_than_equal_to,lower_bollinger_band3_quarterly_less_than_equal_to,lower_bollinger_band3_1_hourly_greater_than_equal_to,lower_bollinger_band3_yearly_less_than_equal_to,lower_bollinger_band3_weekly_less_than_equal_to,lower_bollinger_band3_monthly_less_than_equal_to,lower_bollinger_band3_monthly_greater_than_equal_to,lower_bollinger_band3_yearly_greater_than_equal_to,lower_bollinger_band3_1_hourly_less_than_equal_to,lower_bollinger_band3_4_hourly_greater_than_equal_to,lower_bollinger_band3_15_minutes_greater_than_equal_to,macd_1_hourly_crosses_below,macd_daily_crosses_below,macd_15_minutes_crosses_above,macd_daily_crosses_above,macd_quarterly_crosses_below,macd_yearly_crosses_below,macd_4_hourly_crosses_below,macd_1_hourly_crosses_above,macd_monthly_crosses_above,macd_4_hourly_crosses_above,macd_15_minutes_crosses_below,macd_weekly_crosses_above,macd_monthly_crosses_below,macd_quarterly_crosses_above,macd_weekly_crosses_below,macd_yearly_crosses_above,rsi_yearly_crosses_above,rsi_yearly_crosses_below,rsi_monthly_crosses_above,rsi_daily_crosses_above,rsi_daily_crosses_below,rsi_1_hourly_crosses_below,rsi_weekly_crosses_above,rsi_15_minutes_crosses_below,rsi_monthly_crosses_below,rsi_1_hourly_crosses_above,rsi_4_hourly_crosses_above,rsi_quarterly_crosses_above,rsi_15_minutes_crosses_above,rsi_weekly_crosses_below,rsi_quarterly_crosses_below,rsi_4_hourly_crosses_below,stochastic_quarterly_crosses_above,stochastic_15_minutes_crosses_above,stochastic_monthly_crosses_above,stochastic_monthly_crosses_below,stochastic_weekly_crosses_below,stochastic_1_hourly_crosses_above,stochastic_4_hourly_crosses_above,stochastic_daily_crosses_below,stochastic_yearly_crosses_below,stochastic_4_hourly_crosses_below,stochastic_yearly_crosses_above,stochastic_weekly_crosses_above,stochastic_1_hourly_crosses_below,stochastic_quarterly_crosses_below,stochastic_daily_crosses_above,stochastic_15_minutes_crosses_below,upper_bollinger_band2_15_minutes_less_than_equal_to,upper_bollinger_band2_1_hourly_greater_than_equal_to,upper_bollinger_band2_yearly_less_than_equal_to,upper_bollinger_band2_15_minutes_greater_than_equal_to,upper_bollinger_band2_daily_greater_than_equal_to,upper_bollinger_band2_daily_less_than_equal_to,upper_bollinger_band2_monthly_less_than_equal_to,upper_bollinger_band2_1_hourly_less_than_equal_to,upper_bollinger_band2_quarterly_greater_than_equal_to,upper_bollinger_band2_yearly_greater_than_equal_to,upper_bollinger_band2_4_hourly_less_than_equal_to,upper_bollinger_band2_weekly_less_than_equal_to,upper_bollinger_band2_quarterly_less_than_equal_to,upper_bollinger_band2_4_hourly_greater_than_equal_to,upper_bollinger_band2_monthly_greater_than_equal_to,upper_bollinger_band2_weekly_greater_than_equal_to,upper_bollinger_band3_monthly_greater_than_equal_to,upper_bollinger_band3_weekly_greater_than_equal_to,upper_bollinger_band3_weekly_less_than_equal_to,upper_bollinger_band3_quarterly_less_than_equal_to,upper_bollinger_band3_1_hourly_less_than_equal_to,upper_bollinger_band3_4_hourly_greater_than_equal_to,upper_bollinger_band3_monthly_less_than_equal_to,upper_bollinger_band3_4_hourly_less_than_equal_to,upper_bollinger_band3_daily_less_than_equal_to,upper_bollinger_band3_quarterly_greater_than_equal_to,upper_bollinger_band3_daily_greater_than_equal_to,upper_bollinger_band3_yearly_greater_than_equal_to,upper_bollinger_band3_15_minutes_less_than_equal_to,upper_bollinger_band3_1_hourly_greater_than_equal_to,upper_bollinger_band3_15_minutes_greater_than_equal_to,upper_bollinger_band3_yearly_less_than_equal_to,volume_4_hourly_greater_than_equal_to,volume_daily_greater_than_equal_to,volume_weekly_less_than_equal_to,volume_yearly_shockers,volume_4_hourly_shockers,volume_quarterly_greater_than_equal_to,volume_yearly_less_than_equal_to,volume_1_hourly_shockers,volume_yearly_greater_than_equal_to,volume_daily_less_than_equal_to,volume_monthly_greater_than_equal_to,volume_4_hourly_less_than_equal_to,volume_1_hourly_less_than_equal_to,volume_1_hourly_greater_than_equal_to,volume_weekly_shockers,volume_15_minutes_less_than_equal_to,volume_quarterly_less_than_equal_to,volume_15_minutes_greater_than_equal_to,volume_15_minutes_shockers,volume_monthly_shockers,volume_daily_shockers,volume_monthly_less_than_equal_to,volume_quarterly_shockers,volume_weekly_greater_than_equal_to)
SELECT * 
FROM source
PIVOT (
    MAX(sno)
    FOR ind_direction IN (adx_quarterly_crosses_below,adx_1_hourly_crosses_below,adx_4_hourly_crosses_below,adx_weekly_crosses_above,adx_weekly_crosses_below,adx_quarterly_crosses_above,adx_monthly_crosses_below,adx_daily_crosses_above,adx_monthly_crosses_above,adx_15_minutes_crosses_above,adx_4_hourly_crosses_above,adx_daily_crosses_below,adx_yearly_crosses_above,adx_1_hourly_crosses_above,adx_yearly_crosses_below,adx_15_minutes_crosses_below,adx_down_tick_15_minutes_less_than_equal_to,adx_down_tick_1_hourly_less_than_equal_to,adx_down_tick_4_hourly_less_than_equal_to,adx_down_tick_monthly_less_than_equal_to,adx_down_tick_quarterly_less_than_equal_to,adx_down_tick_daily_less_than_equal_to,adx_down_tick_weekly_less_than_equal_to,adx_down_tick_yearly_less_than_equal_to,adx_up_tick_quarterly_greater_than_equal_to,adx_up_tick_1_hourly_greater_than_equal_to,adx_up_tick_4_hourly_greater_than_equal_to,adx_up_tick_yearly_greater_than_equal_to,adx_up_tick_daily_greater_than_equal_to,adx_up_tick_15_minutes_greater_than_equal_to,adx_up_tick_weekly_greater_than_equal_to,adx_up_tick_monthly_greater_than_equal_to,ema_100_200_monthly_crosses_above,ema_100_200_yearly_crosses_above,ema_100_200_quarterly_crosses_below,ema_100_200_daily_crosses_below,ema_100_200_1_hourly_crosses_below,ema_100_200_15_minutes_crosses_below,ema_100_200_quarterly_crosses_above,ema_100_200_weekly_crosses_below,ema_100_200_4_hourly_crosses_above,ema_100_200_daily_crosses_above,ema_100_200_15_minutes_crosses_above,ema_100_200_4_hourly_crosses_below,ema_100_200_yearly_crosses_below,ema_100_200_monthly_crosses_below,ema_100_200_weekly_crosses_above,ema_100_200_1_hourly_crosses_above,ema_13_26_weekly_crosses_above,ema_13_26_1_hourly_crosses_below,ema_13_26_15_minutes_crosses_below,ema_13_26_1_hourly_crosses_above,ema_13_26_daily_crosses_above,ema_13_26_monthly_crosses_above,ema_13_26_yearly_crosses_above,ema_13_26_quarterly_crosses_above,ema_13_26_weekly_crosses_below,ema_13_26_4_hourly_crosses_below,ema_13_26_4_hourly_crosses_above,ema_13_26_daily_crosses_below,ema_13_26_quarterly_crosses_below,ema_13_26_15_minutes_crosses_above,ema_13_26_yearly_crosses_below,ema_13_26_monthly_crosses_below,ema_5_13_weekly_crosses_below,ema_5_13_yearly_crosses_above,ema_5_13_monthly_crosses_above,ema_5_13_1_hourly_crosses_below,ema_5_13_weekly_crosses_above,ema_5_13_quarterly_crosses_below,ema_5_13_daily_crosses_above,ema_5_13_15_minutes_crosses_above,ema_5_13_daily_crosses_below,ema_5_13_1_hourly_crosses_above,ema_5_13_15_minutes_crosses_below,ema_5_13_quarterly_crosses_above,ema_5_13_4_hourly_crosses_below,ema_5_13_yearly_crosses_below,ema_5_13_monthly_crosses_below,ema_5_13_4_hourly_crosses_above,ema_50_100_yearly_crosses_above,ema_50_100_4_hourly_crosses_above,ema_50_100_quarterly_crosses_above,ema_50_100_yearly_crosses_below,ema_50_100_4_hourly_crosses_below,ema_50_100_weekly_crosses_below,ema_50_100_daily_crosses_below,ema_50_100_quarterly_crosses_below,ema_50_100_1_hourly_crosses_above,ema_50_100_monthly_crosses_below,ema_50_100_15_minutes_crosses_above,ema_50_100_daily_crosses_above,ema_50_100_15_minutes_crosses_below,ema_50_100_monthly_crosses_above,ema_50_100_weekly_crosses_above,ema_50_100_1_hourly_crosses_below,lower_bollinger_band2_15_minutes_less_than_equal_to,lower_bollinger_band2_weekly_less_than_equal_to,lower_bollinger_band2_4_hourly_greater_than_equal_to,lower_bollinger_band2_daily_less_than_equal_to,lower_bollinger_band2_monthly_greater_than_equal_to,lower_bollinger_band2_yearly_less_than_equal_to,lower_bollinger_band2_yearly_greater_than_equal_to,lower_bollinger_band2_monthly_less_than_equal_to,lower_bollinger_band2_15_minutes_greater_than_equal_to,lower_bollinger_band2_1_hourly_greater_than_equal_to,lower_bollinger_band2_quarterly_less_than_equal_to,lower_bollinger_band2_daily_greater_than_equal_to,lower_bollinger_band2_weekly_greater_than_equal_to,lower_bollinger_band2_1_hourly_less_than_equal_to,lower_bollinger_band2_quarterly_greater_than_equal_to,lower_bollinger_band2_4_hourly_less_than_equal_to,lower_bollinger_band3_weekly_greater_than_equal_to,lower_bollinger_band3_daily_greater_than_equal_to,lower_bollinger_band3_15_minutes_less_than_equal_to,lower_bollinger_band3_daily_less_than_equal_to,lower_bollinger_band3_quarterly_greater_than_equal_to,lower_bollinger_band3_4_hourly_less_than_equal_to,lower_bollinger_band3_quarterly_less_than_equal_to,lower_bollinger_band3_1_hourly_greater_than_equal_to,lower_bollinger_band3_yearly_less_than_equal_to,lower_bollinger_band3_weekly_less_than_equal_to,lower_bollinger_band3_monthly_less_than_equal_to,lower_bollinger_band3_monthly_greater_than_equal_to,lower_bollinger_band3_yearly_greater_than_equal_to,lower_bollinger_band3_1_hourly_less_than_equal_to,lower_bollinger_band3_4_hourly_greater_than_equal_to,lower_bollinger_band3_15_minutes_greater_than_equal_to,macd_1_hourly_crosses_below,macd_daily_crosses_below,macd_15_minutes_crosses_above,macd_daily_crosses_above,macd_quarterly_crosses_below,macd_yearly_crosses_below,macd_4_hourly_crosses_below,macd_1_hourly_crosses_above,macd_monthly_crosses_above,macd_4_hourly_crosses_above,macd_15_minutes_crosses_below,macd_weekly_crosses_above,macd_monthly_crosses_below,macd_quarterly_crosses_above,macd_weekly_crosses_below,macd_yearly_crosses_above,rsi_yearly_crosses_above,rsi_yearly_crosses_below,rsi_monthly_crosses_above,rsi_daily_crosses_above,rsi_daily_crosses_below,rsi_1_hourly_crosses_below,rsi_weekly_crosses_above,rsi_15_minutes_crosses_below,rsi_monthly_crosses_below,rsi_1_hourly_crosses_above,rsi_4_hourly_crosses_above,rsi_quarterly_crosses_above,rsi_15_minutes_crosses_above,rsi_weekly_crosses_below,rsi_quarterly_crosses_below,rsi_4_hourly_crosses_below,stochastic_quarterly_crosses_above,stochastic_15_minutes_crosses_above,stochastic_monthly_crosses_above,stochastic_monthly_crosses_below,stochastic_weekly_crosses_below,stochastic_1_hourly_crosses_above,stochastic_4_hourly_crosses_above,stochastic_daily_crosses_below,stochastic_yearly_crosses_below,stochastic_4_hourly_crosses_below,stochastic_yearly_crosses_above,stochastic_weekly_crosses_above,stochastic_1_hourly_crosses_below,stochastic_quarterly_crosses_below,stochastic_daily_crosses_above,stochastic_15_minutes_crosses_below,upper_bollinger_band2_15_minutes_less_than_equal_to,upper_bollinger_band2_1_hourly_greater_than_equal_to,upper_bollinger_band2_yearly_less_than_equal_to,upper_bollinger_band2_15_minutes_greater_than_equal_to,upper_bollinger_band2_daily_greater_than_equal_to,upper_bollinger_band2_daily_less_than_equal_to,upper_bollinger_band2_monthly_less_than_equal_to,upper_bollinger_band2_1_hourly_less_than_equal_to,upper_bollinger_band2_quarterly_greater_than_equal_to,upper_bollinger_band2_yearly_greater_than_equal_to,upper_bollinger_band2_4_hourly_less_than_equal_to,upper_bollinger_band2_weekly_less_than_equal_to,upper_bollinger_band2_quarterly_less_than_equal_to,upper_bollinger_band2_4_hourly_greater_than_equal_to,upper_bollinger_band2_monthly_greater_than_equal_to,upper_bollinger_band2_weekly_greater_than_equal_to,upper_bollinger_band3_monthly_greater_than_equal_to,upper_bollinger_band3_weekly_greater_than_equal_to,upper_bollinger_band3_weekly_less_than_equal_to,upper_bollinger_band3_quarterly_less_than_equal_to,upper_bollinger_band3_1_hourly_less_than_equal_to,upper_bollinger_band3_4_hourly_greater_than_equal_to,upper_bollinger_band3_monthly_less_than_equal_to,upper_bollinger_band3_4_hourly_less_than_equal_to,upper_bollinger_band3_daily_less_than_equal_to,upper_bollinger_band3_quarterly_greater_than_equal_to,upper_bollinger_band3_daily_greater_than_equal_to,upper_bollinger_band3_yearly_greater_than_equal_to,upper_bollinger_band3_15_minutes_less_than_equal_to,upper_bollinger_band3_1_hourly_greater_than_equal_to,upper_bollinger_band3_15_minutes_greater_than_equal_to,upper_bollinger_band3_yearly_less_than_equal_to,volume_4_hourly_greater_than_equal_to,volume_daily_greater_than_equal_to,volume_weekly_less_than_equal_to,volume_yearly_shockers,volume_4_hourly_shockers,volume_quarterly_greater_than_equal_to,volume_yearly_less_than_equal_to,volume_1_hourly_shockers,volume_yearly_greater_than_equal_to,volume_daily_less_than_equal_to,volume_monthly_greater_than_equal_to,volume_4_hourly_less_than_equal_to,volume_1_hourly_less_than_equal_to,volume_1_hourly_greater_than_equal_to,volume_weekly_shockers,volume_15_minutes_less_than_equal_to,volume_quarterly_less_than_equal_to,volume_15_minutes_greater_than_equal_to,volume_15_minutes_shockers,volume_monthly_shockers,volume_daily_shockers,volume_monthly_less_than_equal_to,volume_quarterly_shockers,volume_weekly_greater_than_equal_to)
) AS pivoted
order by symbol;
end

begin
select * from Stocks_Analysis.dbo.ScreenSort
select * from Stocks_Analysis.dbo.Sector_Table
select * from Stocks_Analysis.dbo.master_segments
select * from Stocks_Analysis.dbo.master_segments_distinct
end

begin
EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

exec sp_rename 'Analyse_15Minutes_Stocks.Report_Sort_Order'          ,Report_Sort_Order        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trading View'               ,trade_view             ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trading View - Order'       ,Trade_View_Order       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Segments - Order'           ,Segments_Order           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Other_Setups - Sum'      ,Volume_Shockers_Sum      ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type Details'         ,Trade_Type_Details       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type Details - Sum'   ,Trade_Type_Details_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Percent_Change'                      ,Percent_Change           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type'                 ,Trade_Type               ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type - Length'        ,Trade_Type_Length        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type - Bullish Sum'   ,Trade_Type_Bullish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type - Bearish Sum'   ,Trade_Type_Bearish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Trade Type Details - Length',Trade_Type_Details_Length,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Segments - Length'          ,Segments_Length          ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Segments_Sum'             ,Segments_Sum             ,'column';

end

begin
EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

exec sp_rename 'Analyse_15Minutes_Stocks.Report_Sort_Order'			   ,Report_Sort_Order        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trading View]'               ,trade_view             ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trading View - Order]'       ,Trade_View_Order       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Segments - Order]'           ,Segments_Order           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Other_Setups - Sum]'      ,Volume_Shockers_Sum      ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details]'         ,Trade_Type_Details       ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details - Sum]'   ,Trade_Type_Details_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Percent_Change'               ,Percent_Change           ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type]'                 ,Trade_Type               ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Length]'        ,Trade_Type_Length        ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Bullish Sum]'   ,Trade_Type_Bullish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type - Bearish Sum]'   ,Trade_Type_Bearish_Sum   ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Trade Type Details - Length]',Trade_Type_Details_Length,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.[Segments - Length]'          ,Segments_Length          ,'column';
exec sp_rename 'Analyse_15Minutes_Stocks.Segments_Sum'				   ,Segments_Sum             ,'column';

--sno -- Sno
--% Cng - Percent_change
--segments - segments
--end
end

begin
-- Value Pivot (numeric data)
WITH ValueSource AS 
(	SELECT Batch_No, Screen_Names, Value /*,TRY_CAST(Value AS NUMERIC(18,0)) AS Value*/ 
    FROM Master_Screen_Name_Values WHERE Batch_No = 1
),
ValuePivot AS 
(	SELECT * FROM ValueSource
    PIVOT (SUM(Value) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])) AS vp
) -- Final Output with DataType column for clarity
SELECT 'Value' AS DataType, * FROM ValuePivot
;
-- Description Pivot (text data)
WITH DescSource AS 
(	SELECT Batch_No, Screen_Names, Description 
	FROM Master_Screen_Name_Values 
	WHERE Batch_No = 1
),
DescPivot AS 
(	SELECT * FROM DescSource a 
	PIVOT (MAX(Description) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
		  ) AS dp
)
SELECT 'Description' AS DataType, * FROM DescPivot
;
end

begin
-- update screen values 

begin -- version 2 
with SourceValues as 
(
SELECT Batch_No,Metric,[Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly]
FROM (
    SELECT Batch_No, Screen_Names, Metric, ColValue 
    FROM Master_Screen_Name_Values
    CROSS APPLY (
        VALUES 
            ('Value', CAST(Value AS VARCHAR)),
            ('Description', Description)
    ) AS Metrics(Metric, ColValue)
) AS SourceTable
PIVOT (
    MAX(ColValue) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
) AS PivotTable
where Batch_No = 1
)
SELECT 'Calculate' as tbl,
    a.Symbol,
    a.Batch_No,
    Trade_Type = ISNULL(a.Trade_Type, '') + CASE 
		WHEN	a.Bullish_Single_Screen_Yearly           >0 OR 
				a.Bullish_Single_Screen_Quarterly        >0 OR 
				a.Bullish_Single_Screen_Monthly          >0 OR 
				a.Bullish_Single_Screen_Weekly           >0 OR 
				a.Bullish_Single_Screen_Daily            >0 OR 
				a.Bullish_Single_Screen_4_Hourly         >0 OR 
				a.Bullish_Single_Screen_1_Hourly         >0 OR 
				a.Bullish_Single_Screen_15_Minutes       >0 OR 
				a.Bullish_Double_Screen_Strong_Quarterly >0 OR 
				a.Bullish_Double_Screen_Strong_Monthly   >0 OR 
				a.Bullish_Double_Screen_Strong_Weekly    >0 OR 
				a.Bullish_Double_Screen_Strong_Daily     >0 OR 
				a.Bullish_Double_Screen_Strong_4_Hourly  >0 OR 
				a.Bullish_Double_Screen_Strong_1_Hourly  >0 OR 
				a.Bullish_Triple_Screen_Strong_Weekly    >0 OR 
				a.Bullish_Triple_Screen_Strong_Daily     >0 OR 
				a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then 'Bullish;' 
		WHEN	a.Bearish_Single_Screen_Yearly           >0 OR 
				a.Bearish_Single_Screen_Quarterly        >0 OR 
				a.Bearish_Single_Screen_Monthly          >0 OR 
				a.Bearish_Single_Screen_Weekly           >0 OR 
				a.Bearish_Single_Screen_Daily            >0 OR 
				a.Bearish_Single_Screen_4_Hourly         >0 OR 
				a.Bearish_Single_Screen_1_Hourly         >0 OR 
				a.Bearish_Single_Screen_15_Minutes       >0 OR 
				a.Bearish_Double_Screen_Strong_Quarterly >0 OR 
				a.Bearish_Double_Screen_Strong_Monthly   >0 OR 
				a.Bearish_Double_Screen_Strong_Weekly    >0 OR 
				a.Bearish_Double_Screen_Strong_Daily     >0 OR 
				a.Bearish_Double_Screen_Strong_4_Hourly  >0 OR 
				a.Bearish_Double_Screen_Strong_1_Hourly  >0 OR 
				a.Bearish_Triple_Screen_Strong_Weekly    >0 OR 
				a.Bearish_Triple_Screen_Strong_Daily     >0 OR 
				a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then 'Bullish;'
        ELSE ''
	END,
    Trade_Type_Details = ISNULL(a.Trade_Type_Details, '') + COALESCE(CASE
		when a.Bullish_Single_Screen_Yearly           >0 then dp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then dp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then dp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then dp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then dp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then dp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then dp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then dp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then dp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then dp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then dp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then dp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then dp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then dp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then dp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then dp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then dp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then dp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then dp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then dp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then dp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then dp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then dp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then dp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then dp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then dp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then dp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then dp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then dp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then dp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then dp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then dp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bearish_Triple_Screen_Strong_4_Hourly
        ELSE '' END, ''),
    Trade_Type_Details_Sum = ISNULL(a.Trade_Type_Details_Sum, 0) + COALESCE(CASE
			when a.Bullish_Single_Screen_Yearly           >0 then vp.Bullish_Single_Screen_Yearly
			when a.Bullish_Single_Screen_Quarterly        >0 then vp.Bullish_Single_Screen_Quarterly
			when a.Bullish_Single_Screen_Monthly          >0 then vp.Bullish_Single_Screen_Monthly
			when a.Bullish_Single_Screen_Weekly           >0 then vp.Bullish_Single_Screen_Weekly
			when a.Bullish_Single_Screen_Daily            >0 then vp.Bullish_Single_Screen_Daily
			when a.Bullish_Single_Screen_4_Hourly         >0 then vp.Bullish_Single_Screen_4_Hourly
			when a.Bullish_Single_Screen_1_Hourly         >0 then vp.Bullish_Single_Screen_1_Hourly
			when a.Bullish_Single_Screen_15_Minutes       >0 then vp.Bullish_Single_Screen_15_Minutes
			when a.Bullish_Double_Screen_Strong_Quarterly >0 then vp.Bullish_Double_Screen_Strong_Quarterly
			when a.Bullish_Double_Screen_Strong_Monthly   >0 then vp.Bullish_Double_Screen_Strong_Monthly
			when a.Bullish_Double_Screen_Strong_Weekly    >0 then vp.Bullish_Double_Screen_Strong_Weekly
			when a.Bullish_Double_Screen_Strong_Daily     >0 then vp.Bullish_Double_Screen_Strong_Daily
			when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then vp.Bullish_Double_Screen_Strong_4_Hourly
			when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then vp.Bullish_Double_Screen_Strong_1_Hourly
			when a.Bullish_Triple_Screen_Strong_Weekly    >0 then vp.Bullish_Triple_Screen_Strong_Weekly
			when a.Bullish_Triple_Screen_Strong_Daily     >0 then vp.Bullish_Triple_Screen_Strong_Daily
			when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bullish_Triple_Screen_Strong_4_Hourly
			when a.Bearish_Single_Screen_Yearly           >0 then vp.Bearish_Single_Screen_Yearly
			when a.Bearish_Single_Screen_Quarterly        >0 then vp.Bearish_Single_Screen_Quarterly
			when a.Bearish_Single_Screen_Monthly          >0 then vp.Bearish_Single_Screen_Monthly
			when a.Bearish_Single_Screen_Weekly           >0 then vp.Bearish_Single_Screen_Weekly
			when a.Bearish_Single_Screen_Daily            >0 then vp.Bearish_Single_Screen_Daily
			when a.Bearish_Single_Screen_4_Hourly         >0 then vp.Bearish_Single_Screen_4_Hourly
			when a.Bearish_Single_Screen_1_Hourly         >0 then vp.Bearish_Single_Screen_1_Hourly
			when a.Bearish_Single_Screen_15_Minutes       >0 then vp.Bearish_Single_Screen_15_Minutes
			when a.Bearish_Double_Screen_Strong_Quarterly >0 then vp.Bearish_Double_Screen_Strong_Quarterly
			when a.Bearish_Double_Screen_Strong_Monthly   >0 then vp.Bearish_Double_Screen_Strong_Monthly
			when a.Bearish_Double_Screen_Strong_Weekly    >0 then vp.Bearish_Double_Screen_Strong_Weekly
			when a.Bearish_Double_Screen_Strong_Daily     >0 then vp.Bearish_Double_Screen_Strong_Daily
			when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then vp.Bearish_Double_Screen_Strong_4_Hourly
			when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then vp.Bearish_Double_Screen_Strong_1_Hourly
			when a.Bearish_Triple_Screen_Strong_Weekly    >0 then vp.Bearish_Triple_Screen_Strong_Weekly
			when a.Bearish_Triple_Screen_Strong_Daily     >0 then vp.Bearish_Triple_Screen_Strong_Daily
			when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bearish_Triple_Screen_Strong_4_Hourly
            ELSE 0 END, 0),
    Trade_Type_Bullish_Sum = ISNULL(a.Trade_Type_Bullish_Sum, 0) + COALESCE(CASE
			when a.Bullish_Single_Screen_Yearly           >0 then ISNULL(vp.Bullish_Single_Screen_Yearly		  , 0)
			when a.Bullish_Single_Screen_Quarterly        >0 then ISNULL(vp.Bullish_Single_Screen_Quarterly		  , 0)
			when a.Bullish_Single_Screen_Monthly          >0 then ISNULL(vp.Bullish_Single_Screen_Monthly		  , 0)
			when a.Bullish_Single_Screen_Weekly           >0 then ISNULL(vp.Bullish_Single_Screen_Weekly		  , 0)
			when a.Bullish_Single_Screen_Daily            >0 then ISNULL(vp.Bullish_Single_Screen_Daily			  , 0)
			when a.Bullish_Single_Screen_4_Hourly         >0 then ISNULL(vp.Bullish_Single_Screen_4_Hourly		  , 0)
			when a.Bullish_Single_Screen_1_Hourly         >0 then ISNULL(vp.Bullish_Single_Screen_1_Hourly		  , 0)
			when a.Bullish_Single_Screen_15_Minutes       >0 then ISNULL(vp.Bullish_Single_Screen_15_Minutes	  , 0)
			when a.Bullish_Double_Screen_Strong_Quarterly >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Quarterly, 0)
			when a.Bullish_Double_Screen_Strong_Monthly   >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Monthly  , 0)
			when a.Bullish_Double_Screen_Strong_Weekly    >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Weekly	  , 0)
			when a.Bullish_Double_Screen_Strong_Daily     >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Daily	  , 0)
			when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bullish_Double_Screen_Strong_4_Hourly , 0)
			when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then ISNULL(vp.Bullish_Double_Screen_Strong_1_Hourly , 0)
			when a.Bullish_Triple_Screen_Strong_Weekly    >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_Weekly	  , 0)
			when a.Bullish_Triple_Screen_Strong_Daily     >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_Daily	  , 0)
			when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_4_Hourly , 0)
            ELSE 0 END, 0),
    Trade_Type_Bearish_Sum = ISNULL(a.Trade_Type_Bearish_Sum, 0) + COALESCE(CASE
			when a.Bearish_Single_Screen_Yearly           >0 then ISNULL(vp.Bearish_Single_Screen_Yearly		  , 0)
			when a.Bearish_Single_Screen_Quarterly        >0 then ISNULL(vp.Bearish_Single_Screen_Quarterly		  , 0)
			when a.Bearish_Single_Screen_Monthly          >0 then ISNULL(vp.Bearish_Single_Screen_Monthly		  , 0)
			when a.Bearish_Single_Screen_Weekly           >0 then ISNULL(vp.Bearish_Single_Screen_Weekly		  , 0)
			when a.Bearish_Single_Screen_Daily            >0 then ISNULL(vp.Bearish_Single_Screen_Daily			  , 0)
			when a.Bearish_Single_Screen_4_Hourly         >0 then ISNULL(vp.Bearish_Single_Screen_4_Hourly		  , 0)
			when a.Bearish_Single_Screen_1_Hourly         >0 then ISNULL(vp.Bearish_Single_Screen_1_Hourly		  , 0)
			when a.Bearish_Single_Screen_15_Minutes       >0 then ISNULL(vp.Bearish_Single_Screen_15_Minutes	  , 0)
			when a.Bearish_Double_Screen_Strong_Quarterly >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Quarterly, 0)
			when a.Bearish_Double_Screen_Strong_Monthly   >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Monthly  , 0)
			when a.Bearish_Double_Screen_Strong_Weekly    >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Weekly	  , 0)
			when a.Bearish_Double_Screen_Strong_Daily     >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Daily	  , 0)
			when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bearish_Double_Screen_Strong_4_Hourly , 0)
			when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then ISNULL(vp.Bearish_Double_Screen_Strong_1_Hourly , 0)
			when a.Bearish_Triple_Screen_Strong_Weekly    >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_Weekly	  , 0)
			when a.Bearish_Triple_Screen_Strong_Daily     >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_Daily	  , 0)
			when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_4_Hourly , 0)
            ELSE 0 END, 0)
FROM Stocks_Analysis.dbo.Analyse_Stocks a 
JOIN SourceValues dp on dp.Metric = 'Description'
JOIN SourceValues vp on vp.Metric = 'Value' AND a.Batch_No = (SELECT MAX(Batch_No) FROM Analyse_Stocks)
where ISNULL(a.Trade_Type_Details_Sum, 0) > 0

union all

select 'Analyse_Stocks' as tbl,symbol,Batch_No,Trade_Type,Trade_Type_Details,Trade_Type_Details_Sum,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum
from Analyse_stocks where Batch_No = (select max(batch_no) from Analyse_Stocks) and len(trade_type_details) >5
order by Symbol,tbl
end
-- OR
begin -- version 1 
WITH 
ValueSource AS 
(	SELECT Batch_No, Screen_Names, Value FROM Master_Screen_Name_Values WHERE Batch_No = 1
)
,ValuePivot AS 
(   SELECT *
    FROM ValueSource PIVOT 
	(SUM(Value) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
	) AS vp
)
,DescSource AS 
(	SELECT Batch_No, Screen_Names, Description FROM Master_Screen_Name_Values WHERE Batch_No = 1
)
,DescPivot AS 
(	SELECT * FROM DescSource PIVOT 
	( MAX(Description) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
    ) AS dp
)
SELECT 'Calculate' as tbl,
    a.Symbol,
    a.Batch_No,
    Trade_Type = ISNULL(a.Trade_Type, '') + 
	CASE 
		When	a.Bullish_Single_Screen_Yearly           >0 OR 
				a.Bullish_Single_Screen_Quarterly        >0 OR 
				a.Bullish_Single_Screen_Monthly          >0 OR 
				a.Bullish_Single_Screen_Weekly           >0 OR 
				a.Bullish_Single_Screen_Daily            >0 OR 
				a.Bullish_Single_Screen_4_Hourly         >0 OR 
				a.Bullish_Single_Screen_1_Hourly         >0 OR 
				a.Bullish_Single_Screen_15_Minutes       >0 OR 
				a.Bullish_Double_Screen_Strong_Quarterly >0 OR 
				a.Bullish_Double_Screen_Strong_Monthly   >0 OR 
				a.Bullish_Double_Screen_Strong_Weekly    >0 OR 
				a.Bullish_Double_Screen_Strong_Daily     >0 OR 
				a.Bullish_Double_Screen_Strong_4_Hourly  >0 OR 
				a.Bullish_Double_Screen_Strong_1_Hourly  >0 OR 
				a.Bullish_Triple_Screen_Strong_Weekly    >0 OR 
				a.Bullish_Triple_Screen_Strong_Daily     >0 OR 
				a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then 'Bullish;' 
		When	a.Bearish_Single_Screen_Yearly           >0 OR 
				a.Bearish_Single_Screen_Quarterly        >0 OR 
				a.Bearish_Single_Screen_Monthly          >0 OR 
				a.Bearish_Single_Screen_Weekly           >0 OR 
				a.Bearish_Single_Screen_Daily            >0 OR 
				a.Bearish_Single_Screen_4_Hourly         >0 OR 
				a.Bearish_Single_Screen_1_Hourly         >0 OR 
				a.Bearish_Single_Screen_15_Minutes       >0 OR 
				a.Bearish_Double_Screen_Strong_Quarterly >0 OR 
				a.Bearish_Double_Screen_Strong_Monthly   >0 OR 
				a.Bearish_Double_Screen_Strong_Weekly    >0 OR 
				a.Bearish_Double_Screen_Strong_Daily     >0 OR 
				a.Bearish_Double_Screen_Strong_4_Hourly  >0 OR 
				a.Bearish_Double_Screen_Strong_1_Hourly  >0 OR 
				a.Bearish_Triple_Screen_Strong_Weekly    >0 OR 
				a.Bearish_Triple_Screen_Strong_Daily     >0 OR 
				a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then 'Bullish;'
        ELSE ''
	END,
    Trade_Type_Details = ISNULL(a.Trade_Type_Details, '') +
    COALESCE(
    CASE
		when a.Bullish_Single_Screen_Yearly           >0 then dp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then dp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then dp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then dp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then dp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then dp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then dp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then dp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then dp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then dp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then dp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then dp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then dp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then dp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then dp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then dp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then dp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then dp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then dp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then dp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then dp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then dp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then dp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then dp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then dp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then dp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then dp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then dp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then dp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then dp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then dp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then dp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bearish_Triple_Screen_Strong_4_Hourly
        ELSE ''
    END, ''),
    Trade_Type_Details_Sum = ISNULL(a.Trade_Type_Details_Sum, 0) + 
        COALESCE(
		CASE
			when a.Bullish_Single_Screen_Yearly           >0 then vp.Bullish_Single_Screen_Yearly
			when a.Bullish_Single_Screen_Quarterly        >0 then vp.Bullish_Single_Screen_Quarterly
			when a.Bullish_Single_Screen_Monthly          >0 then vp.Bullish_Single_Screen_Monthly
			when a.Bullish_Single_Screen_Weekly           >0 then vp.Bullish_Single_Screen_Weekly
			when a.Bullish_Single_Screen_Daily            >0 then vp.Bullish_Single_Screen_Daily
			when a.Bullish_Single_Screen_4_Hourly         >0 then vp.Bullish_Single_Screen_4_Hourly
			when a.Bullish_Single_Screen_1_Hourly         >0 then vp.Bullish_Single_Screen_1_Hourly
			when a.Bullish_Single_Screen_15_Minutes       >0 then vp.Bullish_Single_Screen_15_Minutes
			when a.Bullish_Double_Screen_Strong_Quarterly >0 then vp.Bullish_Double_Screen_Strong_Quarterly
			when a.Bullish_Double_Screen_Strong_Monthly   >0 then vp.Bullish_Double_Screen_Strong_Monthly
			when a.Bullish_Double_Screen_Strong_Weekly    >0 then vp.Bullish_Double_Screen_Strong_Weekly
			when a.Bullish_Double_Screen_Strong_Daily     >0 then vp.Bullish_Double_Screen_Strong_Daily
			when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then vp.Bullish_Double_Screen_Strong_4_Hourly
			when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then vp.Bullish_Double_Screen_Strong_1_Hourly
			when a.Bullish_Triple_Screen_Strong_Weekly    >0 then vp.Bullish_Triple_Screen_Strong_Weekly
			when a.Bullish_Triple_Screen_Strong_Daily     >0 then vp.Bullish_Triple_Screen_Strong_Daily
			when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bullish_Triple_Screen_Strong_4_Hourly
			when a.Bearish_Single_Screen_Yearly           >0 then vp.Bearish_Single_Screen_Yearly
			when a.Bearish_Single_Screen_Quarterly        >0 then vp.Bearish_Single_Screen_Quarterly
			when a.Bearish_Single_Screen_Monthly          >0 then vp.Bearish_Single_Screen_Monthly
			when a.Bearish_Single_Screen_Weekly           >0 then vp.Bearish_Single_Screen_Weekly
			when a.Bearish_Single_Screen_Daily            >0 then vp.Bearish_Single_Screen_Daily
			when a.Bearish_Single_Screen_4_Hourly         >0 then vp.Bearish_Single_Screen_4_Hourly
			when a.Bearish_Single_Screen_1_Hourly         >0 then vp.Bearish_Single_Screen_1_Hourly
			when a.Bearish_Single_Screen_15_Minutes       >0 then vp.Bearish_Single_Screen_15_Minutes
			when a.Bearish_Double_Screen_Strong_Quarterly >0 then vp.Bearish_Double_Screen_Strong_Quarterly
			when a.Bearish_Double_Screen_Strong_Monthly   >0 then vp.Bearish_Double_Screen_Strong_Monthly
			when a.Bearish_Double_Screen_Strong_Weekly    >0 then vp.Bearish_Double_Screen_Strong_Weekly
			when a.Bearish_Double_Screen_Strong_Daily     >0 then vp.Bearish_Double_Screen_Strong_Daily
			when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then vp.Bearish_Double_Screen_Strong_4_Hourly
			when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then vp.Bearish_Double_Screen_Strong_1_Hourly
			when a.Bearish_Triple_Screen_Strong_Weekly    >0 then vp.Bearish_Triple_Screen_Strong_Weekly
			when a.Bearish_Triple_Screen_Strong_Daily     >0 then vp.Bearish_Triple_Screen_Strong_Daily
			when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bearish_Triple_Screen_Strong_4_Hourly
            ELSE 0
        END, 0),
    Trade_Type_Bullish_Sum = ISNULL(a.Trade_Type_Bullish_Sum, 0) +
        COALESCE(
		CASE
			when a.Bullish_Single_Screen_Yearly           >0 then ISNULL(vp.Bullish_Single_Screen_Yearly		  , 0 )
			when a.Bullish_Single_Screen_Quarterly        >0 then ISNULL(vp.Bullish_Single_Screen_Quarterly		  , 0 )
			when a.Bullish_Single_Screen_Monthly          >0 then ISNULL(vp.Bullish_Single_Screen_Monthly		  , 0 )
			when a.Bullish_Single_Screen_Weekly           >0 then ISNULL(vp.Bullish_Single_Screen_Weekly		  , 0 )
			when a.Bullish_Single_Screen_Daily            >0 then ISNULL(vp.Bullish_Single_Screen_Daily			  , 0 )
			when a.Bullish_Single_Screen_4_Hourly         >0 then ISNULL(vp.Bullish_Single_Screen_4_Hourly		  , 0 )
			when a.Bullish_Single_Screen_1_Hourly         >0 then ISNULL(vp.Bullish_Single_Screen_1_Hourly		  , 0 )
			when a.Bullish_Single_Screen_15_Minutes       >0 then ISNULL(vp.Bullish_Single_Screen_15_Minutes	  , 0 )
			when a.Bullish_Double_Screen_Strong_Quarterly >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Quarterly, 0 )
			when a.Bullish_Double_Screen_Strong_Monthly   >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Monthly  , 0 )
			when a.Bullish_Double_Screen_Strong_Weekly    >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Weekly	  , 0 )
			when a.Bullish_Double_Screen_Strong_Daily     >0 then ISNULL(vp.Bullish_Double_Screen_Strong_Daily	  , 0 )
			when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bullish_Double_Screen_Strong_4_Hourly , 0 )
			when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then ISNULL(vp.Bullish_Double_Screen_Strong_1_Hourly , 0 )
			when a.Bullish_Triple_Screen_Strong_Weekly    >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_Weekly	  , 0 )
			when a.Bullish_Triple_Screen_Strong_Daily     >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_Daily	  , 0 )
			when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bullish_Triple_Screen_Strong_4_Hourly , 0 )
            ELSE 0
        END, 0),

    Trade_Type_Bearish_Sum = ISNULL(a.Trade_Type_Bearish_Sum, 0) +
        COALESCE(
		CASE
			when a.Bearish_Single_Screen_Yearly           >0 then ISNULL(vp.Bearish_Single_Screen_Yearly		  , 0)
			when a.Bearish_Single_Screen_Quarterly        >0 then ISNULL(vp.Bearish_Single_Screen_Quarterly		  , 0)
			when a.Bearish_Single_Screen_Monthly          >0 then ISNULL(vp.Bearish_Single_Screen_Monthly		  , 0)
			when a.Bearish_Single_Screen_Weekly           >0 then ISNULL(vp.Bearish_Single_Screen_Weekly		  , 0)
			when a.Bearish_Single_Screen_Daily            >0 then ISNULL(vp.Bearish_Single_Screen_Daily			  , 0)
			when a.Bearish_Single_Screen_4_Hourly         >0 then ISNULL(vp.Bearish_Single_Screen_4_Hourly		  , 0)
			when a.Bearish_Single_Screen_1_Hourly         >0 then ISNULL(vp.Bearish_Single_Screen_1_Hourly		  , 0)
			when a.Bearish_Single_Screen_15_Minutes       >0 then ISNULL(vp.Bearish_Single_Screen_15_Minutes	  , 0)
			when a.Bearish_Double_Screen_Strong_Quarterly >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Quarterly, 0)
			when a.Bearish_Double_Screen_Strong_Monthly   >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Monthly  , 0)
			when a.Bearish_Double_Screen_Strong_Weekly    >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Weekly	  , 0)
			when a.Bearish_Double_Screen_Strong_Daily     >0 then ISNULL(vp.Bearish_Double_Screen_Strong_Daily	  , 0)
			when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bearish_Double_Screen_Strong_4_Hourly , 0)
			when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then ISNULL(vp.Bearish_Double_Screen_Strong_1_Hourly , 0)
			when a.Bearish_Triple_Screen_Strong_Weekly    >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_Weekly	  , 0)
			when a.Bearish_Triple_Screen_Strong_Daily     >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_Daily	  , 0)
			when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then ISNULL(vp.Bearish_Triple_Screen_Strong_4_Hourly , 0)
            ELSE 0
        END, 0)
FROM Stocks_Analysis.dbo.Analyse_Stocks a 
JOIN DescPivot dp ON dp.Batch_No = 1 
JOIN ValuePivot vp ON vp.Batch_No = dp.Batch_No AND a.Batch_No = (SELECT MAX(Batch_No) FROM Analyse_Stocks)
where ISNULL(a.Trade_Type_Details_Sum, 0) > 0

union all

select 'Analyse_Stocks' as tbl,symbol,Batch_No,Trade_Type,Trade_Type_Details,Trade_Type_Details_Sum,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum
from Analyse_stocks where Batch_No = (select max(batch_no) from Analyse_Stocks) and len(trade_type_details) >5
order by Symbol,tbl

end

begin -- history 
WITH ValueSource AS 
(	SELECT Batch_No, Screen_Names, Value
    FROM Master_Screen_Name_Values WHERE Batch_No = 1
)
,ValuePivot AS 
(	SELECT * FROM ValueSource
    PIVOT (SUM(Value) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])) AS vp
) 
,DescSource AS 
(	SELECT Batch_No, Screen_Names, Description 
	FROM Master_Screen_Name_Values 
	WHERE Batch_No = 1
)
,DescPivot AS 
(	SELECT * FROM DescSource a 
	PIVOT (MAX(Description) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
		  ) AS dp
) -- SELECT 'Description' AS DataType, * FROM DescPivot; -- SELECT 'Value' AS DataType, * FROM ValuePivot; --select a.Symbol, a.Batch_No,
UPDATE a SET 
    Trade_Type = ISNULL(a.Trade_Type, '') + case 
		when a.Bullish_Single_Screen_Yearly           >0 then 'Bullish;'
		when a.Bullish_Single_Screen_Quarterly        >0 then 'Bullish;'
		when a.Bullish_Single_Screen_Monthly          >0 then 'Bullish;'
		when a.Bullish_Single_Screen_Weekly           >0 then 'Bullish;'
		when a.Bullish_Single_Screen_Daily            >0 then 'Bullish;'
		when a.Bullish_Single_Screen_4_Hourly         >0 then 'Bullish;'
		when a.Bullish_Single_Screen_1_Hourly         >0 then 'Bullish;'
		when a.Bullish_Single_Screen_15_Minutes       >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_Daily     >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then 'Bullish;'
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then 'Bullish;'
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then 'Bullish;'
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then 'Bullish;'
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then 'Bullish;'
		when a.Bearish_Single_Screen_Yearly           >0 then 'Bearish;'
		when a.Bearish_Single_Screen_Quarterly        >0 then 'Bearish;'
		when a.Bearish_Single_Screen_Monthly          >0 then 'Bearish;'
		when a.Bearish_Single_Screen_Weekly           >0 then 'Bearish;'
		when a.Bearish_Single_Screen_Daily            >0 then 'Bearish;'
		when a.Bearish_Single_Screen_4_Hourly         >0 then 'Bearish;'
		when a.Bearish_Single_Screen_1_Hourly         >0 then 'Bearish;'
		when a.Bearish_Single_Screen_15_Minutes       >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_Daily     >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then 'Bearish;'
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then 'Bearish;'
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then 'Bearish;'
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then 'Bearish;'
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then 'Bearish;'
		else '' end,
    Trade_Type_Details = ISNULL(a.Trade_Type_Details, '') + case 
		when a.Bullish_Single_Screen_Yearly           >0 then dp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then dp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then dp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then dp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then dp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then dp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then dp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then dp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then dp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then dp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then dp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then dp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then dp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then dp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then dp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then dp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then dp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then dp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then dp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then dp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then dp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then dp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then dp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then dp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then dp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then dp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then dp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then dp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then dp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then dp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then dp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then dp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then dp.Bearish_Triple_Screen_Strong_4_Hourly
		else '' end,
    Trade_Type_Details_Sum = ISNULL(a.Trade_Type_Details_Sum, 0) + case 
		when a.Bullish_Single_Screen_Yearly           >0 then vp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then vp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then vp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then vp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then vp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then vp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then vp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then vp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then vp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then vp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then vp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then vp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then vp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then vp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then vp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then vp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then vp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then vp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then vp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then vp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then vp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then vp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then vp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then vp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then vp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then vp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then vp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then vp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then vp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then vp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then vp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then vp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bearish_Triple_Screen_Strong_4_Hourly
		else 0 end,	
    Trade_Type_Bullish_Sum = ISNULL(a.Trade_Type_Bullish_Sum, 0) + case 
		when a.Bullish_Single_Screen_Yearly           >0 then vp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then vp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then vp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then vp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then vp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then vp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then vp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then vp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then vp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then vp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then vp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then vp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then vp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then vp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then vp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then vp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then vp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then vp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then vp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then vp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then vp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then vp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then vp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then vp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then vp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then vp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then vp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then vp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then vp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then vp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then vp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then vp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bearish_Triple_Screen_Strong_4_Hourly
		else 0 end,		
    Trade_Type_Bearish_Sum = ISNULL(a.Trade_Type_Bearish_Sum, 0) + case 
		when a.Bullish_Single_Screen_Yearly           >0 then vp.Bullish_Single_Screen_Yearly
		when a.Bullish_Single_Screen_Quarterly        >0 then vp.Bullish_Single_Screen_Quarterly
		when a.Bullish_Single_Screen_Monthly          >0 then vp.Bullish_Single_Screen_Monthly
		when a.Bullish_Single_Screen_Weekly           >0 then vp.Bullish_Single_Screen_Weekly
		when a.Bullish_Single_Screen_Daily            >0 then vp.Bullish_Single_Screen_Daily
		when a.Bullish_Single_Screen_4_Hourly         >0 then vp.Bullish_Single_Screen_4_Hourly
		when a.Bullish_Single_Screen_1_Hourly         >0 then vp.Bullish_Single_Screen_1_Hourly
		when a.Bullish_Single_Screen_15_Minutes       >0 then vp.Bullish_Single_Screen_15_Minutes
		when a.Bullish_Double_Screen_Strong_Quarterly >0 then vp.Bullish_Double_Screen_Strong_Quarterly
		when a.Bullish_Double_Screen_Strong_Monthly   >0 then vp.Bullish_Double_Screen_Strong_Monthly
		when a.Bullish_Double_Screen_Strong_Weekly    >0 then vp.Bullish_Double_Screen_Strong_Weekly
		when a.Bullish_Double_Screen_Strong_Daily     >0 then vp.Bullish_Double_Screen_Strong_Daily
		when a.Bullish_Double_Screen_Strong_4_Hourly  >0 then vp.Bullish_Double_Screen_Strong_4_Hourly
		when a.Bullish_Double_Screen_Strong_1_Hourly  >0 then vp.Bullish_Double_Screen_Strong_1_Hourly
		when a.Bullish_Triple_Screen_Strong_Weekly    >0 then vp.Bullish_Triple_Screen_Strong_Weekly
		when a.Bullish_Triple_Screen_Strong_Daily     >0 then vp.Bullish_Triple_Screen_Strong_Daily
		when a.Bullish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bullish_Triple_Screen_Strong_4_Hourly
		when a.Bearish_Single_Screen_Yearly           >0 then vp.Bearish_Single_Screen_Yearly
		when a.Bearish_Single_Screen_Quarterly        >0 then vp.Bearish_Single_Screen_Quarterly
		when a.Bearish_Single_Screen_Monthly          >0 then vp.Bearish_Single_Screen_Monthly
		when a.Bearish_Single_Screen_Weekly           >0 then vp.Bearish_Single_Screen_Weekly
		when a.Bearish_Single_Screen_Daily            >0 then vp.Bearish_Single_Screen_Daily
		when a.Bearish_Single_Screen_4_Hourly         >0 then vp.Bearish_Single_Screen_4_Hourly
		when a.Bearish_Single_Screen_1_Hourly         >0 then vp.Bearish_Single_Screen_1_Hourly
		when a.Bearish_Single_Screen_15_Minutes       >0 then vp.Bearish_Single_Screen_15_Minutes
		when a.Bearish_Double_Screen_Strong_Quarterly >0 then vp.Bearish_Double_Screen_Strong_Quarterly
		when a.Bearish_Double_Screen_Strong_Monthly   >0 then vp.Bearish_Double_Screen_Strong_Monthly
		when a.Bearish_Double_Screen_Strong_Weekly    >0 then vp.Bearish_Double_Screen_Strong_Weekly
		when a.Bearish_Double_Screen_Strong_Daily     >0 then vp.Bearish_Double_Screen_Strong_Daily
		when a.Bearish_Double_Screen_Strong_4_Hourly  >0 then vp.Bearish_Double_Screen_Strong_4_Hourly
		when a.Bearish_Double_Screen_Strong_1_Hourly  >0 then vp.Bearish_Double_Screen_Strong_1_Hourly
		when a.Bearish_Triple_Screen_Strong_Weekly    >0 then vp.Bearish_Triple_Screen_Strong_Weekly
		when a.Bearish_Triple_Screen_Strong_Daily     >0 then vp.Bearish_Triple_Screen_Strong_Daily
		when a.Bearish_Triple_Screen_Strong_4_Hourly  >0 then vp.Bearish_Triple_Screen_Strong_4_Hourly
		else 0 end
FROM Stocks_Analysis.dbo.Analyse_Stocks a
JOIN DescPivot dp  ON dp.Batch_No = 1 AND a.Batch_No = (select max(batch_no) from Analyse_Stocks)
JOIN ValuePivot vp ON vp.Batch_No = 1 
;
end
end

begin
-- multiple columns pivoting 

SELECT Batch_No,Metric,[Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly]
FROM (
    SELECT Batch_No, Screen_Names, Metric, ColValue 
    FROM Master_Screen_Name_Values
    CROSS APPLY (
        VALUES 
            ('Value', CAST(Value AS VARCHAR)),
            ('Description', Description)
    ) AS Metrics(Metric, ColValue)
) AS SourceTable
PIVOT (
    MAX(ColValue) FOR Screen_Names IN ([Bullish_Single_Screen_Yearly],[Bullish_Single_Screen_Quarterly],[Bullish_Single_Screen_Monthly],[Bullish_Single_Screen_Weekly],[Bullish_Single_Screen_Daily],[Bullish_Single_Screen_4_Hourly],[Bullish_Single_Screen_1_Hourly],[Bullish_Single_Screen_15_Minutes],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Yearly],[Bearish_Single_Screen_Quarterly],[Bearish_Single_Screen_Monthly],[Bearish_Single_Screen_Weekly],[Bearish_Single_Screen_Daily],[Bearish_Single_Screen_4_Hourly],[Bearish_Single_Screen_1_Hourly],[Bearish_Single_Screen_15_Minutes],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly])
) AS PivotTable
where Batch_No = 1
ORDER BY Batch_No, Metric;

end

begin
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- from reset script.sql 
select 1
end

begin
-- price action 
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 1=1 
        -- and batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
), 
Price_Action_Final as ( 
	SELECT 
		symbol,
		batch_no,
		replace('{' + STRING_AGG(
			CONCAT('"', timeline,'" : [', value_list, '],'), 
			' '
		) WITHIN GROUP (ORDER BY timeline_order) + '}',',}','}') AS price_action_aggregate 
	FROM Formatted
	GROUP BY symbol, batch_no
)
Update a set a.[price_action] = price_action_aggregate
from Stocks_Analysis.dbo.[Analyse_Stocks] a join Price_Action_Final b
on a.Symbol = b.symbol and a.Batch_No = b.batch_no
;

INSERT INTO Stocks_Analysis.dbo.Analyse_Stocks__Price_Action_table (Row_id,Batch_no,symbol,Timeframe,Value)
SELECT ROW_NUMBER() OVER (PARTITION BY s.batch_no,s.symbol ORDER BY outerJson.[key],abs(innerJson.[value])) AS Row_Id,
	s.Batch_no,s.symbol,
    outerJson.[key] AS Timeframe,
    innerJson.[value] AS Value
FROM Stocks_Analysis.dbo.Analyse_Stocks s
CROSS APPLY OPENJSON(s.price_action) AS outerJson
CROSS APPLY OPENJSON(outerJson.[value]) AS innerJson
-- where s.Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
order by 3,4,5,abs(innerJson.[value])
;
------------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- from update_report_queries
end

begin
-- price action 
;WITH AdjustedValues AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        CASE 
            WHEN direction LIKE 'less than equal to%' THEN 
                -1 * CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            WHEN direction LIKE 'greater than equal to%' THEN 
                CAST(REPLACE(REPLACE(indicator, 'price action ', ''), ' candle', '') AS INT)
            ELSE NULL
        END AS adjusted_value
    FROM 
        Stocks_Analysis.dbo.Cash_Stocks
    WHERE 
        batch_no = (SELECT MAX(batch_no) FROM Stocks_Analysis.dbo.Cash_Stocks)
        AND indicator LIKE '%price action%'
        AND (direction LIKE 'greater than equal to%' OR direction LIKE 'less than equal to%')
),
Grouped AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        adjusted_value
    FROM AdjustedValues
    WHERE adjusted_value IS NOT NULL
),
Formatted AS (
    SELECT 
        symbol,
        timeline,
        batch_no,
        STRING_AGG(adjusted_value, ', ') 
            WITHIN GROUP (ORDER BY ABS(adjusted_value)) AS value_list,
        CASE timeline
            WHEN 'yearly' THEN 1
            WHEN 'half-yearly' THEN 2
            WHEN 'quarterly' THEN 3
            WHEN 'monthly' THEN 4
            WHEN 'weekly' THEN 5
            WHEN 'daily' THEN 6
            WHEN '4 hourly' THEN 7
            WHEN '1 hourly' THEN 8
            WHEN '15 minutes' THEN 9
            ELSE 10
        END AS timeline_order
    FROM Grouped
    GROUP BY symbol, timeline, batch_no
), 
Price_Action_Final as ( 
	SELECT 
		symbol,
		batch_no,
		replace('{' + STRING_AGG(
			CONCAT('"', timeline,'" : [', value_list, '],'), 
			' '
		) WITHIN GROUP (ORDER BY timeline_order) + '}',',}','}') AS price_action_aggregate 
	FROM Formatted
	GROUP BY symbol, batch_no
)
Update a set a.[price_action] = price_action_aggregate
from Stocks_Analysis.dbo.[Analyse_Stocks] a join Price_Action_Final b
on a.Symbol = b.symbol and a.Batch_No = b.batch_no
;
INSERT INTO Stocks_Analysis.dbo.Analyse_Stocks__Price_Action_table (Row_id,Batch_no,symbol, Timeframe, Value)
SELECT ROW_NUMBER() OVER (PARTITION BY s.batch_no,s.symbol ORDER BY outerJson.[key],abs(innerJson.[value])) AS Row_Id,
	s.Batch_no,s.symbol,
    outerJson.[key] AS Timeframe,
    innerJson.[value] AS Value
FROM Stocks_Analysis.dbo.Analyse_Stocks s
CROSS APPLY OPENJSON(s.price_action) AS outerJson
CROSS APPLY OPENJSON(outerJson.[value]) AS innerJson
where s.Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
order by 3,4,5,abs(innerJson.[value])
;
end

begin
-- from rest script.sql

begin -- sorted Trade_Type details
;WITH SplitSignals AS (
    SELECT distinct
        batch_no,sno,Trade_Type_Details,
        TRIM(value) AS Signal
    FROM Stocks_Analysis.dbo.Analyse_Stocks
    CROSS APPLY STRING_SPLIT(replace(replace(replace(Trade_Type_Details,'; ',';'),'(',''),')',''), ';')
    WHERE value <> '' -- and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
	-- order by Batch_No,Sno
)
,OrderedSignals AS (
    SELECT TOP 100 PERCENT
        batch_no,sno,ss.[order],Trade_Type_Details,
        Signal
    FROM SplitSignals Ps
    LEFT JOIN Stocks_Analysis.dbo.ScreenSort ss
	ON ps.Signal = replace(ss.Name,'_',' ')
	order by batch_no,sno,ss.[order]
) -- select * from OrderedSignals
,final as (
SELECT 
    Batch_No,Sno,Trade_Type_Details,
    STRING_AGG(Signal, '; ') WITHIN GROUP (ORDER BY Batch_No,Sno,[order] ASC)  AS SortedSignalString
FROM OrderedSignals
GROUP BY Batch_No,Sno,Trade_Type_Details
)
update a
set Trade_Type_Details = SortedSignalString
from Stocks_Analysis.dbo.Analyse_Stocks a
inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
;
end
-- from update_report_query
begin -- sorted Trade_Type details
;WITH SplitSignals AS (
    SELECT distinct
        batch_no,sno,Trade_Type_Details,
        TRIM(value) AS Signal
    FROM Stocks_Analysis.dbo.Analyse_Stocks
    CROSS APPLY STRING_SPLIT(replace(replace(replace(Trade_Type_Details,'; ',';'),'(',''),')',''), ';')
    WHERE value <> '' and Batch_No = (select MAX(Batch_No) from Stocks_Analysis.dbo.Analyse_Stocks)
) 
,OrderedSignals AS (
    SELECT TOP 100 PERCENT
        batch_no,sno,ss.[order],Trade_Type_Details,
        Signal
    FROM SplitSignals Ps
    LEFT JOIN Stocks_Analysis.dbo.ScreenSort ss
	ON ps.Signal = replace(ss.Name,'_',' ')
	order by batch_no,sno,ss.[order]
)
,final as (
SELECT 
    Batch_No,Sno,Trade_Type_Details,
    STRING_AGG(Signal, '; ') WITHIN GROUP (ORDER BY Batch_No,Sno,[order] ASC)  AS SortedSignalString
FROM OrderedSignals
GROUP BY Batch_No,Sno,Trade_Type_Details
)
update a
set Trade_Type_Details = SortedSignalString
from Stocks_Analysis.dbo.Analyse_Stocks a
inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
;
end

end

begin
select top 2500 * from Stocks_Analysis.dbo.Analyse_Stocks
where trade_view is not null
order by Batch_No desc,Report_Sort_Order asc
;
select * from Master_Screen_Name_Values where batch_no = 1 order by sno
end

begin
select * from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
and Trade_Type_Details != ''
order by Other_Setups desc
;
select coalesce(case when 1=1 then 'coalesce 1st part' else 'elsepart' end,'coalesce 2nd part') as checking
;
end

begin
/*
select *  from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks;
select *  from Stocks_Analysis.dbo.Analyse_Stocks;
select *  from Stocks_Analysis.dbo.Cash_15Minutes_Stocks;
select *  from Stocks_Analysis.dbo.Cash_Stocks;
*/
select * from Analyse_Stocks_v order by Trade_View_Order, Other_Setups desc ,Report_Sort_Order;
end

begin

-- column list
--  Sno,Batch_No,Created_Date,Report_Sort_Order,Symbol,Trade_View_Order,Segments_Order,Segments,Segments_Length,Segments_Sum,Other_Setups,Volume_Shockers_Sum,Trade_Type_Details_Length,Trade_Type_Details,Trade_Type_Details_Sum,Industry,Stock_Name,Percent_Change,Price,Volume,Series,trade_view,Trade_Type,Trade_Type_Length,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum,price_action,ISIN_Code
-- ,Bullish_Triple_Screen_Strong_Monthly,Bullish_Triple_Screen_Strong_Weekly,Bullish_Triple_Screen_Strong_Daily,Bullish_Triple_Screen_Strong_4_Hourly,Bullish_Triple_Screen_Strong_1_Hourly,Bullish_Triple_Screen_Strong_15_Minutes,Bullish_Triple_Screen_Strong_Correction_Monthly,Bullish_Triple_Screen_Strong_Correction_Weekly,Bullish_Triple_Screen_Strong_Correction_Daily,Bullish_Triple_Screen_Strong_Correction_4_Hourly,Bullish_Triple_Screen_Strong_Correction_1_Hourly,Bullish_Triple_Screen_Strong_Correction_15_Minutes,Bullish_Double_Screen_Strong_Quarterly,Bullish_Double_Screen_Strong_Monthly,Bullish_Double_Screen_Strong_Weekly,Bullish_Double_Screen_Strong_Daily,Bullish_Double_Screen_Strong_4_Hourly,Bullish_Double_Screen_Strong_1_Hourly,Bullish_Double_Screen_Strong_15_Minutes,Bullish_Double_Screen_Strong_Correction_Quarterly,Bullish_Double_Screen_Strong_Correction_Monthly,Bullish_Double_Screen_Strong_Correction_Weekly,Bullish_Double_Screen_Strong_Correction_Daily,Bullish_Double_Screen_Strong_Correction_4_Hourly,Bullish_Double_Screen_Strong_Correction_1_Hourly,Bullish_Double_Screen_Strong_Correction_15_Minutes,Bullish_Single_Screen_Yearly,Bullish_Single_Screen_Quarterly,Bullish_Single_Screen_Monthly,Bullish_Single_Screen_Weekly,Bullish_Single_Screen_Daily,Bullish_Single_Screen_4_Hourly,Bullish_Single_Screen_1_Hourly,Bullish_Single_Screen_15_Minutes
-- ,Bearish_Triple_Screen_Strong_Monthly,Bearish_Triple_Screen_Strong_Weekly,Bearish_Triple_Screen_Strong_Daily,Bearish_Triple_Screen_Strong_4_Hourly,Bearish_Triple_Screen_Strong_1_Hourly,Bearish_Triple_Screen_Strong_15_Minutes,Bearish_Triple_Screen_Strong_Correction_Monthly,Bearish_Triple_Screen_Strong_Correction_Weekly,Bearish_Triple_Screen_Strong_Correction_Daily,Bearish_Triple_Screen_Strong_Correction_4_Hourly,Bearish_Triple_Screen_Strong_Correction_1_Hourly,Bearish_Triple_Screen_Strong_Correction_15_Minutes,Bearish_Double_Screen_Strong_Quarterly,Bearish_Double_Screen_Strong_Monthly,Bearish_Double_Screen_Strong_Weekly,Bearish_Double_Screen_Strong_Daily,Bearish_Double_Screen_Strong_4_Hourly,Bearish_Double_Screen_Strong_1_Hourly,Bearish_Double_Screen_Strong_15_Minutes,Bearish_Double_Screen_Strong_Correction_Quarterly,Bearish_Double_Screen_Strong_Correction_Monthly,Bearish_Double_Screen_Strong_Correction_Weekly,Bearish_Double_Screen_Strong_Correction_Daily,Bearish_Double_Screen_Strong_Correction_4_Hourly,Bearish_Double_Screen_Strong_Correction_1_Hourly,Bearish_Double_Screen_Strong_Correction_15_Minutes,Bearish_Single_Screen_Yearly,Bearish_Single_Screen_Quarterly,Bearish_Single_Screen_Monthly,Bearish_Single_Screen_Weekly,Bearish_Single_Screen_Daily,Bearish_Single_Screen_4_Hourly,Bearish_Single_Screen_1_Hourly,Bearish_Single_Screen_15_Minutes
-- ,Macd_Yearly_Crosses_Above,Macd_Yearly_Crosses_Below,Macd_Quarterly_Crosses_Above,Macd_Quarterly_Crosses_Below,Macd_Monthly_Crosses_Above,Macd_Monthly_Crosses_Below,Macd_Weekly_Crosses_Above,Macd_Weekly_Crosses_Below,Macd_Daily_Crosses_Above,Macd_Daily_Crosses_Below,Macd_4_Hourly_Crosses_Above,Macd_4_Hourly_Crosses_Below,Macd_1_Hourly_Crosses_Above,Macd_1_Hourly_Crosses_Below,Macd_15_Minutes_Crosses_Above,Macd_15_Minutes_Crosses_Below,Stochastic_Yearly_Crosses_Above,Stochastic_Yearly_Crosses_Below,Stochastic_Quarterly_Crosses_Above,Stochastic_Quarterly_Crosses_Below,Stochastic_Monthly_Crosses_Above,Stochastic_Monthly_Crosses_Below,Stochastic_Weekly_Crosses_Above,Stochastic_Weekly_Crosses_Below,Stochastic_Daily_Crosses_Above,Stochastic_Daily_Crosses_Below,Stochastic_4_Hourly_Crosses_Above,Stochastic_4_Hourly_Crosses_Below,Stochastic_1_Hourly_Crosses_Above,Stochastic_1_Hourly_Crosses_Below,Stochastic_15_Minutes_Crosses_Above,Stochastic_15_Minutes_Crosses_Below,Ema_5_13_Yearly_Crosses_Above,Ema_5_13_Yearly_Crosses_Below,Ema_5_13_Quarterly_Crosses_Above,Ema_5_13_Quarterly_Crosses_Below,Ema_5_13_Monthly_Crosses_Above,Ema_5_13_Monthly_Crosses_Below,Ema_5_13_Weekly_Crosses_Above,Ema_5_13_Weekly_Crosses_Below,Ema_5_13_Daily_Crosses_Above,Ema_5_13_Daily_Crosses_Below,Ema_5_13_4_Hourly_Crosses_Above,Ema_5_13_4_Hourly_Crosses_Below,Ema_5_13_1_Hourly_Crosses_Above,Ema_5_13_1_Hourly_Crosses_Below,Ema_5_13_15_Minutes_Crosses_Above,Ema_5_13_15_Minutes_Crosses_Below,Ema_13_26_Yearly_Crosses_Above,Ema_13_26_Yearly_Crosses_Below,Ema_13_26_Quarterly_Crosses_Above,Ema_13_26_Quarterly_Crosses_Below,Ema_13_26_Monthly_Crosses_Above,Ema_13_26_Monthly_Crosses_Below,Ema_13_26_Weekly_Crosses_Above,Ema_13_26_Weekly_Crosses_Below,Ema_13_26_Daily_Crosses_Above,Ema_13_26_Daily_Crosses_Below,Ema_13_26_4_Hourly_Crosses_Above,Ema_13_26_4_Hourly_Crosses_Below,Ema_13_26_1_Hourly_Crosses_Above,Ema_13_26_1_Hourly_Crosses_Below,Ema_13_26_15_Minutes_Crosses_Above,Ema_13_26_15_Minutes_Crosses_Below,Ema_50_100_Yearly_Crosses_Above,Ema_50_100_Yearly_Crosses_Below,Ema_50_100_Quarterly_Crosses_Above,Ema_50_100_Quarterly_Crosses_Below,Ema_50_100_Monthly_Crosses_Above,Ema_50_100_Monthly_Crosses_Below,Ema_50_100_Weekly_Crosses_Above,Ema_50_100_Weekly_Crosses_Below,Ema_50_100_Daily_Crosses_Above,Ema_50_100_Daily_Crosses_Below,Ema_50_100_4_Hourly_Crosses_Above,Ema_50_100_4_Hourly_Crosses_Below,Ema_50_100_1_Hourly_Crosses_Above,Ema_50_100_1_Hourly_Crosses_Below,Ema_50_100_15_Minutes_Crosses_Above,Ema_50_100_15_Minutes_Crosses_Below,Ema_100_200_Yearly_Crosses_Above,Ema_100_200_Yearly_Crosses_Below,Ema_100_200_Quarterly_Crosses_Above,Ema_100_200_Quarterly_Crosses_Below,Ema_100_200_Monthly_Crosses_Above,Ema_100_200_Monthly_Crosses_Below,Ema_100_200_Weekly_Crosses_Above,Ema_100_200_Weekly_Crosses_Below,Ema_100_200_Daily_Crosses_Above,Ema_100_200_Daily_Crosses_Below,Ema_100_200_4_Hourly_Crosses_Above,Ema_100_200_4_Hourly_Crosses_Below,Ema_100_200_1_Hourly_Crosses_Above,Ema_100_200_1_Hourly_Crosses_Below,Ema_100_200_15_Minutes_Crosses_Above,Ema_100_200_15_Minutes_Crosses_Below,Adx_Yearly_Crosses_Above,Adx_Yearly_Crosses_Below,Adx_Quarterly_Crosses_Above,Adx_Quarterly_Crosses_Below,Adx_Monthly_Crosses_Above,Adx_Monthly_Crosses_Below,Adx_Weekly_Crosses_Above,Adx_Weekly_Crosses_Below,Adx_Daily_Crosses_Above,Adx_Daily_Crosses_Below,Adx_4_Hourly_Crosses_Above,Adx_4_Hourly_Crosses_Below,Adx_1_Hourly_Crosses_Above,Adx_1_Hourly_Crosses_Below,Adx_15_Minutes_Crosses_Above,Adx_15_Minutes_Crosses_Below,Rsi_Yearly_Crosses_Above,Rsi_Yearly_Crosses_Below,Rsi_Quarterly_Crosses_Above,Rsi_Quarterly_Crosses_Below,Rsi_Monthly_Crosses_Above,Rsi_Monthly_Crosses_Below,Rsi_Weekly_Crosses_Above,Rsi_Weekly_Crosses_Below,Rsi_Daily_Crosses_Above,Rsi_Daily_Crosses_Below,Rsi_4_Hourly_Crosses_Above,Rsi_4_Hourly_Crosses_Below,Rsi_1_Hourly_Crosses_Above,Rsi_1_Hourly_Crosses_Below,Rsi_15_Minutes_Crosses_Above,Rsi_15_Minutes_Crosses_Below,Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band3_Daily_Less_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band3_Daily_Less_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band2_Daily_Less_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band2_Daily_Less_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Volume_Yearly_Greater_Than_Equal_To,Volume_Yearly_Less_Than_Equal_To,Volume_Quarterly_Greater_Than_Equal_To,Volume_Quarterly_Less_Than_Equal_To,Volume_Monthly_Greater_Than_Equal_To,Volume_Monthly_Less_Than_Equal_To,Volume_Weekly_Greater_Than_Equal_To,Volume_Weekly_Less_Than_Equal_To,Volume_Daily_Greater_Than_Equal_To,Volume_Daily_Less_Than_Equal_To,Volume_4_Hourly_Greater_Than_Equal_To,Volume_4_Hourly_Less_Than_Equal_To,Volume_1_Hourly_Greater_Than_Equal_To,Volume_1_Hourly_Less_Than_Equal_To,Volume_15_Minutes_Greater_Than_Equal_To,Volume_15_Minutes_Less_Than_Equal_To,Adx_Up_Tick_Yearly_Greater_Than_Equal_To,Adx_Down_Tick_Yearly_Less_Than_Equal_To,Adx_Up_Tick_Quarterly_Greater_Than_Equal_To,Adx_Down_Tick_Quarterly_Less_Than_Equal_To,Adx_Up_Tick_Monthly_Greater_Than_Equal_To,Adx_Down_Tick_Monthly_Less_Than_Equal_To,Adx_Up_Tick_Weekly_Greater_Than_Equal_To,Adx_Down_Tick_Weekly_Less_Than_Equal_To,Adx_Up_Tick_Daily_Greater_Than_Equal_To,Adx_Down_Tick_Daily_Less_Than_Equal_To,Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To,Adx_Down_Tick_4_Hourly_Less_Than_Equal_To,Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To,Adx_Down_Tick_1_Hourly_Less_Than_Equal_To,Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To,Adx_Down_Tick_15_Minutes_Less_Than_Equal_To,volume_yearly_shockers,volume_quarterly_shockers,volume_monthly_shockers,volume_weekly_shockers,volume_daily_shockers,volume_4_hourly_shockers,volume_1_hourly_shockers,volume_15_minutes_shockers
select * from [dbo].[Master_Segments] where Industry is null;
select * from [dbo].[Master_Segments] where Industry is not null;
select distinct segments from [dbo].[Master_Segments] where Industry is null;
select * from [dbo].[Master_Stocks_Industry_Sector_Wise_distinct];

end

begin
select 
Sno,Batch_No,Created_Date,Report_Sort_Order,Symbol,Segments_Order,Segments,Segments_Length,Segments_Sum,Other_Setups,Volume_Shockers_Sum,Trade_Type_Details_Length,Trade_Type_Details,Trade_Type_Details_Sum,Industry,Stock_Name,Percent_Change,Price,Volume,Series,trade_view,Trade_View_Order,Trade_Type,Trade_Type_Length,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum,price_action,ISIN_Code
-- ,Bullish_Triple_Screen_Strong_Monthly,Bullish_Triple_Screen_Strong_Weekly,Bullish_Triple_Screen_Strong_Daily,Bullish_Triple_Screen_Strong_4_Hourly,Bullish_Triple_Screen_Strong_1_Hourly,Bullish_Triple_Screen_Strong_15_Minutes,Bullish_Triple_Screen_Strong_Correction_Monthly,Bullish_Triple_Screen_Strong_Correction_Weekly,Bullish_Triple_Screen_Strong_Correction_Daily,Bullish_Triple_Screen_Strong_Correction_4_Hourly,Bullish_Triple_Screen_Strong_Correction_1_Hourly,Bullish_Triple_Screen_Strong_Correction_15_Minutes,Bullish_Double_Screen_Strong_Quarterly,Bullish_Double_Screen_Strong_Monthly,Bullish_Double_Screen_Strong_Weekly,Bullish_Double_Screen_Strong_Daily,Bullish_Double_Screen_Strong_4_Hourly,Bullish_Double_Screen_Strong_1_Hourly,Bullish_Double_Screen_Strong_15_Minutes,Bullish_Double_Screen_Strong_Correction_Quarterly,Bullish_Double_Screen_Strong_Correction_Monthly,Bullish_Double_Screen_Strong_Correction_Weekly,Bullish_Double_Screen_Strong_Correction_Daily,Bullish_Double_Screen_Strong_Correction_4_Hourly,Bullish_Double_Screen_Strong_Correction_1_Hourly,Bullish_Double_Screen_Strong_Correction_15_Minutes,Bullish_Single_Screen_Yearly,Bullish_Single_Screen_Quarterly,Bullish_Single_Screen_Monthly,Bullish_Single_Screen_Weekly,Bullish_Single_Screen_Daily,Bullish_Single_Screen_4_Hourly,Bullish_Single_Screen_1_Hourly,Bullish_Single_Screen_15_Minutes
-- ,Bearish_Triple_Screen_Strong_Monthly,Bearish_Triple_Screen_Strong_Weekly,Bearish_Triple_Screen_Strong_Daily,Bearish_Triple_Screen_Strong_4_Hourly,Bearish_Triple_Screen_Strong_1_Hourly,Bearish_Triple_Screen_Strong_15_Minutes,Bearish_Triple_Screen_Strong_Correction_Monthly,Bearish_Triple_Screen_Strong_Correction_Weekly,Bearish_Triple_Screen_Strong_Correction_Daily,Bearish_Triple_Screen_Strong_Correction_4_Hourly,Bearish_Triple_Screen_Strong_Correction_1_Hourly,Bearish_Triple_Screen_Strong_Correction_15_Minutes,Bearish_Double_Screen_Strong_Quarterly,Bearish_Double_Screen_Strong_Monthly,Bearish_Double_Screen_Strong_Weekly,Bearish_Double_Screen_Strong_Daily,Bearish_Double_Screen_Strong_4_Hourly,Bearish_Double_Screen_Strong_1_Hourly,Bearish_Double_Screen_Strong_15_Minutes,Bearish_Double_Screen_Strong_Correction_Quarterly,Bearish_Double_Screen_Strong_Correction_Monthly,Bearish_Double_Screen_Strong_Correction_Weekly,Bearish_Double_Screen_Strong_Correction_Daily,Bearish_Double_Screen_Strong_Correction_4_Hourly,Bearish_Double_Screen_Strong_Correction_1_Hourly,Bearish_Double_Screen_Strong_Correction_15_Minutes,Bearish_Single_Screen_Yearly,Bearish_Single_Screen_Quarterly,Bearish_Single_Screen_Monthly,Bearish_Single_Screen_Weekly,Bearish_Single_Screen_Daily,Bearish_Single_Screen_4_Hourly,Bearish_Single_Screen_1_Hourly,Bearish_Single_Screen_15_Minutes
-- ,Macd_Yearly_Crosses_Above,Macd_Yearly_Crosses_Below,Macd_Quarterly_Crosses_Above,Macd_Quarterly_Crosses_Below,Macd_Monthly_Crosses_Above,Macd_Monthly_Crosses_Below,Macd_Weekly_Crosses_Above,Macd_Weekly_Crosses_Below,Macd_Daily_Crosses_Above,Macd_Daily_Crosses_Below,Macd_4_Hourly_Crosses_Above,Macd_4_Hourly_Crosses_Below,Macd_1_Hourly_Crosses_Above,Macd_1_Hourly_Crosses_Below,Macd_15_Minutes_Crosses_Above,Macd_15_Minutes_Crosses_Below,Stochastic_Yearly_Crosses_Above,Stochastic_Yearly_Crosses_Below,Stochastic_Quarterly_Crosses_Above,Stochastic_Quarterly_Crosses_Below,Stochastic_Monthly_Crosses_Above,Stochastic_Monthly_Crosses_Below,Stochastic_Weekly_Crosses_Above,Stochastic_Weekly_Crosses_Below,Stochastic_Daily_Crosses_Above,Stochastic_Daily_Crosses_Below,Stochastic_4_Hourly_Crosses_Above,Stochastic_4_Hourly_Crosses_Below,Stochastic_1_Hourly_Crosses_Above,Stochastic_1_Hourly_Crosses_Below,Stochastic_15_Minutes_Crosses_Above,Stochastic_15_Minutes_Crosses_Below,Ema_5_13_Yearly_Crosses_Above,Ema_5_13_Yearly_Crosses_Below,Ema_5_13_Quarterly_Crosses_Above,Ema_5_13_Quarterly_Crosses_Below,Ema_5_13_Monthly_Crosses_Above,Ema_5_13_Monthly_Crosses_Below,Ema_5_13_Weekly_Crosses_Above,Ema_5_13_Weekly_Crosses_Below,Ema_5_13_Daily_Crosses_Above,Ema_5_13_Daily_Crosses_Below,Ema_5_13_4_Hourly_Crosses_Above,Ema_5_13_4_Hourly_Crosses_Below,Ema_5_13_1_Hourly_Crosses_Above,Ema_5_13_1_Hourly_Crosses_Below,Ema_5_13_15_Minutes_Crosses_Above,Ema_5_13_15_Minutes_Crosses_Below,Ema_13_26_Yearly_Crosses_Above,Ema_13_26_Yearly_Crosses_Below,Ema_13_26_Quarterly_Crosses_Above,Ema_13_26_Quarterly_Crosses_Below,Ema_13_26_Monthly_Crosses_Above,Ema_13_26_Monthly_Crosses_Below,Ema_13_26_Weekly_Crosses_Above,Ema_13_26_Weekly_Crosses_Below,Ema_13_26_Daily_Crosses_Above,Ema_13_26_Daily_Crosses_Below,Ema_13_26_4_Hourly_Crosses_Above,Ema_13_26_4_Hourly_Crosses_Below,Ema_13_26_1_Hourly_Crosses_Above,Ema_13_26_1_Hourly_Crosses_Below,Ema_13_26_15_Minutes_Crosses_Above,Ema_13_26_15_Minutes_Crosses_Below,Ema_50_100_Yearly_Crosses_Above,Ema_50_100_Yearly_Crosses_Below,Ema_50_100_Quarterly_Crosses_Above,Ema_50_100_Quarterly_Crosses_Below,Ema_50_100_Monthly_Crosses_Above,Ema_50_100_Monthly_Crosses_Below,Ema_50_100_Weekly_Crosses_Above,Ema_50_100_Weekly_Crosses_Below,Ema_50_100_Daily_Crosses_Above,Ema_50_100_Daily_Crosses_Below,Ema_50_100_4_Hourly_Crosses_Above,Ema_50_100_4_Hourly_Crosses_Below,Ema_50_100_1_Hourly_Crosses_Above,Ema_50_100_1_Hourly_Crosses_Below,Ema_50_100_15_Minutes_Crosses_Above,Ema_50_100_15_Minutes_Crosses_Below,Ema_100_200_Yearly_Crosses_Above,Ema_100_200_Yearly_Crosses_Below,Ema_100_200_Quarterly_Crosses_Above,Ema_100_200_Quarterly_Crosses_Below,Ema_100_200_Monthly_Crosses_Above,Ema_100_200_Monthly_Crosses_Below,Ema_100_200_Weekly_Crosses_Above,Ema_100_200_Weekly_Crosses_Below,Ema_100_200_Daily_Crosses_Above,Ema_100_200_Daily_Crosses_Below,Ema_100_200_4_Hourly_Crosses_Above,Ema_100_200_4_Hourly_Crosses_Below,Ema_100_200_1_Hourly_Crosses_Above,Ema_100_200_1_Hourly_Crosses_Below,Ema_100_200_15_Minutes_Crosses_Above,Ema_100_200_15_Minutes_Crosses_Below,Adx_Yearly_Crosses_Above,Adx_Yearly_Crosses_Below,Adx_Quarterly_Crosses_Above,Adx_Quarterly_Crosses_Below,Adx_Monthly_Crosses_Above,Adx_Monthly_Crosses_Below,Adx_Weekly_Crosses_Above,Adx_Weekly_Crosses_Below,Adx_Daily_Crosses_Above,Adx_Daily_Crosses_Below,Adx_4_Hourly_Crosses_Above,Adx_4_Hourly_Crosses_Below,Adx_1_Hourly_Crosses_Above,Adx_1_Hourly_Crosses_Below,Adx_15_Minutes_Crosses_Above,Adx_15_Minutes_Crosses_Below,Rsi_Yearly_Crosses_Above,Rsi_Yearly_Crosses_Below,Rsi_Quarterly_Crosses_Above,Rsi_Quarterly_Crosses_Below,Rsi_Monthly_Crosses_Above,Rsi_Monthly_Crosses_Below,Rsi_Weekly_Crosses_Above,Rsi_Weekly_Crosses_Below,Rsi_Daily_Crosses_Above,Rsi_Daily_Crosses_Below,Rsi_4_Hourly_Crosses_Above,Rsi_4_Hourly_Crosses_Below,Rsi_1_Hourly_Crosses_Above,Rsi_1_Hourly_Crosses_Below,Rsi_15_Minutes_Crosses_Above,Rsi_15_Minutes_Crosses_Below,Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band3_Daily_Less_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band3_Daily_Less_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band2_Daily_Less_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band2_Daily_Less_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Volume_Yearly_Greater_Than_Equal_To,Volume_Yearly_Less_Than_Equal_To,Volume_Quarterly_Greater_Than_Equal_To,Volume_Quarterly_Less_Than_Equal_To,Volume_Monthly_Greater_Than_Equal_To,Volume_Monthly_Less_Than_Equal_To,Volume_Weekly_Greater_Than_Equal_To,Volume_Weekly_Less_Than_Equal_To,Volume_Daily_Greater_Than_Equal_To,Volume_Daily_Less_Than_Equal_To,Volume_4_Hourly_Greater_Than_Equal_To,Volume_4_Hourly_Less_Than_Equal_To,Volume_1_Hourly_Greater_Than_Equal_To,Volume_1_Hourly_Less_Than_Equal_To,Volume_15_Minutes_Greater_Than_Equal_To,Volume_15_Minutes_Less_Than_Equal_To,Adx_Up_Tick_Yearly_Greater_Than_Equal_To,Adx_Down_Tick_Yearly_Less_Than_Equal_To,Adx_Up_Tick_Quarterly_Greater_Than_Equal_To,Adx_Down_Tick_Quarterly_Less_Than_Equal_To,Adx_Up_Tick_Monthly_Greater_Than_Equal_To,Adx_Down_Tick_Monthly_Less_Than_Equal_To,Adx_Up_Tick_Weekly_Greater_Than_Equal_To,Adx_Down_Tick_Weekly_Less_Than_Equal_To,Adx_Up_Tick_Daily_Greater_Than_Equal_To,Adx_Down_Tick_Daily_Less_Than_Equal_To,Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To,Adx_Down_Tick_4_Hourly_Less_Than_Equal_To,Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To,Adx_Down_Tick_1_Hourly_Less_Than_Equal_To,Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To,Adx_Down_Tick_15_Minutes_Less_Than_Equal_To,volume_yearly_shockers,volume_quarterly_shockers,volume_monthly_shockers,volume_weekly_shockers,volume_daily_shockers,volume_4_hourly_shockers,volume_1_hourly_shockers,volume_15_minutes_shockers
from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
-- and Trade_View_Order is not null
order by Report_Sort_Order,Trade_View_Order, Other_Setups desc
;

select * from Stocks_Analysis.dbo.Master_Segments where Industry is null

update a set Industry = b.[Industry / Segment],ISIN_Code = b.[ISIN Code],series = b.series
from Stocks_Analysis.dbo.Master_Segments a
inner join [dbo].[Symbol-IndustrySegment-Series] b on a.Symbol = b.Symbol

select * from Stocks_Analysis.dbo.Master_Segments a
-- inner join [dbo].[Symbol-IndustrySegment-Series] b on a.Symbol = b.Symbol
where a.Industry is null

select * from [dbo].[Symbol-IndustrySegment-Series]
end

begin
DECLARE @StartTime DATETIME = GETDATE();
PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121);

-- delete from Stocks_Analysis.dbo.Cash_Stocks where Batch_No = 20250731180015;

BULK INSERT Stocks_Analysis.dbo.cash_stocks FROM 'C:\Users\gsrsr\Documents\PythonProject\Chart_Ink\Source\chart_ink_daily1.csv'
WITH ( 
	FIELDTERMINATOR = ',',   -- Column delimiter, e.g., comma for CSV
	ROWTERMINATOR = '\n',       -- Row delimiter, newline character
	FIRSTROW = 2,   -- Skip header row if present (start at row 2)
	TABLOCK,        -- Optional: improve performance by locking the table
	KEEPIDENTITY    -- keep identity values from file
);

-- select count(1) from Stocks_Analysis.dbo.Cash_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Cash_Stocks)
DECLARE	 @EndTime DATETIME = GETDATE() --,@StartTime DATETIME = GETDATE(); 
DECLARE	 @DurationMs INT = DATEDIFF(MILLISECOND, @StartTime, @EndTime); 

PRINT 'Script started at: ' + CONVERT(VARCHAR, @StartTime, 121); 
PRINT 'Script ended at  : ' + CONVERT(VARCHAR, @EndTime, 121); 
PRINT 'Duration (ms)    : ' + CAST(@DurationMs AS VARCHAR); 
PRINT 'Duration         : ' + CAST(CAST(DATEADD(MILLISECOND, @DurationMs, '00:00:00.000') AS TIME) as VARCHAR)
; 

end

begin
select * from Stocks_Analysis.dbo.Cash_Stocks where Batch_No = (select max(batch_no) from Stocks_Analysis.dbo.Cash_Stocks)
-- 20250731180015
-- 20250731205113

select sno,symbol,stock_name,bsecode,percent_change,price,volume,Indicator,TimeLine,Direction,segments,Batch_No
-- into Stocks_Analysis.dbo.Cash_15Minutes_Stocks_1
from Stocks_Analysis.dbo.Cash_15Minutes_Stocks
select count(1), Batch_No from [dbo].Cash_Stocks group by Batch_No order by Batch_No

select * from Analyse_Stocks_v order by Report_Sort_Order,Trade_View_Order, Other_Setups desc;

select * from Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
and Trade_Type_Details != ''
order by Other_Setups desc
;
end

begin
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__yearly__crosses_above		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__yearly__crosses_below		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__quarterly__crosses_above	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__quarterly__crosses_below	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__monthly__crosses_above	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__monthly__crosses_below	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__weekly__crosses_above		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__weekly__crosses_below		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__daily__crosses_above		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__daily__crosses_below		 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__4_hourly__crosses_above	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__4_hourly__crosses_below	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__1_hourly__crosses_above	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__1_hourly__crosses_below	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__15_minutes__crosses_above	 bit null ;
alter table Stocks_Analysis.dbo.Analyse_15Minutes_Stocks add  ema_50_200__15_minutes__crosses_below	 bit null ;


exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__yearly__crosses_above',	'ema_50_200_yearly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__yearly__crosses_below',	'ema_50_200_yearly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__quarterly__crosses_above',	'ema_50_200_quarterly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__quarterly__crosses_below',	'ema_50_200_quarterly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__monthly__crosses_above',	'ema_50_200_monthly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__monthly__crosses_below',	'ema_50_200_monthly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__weekly__crosses_above',	'ema_50_200_weekly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__weekly__crosses_below',	'ema_50_200_weekly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__daily__crosses_above',		'ema_50_200_daily_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__daily__crosses_below',		'ema_50_200_daily_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__4_hourly__crosses_above',	'ema_50_200_4_hourly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__4_hourly__crosses_below',	'ema_50_200_4_hourly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__1_hourly__crosses_above',	'ema_50_200_1_hourly_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__1_hourly__crosses_below',	'ema_50_200_1_hourly_crosses_below'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__15_minutes__crosses_above','ema_50_200_15_minutes_crosses_above'
exec sp_rename 'Stocks_Analysis.dbo.Analyse_Stocks.ema_50_200__15_minutes__crosses_below','ema_50_200_15_minutes_crosses_below'

end

begin
 select * from Stocks_Analysis.dbo.Analyse_Stocks where Batch_No = 20250803070622 and Symbol = 'BEL'
-- select * from [dbo].[Master_Screen_Name_Values]

select Batch_No,Report_Sort_Order,Symbol,Trade_Type_Details,trade_view,Other_Setups,Industry,Segments,Price,Percent_Change,Volume,Sno,Trade_View_Order,Trade_Type,Trade_Type_Length,Trade_Type_Bullish_Sum,Volume_Shockers_Sum,Trade_Type_Bearish_Sum,Trade_Type_Details_Length,Trade_Type_Details_Sum,Segments_Order,Segments_Length,Segments_Sum,Stock_Name,Series,ISIN_Code,price_action,Created_Date,Bullish_Triple_Screen_Strong_Monthly,Bullish_Triple_Screen_Strong_Weekly,Bullish_Triple_Screen_Strong_Daily,Bullish_Triple_Screen_Strong_4_Hourly,Bullish_Triple_Screen_Strong_1_Hourly,Bullish_Triple_Screen_Strong_15_Minutes,Bullish_Triple_Screen_Strong_Correction_Monthly,Bullish_Triple_Screen_Strong_Correction_Weekly,Bullish_Triple_Screen_Strong_Correction_Daily,Bullish_Triple_Screen_Strong_Correction_4_Hourly,Bullish_Triple_Screen_Strong_Correction_1_Hourly,Bullish_Triple_Screen_Strong_Correction_15_Minutes,Bullish_Double_Screen_Strong_Quarterly,Bullish_Double_Screen_Strong_Monthly,Bullish_Double_Screen_Strong_Weekly,Bullish_Double_Screen_Strong_Daily,Bullish_Double_Screen_Strong_4_Hourly,Bullish_Double_Screen_Strong_1_Hourly,Bullish_Double_Screen_Strong_15_Minutes,Bullish_Double_Screen_Strong_Correction_Quarterly,Bullish_Double_Screen_Strong_Correction_Monthly,Bullish_Double_Screen_Strong_Correction_Weekly,Bullish_Double_Screen_Strong_Correction_Daily,Bullish_Double_Screen_Strong_Correction_4_Hourly,Bullish_Double_Screen_Strong_Correction_1_Hourly,Bullish_Double_Screen_Strong_Correction_15_Minutes,Bullish_Single_Screen_Yearly,Bullish_Single_Screen_Quarterly,Bullish_Single_Screen_Monthly,Bullish_Single_Screen_Weekly,Bullish_Single_Screen_Daily,Bullish_Single_Screen_4_Hourly,Bullish_Single_Screen_1_Hourly,Bullish_Single_Screen_15_Minutes,Macd_Yearly_Crosses_Above,Macd_Quarterly_Crosses_Above,Macd_Monthly_Crosses_Above,Macd_Weekly_Crosses_Above,Macd_Daily_Crosses_Above,Macd_4_Hourly_Crosses_Above,Macd_1_Hourly_Crosses_Above,Macd_15_Minutes_Crosses_Above,Rsi_Yearly_Crosses_Above,Rsi_Quarterly_Crosses_Above,Rsi_Monthly_Crosses_Above,Rsi_Weekly_Crosses_Above,Rsi_Daily_Crosses_Above,Rsi_4_Hourly_Crosses_Above,Rsi_1_Hourly_Crosses_Above,Rsi_15_Minutes_Crosses_Above,Stochastic_Yearly_Crosses_Above,Stochastic_Quarterly_Crosses_Above,Stochastic_Monthly_Crosses_Above,Stochastic_Weekly_Crosses_Above,Stochastic_Daily_Crosses_Above,Stochastic_4_Hourly_Crosses_Above,Stochastic_1_Hourly_Crosses_Above,Stochastic_15_Minutes_Crosses_Above,Ema_5_13_Yearly_Crosses_Above,Ema_5_13_Quarterly_Crosses_Above,Ema_5_13_Monthly_Crosses_Above,Ema_5_13_Weekly_Crosses_Above,Ema_5_13_Daily_Crosses_Above,Ema_5_13_4_Hourly_Crosses_Above,Ema_5_13_1_Hourly_Crosses_Above,Ema_5_13_15_Minutes_Crosses_Above,Ema_13_26_Yearly_Crosses_Above,Ema_13_26_Quarterly_Crosses_Above,Ema_13_26_Monthly_Crosses_Above,Ema_13_26_Weekly_Crosses_Above,Ema_13_26_Daily_Crosses_Above,Ema_13_26_4_Hourly_Crosses_Above,Ema_13_26_1_Hourly_Crosses_Above,Ema_13_26_15_Minutes_Crosses_Above,Ema_50_100_Yearly_Crosses_Above,Ema_50_100_Quarterly_Crosses_Above,Ema_50_100_Monthly_Crosses_Above,Ema_50_100_Weekly_Crosses_Above,Ema_50_100_Daily_Crosses_Above,Ema_50_100_4_Hourly_Crosses_Above,Ema_50_100_1_Hourly_Crosses_Above,Ema_50_100_15_Minutes_Crosses_Above,Ema_50_200_Yearly_Crosses_Above,Ema_50_200_Quarterly_Crosses_Above,Ema_50_200_Monthly_Crosses_Above,Ema_50_200_Weekly_Crosses_Above,Ema_50_200_Daily_Crosses_Above,Ema_50_200_4_Hourly_Crosses_Above,Ema_50_200_1_Hourly_Crosses_Above,Ema_50_200_15_Minutes_Crosses_Above,Ema_100_200_Yearly_Crosses_Above,Ema_100_200_Quarterly_Crosses_Above,Ema_100_200_Monthly_Crosses_Above,Ema_100_200_Weekly_Crosses_Above,Ema_100_200_Daily_Crosses_Above,Ema_100_200_4_Hourly_Crosses_Above,Ema_100_200_1_Hourly_Crosses_Above,Ema_100_200_15_Minutes_Crosses_Above,Adx_Yearly_Crosses_Above,Adx_Quarterly_Crosses_Above,Adx_Monthly_Crosses_Above,Adx_Weekly_Crosses_Above,Adx_Daily_Crosses_Above,Adx_4_Hourly_Crosses_Above,Adx_1_Hourly_Crosses_Above,Adx_15_Minutes_Crosses_Above,Adx_Up_Tick_Yearly_Greater_Than_Equal_To,Adx_Up_Tick_Quarterly_Greater_Than_Equal_To,Adx_Up_Tick_Monthly_Greater_Than_Equal_To,Adx_Up_Tick_Weekly_Greater_Than_Equal_To,Adx_Up_Tick_Daily_Greater_Than_Equal_To,Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To,Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To,Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band3_Daily_Less_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band2_Daily_Less_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Volume_Yearly_Greater_Than_Equal_To,Volume_Quarterly_Greater_Than_Equal_To,Volume_Monthly_Greater_Than_Equal_To,Volume_Weekly_Greater_Than_Equal_To,Volume_Daily_Greater_Than_Equal_To,Volume_4_Hourly_Greater_Than_Equal_To,Volume_1_Hourly_Greater_Than_Equal_To,Volume_15_Minutes_Greater_Than_Equal_To,volume_yearly_shockers,volume_quarterly_shockers,volume_monthly_shockers,volume_weekly_shockers,volume_daily_shockers,volume_4_hourly_shockers,volume_1_hourly_shockers,volume_15_minutes_shockers,Bearish_Triple_Screen_Strong_Monthly,Bearish_Triple_Screen_Strong_Weekly,Bearish_Triple_Screen_Strong_Daily,Bearish_Triple_Screen_Strong_4_Hourly,Bearish_Triple_Screen_Strong_1_Hourly,Bearish_Triple_Screen_Strong_15_Minutes,Bearish_Triple_Screen_Strong_Correction_Monthly,Bearish_Triple_Screen_Strong_Correction_Weekly,Bearish_Triple_Screen_Strong_Correction_Daily,Bearish_Triple_Screen_Strong_Correction_4_Hourly,Bearish_Triple_Screen_Strong_Correction_1_Hourly,Bearish_Triple_Screen_Strong_Correction_15_Minutes,Bearish_Double_Screen_Strong_Quarterly,Bearish_Double_Screen_Strong_Monthly,Bearish_Double_Screen_Strong_Weekly,Bearish_Double_Screen_Strong_Daily,Bearish_Double_Screen_Strong_4_Hourly,Bearish_Double_Screen_Strong_1_Hourly,Bearish_Double_Screen_Strong_15_Minutes,Bearish_Double_Screen_Strong_Correction_Quarterly,Bearish_Double_Screen_Strong_Correction_Monthly,Bearish_Double_Screen_Strong_Correction_Weekly,Bearish_Double_Screen_Strong_Correction_Daily,Bearish_Double_Screen_Strong_Correction_4_Hourly,Bearish_Double_Screen_Strong_Correction_1_Hourly,Bearish_Double_Screen_Strong_Correction_15_Minutes,Bearish_Single_Screen_Yearly,Bearish_Single_Screen_Quarterly,Bearish_Single_Screen_Monthly,Bearish_Single_Screen_Weekly,Bearish_Single_Screen_Daily,Bearish_Single_Screen_4_Hourly,Bearish_Single_Screen_1_Hourly,Bearish_Single_Screen_15_Minutes,Macd_Yearly_Crosses_Below,Macd_Quarterly_Crosses_Below,Macd_Monthly_Crosses_Below,Macd_Weekly_Crosses_Below,Macd_Daily_Crosses_Below,Macd_4_Hourly_Crosses_Below,Macd_1_Hourly_Crosses_Below,Macd_15_Minutes_Crosses_Below,Rsi_Yearly_Crosses_Below,Rsi_Quarterly_Crosses_Below,Rsi_Monthly_Crosses_Below,Rsi_Weekly_Crosses_Below,Rsi_Daily_Crosses_Below,Rsi_4_Hourly_Crosses_Below,Rsi_1_Hourly_Crosses_Below,Rsi_15_Minutes_Crosses_Below,Stochastic_Yearly_Crosses_Below,Stochastic_Quarterly_Crosses_Below,Stochastic_Monthly_Crosses_Below,Stochastic_Weekly_Crosses_Below,Stochastic_Daily_Crosses_Below,Stochastic_4_Hourly_Crosses_Below,Stochastic_1_Hourly_Crosses_Below,Stochastic_15_Minutes_Crosses_Below,Ema_5_13_Yearly_Crosses_Below,Ema_5_13_Quarterly_Crosses_Below,Ema_5_13_Monthly_Crosses_Below,Ema_5_13_Weekly_Crosses_Below,Ema_5_13_Daily_Crosses_Below,Ema_5_13_4_Hourly_Crosses_Below,Ema_5_13_1_Hourly_Crosses_Below,Ema_5_13_15_Minutes_Crosses_Below,Ema_13_26_Yearly_Crosses_Below,Ema_13_26_Quarterly_Crosses_Below,Ema_13_26_Monthly_Crosses_Below,Ema_13_26_Weekly_Crosses_Below,Ema_13_26_Daily_Crosses_Below,Ema_13_26_4_Hourly_Crosses_Below,Ema_13_26_1_Hourly_Crosses_Below,Ema_13_26_15_Minutes_Crosses_Below,Ema_50_100_Yearly_Crosses_Below,Ema_50_100_Quarterly_Crosses_Below,Ema_50_100_Monthly_Crosses_Below,Ema_50_100_Weekly_Crosses_Below,Ema_50_100_Daily_Crosses_Below,Ema_50_100_4_Hourly_Crosses_Below,Ema_50_100_1_Hourly_Crosses_Below,Ema_50_100_15_Minutes_Crosses_Below,Ema_50_200_Yearly_Crosses_Below,Ema_50_200_Quarterly_Crosses_Below,Ema_50_200_Monthly_Crosses_Below,Ema_50_200_Weekly_Crosses_Below,Ema_50_200_Daily_Crosses_Below,Ema_50_200_4_Hourly_Crosses_Below,Ema_50_200_1_Hourly_Crosses_Below,Ema_50_200_15_Minutes_Crosses_Below,Ema_100_200_Yearly_Crosses_Below,Ema_100_200_Quarterly_Crosses_Below,Ema_100_200_Monthly_Crosses_Below,Ema_100_200_Weekly_Crosses_Below,Ema_100_200_Daily_Crosses_Below,Ema_100_200_4_Hourly_Crosses_Below,Ema_100_200_1_Hourly_Crosses_Below,Ema_100_200_15_Minutes_Crosses_Below,Adx_Yearly_Crosses_Below,Adx_Quarterly_Crosses_Below,Adx_Monthly_Crosses_Below,Adx_Weekly_Crosses_Below,Adx_Daily_Crosses_Below,Adx_4_Hourly_Crosses_Below,Adx_1_Hourly_Crosses_Below,Adx_15_Minutes_Crosses_Below,Adx_Down_Tick_Yearly_Less_Than_Equal_To,Adx_Down_Tick_Quarterly_Less_Than_Equal_To,Adx_Down_Tick_Monthly_Less_Than_Equal_To,Adx_Down_Tick_Weekly_Less_Than_Equal_To,Adx_Down_Tick_Daily_Less_Than_Equal_To,Adx_Down_Tick_4_Hourly_Less_Than_Equal_To,Adx_Down_Tick_1_Hourly_Less_Than_Equal_To,Adx_Down_Tick_15_Minutes_Less_Than_Equal_To,Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band3_Daily_Less_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band2_Daily_Less_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Volume_Yearly_Less_Than_Equal_To,Volume_Quarterly_Less_Than_Equal_To,Volume_Monthly_Less_Than_Equal_To,Volume_Weekly_Less_Than_Equal_To,Volume_Daily_Less_Than_Equal_To,Volume_4_Hourly_Less_Than_Equal_To,Volume_1_Hourly_Less_Than_Equal_To,Volume_15_Minutes_Less_Than_Equal_To
-- into Stocks_Analysis.dbo.Analyse_15Minutes_Stocks_1
from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
order by Batch_No desc,Report_Sort_Order asc
;
select * from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks
end

begin

update Master_Screen_Name_Values
set Description = REPLACE(Description,'-Ts-','-T-')
where Batch_No = 1 -- and Screen_Names like '%Strong_Daily%'
;
select * from Stocks_Analysis.dbo.Master_Screen_Name_Values where Batch_No = 1
order by sno,[Value] desc;

WITH Split AS (
    SELECT value = TRIM(value)
    FROM STRING_SPLIT('orange,apple,banana', ',')
)
SELECT STUFF((
    SELECT ',' + value
    FROM Split
    ORDER BY value
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS SortedString;

end

begin
select count(sno),batch_no,description 
from Master_Screen_Name_Values 
where batch_no = 1 
group by batch_no,description
having count(1)>1
select * from Master_Screen_Name_Values where Description = 'Bu-T-Stg-Corr-M'
update Master_Screen_Name_Values set Description = 'Bu-T-Stg-Corr-D'
where sno = 9 and Batch_No = 1
end

begin

DECLARE @raw_string NVARCHAR(MAX) = 
  'Bu-T-Stg-W;Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Sgl-Y;Bu-Sgl-Q;Bu-Sgl-M;Bu-Sgl-W';

WITH SplitValues AS (
    SELECT 
        value AS full_string,
        PARSENAME(REPLACE(value, '-', '.'), 4) AS part1,  -- Bu
        PARSENAME(REPLACE(value, '-', '.'), 3) AS part2,  -- T / Dbl / Sgl
        PARSENAME(REPLACE(value, '-', '.'), 2) AS part3,  -- Optional: Stg or Suffix
        PARSENAME(REPLACE(value, '-', '.'), 1) AS suffix  -- Optional: suffix
    FROM STRING_SPLIT(@raw_string, ';')
),
Normalized AS (
    SELECT 
        CASE 
            WHEN part2 = 'Sgl' THEN CONCAT(part1, '-', part2)             -- Bu-Sgl
            ELSE CONCAT(part1, '-', part2, '-', part3)                    -- Bu-T-Stg / Bu-Dbl-Stg
        END AS group_key,
        CASE 
            WHEN part2 = 'Sgl' THEN part3                                 -- Suffix for Bu-Sgl
            ELSE suffix                                                  -- Suffix for Bu-T/Dbl
        END AS suffix_value
    FROM SplitValues
),
GroupAgg AS (
    SELECT 
        group_key,
        STRING_AGG(suffix_value, ',') WITHIN GROUP (ORDER BY suffix_value) AS suffixes
    FROM Normalized
    GROUP BY group_key
)
SELECT STRING_AGG(group_key + '-' + suffixes, ';') AS final_output
FROM GroupAgg;

DECLARE @raw_string1 NVARCHAR(MAX) = 'Bu-T-Stg-W;Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Sgl-Y;Bu-Sgl-Q;Bu-Sgl-M;Bu-Sgl-W';

;WITH SplitValues AS (
    SELECT 
        value,
        PARSENAME(REPLACE(value, '-', '.'), 4) AS prefix,  -- Bu
        PARSENAME(REPLACE(value, '-', '.'), 3) AS category, -- T / Dbl / Sgl
        PARSENAME(REPLACE(value, '-', '.'), 2) AS mid,      -- Stg or suffix
        PARSENAME(REPLACE(value, '-', '.'), 1) AS suffix    -- suffix
    FROM STRING_SPLIT(@raw_string, ';')
),
Normalized AS (
    SELECT 
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN NULL ELSE mid END AS mid_value
    FROM SplitValues
),
GroupAgg AS (
    SELECT 
        category,
        ISNULL(mid_value, '') AS mid_text,
        STRING_AGG(suffix_value, ',') WITHIN GROUP (ORDER BY suffix_value) AS suffixes
    FROM Normalized
    GROUP BY category, mid_value
),
Formatted AS (
    SELECT 
        CASE 
            WHEN category = 'T' THEN 'T-Stg-' + suffixes
            WHEN category = 'Dbl' THEN 'Dbl-Stg-' + suffixes
            ELSE 'Sgl-' + suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_order
    FROM GroupAgg
)
SELECT 'Bu-' + STRING_AGG(segments, ';') WITHIN GROUP (ORDER BY sort_order) AS final_output;
end

begin
select 'Bu-T-Stg-W;

Bu-Dbl-Stg-Q;
Bu-Dbl-Stg-M;
Bu-Dbl-Stg-W;

Bu-Sgl-Y;
Bu-Sgl-Q;
Bu-Sgl-M;
Bu-Sgl-W
Bu-T-Stg-W;Dbl-Stg-Q,M,W;Sgl-Y,Q,M,W;'
end

begin

WITH split_items AS (
    SELECT 
		i.Batch_No,
        i.Report_Sort_Order,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')	
	where LTRIM(RTRIM(value)) !=''	
)
,joined_items AS (
    SELECT top 100 percent 
		s.Batch_No,
        s.Report_Sort_Order,
        s.item,
		cast(o.sno as int) as sno
    FROM split_items s
    JOIN Master_Screen_Name_Values o ON s.item = o.Description and o.Batch_No = 1
	where s.item !=''
)
SELECT 
    Batch_No,Report_Sort_Order,
    STRING_AGG(item, ';') WITHIN GROUP (ORDER BY batch_no,report_sort_order,sno) AS sorted_Trade_Type_Details
FROM joined_items
GROUP BY batch_no,report_sort_order
order by batch_no,report_sort_order
end

begin
WITH split_items AS (
    SELECT 
        i.Batch_No,
        i.Report_Sort_Order,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
),
joined_items AS (
    SELECT 
        s.Batch_No,
        s.Report_Sort_Order,
        s.item,
        CAST(o.sno AS INT) AS sno
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description 
       AND o.Batch_No = 1
    WHERE s.item != ''
),
item_parts AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,     -- Bu
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,   -- T / Dbl / Sgl
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid_part,   -- Stg or suffix
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix_part -- W / Q / M / Y
    FROM joined_items
),
normalized_items AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        CASE 
            WHEN category = 'Sgl' THEN mid_part
            ELSE suffix_part
        END AS suffix_value,
        CASE 
            WHEN category = 'Sgl' THEN ''
            ELSE mid_part
        END AS mid_value
    FROM item_parts
),
grouped_items AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        mid_value,
        STRING_AGG(suffix_value, ',') WITHIN GROUP (ORDER BY suffix_value) AS aggregated_suffixes
    FROM normalized_items
    GROUP BY Batch_No, Report_Sort_Order, category, mid_value
),
formatted_items AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + aggregated_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + aggregated_suffixes
            ELSE 'Sgl-' + aggregated_suffixes
        END AS formatted_segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_order
    FROM grouped_items
)
,final as (
SELECT 
    Batch_No,
    Report_Sort_Order,
    'Bu-' + STRING_AGG(formatted_segment, ';') WITHIN GROUP (ORDER BY sort_order) AS transformed_Trade_Type_Details
FROM formatted_items
GROUP BY Batch_No, Report_Sort_Order
-- ORDER BY Batch_No, Report_Sort_Order
) 
select * from final order by len(transformed_Trade_Type_Details) desc
-- Bu-T-Stg-W;Dbl-Stg-M,Q,W; Sgl-M,Q,W,Y 
end

begin

WITH split_items AS (
    SELECT 
        i.Batch_No,
        i.Report_Sort_Order,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
),
joined_items AS (
    SELECT 
        s.Batch_No,
        s.Report_Sort_Order,
        s.item,
        CAST(o.sno AS INT) AS sno
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
),
parts AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
),
normalized AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM parts
),
ordered_suffixes AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        mid_value,
        suffix_value
    FROM normalized
),
distinct_groups AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        mid_value,
        suffix_value
    FROM ordered_suffixes
),
xml_sort AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        mid_value,
        (
            SELECT suffix_value AS [*]
            FROM ordered_suffixes x
            WHERE x.Batch_No = g.Batch_No AND x.Report_Sort_Order = g.Report_Sort_Order
              AND x.category = g.category AND x.mid_value = g.mid_value
            ORDER BY suffix_value
            FOR XML PATH('')
        ) AS xml_suffixes
    FROM distinct_groups g
),
final_format AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        mid_value,
        REPLACE(REPLACE(REPLACE(CAST(xml_suffixes AS NVARCHAR(MAX)), '</suffix_value><suffix_value>', ','), '<suffix_value>', ''), '</suffix_value>', '') AS sorted_suffixes
    FROM xml_sort
),
segments AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_order
    FROM final_format
)
,final as (
SELECT 
    Batch_No,
    Report_Sort_Order,
    'Bu-' + STRING_AGG(segment, ';') WITHIN GROUP (ORDER BY sort_order) AS transformed_Trade_Type_Details
FROM segments
GROUP BY Batch_No, Report_Sort_Order
--ORDER BY Batch_No, Report_Sort_Order
)
select * from final order by len(transformed_Trade_Type_Details) desc

end

begin
-- Define suffix weight mapping
;WITH suffix_order AS (
    SELECT 'Y' AS suffix, 4 AS sort_order UNION ALL
    SELECT 'Q', 1 UNION ALL
    SELECT 'M', 2 UNION ALL
    SELECT 'W', 3
),
split_items AS (
    SELECT 
        i.Batch_No,
        i.Report_Sort_Order,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
),
joined_items AS (
    SELECT 
        s.Batch_No,
        s.Report_Sort_Order,
        s.item,
        CAST(o.sno AS INT) AS sno
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
),
item_parts AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
),
normalized AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM item_parts
),
ordered_suffixes AS (
    SELECT 
        n.Batch_No,
        n.Report_Sort_Order,
        n.category,
        n.mid_value,
        n.suffix_value,
        so.sort_order
    FROM normalized n
    JOIN suffix_order so ON n.suffix_value = so.suffix
),
grouped_suffixes AS (
    SELECT Batch_No,Report_Sort_Order,category,mid_value,
        STRING_AGG(suffix_value, ',') WITHIN GROUP (ORDER BY sort_order) AS sorted_suffixes
    FROM ordered_suffixes
    GROUP BY Batch_No, Report_Sort_Order, category, mid_value
),
formatted AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_priority
    FROM grouped_suffixes
)
SELECT 
    Batch_No,
    Report_Sort_Order,
    'Bu-' + STRING_AGG(segment, ';') WITHIN GROUP (ORDER BY sort_priority) AS transformed_Trade_Type_Details
FROM formatted
GROUP BY Batch_No, Report_Sort_Order
ORDER BY Batch_No, Report_Sort_Order;
end

begin
WITH suffix_order AS (
    SELECT 'Y' AS suffix, 1 AS sort_order UNION ALL
    SELECT 'Q', 2 UNION ALL
    SELECT 'M', 3 UNION ALL
    SELECT 'W', 4
),
split_items AS (
    SELECT 
        i.Batch_No,
        i.Report_Sort_Order,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
),
joined_items AS (
    SELECT 
        s.Batch_No,
        s.Report_Sort_Order,
        s.item,
        CAST(o.sno AS INT) AS sno
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
),
item_parts AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
),
normalized AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM item_parts
),
ordered_suffixes AS (
    SELECT 
        n.Batch_No,
        n.Report_Sort_Order,
        n.category,
        n.mid_value,
        n.suffix_value,
        so.sort_order
    FROM normalized n
    JOIN suffix_order so ON n.suffix_value = so.suffix
),
grouped_suffixes AS (
    SELECT 
        g.Batch_No,
        g.Report_Sort_Order,
        g.category,
        g.mid_value,
        STUFF((
            SELECT ',' + dx.suffix_value
            FROM (
                SELECT DISTINCT x.suffix_value
                FROM ordered_suffixes x
                WHERE x.Batch_No = g.Batch_No 
                  AND x.Report_Sort_Order = g.Report_Sort_Order
                  AND x.category = g.category 
                  AND x.mid_value = g.mid_value
            ) dx
            JOIN suffix_order so ON dx.suffix_value = so.suffix
            ORDER BY so.sort_order
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS sorted_suffixes
    FROM ordered_suffixes g
    GROUP BY g.Batch_No, g.Report_Sort_Order, g.category, g.mid_value
),
formatted AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_priority
    FROM grouped_suffixes
),
final AS (
    SELECT 
        Batch_No,
        Report_Sort_Order,
        'Bu-' + STUFF((
            SELECT ';' + segment
            FROM formatted f2
            WHERE f2.Batch_No = f1.Batch_No AND f2.Report_Sort_Order = f1.Report_Sort_Order
            ORDER BY sort_priority
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS transformed_Trade_Type_Details
    FROM formatted f1
    GROUP BY Batch_No, Report_Sort_Order
)
SELECT * FROM final order by len(transformed_Trade_Type_Details) desc
end

begin
-- final query to sort the string in trade type details and update
WITH suffix_order AS (
    SELECT 'Y' AS suffix, 1 AS sort_order UNION ALL
    SELECT 'Q', 2 UNION ALL
    SELECT 'M', 3 UNION ALL
    SELECT 'W', 4
),
split_items AS (
    SELECT 
        i.Batch_No,
        i.SNO,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
),
joined_items AS (
    SELECT 
        s.Batch_No,
        s.SNO,
        s.item
        -- ,CAST(o.sno AS INT) AS sno_Order
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
),
item_parts AS (
    SELECT 
        Batch_No,
        SNO,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
),
normalized AS (
    SELECT 
        Batch_No,
        SNO,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM item_parts
),
ordered_suffixes AS (
    SELECT 
        n.Batch_No,
        n.SNO,
        n.category,
        n.mid_value,
        n.suffix_value,
        so.sort_order
    FROM normalized n
    JOIN suffix_order so ON n.suffix_value = so.suffix
),
grouped_suffixes AS (
    SELECT 
        g.Batch_No,
        g.SNO,
        g.category,
        g.mid_value,
        STUFF((
            SELECT ',' + dx.suffix_value
            FROM (
                SELECT DISTINCT x.suffix_value
                FROM ordered_suffixes x
                WHERE x.Batch_No = g.Batch_No 
                  AND x.SNO = g.SNO
                  AND x.category = g.category 
                  AND x.mid_value = g.mid_value
            ) dx
            JOIN suffix_order so ON dx.suffix_value = so.suffix
            ORDER BY so.sort_order
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS sorted_suffixes
    FROM ordered_suffixes g
    GROUP BY g.Batch_No, g.SNO, g.category, g.mid_value
),
formatted AS (
    SELECT 
        Batch_No,
        SNO,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_priority
    FROM grouped_suffixes
),
final AS (
    SELECT 
        Batch_No,
        SNO,
        'Bu-' + STUFF((
            SELECT ';' + segment
            FROM formatted f2
            WHERE f2.Batch_No = f1.Batch_No AND f2.SNO = f1.SNO
            ORDER BY sort_priority
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS transformed_Trade_Type_Details
    FROM formatted f1
    GROUP BY Batch_No, SNO
)
update a set trade_type_details = transformed_Trade_Type_Details
from Analyse_Stocks a inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
;
end

begin
WITH suffix_order AS (
    SELECT 'Y' AS suffix, 1 AS sort_order UNION ALL
    SELECT 'Q', 2 UNION ALL
    SELECT 'M', 3 UNION ALL
    SELECT 'W', 4
)
,split_items AS (
    SELECT 
        i.Batch_No,
        i.SNO,
        LTRIM(RTRIM(value)) AS item
    FROM Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != ''
) -- select * from split_items
,joined_items AS (
    SELECT 
        s.Batch_No,
        s.SNO,
        s.item
        ,CAST(o.sno AS INT) AS sno_Order
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
) -- select * from joined_items 
,item_parts AS (
    SELECT 
        Batch_No,
        SNO,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
) -- select * from item_parts -- 20294
,normalized AS (
    SELECT 
        Batch_No,
        SNO,
		prefix,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM item_parts
) -- select * from normalized
,ordered_suffixes AS (
    SELECT 
        n.Batch_No,
        n.SNO,
        n.category,
        n.mid_value,
        n.suffix_value,
        so.sort_order
    FROM normalized n
    JOIN suffix_order so ON n.suffix_value = so.suffix
)
,grouped_suffixes AS (
    SELECT 
        g.Batch_No,
        g.SNO,
        g.category,
        g.mid_value,
        STUFF((
            SELECT ',' + dx.suffix_value
            FROM (
                SELECT DISTINCT x.suffix_value
                FROM ordered_suffixes x
                WHERE x.Batch_No = g.Batch_No 
                  AND x.SNO = g.SNO
                  AND x.category = g.category 
                  AND x.mid_value = g.mid_value
            ) dx
            JOIN suffix_order so ON dx.suffix_value = so.suffix
            ORDER BY so.sort_order
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS sorted_suffixes
    FROM ordered_suffixes g
    GROUP BY g.Batch_No, g.SNO, g.category, g.mid_value
)
,formatted AS (
    SELECT 
        Batch_No,
        SNO,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_priority
    FROM grouped_suffixes
) --select * from formatted 
,final AS (
    SELECT 
        Batch_No,
        SNO,
        'Bu-' + STUFF((
            SELECT ';' + segment
            FROM formatted f2
            WHERE f2.Batch_No = f1.Batch_No AND f2.SNO = f1.SNO
            ORDER BY sort_priority
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS transformed_Trade_Type_Details
    FROM formatted f1
    GROUP BY Batch_No, SNO
)
select * from final 
-- where transformed_Trade_Type_Details like '%Be-%'
--update a set trade_type_details = transformed_Trade_Type_Details
--from Analyse_Stocks a inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
--;

select * from Master_Screen_Name_Values order by batch_no,sno
end

begin
-- sort the string in Trade type details 
WITH suffix_order AS (
    SELECT 'Y' AS suffix, 1 AS sort_order UNION ALL
    SELECT 'Q', 2 UNION ALL
    SELECT 'M', 3 UNION ALL
    SELECT 'W', 4
)
,split_items AS (
    SELECT 
        i.Batch_No,
        i.SNO,
        LTRIM(RTRIM(value)) AS item
    FROM Stocks_Analysis.dbo.Analyse_Stocks i 
    CROSS APPLY STRING_SPLIT(i.Trade_Type_Details, ';')
    WHERE LTRIM(RTRIM(value)) != '' -- and trade_view = 'Bullish'
) -- select * from split_items
,joined_items AS (
    SELECT 
        s.Batch_No,
        s.SNO,
        s.item
       ,CAST(o.sno AS INT) AS sno_Order
    FROM split_items s
    JOIN Master_Screen_Name_Values o 
        ON s.item = o.Description AND o.Batch_No = 1
)
,item_parts AS (
    SELECT 
        Batch_No,
        SNO,
        item,
        PARSENAME(REPLACE(item, '-', '.'), 4) AS prefix,
        PARSENAME(REPLACE(item, '-', '.'), 3) AS category,
        PARSENAME(REPLACE(item, '-', '.'), 2) AS mid,
        PARSENAME(REPLACE(item, '-', '.'), 1) AS suffix
    FROM joined_items
) -- select * from item_parts
,normalized AS (
    SELECT 
        Batch_No,
        SNO,
		prefix,
        category,
        CASE WHEN category = 'Sgl' THEN mid ELSE suffix END AS suffix_value,
        CASE WHEN category = 'Sgl' THEN '' ELSE mid END AS mid_value
    FROM item_parts
) -- select * from normalized 
,ordered_suffixes AS (
    SELECT 
        n.Batch_No,
        n.SNO,
        n.prefix,
		n.category,
        n.mid_value,
        n.suffix_value,
        so.sort_order
    FROM normalized n
    JOIN suffix_order so ON n.suffix_value = so.suffix
) -- select * from ordered_suffixes
,grouped_suffixes AS (
    SELECT 
        g.Batch_No,
        g.SNO,
		g.prefix,
        g.category,
        g.mid_value,
        STUFF((
            SELECT ',' + dx.suffix_value
            FROM (
                SELECT DISTINCT x.suffix_value
                FROM ordered_suffixes x
                WHERE x.Batch_No = g.Batch_No 
                  AND x.SNO = g.SNO
                  AND x.category = g.category 
                  AND x.mid_value = g.mid_value
            ) dx
            JOIN suffix_order so ON dx.suffix_value = so.suffix
            ORDER BY so.sort_order
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS sorted_suffixes
    FROM ordered_suffixes g
    GROUP BY g.Batch_No, g.SNO, g.prefix, g.category, g.mid_value
) -- select * from grouped_suffixes
,formatted AS (
    SELECT 
        Batch_No,
        SNO,
		prefix,
        CASE 
            WHEN category = 'T' THEN 'T-' + mid_value + '-' + sorted_suffixes
            WHEN category = 'Dbl' THEN 'Dbl-' + mid_value + '-' + sorted_suffixes
            ELSE 'Sgl-' + sorted_suffixes
        END AS segment,
        CASE 
            WHEN category = 'T' THEN 1
            WHEN category = 'Dbl' THEN 2
            ELSE 3
        END AS sort_priority
    FROM grouped_suffixes
) -- select * from formatted
,final AS (
    SELECT 
        Batch_No,
        SNO,
        max(isnull(prefix,'')) + '-' + STUFF((
            SELECT ';' + segment
            FROM formatted f2
            WHERE f2.Batch_No = f1.Batch_No AND f2.SNO = f1.SNO
            ORDER BY sort_priority
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS transformed_Trade_Type_Details
    FROM formatted f1
    GROUP BY Batch_No, SNO
)
select * from final
--update a set trade_type_details = transformed_Trade_Type_Details
--from Stocks_Analysis.dbo.Analyse_Stocks a inner join final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno
--;
end

begin
update a
set Description = replace(Description,'-Sim','-Sim-')
from Master_Screen_Name_Values a where Batch_No = 1 and Description like '%-sim%';
select * from Master_Screen_Name_Values where Batch_No = 1 and Description like '%-Sgl-%'
order by sno
;
end

begin
-- If using SQL Server 2016+, use STRING_SPLIT
DECLARE @input NVARCHAR(MAX) = 'Bu-Sgl-Sim-D;Bu-Sgl-Sim-4H;Bu-Sgl-Sim-1H;Bu-Dbl-Stg-4H;Bu-Dbl-Stg-1H;Be-Dbl-Stg-4H;Be-Dbl-Stg-1H;Be-Sgl-Sim-D;Be-Sgl-Sim-4H;Be-Sgl-Sim-1H;';

WITH SplitCodes AS (
    SELECT value AS Code
    FROM STRING_SPLIT(@input, ';')
    WHERE value <> ''
),
Parsed AS (
    SELECT
        -- Get first code segment (Bu or Be)
        LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
        -- Get kind (Sgl-Sim or Dbl-Stg or Tri-Stg)
        SUBSTRING(Code, CHARINDEX('-', Code) + 1,
            CHARINDEX('-', Code + '-', CHARINDEX('-', Code) + 1) - CHARINDEX('-', Code) - 1) AS Type,
        -- Last part
        RIGHT(Code, LEN(Code) - LEN(LEFT(Code, CHARINDEX('-', Code + '-') - 1) + '-' +
            SUBSTRING(Code, CHARINDEX('-', Code) + 1, 
                CHARINDEX('-', Code + '-', CHARINDEX('-', Code) + 1) - CHARINDEX('-', Code) - 1)) - 1) AS SubType
    FROM SplitCodes
) -- select * from SplitCodes
, TypeReplaced AS (
    SELECT 
        Brand,
        CASE WHEN Type = 'Sgl-Sim' THEN 'Sgl-Sim' ELSE Type END AS Type, 
        SubType
    FROM Parsed
)
, Grouped AS (
    SELECT
        Brand,
        Type,
        STRING_AGG(SubType, ',') WITHIN GROUP (ORDER BY 
           CASE SubType 
             WHEN 'Y' THEN 1
			 WHEN 'Q' THEN 2
			 WHEN 'M' THEN 3
			 WHEN 'W' THEN 4
			 WHEN 'D' THEN 5
             WHEN '4H' THEN 6
             WHEN '1H' THEN 7
             ELSE 100 END
        ) AS SubTypes
    FROM TypeReplaced
    GROUP BY Brand, Type
)
, FinalAgg AS (
    SELECT
        Brand,
        STRING_AGG(Type + '-' + SubTypes, ';') WITHIN GROUP (ORDER BY 
            CASE Type 
                WHEN 'Tri-Stg' THEN 1
				WHEN 'Dbl-Stg' THEN 2
                WHEN 'Sgl-Sim' THEN 3
                ELSE 100 END
            ) AS Val
    FROM Grouped
    GROUP BY Brand
)
SELECT STRING_AGG(Val, ';;') WITHIN GROUP (ORDER BY
         CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 100 END
      ) AS Output
FROM FinalAgg
;
end

begin
DECLARE @input1 NVARCHAR(MAX) =
'Bu-Tri-Stg-Y;Bu-Tri-Stg-Q;Bu-Tri-Stg-M;Bu-Tri-Stg-W;Bu-Tri-Stg-D,Bu-Tri-Stg-4H,Bu-Tri-Stg-1H,Bu-Tri-Stg-15;Bu-Dbl-Stg-Y;Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Dbl-Stg-D,Bu-Dbl-Stg-4H,Bu-Dbl-Stg-1H,Bu-Dbl-Stg-15;Bu-Sgl-Sim-Y;Bu-Sgl-Sim-Q;Bu-Sgl-Sim-M;Bu-Sgl-Sim-W;Bu-Sgl-Sim-D,Bu-Sgl-Sim-4H,Bu-Sgl-Sim-1H,Bu-Sgl-Sim-15;Be-Tri-Stg-Y;Be-Tri-Stg-Q;Be-Tri-Stg-M;Be-Tri-Stg-W;Be-Tri-Stg-D,Be-Tri-Stg-4H,Be-Tri-Stg-1H,Be-Tri-Stg-15;Be-Dbl-Stg-Y;Be-Dbl-Stg-Q;Be-Dbl-Stg-M;Be-Dbl-Stg-W;Be-Dbl-Stg-D,Be-Dbl-Stg-4H,Be-Dbl-Stg-1H,Be-Dbl-Stg-15;Be-Sgl-Sim-Y;Be-Sgl-Sim-Q;Be-Sgl-Sim-M;Be-Sgl-Sim-W;Be-Sgl-Sim-D,Be-Sgl-Sim-4H,Be-Sgl-Sim-1H,Be-Sgl-Sim-15;'

-- 1. Split @input into rows using ';'
;WITH Splits AS (
    SELECT value AS GroupStr, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS grpOrder
    FROM STRING_SPLIT(@input, ';')
    WHERE value <> ''
), Parsed AS (
    -- Split each group, if it contains multiple codes by ','
    SELECT
        grpOrder,
        TRIM(value) AS Code
    FROM Splits
    CROSS APPLY STRING_SPLIT(GroupStr, ',')
    WHERE TRIM(value) <> ''
), Parts AS (
    -- Split code into Brand, Type, Stg, Subtype
    SELECT *,
        LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
        PARSENAME(REPLACE(Code, '-', '.'), 4) AS Type,
        PARSENAME(REPLACE(Code, '-', '.'), 3) AS Stg,
        PARSENAME(REPLACE(Code, '-', '.'), 1) AS SubTypeRest
    FROM Parsed
), FinalParts AS (
    SELECT
        Brand,
        Type,
        Stg,
        SubTypeRest AS SubType,
        grpOrder
    FROM Parts
), Grouped AS (
    -- Aggregate subtypes (order: Y, Q, M, W, D, 4H, 1H, 15); skip empty
    SELECT
        Brand,
        Type,
        Stg,
        STRING_AGG(SubType, ',') WITHIN GROUP (
            ORDER BY 
                CASE SubType WHEN 'Y' THEN 1 WHEN 'Q' THEN 2 WHEN 'M' THEN 3 WHEN 'W' THEN 4
                WHEN 'D' THEN 5 WHEN '4H' THEN 6 WHEN '1H' THEN 7 WHEN '15' THEN 8 ELSE 100 END
        ) AS SubTypes
    FROM FinalParts
    GROUP BY Brand, Type, Stg
), BrandGroups AS (
    -- Build each segment per Brand, e.g. Bu-Tri-Stg-[subtypes]
    SELECT
        Brand,
        CONCAT(Type, '-', Stg, '-', SubTypes) AS Segment,
        -- for ordering within the brand group
        CASE 
            WHEN Type='Tri' AND Stg='Stg' THEN 1
            WHEN Type='Dbl' AND Stg='Stg' THEN 2
            WHEN Type='Sgl' AND Stg='Sim' THEN 3
            WHEN Type='Sgl' AND Stg='Stg' THEN 4
            ELSE 100 
        END as SubOrder
    FROM Grouped
), FinalAgg AS (
    -- Within each brand, join the segments with ;
    SELECT
        Brand,
        STRING_AGG(Segment, ';') WITHIN GROUP (ORDER BY SubOrder) AS BrandStr,
        CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 99 END as BrandOrder
    FROM BrandGroups
    GROUP BY Brand
)
-- Finally, join brands with ';;'
SELECT STRING_AGG(BrandStr, ';;') WITHIN GROUP (ORDER BY BrandOrder) AS Output
FROM FinalAgg
end

begin
DECLARE @input2 NVARCHAR(MAX) =
'Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Dbl-Stg-D;Bu-Dbl-Stg-4H;Bu-Dbl-Stg-1H;Bu-Dbl-Stg-15;Bu-Sgl-Sim-Y;Bu-Sgl-Sim-Q;Bu-Sgl-Sim-M;Bu-Sgl-Sim-W;Bu-Sgl-Sim-D;Bu-Sgl-Sim-4H;Bu-Sgl-Sim-1H;Bu-Sgl-Sim-15;Be-Tri-Stg-Y;Be-Tri-Stg-Q;Be-Tri-Stg-M;Be-Tri-Stg-W;Be-Tri-Stg-D;Be-Tri-Stg-4H;Be-Tri-Stg-1H;Be-Tri-Stg-15;Be-Dbl-Stg-Y;Be-Dbl-Stg-Q;Be-Dbl-Stg-M;Be-Dbl-Stg-W;Be-Dbl-Stg-D;Be-Dbl-Stg-4H;Be-Dbl-Stg-1H;Be-Dbl-Stg-15;Be-Sgl-Sim-Y;Be-Sgl-Sim-Q;Be-Sgl-Sim-M;Be-Sgl-Sim-W;Be-Sgl-Sim-D;Be-Sgl-Sim-4H;Be-Sgl-Sim-1H;Be-Sgl-Sim-15;'

-- 'Bu-Tri-Stg-Y;Bu-Tri-Stg-Q;Bu-Tri-Stg-M;Bu-Tri-Stg-W;Bu-Tri-Stg-D;Bu-Tri-Stg-4H;Bu-Tri-Stg-1H;Bu-Tri-Stg-15;Bu-Dbl-Stg-Y;Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Dbl-Stg-D;Bu-Dbl-Stg-4H;Bu-Dbl-Stg-1H;Bu-Dbl-Stg-15;Bu-Sgl-Sim-Y;Bu-Sgl-Sim-Q;Bu-Sgl-Sim-M;Bu-Sgl-Sim-W;Bu-Sgl-Sim-D;Bu-Sgl-Sim-4H;Bu-Sgl-Sim-1H;Bu-Sgl-Sim-15;Be-Tri-Stg-Y;Be-Tri-Stg-Q;Be-Tri-Stg-M;Be-Tri-Stg-W;Be-Tri-Stg-D;Be-Tri-Stg-4H;Be-Tri-Stg-1H;Be-Tri-Stg-15;Be-Dbl-Stg-Y;Be-Dbl-Stg-Q;Be-Dbl-Stg-M;Be-Dbl-Stg-W;Be-Dbl-Stg-D;Be-Dbl-Stg-4H;Be-Dbl-Stg-1H;Be-Dbl-Stg-15;Be-Sgl-Sim-Y;Be-Sgl-Sim-Q;Be-Sgl-Sim-M;Be-Sgl-Sim-W;Be-Sgl-Sim-D;Be-Sgl-Sim-4H;Be-Sgl-Sim-1H;Be-Sgl-Sim-15;'

;WITH Split1 AS (
    SELECT value AS GroupStr
    FROM STRING_SPLIT(@input, ';')
    WHERE value <> ''
) -- select * from Split1
, Split2 AS (
    SELECT TRIM(value) AS Code
    FROM Split1
    CROSS APPLY STRING_SPLIT(GroupStr, ',')
    WHERE TRIM(value) <> ''
) 
, Parts AS (
    SELECT
        Code,
        LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
        PARSENAME(REPLACE(Code, '-', '.'), 3) AS Type,
        PARSENAME(REPLACE(Code, '-', '.'), 2) AS Stg,
        PARSENAME(REPLACE(Code, '-', '.'), 1) AS SubType
    FROM Split2
) -- select * from parts
, Grouped AS (
    SELECT
        Brand, Type, Stg,
        STRING_AGG(SubType, ',') WITHIN GROUP (
            ORDER BY 
                CASE SubType WHEN 'Y' THEN 1 WHEN 'Q' THEN 2 WHEN 'M' THEN 3 WHEN 'W' THEN 4
                WHEN 'D' THEN 5 WHEN '4H' THEN 6 WHEN '1H' THEN 7 WHEN '15' THEN 8 ELSE 100 END
        ) AS SubTypes
    FROM Parts
    GROUP BY Brand, Type, Stg
) -- select * from Grouped
, BrandOrderFix AS (
    SELECT
        Brand, Type, Stg, SubTypes,
        CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 99 END AS BrandOrder,
        -- Tri first (1), Dbl (2), Sgl-Sim (3)
        CASE WHEN Type='Tri' THEN 1 WHEN Type='Dbl' THEN 2 WHEN Type='Sgl' THEN 3 ELSE 99 END AS TypeOrder
    FROM Grouped
) -- select * from BrandOrderFix
, SectionPrep AS (
    SELECT
        Brand, BrandOrder, TypeOrder,
        CASE WHEN TypeOrder = 1 THEN CONCAT(Brand,'-',Type,'-',Stg,'-',SubTypes)
             ELSE CONCAT(Type,'-',Stg,'-',SubTypes)
        END AS SectionStr
    FROM BrandOrderFix
) -- select * from SectionPrep
, BrandAggregate AS (
    SELECT
        Brand, BrandOrder,
        STRING_AGG(SectionStr, ';') WITHIN GROUP (ORDER BY BrandOrder,TypeOrder) AS BrandSection
    FROM SectionPrep
    GROUP BY Brand, BrandOrder
)
SELECT STRING_AGG(BrandSection, ';;') WITHIN GROUP (ORDER BY BrandOrder) AS Output
FROM BrandAggregate
select '
Bu- Tri-Stg-Y,Q,M,W,D,4H,1H,15;
	Dbl-Stg-Y,Q,M,W,D,4H,1H,15;
	Sgl-Sim-Y,Q,M,W,D,4H,1H,15;;

Be-	Tri-Stg-Y,Q,M,W,D,4H,1H,15;
	Dbl-Stg-Y,Q,M,W,D,4H,1H,15;
	Sgl-Sim-Y,Q,M,W,D,4H,1H,15;
'
end

begin
DECLARE @input4 NVARCHAR(MAX) =
'Bu-Dbl-Stg-Q;Bu-Dbl-Stg-Q;Bu-Dbl-Stg-M;Bu-Dbl-Stg-W;Bu-Dbl-Stg-D;Bu-Dbl-Stg-4H;Bu-Dbl-Stg-1H;Bu-Dbl-Stg-15;Bu-Sgl-Sim-Y;Bu-Sgl-Sim-Q;Bu-Sgl-Sim-M;Bu-Sgl-Sim-W;Bu-Sgl-Sim-D;Bu-Sgl-Sim-4H;Bu-Sgl-Sim-1H;Bu-Sgl-Sim-15;Be-Dbl-Stg-Y;Be-Dbl-Stg-Q;Be-Dbl-Stg-M;Be-Dbl-Stg-W;Be-Dbl-Stg-D;Be-Dbl-Stg-4H;Be-Dbl-Stg-15;Be-Sgl-Sim-Y;Be-Sgl-Sim-Q;Be-Sgl-Sim-M;Be-Sgl-Sim-W;Be-Sgl-Sim-4H;Be-Sgl-Sim-1H;Be-Sgl-Sim-15;'

;WITH Split1 AS (
    SELECT value AS GroupStr
    FROM STRING_SPLIT(@input, ';')
    WHERE value <> ''
)
, Split2 AS (
    SELECT TRIM(value) AS Code
    FROM Split1
    CROSS APPLY STRING_SPLIT(GroupStr, ',')
    WHERE TRIM(value) <> ''
)
, Parts AS (
    SELECT distinct
        Code,
        LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
        PARSENAME(REPLACE(Code, '-', '.'), 3) AS Type,
        PARSENAME(REPLACE(Code, '-', '.'), 2) AS Stg,
        PARSENAME(REPLACE(Code, '-', '.'), 1) AS SubType
    FROM Split2
)
, Grouped AS (
    SELECT
        Brand, Type, Stg,
        STRING_AGG(SubType, ',') WITHIN GROUP (
            ORDER BY 
                CASE SubType WHEN 'Y' THEN 1 WHEN 'Q' THEN 2 WHEN 'M' THEN 3 WHEN 'W' THEN 4
                WHEN 'D' THEN 5 WHEN '4H' THEN 6 WHEN '1H' THEN 7 WHEN '15' THEN 8 ELSE 100 END
        ) AS SubTypes
    FROM Parts
    GROUP BY Brand, Type, Stg
)
, BrandOrderFix AS (
    SELECT
        Brand, Type, Stg, SubTypes,
        CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 99 END AS BrandOrder,
        CASE 
            WHEN Type='Tri' THEN 1
            WHEN Type='Dbl' THEN 2
            WHEN Type='Sgl' AND Stg='Sim' THEN 3
            ELSE 99 
        END AS TypeOrder
    FROM Grouped
)
, SectionNumbered AS (
    SELECT
        Brand, BrandOrder, Type, TypeOrder, Stg, SubTypes,
        ROW_NUMBER() OVER (PARTITION BY Brand ORDER BY TypeOrder) AS SeqInBrand
    FROM BrandOrderFix
), SectionPrep AS (
    SELECT
        Brand, BrandOrder, TypeOrder, SeqInBrand,
        CASE WHEN SeqInBrand = 1 THEN CONCAT(Brand,'-',Type,'-',Stg,'-',SubTypes)
             ELSE CONCAT(Type,'-',Stg,'-',SubTypes)
        END AS SectionStr
    FROM SectionNumbered
), BrandAggregate AS (
    SELECT
        Brand, BrandOrder,
        STRING_AGG(SectionStr, ';') WITHIN GROUP (ORDER BY BrandOrder,TypeOrder) AS BrandSection
    FROM SectionPrep
    GROUP BY Brand, BrandOrder
)
,Final as (
SELECT STRING_AGG(BrandSection, ';;') WITHIN GROUP (ORDER BY BrandOrder,BrandSection) AS Output
FROM BrandAggregate
)
select * from Final

end

begin
-- final query to be used in the script
;WITH InputData AS (
    SELECT Batch_No, Sno, Trade_Type_Details
    FROM Stocks_Analysis.dbo.Analyse_Stocks 
	where Batch_No = (select distinct top 1 batch_no from Analyse_Stocks order by Batch_No desc )
	and Trade_Type_Details != '' -- and sno = 24651
	-- order by len(Trade_Type_Details ) desc
), Split1 AS (		-- Split input strings per row into groups separated by ';'
    SELECT	Batch_No, Sno,
			value AS GroupStr
    FROM InputData
	cross apply STRING_SPLIT(Trade_Type_Details, ';')
    WHERE value <> ''
), Split2 AS (		-- Split groups further by ',' into individual codes
    SELECT	Batch_No, Sno,
			TRIM(value) AS Code
    FROM Split1
    CROSS APPLY STRING_SPLIT(GroupStr, ',')
    WHERE TRIM(value) <> ''
), Parts AS (	-- Parse code into Brand, Type, Stg, SubType
    SELECT	Batch_No, Sno, Code,
        -- LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
		PARSENAME(REPLACE(Code, '-', '.'), 4) AS Brand,
        PARSENAME(REPLACE(Code, '-', '.'), 3) AS Type,
        PARSENAME(REPLACE(Code, '-', '.'), 2) AS Stg,
        PARSENAME(REPLACE(Code, '-', '.'), 1) AS SubType
    FROM Split2
), DistinctParts AS (		-- Remove duplicate Brand-Type-Stg-SubType combinations per Id
    SELECT DISTINCT Batch_No, Sno, Brand, Type, Stg, SubType
    FROM Parts
), Grouped AS (		-- Aggregate subtypes, ordered and distinct, per Brand-Type-Stg for each Id
    SELECT	Batch_No, Sno, Brand, Type, Stg,
        STRING_AGG(SubType, ',') WITHIN GROUP (
            ORDER BY 
                CASE SubType 
					WHEN 'Y' THEN 1 WHEN 'Q' THEN 2 WHEN 'M' THEN 3 WHEN 'W' THEN 4
					WHEN 'D' THEN 5 WHEN '4H' THEN 6 WHEN '1H' THEN 7 WHEN '15' THEN 8 ELSE 100 END
        ) AS SubTypes
    FROM DistinctParts
    GROUP BY Batch_No, Sno, Brand, Type, Stg
), BrandOrderFix AS (		-- Assign ordering for brand and type to control output order
    SELECT	Batch_No, Sno, Brand, Type, Stg, SubTypes,
        CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 99 END AS BrandOrder,
        CASE WHEN Type='Tri' THEN 1 WHEN Type='Dbl' THEN 2 WHEN Type='Sgl' THEN 3 ELSE 99 END AS TypeOrder
    FROM Grouped
), SectionNumbered AS (		-- Number sections to know which is first for the brand and hence add prefix
    SELECT	Batch_No, Sno, Brand, BrandOrder, Type, TypeOrder, Stg, SubTypes,
			ROW_NUMBER() OVER (PARTITION BY Batch_No, Sno, Brand ORDER BY TypeOrder) AS SeqInBrand
    FROM BrandOrderFix
), SectionPrep AS (
    SELECT Batch_No, Sno, Brand, BrandOrder, TypeOrder, SeqInBrand,
        CASE WHEN SeqInBrand = 1 THEN CONCAT(Brand,'-',Type,'-',Stg,'-',SubTypes)
             ELSE CONCAT(Type,'-',Stg,'-',SubTypes)
        END AS SectionStr
    FROM SectionNumbered
), BrandAggregate AS (		-- Aggregate segments per brand per Id
    SELECT Batch_No, Sno, Brand, BrandOrder,
        STRING_AGG(SectionStr, ';') WITHIN GROUP (ORDER BY BrandOrder,TypeOrder) AS BrandSection
    FROM SectionPrep
    GROUP BY Batch_No, Sno, Brand, BrandOrder
),Final as (		-- Aggregate full output per Id joining brands with ';;', ordered by BrandOrder (Bu then Be)
SELECT Batch_No, Sno,
	STRING_AGG(BrandSection, ';;') WITHIN GROUP (ORDER BY BrandOrder,BrandSection) AS Output
FROM BrandAggregate
group by Batch_No, Sno
)
select * from Final
end

begin
select  * from Analyse_Stocks where 1=1 
-- and batch_no = 20250804063920 
and Trade_Type_Details != '' 
and Segments_Length >10 
order by -- Batch_No desc,
Segments_Order desc,
-- Report_Sort_Order asc,
Trade_Type_Details_Sum desc,
Volume_Shockers_Sum desc,
trade_view desc
;
end

begin
EXEC sp_rename  'Stocks_Analysis.dbo.Analyse_15Minutes_Stocks.Trading_View','Trade_View'
EXEC sp_rename  'Stocks_Analysis.dbo.Analyse_15Minutes_Stocks.Trade_View_Order','Trade_View_Order'
EXEC sp_rename  'Stocks_Analysis.dbo.Analyse_Stocks.Trading_View','Trade_View'
EXEC sp_rename  'Stocks_Analysis.dbo.Analyse_Stocks.Trade_View_Order','Trade_View_Order'

EXEC sp_rename  'Stocks_Analysis.dbo.Master_master_segments','Master_Segments'

EXEC sp_rename  'Stocks_Analysis.dbo.Master_Stocks_Industry_Sector_Wise','Master_Sector_Industory_Wise'
EXEC sp_rename  'Stocks_Analysis.dbo.Master_Sector_Industory_Wise','zMaster_Sector_Industory_Wise'
EXEC sp_rename  'Stocks_Analysis.dbo.Master_ScreenSort','zMaster_ScreenSort'
EXEC sp_rename  'Stocks_Analysis.dbo.Master_Sector_Table','zMaster_Sector_Table'
end

begin
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'yearly;','Y;' );
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'quarterly;','Q;' );
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'monthly;','M;' );
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'weekly;','W;' );
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'daily;','D;' );
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'4_hourly;','4H;');
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'1_hourly;','1H;');
update Analyse_15minutes_Stocks set Other_Setups = REPLACE(Other_Setups,'15_minutes;','15;');
end

begin
select * 
-- into Stocks_Analysis.dbo.Master_Segments_temp 
from Stocks_Analysis.dbo.Master_Segments where symbol like '% %'

update a set 
Symbol = b.Symbol, 
Stock_Name = b.Stock_Name
from Stocks_Analysis.dbo.Master_Segments a 
inner join Stocks_Analysis.dbo.Master_Segments_temp b 
on a.Stock_Name = b.Symbol
where a.Symbol like '% %'
end

begin
select	'15mins' as TmFrm,Symbol,Trade_Type_Details,Other_Setups,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View,Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,Created_Date,price_action as pa -- ,Trade_Type,Series,ISIN_Code,
from	Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
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
select	'Daily',Symbol,Trade_Type_Details,Other_Setups,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View,Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,Created_Date,price_action as pa -- Trade_Type,Series,ISIN_Code,
from	Stocks_Analysis.dbo.Analyse_Stocks 
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
end

begin
with cte as (
select row_number() over(partition by Symbol order by sno) as rn,
Symbol,Segments,Stock_Name,Industry,ISIN_Code,Series,sno,sector_order,sector_sum
from [dbo].[Master_Segments]
-- order by Symbol,sno
)
delete from Stocks_Analysis.dbo.Master_Segments where sno in (
select distinct sno from cte where rn <> 1 
)
end

begin
select 
* from Stocks_Analysis.dbo.Master_Segments
order by 8 desc,symbol
;
select 
Symbol,count(1) from [dbo].[Master_Segments]
group by Symbol having count(1) > 1
;
end

begin
select symbol from dbo.Cash_Stocks where symbol like '% %' union all 
select symbol from dbo.Cash_15Minutes_Stocks where symbol like '% %' union all 
select symbol from dbo.Analyse_Stocks where symbol like '% %' union all 
select symbol from dbo.Analyse_15Minutes_Stocks where symbol like '% %' 
end

begin
with cte as (
select	'D' as TM,Trade_View as Trd_vw,Symbol,Trade_Type_Details,Other_Setups as vol_sh,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,price_action as pa -- Trade_Type,Series,ISIN_Code,
		,row_number() over(partition by batch_no order by Batch_No,Trade_Type_Details_Sum desc,Volume_Shockers_Sum desc,Segments_Order desc,Trade_View desc,Report_Sort_Order asc) as row_no
		,Created_Date
from	Stocks_Analysis.dbo.Analyse_Stocks 
where	1=1 
	and	batch_no >= cast(Format(getdate(),'yyyyMMdd')+'050505' as bigint)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
union all 
select	'15',Trade_View,Symbol,Trade_Type_Details,Other_Setups,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,price_action as pa -- ,Trade_Type,Series,ISIN_Code,
		,10000+row_number() over(partition by batch_no order by Batch_No,Trade_Type_Details_Sum desc,Volume_Shockers_Sum desc,Segments_Order desc,Trade_View desc,Report_Sort_Order asc) as row_no
		,Created_Date
from	Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
where	1=1 
	and	batch_no = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
)
select * from cte order by row_no asc
end

begin
select '
sno	Screen_Names	Value	Batch_No	Description
13	Bullish_Double_Screen_Strong_Quarterly	287	1	Bu-Dbl-Stg-Q
20	Bullish_Double_Screen_Strong_Correction_Quarterly	43	1	Bu-Dbl-Stg-Corr-Q
47	Bearish_Double_Screen_Strong_Quarterly	287	1	Be-Dbl-Stg-Q
54	Bearish_Double_Screen_Strong_Correction_Quarterly	43	1	Be-Dbl-Stg-Corr-Q
62	Bearish_Single_Screen_Quarterly	7	1	Be-Sgl-Sim-Q
28	Bullish_Single_Screen_Quarterly	7	1	Bu-Sgl-Sim-Q

sno	Screen_Names	Value	Batch_No	Description
61	Bearish_Single_Screen_Yearly	8	1	Be-Sgl-Sim-Y
27	Bullish_Single_Screen_Yearly	8	1	Bu-Sgl-Sim-Y

sno	Screen_Names	Value	Batch_No	Description
1	Bullish_Triple_Screen_Strong_Monthly	11955	1	Bu-Tri-Stg-M
7	Bullish_Triple_Screen_Strong_Correction_Monthly	1994	1	Bu-Tri-Stg-Corr-M
14	Bullish_Double_Screen_Strong_Monthly	286	1	Bu-Dbl-Stg-M
21	Bullish_Double_Screen_Strong_Correction_Monthly	42	1	Bu-Dbl-Stg-Corr-M
41	Bearish_Triple_Screen_Strong_Correction_Monthly	1994	1	Be-Tri-Stg-Corr-M
48	Bearish_Double_Screen_Strong_Monthly	286	1	Be-Dbl-Stg-M
55	Bearish_Double_Screen_Strong_Correction_Monthly	42	1	Be-Dbl-Stg-Corr-M
63	Bearish_Single_Screen_Monthly	6	1	Be-Sgl-Sim-M
29	Bullish_Single_Screen_Monthly	6	1	Bu-Sgl-Sim-M
35	Bearish_Triple_Screen_Strong_Monthly	11955	1	Be-Tri-Stg-M
';
select * 
-- update a set Value = 0 
from [dbo].[Master_Screen_Name_Values] a
where Batch_No = 1 and (Screen_Names like '%yearly%' or Screen_Names like '%quarterly%' or Screen_Names like '%monthly%')
order by Batch_No
;
end

begin
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_Monthly       bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_Weekly        bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_Daily         bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_4_Hourly      bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_1_Hourly      bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Swing_15_Minutes	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Momentum_Monthly    bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Momentum_Weekly     bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Momentum_Daily      bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Monentum_4_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Momentum_1_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Triple_Screen_Momentum_15_Minutes bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_Quarterly 	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_Monthly   	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_Weekly    	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_Daily     	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_4_Hourly  	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_1_Hourly  	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Swing_15_Minutes	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_Quarterly  bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_Monthly    bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_Weekly     bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_Daily      bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_4_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_1_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Double_Screen_Momentum_15_Minutes bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_Yearly    	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_Quarterly 	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_Monthly   	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_Weekly    	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_Daily     	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_4_Hourly  	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_1_Hourly  	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Swing_15_Minutes	 bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_Yearly     bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_Quarterly  bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_Monthly    bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_Weekly     bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_Daily      bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_4_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_1_Hourly   bit null;
alter table Analyse_15minutes_Stocks add Bullish_Single_Screen_Momentum_15_Minutes bit null;

alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Yearly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_15_Minutes bit null;

alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Yearly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Monentum_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Yearly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Quarterly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Monthly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Weekly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Daily bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_4_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_1_Hourly bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_15_Minutes bit null;
alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_yearly bit null;

/*
insert into Master_Screen_Name_Values (Batch_No,Screen_Names) values 
(1,'Bearish_Double_Screen_Momentum_1_Hourly'),
(1,'Bearish_Double_Screen_Momentum_15_Minutes'),
(1,'Bearish_Double_Screen_Momentum_4_Hourly'),
(1,'Bearish_Double_Screen_Momentum_Daily'),
(1,'Bearish_Double_Screen_Momentum_Monthly'),
(1,'Bearish_Double_Screen_Momentum_Quarterly'),
(1,'Bearish_Double_Screen_Momentum_Weekly'),
(1,'Bearish_Double_Screen_Strong_15_Minutes'),
(1,'Bearish_Double_Screen_Strong_Correction_1_Hourly'),
(1,'Bearish_Double_Screen_Strong_Correction_15_Minutes'),
(1,'Bearish_Double_Screen_Strong_Correction_4_Hourly'),
(1,'Bearish_Double_Screen_Strong_Correction_Daily'),
(1,'Bearish_Double_Screen_Strong_Correction_Monthly'),
(1,'Bearish_Double_Screen_Strong_Correction_Quarterly'),
(1,'Bearish_Double_Screen_Strong_Correction_Weekly'),
(1,'Bearish_Double_Screen_Swing_1_Hourly'),
(1,'Bearish_Double_Screen_Swing_15_Minutes'),
(1,'Bearish_Double_Screen_Swing_4_Hourly'),
(1,'Bearish_Double_Screen_Swing_Daily'),
(1,'Bearish_Double_Screen_Swing_Monthly'),
(1,'Bearish_Double_Screen_Swing_Quarterly'),
(1,'Bearish_Double_Screen_Swing_Weekly'),
(1,'Bearish_Single_Screen_Momentum_1_Hourly'),
(1,'Bearish_Single_Screen_Momentum_15_Minutes'),
(1,'Bearish_Single_Screen_Momentum_4_Hourly'),
(1,'Bearish_Single_Screen_Momentum_Daily'),
(1,'Bearish_Single_Screen_Momentum_Monthly'),
(1,'Bearish_Single_Screen_Momentum_Quarterly'),
(1,'Bearish_Single_Screen_Momentum_Weekly'),
(1,'Bearish_Single_Screen_Momentum_Yearly'),
(1,'Bearish_Single_Screen_Strong_Correction_1_Hourly'),
(1,'Bearish_Single_Screen_Strong_Correction_15_Minutes'),
(1,'Bearish_Single_Screen_Strong_Correction_4_Hourly'),
(1,'Bearish_Single_Screen_Strong_Correction_Daily'),
(1,'Bearish_Single_Screen_Strong_Correction_Monthly'),
(1,'Bearish_Single_Screen_Strong_Correction_Quarterly'),
(1,'Bearish_Single_Screen_Strong_Correction_Weekly'),
(1,'Bearish_Single_Screen_Strong_Correction_yearly'),
(1,'Bearish_Single_Screen_Swing_1_Hourly'),
(1,'Bearish_Single_Screen_Swing_15_Minutes'),
(1,'Bearish_Single_Screen_Swing_4_Hourly'),
(1,'Bearish_Single_Screen_Swing_Daily'),
(1,'Bearish_Single_Screen_Swing_Monthly'),
(1,'Bearish_Single_Screen_Swing_Quarterly'),
(1,'Bearish_Single_Screen_Swing_Weekly'),
(1,'Bearish_Single_Screen_Swing_Yearly'),
(1,'Bearish_Triple_Screen_Momentum_1_Hourly'),
(1,'Bearish_Triple_Screen_Momentum_15_Minutes'),
(1,'Bearish_Triple_Screen_Momentum_Daily'),
(1,'Bearish_Triple_Screen_Momentum_Monthly'),
(1,'Bearish_Triple_Screen_Momentum_Weekly'),
(1,'Bearish_Triple_Screen_Monentum_4_Hourly'),
(1,'Bearish_Triple_Screen_Strong_1_Hourly'),
(1,'Bearish_Triple_Screen_Strong_15_Minutes'),
(1,'Bearish_Triple_Screen_Strong_Correction_1_Hourly'),
(1,'Bearish_Triple_Screen_Strong_Correction_15_Minutes'),
(1,'Bearish_Triple_Screen_Strong_Correction_4_Hourly'),
(1,'Bearish_Triple_Screen_Strong_Correction_Daily'),
(1,'Bearish_Triple_Screen_Strong_Correction_Monthly'),
(1,'Bearish_Triple_Screen_Strong_Correction_Weekly'),
(1,'Bearish_Triple_Screen_Swing_1_Hourly'),
(1,'Bearish_Triple_Screen_Swing_15_Minutes'),
(1,'Bearish_Triple_Screen_Swing_4_Hourly'),
(1,'Bearish_Triple_Screen_Swing_Daily'),
(1,'Bearish_Triple_Screen_Swing_Monthly'),
(1,'Bearish_Triple_Screen_Swing_Weekly'),
(1,'Bullish_Double_Screen_Momentum_1_Hourly'),
(1,'Bullish_Double_Screen_Momentum_15_Minutes'),
(1,'Bullish_Double_Screen_Momentum_4_Hourly'),
(1,'Bullish_Double_Screen_Momentum_Daily'),
(1,'Bullish_Double_Screen_Momentum_Monthly'),
(1,'Bullish_Double_Screen_Momentum_Quarterly'),
(1,'Bullish_Double_Screen_Momentum_Weekly'),
(1,'Bullish_Double_Screen_Strong_15_Minutes'),
(1,'Bullish_Double_Screen_Strong_Correction_1_Hourly'),
(1,'Bullish_Double_Screen_Strong_Correction_15_Minutes'),
(1,'Bullish_Double_Screen_Strong_Correction_4_Hourly'),
(1,'Bullish_Double_Screen_Strong_Correction_Daily'),
(1,'Bullish_Double_Screen_Strong_Correction_Monthly'),
(1,'Bullish_Double_Screen_Strong_Correction_Quarterly'),
(1,'Bullish_Double_Screen_Strong_Correction_Weekly'),
(1,'Bullish_Double_Screen_Swing_1_Hourly'),
(1,'Bullish_Double_Screen_Swing_15_Minutes'),
(1,'Bullish_Double_Screen_Swing_4_Hourly'),
(1,'Bullish_Double_Screen_Swing_Daily'),
(1,'Bullish_Double_Screen_Swing_Monthly'),
(1,'Bullish_Double_Screen_Swing_Quarterly'),
(1,'Bullish_Double_Screen_Swing_Weekly'),
(1,'Bullish_Single_Screen_Momentum_1_Hourly'),
(1,'Bullish_Single_Screen_Momentum_15_Minutes'),
(1,'Bullish_Single_Screen_Momentum_4_Hourly'),
(1,'Bullish_Single_Screen_Momentum_Daily'),
(1,'Bullish_Single_Screen_Momentum_Monthly'),
(1,'Bullish_Single_Screen_Momentum_Quarterly'),
(1,'Bullish_Single_Screen_Momentum_Weekly'),
(1,'Bullish_Single_Screen_Momentum_Yearly'),
(1,'Bullish_Single_Screen_Strong_Correction_1_Hourly'),
(1,'Bullish_Single_Screen_Strong_Correction_15_Minutes'),
(1,'Bullish_Single_Screen_Strong_Correction_4_Hourly'),
(1,'Bullish_Single_Screen_Strong_Correction_Daily'),
(1,'Bullish_Single_Screen_Strong_Correction_Monthly'),
(1,'Bullish_Single_Screen_Strong_Correction_Quarterly'),
(1,'Bullish_Single_Screen_Strong_Correction_Weekly'),
(1,'Bullish_Single_Screen_Strong_Correction_Yearly'),
(1,'Bullish_Single_Screen_Swing_1_Hourly'),
(1,'Bullish_Single_Screen_Swing_15_Minutes'),
(1,'Bullish_Single_Screen_Swing_4_Hourly'),
(1,'Bullish_Single_Screen_Swing_Daily'),
(1,'Bullish_Single_Screen_Swing_Monthly'),
(1,'Bullish_Single_Screen_Swing_Quarterly'),
(1,'Bullish_Single_Screen_Swing_Weekly'),
(1,'Bullish_Single_Screen_Swing_Yearly'),
(1,'Bullish_Triple_Screen_Momentum_1_Hourly'),
(1,'Bullish_Triple_Screen_Momentum_15_Minutes'),
(1,'Bullish_Triple_Screen_Momentum_Daily'),
(1,'Bullish_Triple_Screen_Momentum_Monthly'),
(1,'Bullish_Triple_Screen_Momentum_Weekly'),
(1,'Bullish_Triple_Screen_Monentum_4_Hourly'),
(1,'Bullish_Triple_Screen_Strong_1_Hourly'),
(1,'Bullish_Triple_Screen_Strong_15_Minutes'),
(1,'Bullish_Triple_Screen_Strong_Correction_1_Hourly'),
(1,'Bullish_Triple_Screen_Strong_Correction_15_Minutes'),
(1,'Bullish_Triple_Screen_Strong_Correction_4_Hourly'),
(1,'Bullish_Triple_Screen_Strong_Correction_Daily'),
(1,'Bullish_Triple_Screen_Strong_Correction_Monthly'),
(1,'Bullish_Triple_Screen_Strong_Correction_Weekly'),
(1,'Bullish_Triple_Screen_Swing_1_Hourly'),
(1,'Bullish_Triple_Screen_Swing_15_Minutes'),
(1,'Bullish_Triple_Screen_Swing_4_Hourly'),
(1,'Bullish_Triple_Screen_Swing_Daily'),
(1,'Bullish_Triple_Screen_Swing_Monthly'),
(1,'Bullish_Triple_Screen_Swing_Weekly')
;
*/
end

begin
with cte as (
select	'D' as TM,Trade_View as Trd_vw,Symbol,Trade_Type_Details,Other_Setups as vol_sh,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,price_action as pa -- Trade_Type,Series,ISIN_Code,
		,10000+row_number() over(partition by batch_no order by Batch_No,Trade_View desc,Trade_Type_Details_Sum desc,Volume_Shockers_Sum desc,Segments_Order desc,Report_Sort_Order asc) as row_no
		,Created_Date
from	Stocks_Analysis.dbo.Analyse_Stocks 
where	1=1 
	and	batch_no >= (select max(batch_no) from Stocks_Analysis.dbo.Analyse_Stocks)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
union all 
select	'15',Trade_View,Symbol,Trade_Type_Details,Other_Setups,Industry,Segments,
		Stock_Name,Price,Percent_Change as [%cng],Volume,
		Report_Sort_Order as RSO,Batch_No,Sno,
		Trade_View_Order as TVO,Trade_Type_Length as TTL,Trade_Type_Bullish_Sum as TTBuS,Trade_Type_Bearish_Sum as TTBeS,Trade_Type_Details_Length as TTDL,Trade_Type_Details_Sum as TTDS,Segments_Order as SO,Segments_Length as SL,Segments_Sum as SS,Volume_Shockers_Sum as VSS,price_action as pa -- ,Trade_Type,Series,ISIN_Code,
		,row_number() over(partition by batch_no order by Batch_No,Trade_View desc,Trade_Type_Details_Sum desc,Volume_Shockers_Sum desc,Segments_Order desc,Report_Sort_Order asc) as row_no
		,Created_Date
from	Stocks_Analysis.dbo.Analyse_15Minutes_Stocks 
where	1=1 
	and	batch_no = (select max(batch_no) from Stocks_Analysis.dbo.Analyse_15Minutes_Stocks)
	and	Trade_Type_Details_Sum > 15
	and	Segments_Order > 500
)
select * from cte order by row_no asc
end

begin
	declare @Trade_Type nvarchar(max) 
		,@Trade_Type_Details nvarchar(max) 
		,@Trade_Type_Details_Sum  nvarchar(max)

	SELECT
	@Trade_Type = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then ''' + left(Screen_Names,2) + ';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
	,@Trade_Type_Details = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then dp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
	,@Trade_Type_Details_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
	from dbo.Master_Screen_Name_Values where Batch_No = 1;
	select @Trade_Type,@Trade_Type_Details,@Trade_Type_Details_Sum;

	declare @Trade_Type_Bullish_Sum nvarchar(max)
	SELECT
	@Trade_Type_Bullish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
	from dbo.Master_Screen_Name_Values where Batch_No = 1 and Screen_Names like 'Bullish%';
	select @Trade_Type_Bullish_Sum;
	declare @Trade_Type_Bearish_Sum nvarchar(max)
	SELECT
	@Trade_Type_Bearish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
	from dbo.Master_Screen_Name_Values where Batch_No = 1 and Screen_Names like 'Bearish%';
	select @Trade_Type_Bearish_Sum;

end

begin
-- update trade_type.... calculated fields 

declare @Trade_Type nvarchar(max) ,@Trade_Type_Details nvarchar(max) ,@Trade_Type_Details_Sum  nvarchar(max),@ScreenNames nvarchar(max),@sql_query nvarchar(max)
,@Trade_Type_Bullish_Sum nvarchar(max),@Trade_Type_Bearish_Sum nvarchar(max),@sql_query1 nvarchar(max)
SELECT
@ScreenNames = STRING_AGG(CAST(('[' + Screen_Names + ']') AS NVARCHAR(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then ''' + left(Screen_Names,2) + ';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then dp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = 4;
select @ScreenNames,@Trade_Type,@Trade_Type_Details,@Trade_Type_Details_Sum;
SELECT
@Trade_Type_Bullish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = 1 and Screen_Names like 'Bullish%';
select @Trade_Type_Bullish_Sum;
SELECT
@Trade_Type_Bearish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS NVARCHAR(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = 1 and Screen_Names like 'Bearish%';
select @Trade_Type_Bearish_Sum;

select @sql_query = cast('
WITH ValueSource AS ( SELECT Batch_No, Screen_Names, Value FROM dbo.Master_Screen_Name_Values WHERE Batch_No = 1 )
,ValuePivot AS ( SELECT * FROM ValueSource PIVOT (SUM(Value) FOR Screen_Names IN (' + @ScreenNames + ')) AS vp )
,DescSource AS ( SELECT Batch_No, Screen_Names, Description FROM dbo.Master_Screen_Name_Values WHERE Batch_No = 1 )
,DescPivot AS (SELECT * FROM DescSource a PIVOT (MAX(Description) FOR Screen_Names IN (' + @ScreenNames + ') ) AS dp )
UPDATE a SET Trade_Type = ISNULL(a.Trade_Type, '') + ' + @Trade_Type + ' '''',
Trade_Type_Details = ISNULL(a.Trade_Type_Details, '') +  ' + @Trade_Type_Details + ' '''',
Trade_Type_Details_Sum = ISNULL(a.Trade_Type_Details_Sum, 0) + ' + @Trade_Type_Details_Sum + ' 0,
Trade_Type_Bullish_Sum = ISNULL(a.Trade_Type_Bullish_Sum, 0) + ' + @Trade_Type_Bullish_Sum + ' 0,
Trade_Type_Bearish_Sum = ISNULL(a.Trade_Type_Bearish_Sum, 0) + ' + @Trade_Type_Bearish_Sum + ' 0
FROM dbo.Analyse_Stocks a JOIN DescPivot dp ON dp.Batch_No = 1 and a.Batch_No = @batch_no JOIN ValuePivot vp ON vp.Batch_No = 1;' as nvarchar(max))
select @sql_query;

end

begin
with cte as (
select row_number() over (partition by batch_no,screen_names order by screen_names,isnull(sno,999)) as rn
,*
from dbo.Master_Screen_Name_Values
-- where Batch_No  = 1 
)
select * from cte where rn = 1
;
select count(1), batch_no from Master_Screen_Name_Values group by Batch_No
;
end

begin

exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_Yearly',    'Bearish_Single_Screen_Strong_Yearly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_Quarterly', 'Bearish_Single_Screen_Strong_Quarterly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_Monthly',   'Bearish_Single_Screen_Strong_Monthly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_Weekly',    'Bearish_Single_Screen_Strong_Weekly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_Daily',     'Bearish_Single_Screen_Strong_Daily1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_4_Hourly',  'Bearish_Single_Screen_Strong_4_Hourly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_1_Hourly',  'Bearish_Single_Screen_Strong_1_Hourly1';
exec sp_rename 'Analyse_Stocks.Bearish_Single_Screen_15_Minutes','Bearish_Single_Screen_Strong_15_Minutes1';

EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Triple_Screen_Swing_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Double_Screen_Swing_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bullish_Single_Screen_Swing_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Strong_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Momentum_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Triple_Screen_Swing_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Double_Screen_Swing_Correction_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_15_Minutes bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_Yearly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_Quarterly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_Monthly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_Weekly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_Daily bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_4_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_1_Hourly bit null';
EXEC sp_executesql N'Alter table Analyse_15Minutes_Stocks add Bearish_Single_Screen_Swing_Correction_15_Minutes bit null';
alter table Analyse_15minutes_Stocks add double_bottom_yearly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_quarterly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_monthly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_weekly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_daily_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_4_hourly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_1_hourly_setup bit null;
alter table Analyse_15minutes_Stocks add double_bottom_15_minutes_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_yearly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_quarterly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_monthly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_weekly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_daily_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_4_hourly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_1_hourly_setup bit null;
alter table Analyse_15minutes_Stocks add double_top_15_minutes_setup bit null;
alter table Analyse_15minutes_Stocks add price_yearly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_quarterly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_monthly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_weekly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_daily_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_4_hourly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_1_hourly_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add price_15_minutes_above_50_Ema bit null;
alter table Analyse_15minutes_Stocks add Elliott_4th_Wave_Completed_Daily_setup bit null;
alter table Analyse_15minutes_Stocks add Double_Top_with_RSI_Daily_setup bit null;
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_Yearly_setup     bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_Quarterly_setup  bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_Monthly_setup    bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_Weekly_setup     bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_4_Hourly_setup   bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_1_Hourly_setup   bit null; 
alter table Analyse_Stocks add Elliott_4th_Wave_Completed_15_Minutes_setup bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_Yearly_setup            bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_Quarterly_setup         bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_Monthly_setup           bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_Weekly_setup            bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_4_Hourly_setup          bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_1_Hourly_setup          bit null; 
alter table Analyse_Stocks add Double_Top_with_RSI_15_Minutes_setup        bit null; 	

alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_Yearly_setup     bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_Quarterly_setup  bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_Monthly_setup    bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_Weekly_setup     bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_4_Hourly_setup   bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_1_Hourly_setup   bit null; 
alter table Analyse_15Minutes_Stocks add Elliott_4th_Wave_Completed_15_Minutes_setup bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_Yearly_setup            bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_Quarterly_setup         bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_Monthly_setup           bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_Weekly_setup            bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_4_Hourly_setup          bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_1_Hourly_setup          bit null; 
alter table Analyse_15Minutes_Stocks add Double_Top_with_RSI_15_Minutes_setup        bit null; 

end

begin
select * from Master_Screen_Name_Values where Batch_No = 4;

select Batch_No,Report_Sort_Order,Symbol,Trade_Type_Details,Trade_View,Other_Setups,Industry,Segments,Price,Percent_Change,Volume,Sno,Trade_View_Order,Trade_Type,Trade_Type_Length,Trade_Type_Bullish_Sum,Volume_Shockers_Sum,Trade_Type_Bearish_Sum,Trade_Type_Details_Length,Trade_Type_Details_Sum,Segments_Order,Segments_Length,Segments_Sum,Stock_Name,Series,ISIN_Code,price_action,Created_Date,Bullish_Triple_Screen_Strong_Yearly,Bullish_Triple_Screen_Strong_Quarterly,Bullish_Triple_Screen_Strong_Monthly,Bullish_Triple_Screen_Strong_Weekly,Bullish_Triple_Screen_Strong_Daily,Bullish_Triple_Screen_Strong_4_Hourly,Bullish_Triple_Screen_Strong_1_Hourly,Bullish_Triple_Screen_Strong_15_Minutes,Bullish_Triple_Screen_Strong_Correction_Yearly,Bullish_Triple_Screen_Strong_Correction_Quarterly,Bullish_Triple_Screen_Strong_Correction_Monthly,Bullish_Triple_Screen_Strong_Correction_Weekly,Bullish_Triple_Screen_Strong_Correction_Daily,Bullish_Triple_Screen_Strong_Correction_4_Hourly,Bullish_Triple_Screen_Strong_Correction_1_Hourly,Bullish_Triple_Screen_Strong_Correction_15_Minutes,Bullish_Double_Screen_Strong_Yearly,Bullish_Double_Screen_Strong_Quarterly,Bullish_Double_Screen_Strong_Monthly,Bullish_Double_Screen_Strong_Weekly,Bullish_Double_Screen_Strong_Daily,Bullish_Double_Screen_Strong_4_Hourly,Bullish_Double_Screen_Strong_1_Hourly,Bullish_Double_Screen_Strong_15_Minutes,Bullish_Double_Screen_Strong_Correction_Yearly,Bullish_Double_Screen_Strong_Correction_Quarterly,Bullish_Double_Screen_Strong_Correction_Monthly,Bullish_Double_Screen_Strong_Correction_Weekly,Bullish_Double_Screen_Strong_Correction_Daily,Bullish_Double_Screen_Strong_Correction_4_Hourly,Bullish_Double_Screen_Strong_Correction_1_Hourly,Bullish_Double_Screen_Strong_Correction_15_Minutes,Bullish_Single_Screen_Strong_Yearly,Bullish_Single_Screen_Strong_Quarterly,Bullish_Single_Screen_Strong_Monthly,Bullish_Single_Screen_Strong_Weekly,Bullish_Single_Screen_Strong_Daily,Bullish_Single_Screen_Strong_4_Hourly,Bullish_Single_Screen_Strong_1_Hourly,Bullish_Single_Screen_Strong_15_Minutes,Bullish_Single_Screen_Strong_Correction_Yearly,Bullish_Single_Screen_Strong_Correction_Quarterly,Bullish_Single_Screen_Strong_Correction_Monthly,Bullish_Single_Screen_Strong_Correction_Weekly,Bullish_Single_Screen_Strong_Correction_Daily,Bullish_Single_Screen_Strong_Correction_4_Hourly,Bullish_Single_Screen_Strong_Correction_1_Hourly,Bullish_Single_Screen_Strong_Correction_15_Minutes,Bullish_Triple_Screen_Momentum_Yearly,Bullish_Triple_Screen_Momentum_Quarterly,Bullish_Triple_Screen_Momentum_Monthly,Bullish_Triple_Screen_Momentum_Weekly,Bullish_Triple_Screen_Momentum_Daily,Bullish_Triple_Screen_Momentum_4_Hourly,Bullish_Triple_Screen_Momentum_1_Hourly,Bullish_Triple_Screen_Momentum_15_Minutes,Bullish_Triple_Screen_Momentum_Correction_Yearly,Bullish_Triple_Screen_Momentum_Correction_Quarterly,Bullish_Triple_Screen_Momentum_Correction_Monthly,Bullish_Triple_Screen_Momentum_Correction_Weekly,Bullish_Triple_Screen_Momentum_Correction_Daily,Bullish_Triple_Screen_Momentum_Correction_4_Hourly,Bullish_Triple_Screen_Momentum_Correction_1_Hourly,Bullish_Triple_Screen_Momentum_Correction_15_Minutes,Bullish_Double_Screen_Momentum_Yearly,Bullish_Double_Screen_Momentum_Quarterly,Bullish_Double_Screen_Momentum_Monthly,Bullish_Double_Screen_Momentum_Weekly,Bullish_Double_Screen_Momentum_Daily,Bullish_Double_Screen_Momentum_4_Hourly,Bullish_Double_Screen_Momentum_1_Hourly,Bullish_Double_Screen_Momentum_15_Minutes,Bullish_Double_Screen_Momentum_Correction_Yearly,Bullish_Double_Screen_Momentum_Correction_Quarterly,Bullish_Double_Screen_Momentum_Correction_Monthly,Bullish_Double_Screen_Momentum_Correction_Weekly,Bullish_Double_Screen_Momentum_Correction_Daily,Bullish_Double_Screen_Momentum_Correction_4_Hourly,Bullish_Double_Screen_Momentum_Correction_1_Hourly,Bullish_Double_Screen_Momentum_Correction_15_Minutes,Bullish_Single_Screen_Momentum_Yearly,Bullish_Single_Screen_Momentum_Quarterly,Bullish_Single_Screen_Momentum_Monthly,Bullish_Single_Screen_Momentum_Weekly,Bullish_Single_Screen_Momentum_Daily,Bullish_Single_Screen_Momentum_4_Hourly,Bullish_Single_Screen_Momentum_1_Hourly,Bullish_Single_Screen_Momentum_15_Minutes,Bullish_Single_Screen_Momentum_Correction_Yearly,Bullish_Single_Screen_Momentum_Correction_Quarterly,Bullish_Single_Screen_Momentum_Correction_Monthly,Bullish_Single_Screen_Momentum_Correction_Weekly,Bullish_Single_Screen_Momentum_Correction_Daily,Bullish_Single_Screen_Momentum_Correction_4_Hourly,Bullish_Single_Screen_Momentum_Correction_1_Hourly,Bullish_Single_Screen_Momentum_Correction_15_Minutes,Bullish_Triple_Screen_Swing_Yearly,Bullish_Triple_Screen_Swing_Quarterly,Bullish_Triple_Screen_Swing_Monthly,Bullish_Triple_Screen_Swing_Weekly,Bullish_Triple_Screen_Swing_Daily,Bullish_Triple_Screen_Swing_4_Hourly,Bullish_Triple_Screen_Swing_1_Hourly,Bullish_Triple_Screen_Swing_15_Minutes,Bullish_Triple_Screen_Swing_Correction_Yearly,Bullish_Triple_Screen_Swing_Correction_Quarterly,Bullish_Triple_Screen_Swing_Correction_Monthly,Bullish_Triple_Screen_Swing_Correction_Weekly,Bullish_Triple_Screen_Swing_Correction_Daily,Bullish_Triple_Screen_Swing_Correction_4_Hourly,Bullish_Triple_Screen_Swing_Correction_1_Hourly,Bullish_Triple_Screen_Swing_Correction_15_Minutes,Bullish_Double_Screen_Swing_Yearly,Bullish_Double_Screen_Swing_Quarterly,Bullish_Double_Screen_Swing_Monthly,Bullish_Double_Screen_Swing_Weekly,Bullish_Double_Screen_Swing_Daily,Bullish_Double_Screen_Swing_4_Hourly,Bullish_Double_Screen_Swing_1_Hourly,Bullish_Double_Screen_Swing_15_Minutes,Bullish_Double_Screen_Swing_Correction_Yearly,Bullish_Double_Screen_Swing_Correction_Quarterly,Bullish_Double_Screen_Swing_Correction_Monthly,Bullish_Double_Screen_Swing_Correction_Weekly,Bullish_Double_Screen_Swing_Correction_Daily,Bullish_Double_Screen_Swing_Correction_4_Hourly,Bullish_Double_Screen_Swing_Correction_1_Hourly,Bullish_Double_Screen_Swing_Correction_15_Minutes,Bullish_Single_Screen_Swing_Yearly,Bullish_Single_Screen_Swing_Quarterly,Bullish_Single_Screen_Swing_Monthly,Bullish_Single_Screen_Swing_Weekly,Bullish_Single_Screen_Swing_Daily,Bullish_Single_Screen_Swing_4_Hourly,Bullish_Single_Screen_Swing_1_Hourly,Bullish_Single_Screen_Swing_15_Minutes,Bullish_Single_Screen_Swing_Correction_Yearly,Bullish_Single_Screen_Swing_Correction_Quarterly,Bullish_Single_Screen_Swing_Correction_Monthly,Bullish_Single_Screen_Swing_Correction_Weekly,Bullish_Single_Screen_Swing_Correction_Daily,Bullish_Single_Screen_Swing_Correction_4_Hourly,Bullish_Single_Screen_Swing_Correction_1_Hourly,Bullish_Single_Screen_Swing_Correction_15_Minutes,Bearish_Triple_Screen_Strong_Yearly,Bearish_Triple_Screen_Strong_Quarterly,Bearish_Triple_Screen_Strong_Monthly,Bearish_Triple_Screen_Strong_Weekly,Bearish_Triple_Screen_Strong_Daily,Bearish_Triple_Screen_Strong_4_Hourly,Bearish_Triple_Screen_Strong_1_Hourly,Bearish_Triple_Screen_Strong_15_Minutes,Bearish_Triple_Screen_Strong_Correction_Yearly,Bearish_Triple_Screen_Strong_Correction_Quarterly,Bearish_Triple_Screen_Strong_Correction_Monthly,Bearish_Triple_Screen_Strong_Correction_Weekly,Bearish_Triple_Screen_Strong_Correction_Daily,Bearish_Triple_Screen_Strong_Correction_4_Hourly,Bearish_Triple_Screen_Strong_Correction_1_Hourly,Bearish_Triple_Screen_Strong_Correction_15_Minutes,Bearish_Double_Screen_Strong_Yearly,Bearish_Double_Screen_Strong_Quarterly,Bearish_Double_Screen_Strong_Monthly,Bearish_Double_Screen_Strong_Weekly,Bearish_Double_Screen_Strong_Daily,Bearish_Double_Screen_Strong_4_Hourly,Bearish_Double_Screen_Strong_1_Hourly,Bearish_Double_Screen_Strong_15_Minutes,Bearish_Double_Screen_Strong_Correction_Yearly,Bearish_Double_Screen_Strong_Correction_Quarterly,Bearish_Double_Screen_Strong_Correction_Monthly,Bearish_Double_Screen_Strong_Correction_Weekly,Bearish_Double_Screen_Strong_Correction_Daily,Bearish_Double_Screen_Strong_Correction_4_Hourly,Bearish_Double_Screen_Strong_Correction_1_Hourly,Bearish_Double_Screen_Strong_Correction_15_Minutes,Bearish_Single_Screen_Strong_Yearly,Bearish_Single_Screen_Strong_Quarterly,Bearish_Single_Screen_Strong_Monthly,Bearish_Single_Screen_Strong_Weekly,Bearish_Single_Screen_Strong_Daily,Bearish_Single_Screen_Strong_4_Hourly,Bearish_Single_Screen_Strong_1_Hourly,Bearish_Single_Screen_Strong_15_Minutes,Bearish_Single_Screen_Strong_Correction_yearly,Bearish_Single_Screen_Strong_Correction_Quarterly,Bearish_Single_Screen_Strong_Correction_Monthly,Bearish_Single_Screen_Strong_Correction_Weekly,Bearish_Single_Screen_Strong_Correction_Daily,Bearish_Single_Screen_Strong_Correction_4_Hourly,Bearish_Single_Screen_Strong_Correction_1_Hourly,Bearish_Single_Screen_Strong_Correction_15_Minutes,Bearish_Triple_Screen_Momentum_Yearly,Bearish_Triple_Screen_Momentum_Quarterly,Bearish_Triple_Screen_Momentum_Monthly,Bearish_Triple_Screen_Momentum_Weekly,Bearish_Triple_Screen_Momentum_Daily,Bearish_Triple_Screen_Momentum_4_Hourly,Bearish_Triple_Screen_Momentum_1_Hourly,Bearish_Triple_Screen_Momentum_15_Minutes,Bearish_Triple_Screen_Momentum_Correction_Yearly,Bearish_Triple_Screen_Momentum_Correction_Quarterly,Bearish_Triple_Screen_Momentum_Correction_Monthly,Bearish_Triple_Screen_Momentum_Correction_Weekly,Bearish_Triple_Screen_Momentum_Correction_Daily,Bearish_Triple_Screen_Momentum_Correction_4_Hourly,Bearish_Triple_Screen_Momentum_Correction_1_Hourly,Bearish_Triple_Screen_Momentum_Correction_15_Minutes,Bearish_Double_Screen_Momentum_Yearly,Bearish_Double_Screen_Momentum_Quarterly,Bearish_Double_Screen_Momentum_Monthly,Bearish_Double_Screen_Momentum_Weekly,Bearish_Double_Screen_Momentum_Daily,Bearish_Double_Screen_Momentum_4_Hourly,Bearish_Double_Screen_Momentum_1_Hourly,Bearish_Double_Screen_Momentum_15_Minutes,Bearish_Double_Screen_Momentum_Correction_Yearly,Bearish_Double_Screen_Momentum_Correction_Quarterly,Bearish_Double_Screen_Momentum_Correction_Monthly,Bearish_Double_Screen_Momentum_Correction_Weekly,Bearish_Double_Screen_Momentum_Correction_Daily,Bearish_Double_Screen_Momentum_Correction_4_Hourly,Bearish_Double_Screen_Momentum_Correction_1_Hourly,Bearish_Double_Screen_Momentum_Correction_15_Minutes,Bearish_Single_Screen_Momentum_Yearly,Bearish_Single_Screen_Momentum_Quarterly,Bearish_Single_Screen_Momentum_Monthly,Bearish_Single_Screen_Momentum_Weekly,Bearish_Single_Screen_Momentum_Daily,Bearish_Single_Screen_Momentum_4_Hourly,Bearish_Single_Screen_Momentum_1_Hourly,Bearish_Single_Screen_Momentum_15_Minutes,Bearish_Single_Screen_Momentum_Correction_Yearly,Bearish_Single_Screen_Momentum_Correction_Quarterly,Bearish_Single_Screen_Momentum_Correction_Monthly,Bearish_Single_Screen_Momentum_Correction_Weekly,Bearish_Single_Screen_Momentum_Correction_Daily,Bearish_Single_Screen_Momentum_Correction_4_Hourly,Bearish_Single_Screen_Momentum_Correction_1_Hourly,Bearish_Single_Screen_Momentum_Correction_15_Minutes,Bearish_Triple_Screen_Swing_Yearly,Bearish_Triple_Screen_Swing_Quarterly,Bearish_Triple_Screen_Swing_Monthly,Bearish_Triple_Screen_Swing_Weekly,Bearish_Triple_Screen_Swing_Daily,Bearish_Triple_Screen_Swing_4_Hourly,Bearish_Triple_Screen_Swing_1_Hourly,Bearish_Triple_Screen_Swing_15_Minutes,Bearish_Triple_Screen_Swing_Correction_Yearly,Bearish_Triple_Screen_Swing_Correction_Quarterly,Bearish_Triple_Screen_Swing_Correction_Monthly,Bearish_Triple_Screen_Swing_Correction_Weekly,Bearish_Triple_Screen_Swing_Correction_Daily,Bearish_Triple_Screen_Swing_Correction_4_Hourly,Bearish_Triple_Screen_Swing_Correction_1_Hourly,Bearish_Triple_Screen_Swing_Correction_15_Minutes,Bearish_Double_Screen_Swing_Yearly,Bearish_Double_Screen_Swing_Quarterly,Bearish_Double_Screen_Swing_Monthly,Bearish_Double_Screen_Swing_Weekly,Bearish_Double_Screen_Swing_Daily,Bearish_Double_Screen_Swing_4_Hourly,Bearish_Double_Screen_Swing_1_Hourly,Bearish_Double_Screen_Swing_15_Minutes,Bearish_Double_Screen_Swing_Correction_Yearly,Bearish_Double_Screen_Swing_Correction_Quarterly,Bearish_Double_Screen_Swing_Correction_Monthly,Bearish_Double_Screen_Swing_Correction_Weekly,Bearish_Double_Screen_Swing_Correction_Daily,Bearish_Double_Screen_Swing_Correction_4_Hourly,Bearish_Double_Screen_Swing_Correction_1_Hourly,Bearish_Double_Screen_Swing_Correction_15_Minutes,Bearish_Single_Screen_Swing_Yearly,Bearish_Single_Screen_Swing_Quarterly,Bearish_Single_Screen_Swing_Monthly,Bearish_Single_Screen_Swing_Weekly,Bearish_Single_Screen_Swing_Daily,Bearish_Single_Screen_Swing_4_Hourly,Bearish_Single_Screen_Swing_1_Hourly,Bearish_Single_Screen_Swing_15_Minutes,Bearish_Single_Screen_Swing_Correction_Yearly,Bearish_Single_Screen_Swing_Correction_Quarterly,Bearish_Single_Screen_Swing_Correction_Monthly,Bearish_Single_Screen_Swing_Correction_Weekly,Bearish_Single_Screen_Swing_Correction_Daily,Bearish_Single_Screen_Swing_Correction_4_Hourly,Bearish_Single_Screen_Swing_Correction_1_Hourly,Bearish_Single_Screen_Swing_Correction_15_Minutes,Macd_Yearly_Crosses_Above,Macd_Quarterly_Crosses_Above,Macd_Monthly_Crosses_Above,Macd_Weekly_Crosses_Above,Macd_Daily_Crosses_Above,Macd_4_Hourly_Crosses_Above,Macd_1_Hourly_Crosses_Above,Macd_15_Minutes_Crosses_Above,Macd_Yearly_Crosses_Below,Macd_Quarterly_Crosses_Below,Macd_Monthly_Crosses_Below,Macd_Weekly_Crosses_Below,Macd_Daily_Crosses_Below,Macd_4_Hourly_Crosses_Below,Macd_1_Hourly_Crosses_Below,Macd_15_Minutes_Crosses_Below,Rsi_Yearly_Crosses_Above,Rsi_Quarterly_Crosses_Above,Rsi_Monthly_Crosses_Above,Rsi_Weekly_Crosses_Above,Rsi_Daily_Crosses_Above,Rsi_4_Hourly_Crosses_Above,Rsi_1_Hourly_Crosses_Above,Rsi_15_Minutes_Crosses_Above,Rsi_Yearly_Crosses_Below,Rsi_Quarterly_Crosses_Below,Rsi_Monthly_Crosses_Below,Rsi_Weekly_Crosses_Below,Rsi_Daily_Crosses_Below,Rsi_4_Hourly_Crosses_Below,Rsi_1_Hourly_Crosses_Below,Rsi_15_Minutes_Crosses_Below,Stochastic_Yearly_Crosses_Above,Stochastic_Quarterly_Crosses_Above,Stochastic_Monthly_Crosses_Above,Stochastic_Weekly_Crosses_Above,Stochastic_Daily_Crosses_Above,Stochastic_4_Hourly_Crosses_Above,Stochastic_1_Hourly_Crosses_Above,Stochastic_15_Minutes_Crosses_Above,Stochastic_Yearly_Crosses_Below,Stochastic_Quarterly_Crosses_Below,Stochastic_Monthly_Crosses_Below,Stochastic_Weekly_Crosses_Below,Stochastic_Daily_Crosses_Below,Stochastic_4_Hourly_Crosses_Below,Stochastic_1_Hourly_Crosses_Below,Stochastic_15_Minutes_Crosses_Below,Ema_5_13_Yearly_Crosses_Above,Ema_5_13_Quarterly_Crosses_Above,Ema_5_13_Monthly_Crosses_Above,Ema_5_13_Weekly_Crosses_Above,Ema_5_13_Daily_Crosses_Above,Ema_5_13_4_Hourly_Crosses_Above,Ema_5_13_1_Hourly_Crosses_Above,Ema_5_13_15_Minutes_Crosses_Above,Ema_5_13_Yearly_Crosses_Below,Ema_5_13_Quarterly_Crosses_Below,Ema_5_13_Monthly_Crosses_Below,Ema_5_13_Weekly_Crosses_Below,Ema_5_13_Daily_Crosses_Below,Ema_5_13_4_Hourly_Crosses_Below,Ema_5_13_1_Hourly_Crosses_Below,Ema_5_13_15_Minutes_Crosses_Below,Ema_13_26_Yearly_Crosses_Above,Ema_13_26_Quarterly_Crosses_Above,Ema_13_26_Monthly_Crosses_Above,Ema_13_26_Weekly_Crosses_Above,Ema_13_26_Daily_Crosses_Above,Ema_13_26_4_Hourly_Crosses_Above,Ema_13_26_1_Hourly_Crosses_Above,Ema_13_26_15_Minutes_Crosses_Above,Ema_13_26_Yearly_Crosses_Below,Ema_13_26_Quarterly_Crosses_Below,Ema_13_26_Monthly_Crosses_Below,Ema_13_26_Weekly_Crosses_Below,Ema_13_26_Daily_Crosses_Below,Ema_13_26_4_Hourly_Crosses_Below,Ema_13_26_1_Hourly_Crosses_Below,Ema_13_26_15_Minutes_Crosses_Below,Ema_50_100_Yearly_Crosses_Above,Ema_50_100_Quarterly_Crosses_Above,Ema_50_100_Monthly_Crosses_Above,Ema_50_100_Weekly_Crosses_Above,Ema_50_100_Daily_Crosses_Above,Ema_50_100_4_Hourly_Crosses_Above,Ema_50_100_1_Hourly_Crosses_Above,Ema_50_100_15_Minutes_Crosses_Above,Ema_50_100_Yearly_Crosses_Below,Ema_50_100_Quarterly_Crosses_Below,Ema_50_100_Monthly_Crosses_Below,Ema_50_100_Weekly_Crosses_Below,Ema_50_100_Daily_Crosses_Below,Ema_50_100_4_Hourly_Crosses_Below,Ema_50_100_1_Hourly_Crosses_Below,Ema_50_100_15_Minutes_Crosses_Below,Ema_50_200_Yearly_Crosses_Above,Ema_50_200_Quarterly_Crosses_Above,Ema_50_200_Monthly_Crosses_Above,Ema_50_200_Weekly_Crosses_Above,Ema_50_200_Daily_Crosses_Above,Ema_50_200_4_Hourly_Crosses_Above,Ema_50_200_1_Hourly_Crosses_Above,Ema_50_200_15_Minutes_Crosses_Above,Ema_50_200_Yearly_Crosses_Below,Ema_50_200_Quarterly_Crosses_Below,Ema_50_200_Monthly_Crosses_Below,Ema_50_200_Weekly_Crosses_Below,Ema_50_200_Daily_Crosses_Below,Ema_50_200_4_Hourly_Crosses_Below,Ema_50_200_1_Hourly_Crosses_Below,Ema_50_200_15_Minutes_Crosses_Below,Ema_100_200_Yearly_Crosses_Above,Ema_100_200_Quarterly_Crosses_Above,Ema_100_200_Monthly_Crosses_Above,Ema_100_200_Weekly_Crosses_Above,Ema_100_200_Daily_Crosses_Above,Ema_100_200_4_Hourly_Crosses_Above,Ema_100_200_1_Hourly_Crosses_Above,Ema_100_200_15_Minutes_Crosses_Above,Ema_100_200_Yearly_Crosses_Below,Ema_100_200_Quarterly_Crosses_Below,Ema_100_200_Monthly_Crosses_Below,Ema_100_200_Weekly_Crosses_Below,Ema_100_200_Daily_Crosses_Below,Ema_100_200_4_Hourly_Crosses_Below,Ema_100_200_1_Hourly_Crosses_Below,Ema_100_200_15_Minutes_Crosses_Below,Upper_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band3_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band3_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band3_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band3_Daily_Less_Than_Equal_To,Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band3_Daily_Less_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band3_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Upper_Bollinger_Band2_Yearly_Less_Than_Equal_To,Upper_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Upper_Bollinger_Band2_Monthly_Less_Than_Equal_To,Upper_Bollinger_Band2_Weekly_Less_Than_Equal_To,Upper_Bollinger_Band2_Daily_Less_Than_Equal_To,Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Less_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Less_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Less_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Less_Than_Equal_To,Lower_Bollinger_Band2_Daily_Less_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,Lower_Bollinger_Band2_Yearly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Quarterly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Monthly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Weekly_Greater_Than_Equal_To,Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To,Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,Adx_Yearly_Crosses_Above,Adx_Quarterly_Crosses_Above,Adx_Monthly_Crosses_Above,Adx_Weekly_Crosses_Above,Adx_Daily_Crosses_Above,Adx_4_Hourly_Crosses_Above,Adx_1_Hourly_Crosses_Above,Adx_15_Minutes_Crosses_Above,Adx_Yearly_Crosses_Below,Adx_Quarterly_Crosses_Below,Adx_Monthly_Crosses_Below,Adx_Weekly_Crosses_Below,Adx_Daily_Crosses_Below,Adx_4_Hourly_Crosses_Below,Adx_1_Hourly_Crosses_Below,Adx_15_Minutes_Crosses_Below,Adx_Up_Tick_Yearly_Greater_Than_Equal_To,Adx_Up_Tick_Quarterly_Greater_Than_Equal_To,Adx_Up_Tick_Monthly_Greater_Than_Equal_To,Adx_Up_Tick_Weekly_Greater_Than_Equal_To,Adx_Up_Tick_Daily_Greater_Than_Equal_To,Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To,Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To,Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To,Adx_Down_Tick_Yearly_Less_Than_Equal_To,Adx_Down_Tick_Quarterly_Less_Than_Equal_To,Adx_Down_Tick_Monthly_Less_Than_Equal_To,Adx_Down_Tick_Weekly_Less_Than_Equal_To,Adx_Down_Tick_Daily_Less_Than_Equal_To,Adx_Down_Tick_4_Hourly_Less_Than_Equal_To,Adx_Down_Tick_1_Hourly_Less_Than_Equal_To,Adx_Down_Tick_15_Minutes_Less_Than_Equal_To,Volume_Yearly_Greater_Than_Equal_To,Volume_Quarterly_Greater_Than_Equal_To,Volume_Monthly_Greater_Than_Equal_To,Volume_Weekly_Greater_Than_Equal_To,Volume_Daily_Greater_Than_Equal_To,Volume_4_Hourly_Greater_Than_Equal_To,Volume_1_Hourly_Greater_Than_Equal_To,Volume_15_Minutes_Greater_Than_Equal_To,Volume_Yearly_Less_Than_Equal_To,Volume_Quarterly_Less_Than_Equal_To,Volume_Monthly_Less_Than_Equal_To,Volume_Weekly_Less_Than_Equal_To,Volume_Daily_Less_Than_Equal_To,Volume_4_Hourly_Less_Than_Equal_To,Volume_1_Hourly_Less_Than_Equal_To,Volume_15_Minutes_Less_Than_Equal_To,volume_yearly_shockers,volume_quarterly_shockers,volume_monthly_shockers,volume_weekly_shockers,volume_daily_shockers,volume_4_hourly_shockers,volume_1_hourly_shockers,volume_15_minutes_shockers
into Analyse_15Minutes_Stocks1 
from Analyse_15Minutes_Stocks
end

begin

;WITH ValueSource AS 
(   SELECT Batch_No, Screen_Names, Value
	FROM dbo.Master_Screen_Name_Values WHERE Batch_No = 4 -- @batch_num
)
,ValuePivot AS 
(   SELECT * FROM ValueSource
	PIVOT (SUM(Value) FOR Screen_Names IN ([Bullish_Triple_Screen_Strong_Yearly],[Bullish_Triple_Screen_Strong_Quarterly],[Bullish_Triple_Screen_Strong_Monthly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bullish_Triple_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_15_Minutes],[Bullish_Triple_Screen_Strong_Correction_Yearly],[Bullish_Triple_Screen_Strong_Correction_Quarterly],[Bullish_Triple_Screen_Strong_Correction_Monthly],[Bullish_Triple_Screen_Strong_Correction_Weekly],[Bullish_Triple_Screen_Strong_Correction_Daily],[Bullish_Triple_Screen_Strong_Correction_4_Hourly],[Bullish_Triple_Screen_Strong_Correction_1_Hourly],[Bullish_Triple_Screen_Strong_Correction_15_Minutes],[Bullish_Double_Screen_Strong_Yearly],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Double_Screen_Strong_15_Minutes],[Bullish_Double_Screen_Strong_Correction_Yearly],[Bullish_Double_Screen_Strong_Correction_Quarterly],[Bullish_Double_Screen_Strong_Correction_Monthly],[Bullish_Double_Screen_Strong_Correction_Weekly],[Bullish_Double_Screen_Strong_Correction_Daily],[Bullish_Double_Screen_Strong_Correction_4_Hourly],[Bullish_Double_Screen_Strong_Correction_1_Hourly],[Bullish_Double_Screen_Strong_Correction_15_Minutes],[Bullish_Single_Screen_Strong_Yearly],[Bullish_Single_Screen_Strong_Quarterly],[Bullish_Single_Screen_Strong_Monthly],[Bullish_Single_Screen_Strong_Weekly],[Bullish_Single_Screen_Strong_Daily],[Bullish_Single_Screen_Strong_4_Hourly],[Bullish_Single_Screen_Strong_1_Hourly],[Bullish_Single_Screen_Strong_15_Minutes],[Bullish_Single_Screen_Strong_Correction_Yearly],[Bullish_Single_Screen_Strong_Correction_Quarterly],[Bullish_Single_Screen_Strong_Correction_Monthly],[Bullish_Single_Screen_Strong_Correction_Weekly],[Bullish_Single_Screen_Strong_Correction_Daily],[Bullish_Single_Screen_Strong_Correction_4_Hourly],[Bullish_Single_Screen_Strong_Correction_1_Hourly],[Bullish_Single_Screen_Strong_Correction_15_Minutes],[Bullish_Triple_Screen_Momentum_Yearly],[Bullish_Triple_Screen_Momentum_Quarterly],[Bullish_Triple_Screen_Momentum_Monthly],[Bullish_Triple_Screen_Momentum_Weekly],[Bullish_Triple_Screen_Momentum_Daily],[Bullish_Triple_Screen_Momentum_4_Hourly],[Bullish_Triple_Screen_Momentum_1_Hourly],[Bullish_Triple_Screen_Momentum_15_Minutes],[Bullish_Triple_Screen_Momentum_Correction_Yearly],[Bullish_Triple_Screen_Momentum_Correction_Quarterly],[Bullish_Triple_Screen_Momentum_Correction_Monthly],[Bullish_Triple_Screen_Momentum_Correction_Weekly],[Bullish_Triple_Screen_Momentum_Correction_Daily],[Bullish_Triple_Screen_Momentum_Correction_4_Hourly],[Bullish_Triple_Screen_Momentum_Correction_1_Hourly],[Bullish_Triple_Screen_Momentum_Correction_15_Minutes],[Bullish_Double_Screen_Momentum_Yearly],[Bullish_Double_Screen_Momentum_Quarterly],[Bullish_Double_Screen_Momentum_Monthly],[Bullish_Double_Screen_Momentum_Weekly],[Bullish_Double_Screen_Momentum_Daily],[Bullish_Double_Screen_Momentum_4_Hourly],[Bullish_Double_Screen_Momentum_1_Hourly],[Bullish_Double_Screen_Momentum_15_Minutes],[Bullish_Double_Screen_Momentum_Correction_Yearly],[Bullish_Double_Screen_Momentum_Correction_Quarterly],[Bullish_Double_Screen_Momentum_Correction_Monthly],[Bullish_Double_Screen_Momentum_Correction_Weekly],[Bullish_Double_Screen_Momentum_Correction_Daily],[Bullish_Double_Screen_Momentum_Correction_4_Hourly],[Bullish_Double_Screen_Momentum_Correction_1_Hourly],[Bullish_Double_Screen_Momentum_Correction_15_Minutes],[Bullish_Single_Screen_Momentum_Yearly],[Bullish_Single_Screen_Momentum_Quarterly],[Bullish_Single_Screen_Momentum_Monthly],[Bullish_Single_Screen_Momentum_Weekly],[Bullish_Single_Screen_Momentum_Daily],[Bullish_Single_Screen_Momentum_4_Hourly],[Bullish_Single_Screen_Momentum_1_Hourly],[Bullish_Single_Screen_Momentum_15_Minutes],[Bullish_Single_Screen_Momentum_Correction_Yearly],[Bullish_Single_Screen_Momentum_Correction_Quarterly],[Bullish_Single_Screen_Momentum_Correction_Monthly],[Bullish_Single_Screen_Momentum_Correction_Weekly],[Bullish_Single_Screen_Momentum_Correction_Daily],[Bullish_Single_Screen_Momentum_Correction_4_Hourly],[Bullish_Single_Screen_Momentum_Correction_1_Hourly],[Bullish_Single_Screen_Momentum_Correction_15_Minutes],[Bullish_Triple_Screen_Swing_Yearly],[Bullish_Triple_Screen_Swing_Quarterly],[Bullish_Triple_Screen_Swing_Monthly],[Bullish_Triple_Screen_Swing_Weekly],[Bullish_Triple_Screen_Swing_Daily],[Bullish_Triple_Screen_Swing_4_Hourly],[Bullish_Triple_Screen_Swing_1_Hourly],[Bullish_Triple_Screen_Swing_15_Minutes],[Bullish_Triple_Screen_Swing_Correction_Yearly],[Bullish_Triple_Screen_Swing_Correction_Quarterly],[Bullish_Triple_Screen_Swing_Correction_Monthly],[Bullish_Triple_Screen_Swing_Correction_Weekly],[Bullish_Triple_Screen_Swing_Correction_Daily],[Bullish_Triple_Screen_Swing_Correction_4_Hourly],[Bullish_Triple_Screen_Swing_Correction_1_Hourly],[Bullish_Triple_Screen_Swing_Correction_15_Minutes],[Bullish_Double_Screen_Swing_Yearly],[Bullish_Double_Screen_Swing_Quarterly],[Bullish_Double_Screen_Swing_Monthly],[Bullish_Double_Screen_Swing_Weekly],[Bullish_Double_Screen_Swing_Daily],[Bullish_Double_Screen_Swing_4_Hourly],[Bullish_Double_Screen_Swing_1_Hourly],[Bullish_Double_Screen_Swing_15_Minutes],[Bullish_Double_Screen_Swing_Correction_Yearly],[Bullish_Double_Screen_Swing_Correction_Quarterly],[Bullish_Double_Screen_Swing_Correction_Monthly],[Bullish_Double_Screen_Swing_Correction_Weekly],[Bullish_Double_Screen_Swing_Correction_Daily],[Bullish_Double_Screen_Swing_Correction_4_Hourly],[Bullish_Double_Screen_Swing_Correction_1_Hourly],[Bullish_Double_Screen_Swing_Correction_15_Minutes],[Bullish_Single_Screen_Swing_Yearly],[Bullish_Single_Screen_Swing_Quarterly],[Bullish_Single_Screen_Swing_Monthly],[Bullish_Single_Screen_Swing_Weekly],[Bullish_Single_Screen_Swing_Daily],[Bullish_Single_Screen_Swing_4_Hourly],[Bullish_Single_Screen_Swing_1_Hourly],[Bullish_Single_Screen_Swing_15_Minutes],[Bullish_Single_Screen_Swing_Correction_Yearly],[Bullish_Single_Screen_Swing_Correction_Quarterly],[Bullish_Single_Screen_Swing_Correction_Monthly],[Bullish_Single_Screen_Swing_Correction_Weekly],[Bullish_Single_Screen_Swing_Correction_Daily],[Bullish_Single_Screen_Swing_Correction_4_Hourly],[Bullish_Single_Screen_Swing_Correction_1_Hourly],[Bullish_Single_Screen_Swing_Correction_15_Minutes],[Bearish_Triple_Screen_Strong_Yearly],[Bearish_Triple_Screen_Strong_Quarterly],[Bearish_Triple_Screen_Strong_Monthly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly],[Bearish_Triple_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_15_Minutes],[Bearish_Triple_Screen_Strong_Correction_Yearly],[Bearish_Triple_Screen_Strong_Correction_Quarterly],[Bearish_Triple_Screen_Strong_Correction_Monthly],[Bearish_Triple_Screen_Strong_Correction_Weekly],[Bearish_Triple_Screen_Strong_Correction_Daily],[Bearish_Triple_Screen_Strong_Correction_4_Hourly],[Bearish_Triple_Screen_Strong_Correction_1_Hourly],[Bearish_Triple_Screen_Strong_Correction_15_Minutes],[Bearish_Double_Screen_Strong_Yearly],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Double_Screen_Strong_15_Minutes],[Bearish_Double_Screen_Strong_Correction_Yearly],[Bearish_Double_Screen_Strong_Correction_Quarterly],[Bearish_Double_Screen_Strong_Correction_Monthly],[Bearish_Double_Screen_Strong_Correction_Weekly],[Bearish_Double_Screen_Strong_Correction_Daily],[Bearish_Double_Screen_Strong_Correction_4_Hourly],[Bearish_Double_Screen_Strong_Correction_1_Hourly],[Bearish_Double_Screen_Strong_Correction_15_Minutes],[Bearish_Single_Screen_Strong_Yearly],[Bearish_Single_Screen_Strong_Quarterly],[Bearish_Single_Screen_Strong_Monthly],[Bearish_Single_Screen_Strong_Weekly],[Bearish_Single_Screen_Strong_Daily],[Bearish_Single_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Strong_1_Hourly],[Bearish_Single_Screen_Strong_15_Minutes],[Bearish_Single_Screen_Strong_Correction_Yearly],[Bearish_Single_Screen_Strong_Correction_Quarterly],[Bearish_Single_Screen_Strong_Correction_Monthly],[Bearish_Single_Screen_Strong_Correction_Weekly],[Bearish_Single_Screen_Strong_Correction_Daily],[Bearish_Single_Screen_Strong_Correction_4_Hourly],[Bearish_Single_Screen_Strong_Correction_1_Hourly],[Bearish_Single_Screen_Strong_Correction_15_Minutes],[Bearish_Triple_Screen_Momentum_Yearly],[Bearish_Triple_Screen_Momentum_Quarterly],[Bearish_Triple_Screen_Momentum_Monthly],[Bearish_Triple_Screen_Momentum_Weekly],[Bearish_Triple_Screen_Momentum_Daily],[Bearish_Triple_Screen_Momentum_4_Hourly],[Bearish_Triple_Screen_Momentum_1_Hourly],[Bearish_Triple_Screen_Momentum_15_Minutes],[Bearish_Triple_Screen_Momentum_Correction_Yearly],[Bearish_Triple_Screen_Momentum_Correction_Quarterly],[Bearish_Triple_Screen_Momentum_Correction_Monthly],[Bearish_Triple_Screen_Momentum_Correction_Weekly],[Bearish_Triple_Screen_Momentum_Correction_Daily],[Bearish_Triple_Screen_Momentum_Correction_4_Hourly],[Bearish_Triple_Screen_Momentum_Correction_1_Hourly],[Bearish_Triple_Screen_Momentum_Correction_15_Minutes],[Bearish_Double_Screen_Momentum_Yearly],[Bearish_Double_Screen_Momentum_Quarterly],[Bearish_Double_Screen_Momentum_Monthly],[Bearish_Double_Screen_Momentum_Weekly],[Bearish_Double_Screen_Momentum_Daily],[Bearish_Double_Screen_Momentum_4_Hourly],[Bearish_Double_Screen_Momentum_1_Hourly],[Bearish_Double_Screen_Momentum_15_Minutes],[Bearish_Double_Screen_Momentum_Correction_Yearly],[Bearish_Double_Screen_Momentum_Correction_Quarterly],[Bearish_Double_Screen_Momentum_Correction_Monthly],[Bearish_Double_Screen_Momentum_Correction_Weekly],[Bearish_Double_Screen_Momentum_Correction_Daily],[Bearish_Double_Screen_Momentum_Correction_4_Hourly],[Bearish_Double_Screen_Momentum_Correction_1_Hourly],[Bearish_Double_Screen_Momentum_Correction_15_Minutes],[Bearish_Single_Screen_Momentum_Yearly],[Bearish_Single_Screen_Momentum_Quarterly],[Bearish_Single_Screen_Momentum_Monthly],[Bearish_Single_Screen_Momentum_Weekly],[Bearish_Single_Screen_Momentum_Daily],[Bearish_Single_Screen_Momentum_4_Hourly],[Bearish_Single_Screen_Momentum_1_Hourly],[Bearish_Single_Screen_Momentum_15_Minutes],[Bearish_Single_Screen_Momentum_Correction_Yearly],[Bearish_Single_Screen_Momentum_Correction_Quarterly],[Bearish_Single_Screen_Momentum_Correction_Monthly],[Bearish_Single_Screen_Momentum_Correction_Weekly],[Bearish_Single_Screen_Momentum_Correction_Daily],[Bearish_Single_Screen_Momentum_Correction_4_Hourly],[Bearish_Single_Screen_Momentum_Correction_1_Hourly],[Bearish_Single_Screen_Momentum_Correction_15_Minutes],[Bearish_Triple_Screen_Swing_Yearly],[Bearish_Triple_Screen_Swing_Quarterly],[Bearish_Triple_Screen_Swing_Monthly],[Bearish_Triple_Screen_Swing_Weekly],[Bearish_Triple_Screen_Swing_Daily],[Bearish_Triple_Screen_Swing_4_Hourly],[Bearish_Triple_Screen_Swing_1_Hourly],[Bearish_Triple_Screen_Swing_15_Minutes],[Bearish_Triple_Screen_Swing_Correction_Yearly],[Bearish_Triple_Screen_Swing_Correction_Quarterly],[Bearish_Triple_Screen_Swing_Correction_Monthly],[Bearish_Triple_Screen_Swing_Correction_Weekly],[Bearish_Triple_Screen_Swing_Correction_Daily],[Bearish_Triple_Screen_Swing_Correction_4_Hourly],[Bearish_Triple_Screen_Swing_Correction_1_Hourly],[Bearish_Triple_Screen_Swing_Correction_15_Minutes],[Bearish_Double_Screen_Swing_Yearly],[Bearish_Double_Screen_Swing_Quarterly],[Bearish_Double_Screen_Swing_Monthly],[Bearish_Double_Screen_Swing_Weekly],[Bearish_Double_Screen_Swing_Daily],[Bearish_Double_Screen_Swing_4_Hourly],[Bearish_Double_Screen_Swing_1_Hourly],[Bearish_Double_Screen_Swing_15_Minutes],[Bearish_Double_Screen_Swing_Correction_Yearly],[Bearish_Double_Screen_Swing_Correction_Quarterly],[Bearish_Double_Screen_Swing_Correction_Monthly],[Bearish_Double_Screen_Swing_Correction_Weekly],[Bearish_Double_Screen_Swing_Correction_Daily],[Bearish_Double_Screen_Swing_Correction_4_Hourly],[Bearish_Double_Screen_Swing_Correction_1_Hourly],[Bearish_Double_Screen_Swing_Correction_15_Minutes],[Bearish_Single_Screen_Swing_Yearly],[Bearish_Single_Screen_Swing_Quarterly],[Bearish_Single_Screen_Swing_Monthly],[Bearish_Single_Screen_Swing_Weekly],[Bearish_Single_Screen_Swing_Daily],[Bearish_Single_Screen_Swing_4_Hourly],[Bearish_Single_Screen_Swing_1_Hourly],[Bearish_Single_Screen_Swing_15_Minutes],[Bearish_Single_Screen_Swing_Correction_Yearly],[Bearish_Single_Screen_Swing_Correction_Quarterly],[Bearish_Single_Screen_Swing_Correction_Monthly],[Bearish_Single_Screen_Swing_Correction_Weekly],[Bearish_Single_Screen_Swing_Correction_Daily],[Bearish_Single_Screen_Swing_Correction_4_Hourly],[Bearish_Single_Screen_Swing_Correction_1_Hourly],[Bearish_Single_Screen_Swing_Correction_15_Minutes]) 
	) AS vp
)
,DescSource AS 
(   SELECT sno,Batch_No, Screen_Names, Description 
	FROM dbo.Master_Screen_Name_Values
	WHERE Batch_No = 4 -- @batch_num
	order by sno
)
,DescPivot AS 
(   SELECT * FROM DescSource a 
	PIVOT (MAX(Description) FOR Screen_Names IN ([Bullish_Triple_Screen_Strong_Yearly],[Bullish_Triple_Screen_Strong_Quarterly],[Bullish_Triple_Screen_Strong_Monthly],[Bullish_Triple_Screen_Strong_Weekly],[Bullish_Triple_Screen_Strong_Daily],[Bullish_Triple_Screen_Strong_4_Hourly],[Bullish_Triple_Screen_Strong_1_Hourly],[Bullish_Triple_Screen_Strong_15_Minutes],[Bullish_Triple_Screen_Strong_Correction_Yearly],[Bullish_Triple_Screen_Strong_Correction_Quarterly],[Bullish_Triple_Screen_Strong_Correction_Monthly],[Bullish_Triple_Screen_Strong_Correction_Weekly],[Bullish_Triple_Screen_Strong_Correction_Daily],[Bullish_Triple_Screen_Strong_Correction_4_Hourly],[Bullish_Triple_Screen_Strong_Correction_1_Hourly],[Bullish_Triple_Screen_Strong_Correction_15_Minutes],[Bullish_Double_Screen_Strong_Yearly],[Bullish_Double_Screen_Strong_Quarterly],[Bullish_Double_Screen_Strong_Monthly],[Bullish_Double_Screen_Strong_Weekly],[Bullish_Double_Screen_Strong_Daily],[Bullish_Double_Screen_Strong_4_Hourly],[Bullish_Double_Screen_Strong_1_Hourly],[Bullish_Double_Screen_Strong_15_Minutes],[Bullish_Double_Screen_Strong_Correction_Yearly],[Bullish_Double_Screen_Strong_Correction_Quarterly],[Bullish_Double_Screen_Strong_Correction_Monthly],[Bullish_Double_Screen_Strong_Correction_Weekly],[Bullish_Double_Screen_Strong_Correction_Daily],[Bullish_Double_Screen_Strong_Correction_4_Hourly],[Bullish_Double_Screen_Strong_Correction_1_Hourly],[Bullish_Double_Screen_Strong_Correction_15_Minutes],[Bullish_Single_Screen_Strong_Yearly],[Bullish_Single_Screen_Strong_Quarterly],[Bullish_Single_Screen_Strong_Monthly],[Bullish_Single_Screen_Strong_Weekly],[Bullish_Single_Screen_Strong_Daily],[Bullish_Single_Screen_Strong_4_Hourly],[Bullish_Single_Screen_Strong_1_Hourly],[Bullish_Single_Screen_Strong_15_Minutes],[Bullish_Single_Screen_Strong_Correction_Yearly],[Bullish_Single_Screen_Strong_Correction_Quarterly],[Bullish_Single_Screen_Strong_Correction_Monthly],[Bullish_Single_Screen_Strong_Correction_Weekly],[Bullish_Single_Screen_Strong_Correction_Daily],[Bullish_Single_Screen_Strong_Correction_4_Hourly],[Bullish_Single_Screen_Strong_Correction_1_Hourly],[Bullish_Single_Screen_Strong_Correction_15_Minutes],[Bullish_Triple_Screen_Momentum_Yearly],[Bullish_Triple_Screen_Momentum_Quarterly],[Bullish_Triple_Screen_Momentum_Monthly],[Bullish_Triple_Screen_Momentum_Weekly],[Bullish_Triple_Screen_Momentum_Daily],[Bullish_Triple_Screen_Momentum_4_Hourly],[Bullish_Triple_Screen_Momentum_1_Hourly],[Bullish_Triple_Screen_Momentum_15_Minutes],[Bullish_Triple_Screen_Momentum_Correction_Yearly],[Bullish_Triple_Screen_Momentum_Correction_Quarterly],[Bullish_Triple_Screen_Momentum_Correction_Monthly],[Bullish_Triple_Screen_Momentum_Correction_Weekly],[Bullish_Triple_Screen_Momentum_Correction_Daily],[Bullish_Triple_Screen_Momentum_Correction_4_Hourly],[Bullish_Triple_Screen_Momentum_Correction_1_Hourly],[Bullish_Triple_Screen_Momentum_Correction_15_Minutes],[Bullish_Double_Screen_Momentum_Yearly],[Bullish_Double_Screen_Momentum_Quarterly],[Bullish_Double_Screen_Momentum_Monthly],[Bullish_Double_Screen_Momentum_Weekly],[Bullish_Double_Screen_Momentum_Daily],[Bullish_Double_Screen_Momentum_4_Hourly],[Bullish_Double_Screen_Momentum_1_Hourly],[Bullish_Double_Screen_Momentum_15_Minutes],[Bullish_Double_Screen_Momentum_Correction_Yearly],[Bullish_Double_Screen_Momentum_Correction_Quarterly],[Bullish_Double_Screen_Momentum_Correction_Monthly],[Bullish_Double_Screen_Momentum_Correction_Weekly],[Bullish_Double_Screen_Momentum_Correction_Daily],[Bullish_Double_Screen_Momentum_Correction_4_Hourly],[Bullish_Double_Screen_Momentum_Correction_1_Hourly],[Bullish_Double_Screen_Momentum_Correction_15_Minutes],[Bullish_Single_Screen_Momentum_Yearly],[Bullish_Single_Screen_Momentum_Quarterly],[Bullish_Single_Screen_Momentum_Monthly],[Bullish_Single_Screen_Momentum_Weekly],[Bullish_Single_Screen_Momentum_Daily],[Bullish_Single_Screen_Momentum_4_Hourly],[Bullish_Single_Screen_Momentum_1_Hourly],[Bullish_Single_Screen_Momentum_15_Minutes],[Bullish_Single_Screen_Momentum_Correction_Yearly],[Bullish_Single_Screen_Momentum_Correction_Quarterly],[Bullish_Single_Screen_Momentum_Correction_Monthly],[Bullish_Single_Screen_Momentum_Correction_Weekly],[Bullish_Single_Screen_Momentum_Correction_Daily],[Bullish_Single_Screen_Momentum_Correction_4_Hourly],[Bullish_Single_Screen_Momentum_Correction_1_Hourly],[Bullish_Single_Screen_Momentum_Correction_15_Minutes],[Bullish_Triple_Screen_Swing_Yearly],[Bullish_Triple_Screen_Swing_Quarterly],[Bullish_Triple_Screen_Swing_Monthly],[Bullish_Triple_Screen_Swing_Weekly],[Bullish_Triple_Screen_Swing_Daily],[Bullish_Triple_Screen_Swing_4_Hourly],[Bullish_Triple_Screen_Swing_1_Hourly],[Bullish_Triple_Screen_Swing_15_Minutes],[Bullish_Triple_Screen_Swing_Correction_Yearly],[Bullish_Triple_Screen_Swing_Correction_Quarterly],[Bullish_Triple_Screen_Swing_Correction_Monthly],[Bullish_Triple_Screen_Swing_Correction_Weekly],[Bullish_Triple_Screen_Swing_Correction_Daily],[Bullish_Triple_Screen_Swing_Correction_4_Hourly],[Bullish_Triple_Screen_Swing_Correction_1_Hourly],[Bullish_Triple_Screen_Swing_Correction_15_Minutes],[Bullish_Double_Screen_Swing_Yearly],[Bullish_Double_Screen_Swing_Quarterly],[Bullish_Double_Screen_Swing_Monthly],[Bullish_Double_Screen_Swing_Weekly],[Bullish_Double_Screen_Swing_Daily],[Bullish_Double_Screen_Swing_4_Hourly],[Bullish_Double_Screen_Swing_1_Hourly],[Bullish_Double_Screen_Swing_15_Minutes],[Bullish_Double_Screen_Swing_Correction_Yearly],[Bullish_Double_Screen_Swing_Correction_Quarterly],[Bullish_Double_Screen_Swing_Correction_Monthly],[Bullish_Double_Screen_Swing_Correction_Weekly],[Bullish_Double_Screen_Swing_Correction_Daily],[Bullish_Double_Screen_Swing_Correction_4_Hourly],[Bullish_Double_Screen_Swing_Correction_1_Hourly],[Bullish_Double_Screen_Swing_Correction_15_Minutes],[Bullish_Single_Screen_Swing_Yearly],[Bullish_Single_Screen_Swing_Quarterly],[Bullish_Single_Screen_Swing_Monthly],[Bullish_Single_Screen_Swing_Weekly],[Bullish_Single_Screen_Swing_Daily],[Bullish_Single_Screen_Swing_4_Hourly],[Bullish_Single_Screen_Swing_1_Hourly],[Bullish_Single_Screen_Swing_15_Minutes],[Bullish_Single_Screen_Swing_Correction_Yearly],[Bullish_Single_Screen_Swing_Correction_Quarterly],[Bullish_Single_Screen_Swing_Correction_Monthly],[Bullish_Single_Screen_Swing_Correction_Weekly],[Bullish_Single_Screen_Swing_Correction_Daily],[Bullish_Single_Screen_Swing_Correction_4_Hourly],[Bullish_Single_Screen_Swing_Correction_1_Hourly],[Bullish_Single_Screen_Swing_Correction_15_Minutes],[Bearish_Triple_Screen_Strong_Yearly],[Bearish_Triple_Screen_Strong_Quarterly],[Bearish_Triple_Screen_Strong_Monthly],[Bearish_Triple_Screen_Strong_Weekly],[Bearish_Triple_Screen_Strong_Daily],[Bearish_Triple_Screen_Strong_4_Hourly],[Bearish_Triple_Screen_Strong_1_Hourly],[Bearish_Triple_Screen_Strong_15_Minutes],[Bearish_Triple_Screen_Strong_Correction_Yearly],[Bearish_Triple_Screen_Strong_Correction_Quarterly],[Bearish_Triple_Screen_Strong_Correction_Monthly],[Bearish_Triple_Screen_Strong_Correction_Weekly],[Bearish_Triple_Screen_Strong_Correction_Daily],[Bearish_Triple_Screen_Strong_Correction_4_Hourly],[Bearish_Triple_Screen_Strong_Correction_1_Hourly],[Bearish_Triple_Screen_Strong_Correction_15_Minutes],[Bearish_Double_Screen_Strong_Yearly],[Bearish_Double_Screen_Strong_Quarterly],[Bearish_Double_Screen_Strong_Monthly],[Bearish_Double_Screen_Strong_Weekly],[Bearish_Double_Screen_Strong_Daily],[Bearish_Double_Screen_Strong_4_Hourly],[Bearish_Double_Screen_Strong_1_Hourly],[Bearish_Double_Screen_Strong_15_Minutes],[Bearish_Double_Screen_Strong_Correction_Yearly],[Bearish_Double_Screen_Strong_Correction_Quarterly],[Bearish_Double_Screen_Strong_Correction_Monthly],[Bearish_Double_Screen_Strong_Correction_Weekly],[Bearish_Double_Screen_Strong_Correction_Daily],[Bearish_Double_Screen_Strong_Correction_4_Hourly],[Bearish_Double_Screen_Strong_Correction_1_Hourly],[Bearish_Double_Screen_Strong_Correction_15_Minutes],[Bearish_Single_Screen_Strong_Yearly],[Bearish_Single_Screen_Strong_Quarterly],[Bearish_Single_Screen_Strong_Monthly],[Bearish_Single_Screen_Strong_Weekly],[Bearish_Single_Screen_Strong_Daily],[Bearish_Single_Screen_Strong_4_Hourly],[Bearish_Single_Screen_Strong_1_Hourly],[Bearish_Single_Screen_Strong_15_Minutes],[Bearish_Single_Screen_Strong_Correction_Yearly],[Bearish_Single_Screen_Strong_Correction_Quarterly],[Bearish_Single_Screen_Strong_Correction_Monthly],[Bearish_Single_Screen_Strong_Correction_Weekly],[Bearish_Single_Screen_Strong_Correction_Daily],[Bearish_Single_Screen_Strong_Correction_4_Hourly],[Bearish_Single_Screen_Strong_Correction_1_Hourly],[Bearish_Single_Screen_Strong_Correction_15_Minutes],[Bearish_Triple_Screen_Momentum_Yearly],[Bearish_Triple_Screen_Momentum_Quarterly],[Bearish_Triple_Screen_Momentum_Monthly],[Bearish_Triple_Screen_Momentum_Weekly],[Bearish_Triple_Screen_Momentum_Daily],[Bearish_Triple_Screen_Momentum_4_Hourly],[Bearish_Triple_Screen_Momentum_1_Hourly],[Bearish_Triple_Screen_Momentum_15_Minutes],[Bearish_Triple_Screen_Momentum_Correction_Yearly],[Bearish_Triple_Screen_Momentum_Correction_Quarterly],[Bearish_Triple_Screen_Momentum_Correction_Monthly],[Bearish_Triple_Screen_Momentum_Correction_Weekly],[Bearish_Triple_Screen_Momentum_Correction_Daily],[Bearish_Triple_Screen_Momentum_Correction_4_Hourly],[Bearish_Triple_Screen_Momentum_Correction_1_Hourly],[Bearish_Triple_Screen_Momentum_Correction_15_Minutes],[Bearish_Double_Screen_Momentum_Yearly],[Bearish_Double_Screen_Momentum_Quarterly],[Bearish_Double_Screen_Momentum_Monthly],[Bearish_Double_Screen_Momentum_Weekly],[Bearish_Double_Screen_Momentum_Daily],[Bearish_Double_Screen_Momentum_4_Hourly],[Bearish_Double_Screen_Momentum_1_Hourly],[Bearish_Double_Screen_Momentum_15_Minutes],[Bearish_Double_Screen_Momentum_Correction_Yearly],[Bearish_Double_Screen_Momentum_Correction_Quarterly],[Bearish_Double_Screen_Momentum_Correction_Monthly],[Bearish_Double_Screen_Momentum_Correction_Weekly],[Bearish_Double_Screen_Momentum_Correction_Daily],[Bearish_Double_Screen_Momentum_Correction_4_Hourly],[Bearish_Double_Screen_Momentum_Correction_1_Hourly],[Bearish_Double_Screen_Momentum_Correction_15_Minutes],[Bearish_Single_Screen_Momentum_Yearly],[Bearish_Single_Screen_Momentum_Quarterly],[Bearish_Single_Screen_Momentum_Monthly],[Bearish_Single_Screen_Momentum_Weekly],[Bearish_Single_Screen_Momentum_Daily],[Bearish_Single_Screen_Momentum_4_Hourly],[Bearish_Single_Screen_Momentum_1_Hourly],[Bearish_Single_Screen_Momentum_15_Minutes],[Bearish_Single_Screen_Momentum_Correction_Yearly],[Bearish_Single_Screen_Momentum_Correction_Quarterly],[Bearish_Single_Screen_Momentum_Correction_Monthly],[Bearish_Single_Screen_Momentum_Correction_Weekly],[Bearish_Single_Screen_Momentum_Correction_Daily],[Bearish_Single_Screen_Momentum_Correction_4_Hourly],[Bearish_Single_Screen_Momentum_Correction_1_Hourly],[Bearish_Single_Screen_Momentum_Correction_15_Minutes],[Bearish_Triple_Screen_Swing_Yearly],[Bearish_Triple_Screen_Swing_Quarterly],[Bearish_Triple_Screen_Swing_Monthly],[Bearish_Triple_Screen_Swing_Weekly],[Bearish_Triple_Screen_Swing_Daily],[Bearish_Triple_Screen_Swing_4_Hourly],[Bearish_Triple_Screen_Swing_1_Hourly],[Bearish_Triple_Screen_Swing_15_Minutes],[Bearish_Triple_Screen_Swing_Correction_Yearly],[Bearish_Triple_Screen_Swing_Correction_Quarterly],[Bearish_Triple_Screen_Swing_Correction_Monthly],[Bearish_Triple_Screen_Swing_Correction_Weekly],[Bearish_Triple_Screen_Swing_Correction_Daily],[Bearish_Triple_Screen_Swing_Correction_4_Hourly],[Bearish_Triple_Screen_Swing_Correction_1_Hourly],[Bearish_Triple_Screen_Swing_Correction_15_Minutes],[Bearish_Double_Screen_Swing_Yearly],[Bearish_Double_Screen_Swing_Quarterly],[Bearish_Double_Screen_Swing_Monthly],[Bearish_Double_Screen_Swing_Weekly],[Bearish_Double_Screen_Swing_Daily],[Bearish_Double_Screen_Swing_4_Hourly],[Bearish_Double_Screen_Swing_1_Hourly],[Bearish_Double_Screen_Swing_15_Minutes],[Bearish_Double_Screen_Swing_Correction_Yearly],[Bearish_Double_Screen_Swing_Correction_Quarterly],[Bearish_Double_Screen_Swing_Correction_Monthly],[Bearish_Double_Screen_Swing_Correction_Weekly],[Bearish_Double_Screen_Swing_Correction_Daily],[Bearish_Double_Screen_Swing_Correction_4_Hourly],[Bearish_Double_Screen_Swing_Correction_1_Hourly],[Bearish_Double_Screen_Swing_Correction_15_Minutes],[Bearish_Single_Screen_Swing_Yearly],[Bearish_Single_Screen_Swing_Quarterly],[Bearish_Single_Screen_Swing_Monthly],[Bearish_Single_Screen_Swing_Weekly],[Bearish_Single_Screen_Swing_Daily],[Bearish_Single_Screen_Swing_4_Hourly],[Bearish_Single_Screen_Swing_1_Hourly],[Bearish_Single_Screen_Swing_15_Minutes],[Bearish_Single_Screen_Swing_Correction_Yearly],[Bearish_Single_Screen_Swing_Correction_Quarterly],[Bearish_Single_Screen_Swing_Correction_Monthly],[Bearish_Single_Screen_Swing_Correction_Weekly],[Bearish_Single_Screen_Swing_Correction_Daily],[Bearish_Single_Screen_Swing_Correction_4_Hourly],[Bearish_Single_Screen_Swing_Correction_1_Hourly],[Bearish_Single_Screen_Swing_Correction_15_Minutes]) 
	) AS dp
)
UPDATE a SET -- select distinct a.Batch_No,a.sno,
Trade_Type_Details = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
('' + ';Bu-Triple-Stg-' +
(case when a.Bullish_Triple_Screen_Strong_Yearly                  > 0 then dp.Bullish_Triple_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Quarterly               > 0 then dp.Bullish_Triple_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Monthly                 > 0 then dp.Bullish_Triple_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Weekly                  > 0 then dp.Bullish_Triple_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Daily                   > 0 then dp.Bullish_Triple_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_4_Hourly                > 0 then dp.Bullish_Triple_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_1_Hourly                > 0 then dp.Bullish_Triple_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_15_Minutes              > 0 then dp.Bullish_Triple_Screen_Strong_15_Minutes              + ';' else '' end) +
';Bu-Triple-Stg-Corr-' +
(case when a.Bullish_Triple_Screen_Strong_Correction_Yearly       > 0 then dp.Bullish_Triple_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_Quarterly    > 0 then dp.Bullish_Triple_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_Monthly      > 0 then dp.Bullish_Triple_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_Weekly       > 0 then dp.Bullish_Triple_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_Daily        > 0 then dp.Bullish_Triple_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bullish_Triple_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bullish_Triple_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bullish_Triple_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Bu-Double-Stg-' + 
(case when a.Bullish_Double_Screen_Strong_Yearly                  > 0 then dp.Bullish_Double_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Quarterly               > 0 then dp.Bullish_Double_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Monthly                 > 0 then dp.Bullish_Double_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Weekly                  > 0 then dp.Bullish_Double_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Daily                   > 0 then dp.Bullish_Double_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_4_Hourly                > 0 then dp.Bullish_Double_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_1_Hourly                > 0 then dp.Bullish_Double_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_15_Minutes              > 0 then dp.Bullish_Double_Screen_Strong_15_Minutes              + ';' else '' end) +
';Bu-Double-Stg-Corr-' + 
(case when a.Bullish_Double_Screen_Strong_Correction_Yearly       > 0 then dp.Bullish_Double_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_Quarterly    > 0 then dp.Bullish_Double_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_Monthly      > 0 then dp.Bullish_Double_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_Weekly       > 0 then dp.Bullish_Double_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_Daily        > 0 then dp.Bullish_Double_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bullish_Double_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bullish_Double_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bullish_Double_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bullish_Double_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Bu-Single-Stg-' +
(case when a.Bullish_Single_Screen_Strong_Yearly                  > 0 then dp.Bullish_Single_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Quarterly               > 0 then dp.Bullish_Single_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Monthly                 > 0 then dp.Bullish_Single_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Weekly                  > 0 then dp.Bullish_Single_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Daily                   > 0 then dp.Bullish_Single_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_4_Hourly                > 0 then dp.Bullish_Single_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_1_Hourly                > 0 then dp.Bullish_Single_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_15_Minutes              > 0 then dp.Bullish_Single_Screen_Strong_15_Minutes              + ';' else '' end) +
';Bu-Single-Stg-Corr-' +
(case when a.Bullish_Single_Screen_Strong_Correction_Yearly       > 0 then dp.Bullish_Single_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_Quarterly    > 0 then dp.Bullish_Single_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_Monthly      > 0 then dp.Bullish_Single_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_Weekly       > 0 then dp.Bullish_Single_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_Daily        > 0 then dp.Bullish_Single_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bullish_Single_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bullish_Single_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bullish_Single_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bullish_Single_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Bu-Triple-Mom-' +
(case when a.Bullish_Triple_Screen_Momentum_Yearly                > 0 then dp.Bullish_Triple_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Quarterly             > 0 then dp.Bullish_Triple_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Monthly               > 0 then dp.Bullish_Triple_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Weekly                > 0 then dp.Bullish_Triple_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Daily                 > 0 then dp.Bullish_Triple_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_4_Hourly              > 0 then dp.Bullish_Triple_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_1_Hourly              > 0 then dp.Bullish_Triple_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_15_Minutes            > 0 then dp.Bullish_Triple_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Bu-Triple-Mom-Corr-' +
(case when a.Bullish_Triple_Screen_Momentum_Correction_Yearly     > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_Monthly    > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_Weekly     > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_Daily      > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bullish_Triple_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Bu-Double-Mom-' +
(case when a.Bullish_Double_Screen_Momentum_Yearly                > 0 then dp.Bullish_Double_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Quarterly             > 0 then dp.Bullish_Double_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Monthly               > 0 then dp.Bullish_Double_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Weekly                > 0 then dp.Bullish_Double_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Daily                 > 0 then dp.Bullish_Double_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_4_Hourly              > 0 then dp.Bullish_Double_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_1_Hourly              > 0 then dp.Bullish_Double_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_15_Minutes            > 0 then dp.Bullish_Double_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Bu-Double-Mom-Corr-' +
(case when a.Bullish_Double_Screen_Momentum_Correction_Yearly     > 0 then dp.Bullish_Double_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bullish_Double_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_Monthly    > 0 then dp.Bullish_Double_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_Weekly     > 0 then dp.Bullish_Double_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_Daily      > 0 then dp.Bullish_Double_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bullish_Double_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bullish_Double_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bullish_Double_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bullish_Double_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Bu-Single-Mom-' +
(case when a.Bullish_Single_Screen_Momentum_Yearly                > 0 then dp.Bullish_Single_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Quarterly             > 0 then dp.Bullish_Single_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Monthly               > 0 then dp.Bullish_Single_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Weekly                > 0 then dp.Bullish_Single_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Daily                 > 0 then dp.Bullish_Single_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_4_Hourly              > 0 then dp.Bullish_Single_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_1_Hourly              > 0 then dp.Bullish_Single_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_15_Minutes            > 0 then dp.Bullish_Single_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Bu-Single-Mom-Corr-' +
(case when a.Bullish_Single_Screen_Momentum_Correction_Yearly     > 0 then dp.Bullish_Single_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bullish_Single_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_Monthly    > 0 then dp.Bullish_Single_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_Weekly     > 0 then dp.Bullish_Single_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_Daily      > 0 then dp.Bullish_Single_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bullish_Single_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bullish_Single_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bullish_Single_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bullish_Single_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Bu-Triple-Swg-' +
(case when a.Bullish_Triple_Screen_Swing_Yearly                   > 0 then dp.Bullish_Triple_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Quarterly                > 0 then dp.Bullish_Triple_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Monthly                  > 0 then dp.Bullish_Triple_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Weekly                   > 0 then dp.Bullish_Triple_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Daily                    > 0 then dp.Bullish_Triple_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_4_Hourly                 > 0 then dp.Bullish_Triple_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_1_Hourly                 > 0 then dp.Bullish_Triple_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_15_Minutes               > 0 then dp.Bullish_Triple_Screen_Swing_15_Minutes               + ';' else '' end) +
';Bu-Triple-Swg-Corr-' +
(case when a.Bullish_Triple_Screen_Swing_Correction_Yearly        > 0 then dp.Bullish_Triple_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_Quarterly     > 0 then dp.Bullish_Triple_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_Monthly       > 0 then dp.Bullish_Triple_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_Weekly        > 0 then dp.Bullish_Triple_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_Daily         > 0 then dp.Bullish_Triple_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bullish_Triple_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bullish_Triple_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bullish_Triple_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bullish_Triple_Screen_Swing_Correction_15_Minutes    + ';' else '' end) +
';Bu-Double-Swg-Corr-' +
(case when a.Bullish_Double_Screen_Swing_Yearly                   > 0 then dp.Bullish_Double_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Quarterly                > 0 then dp.Bullish_Double_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Monthly                  > 0 then dp.Bullish_Double_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Weekly                   > 0 then dp.Bullish_Double_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Daily                    > 0 then dp.Bullish_Double_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_4_Hourly                 > 0 then dp.Bullish_Double_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_1_Hourly                 > 0 then dp.Bullish_Double_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_15_Minutes               > 0 then dp.Bullish_Double_Screen_Swing_15_Minutes               + ';' else '' end) +
';Bu-Double-Swg-Corr-' +
(case when a.Bullish_Double_Screen_Swing_Correction_Yearly        > 0 then dp.Bullish_Double_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_Quarterly     > 0 then dp.Bullish_Double_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_Monthly       > 0 then dp.Bullish_Double_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_Weekly        > 0 then dp.Bullish_Double_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_Daily         > 0 then dp.Bullish_Double_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bullish_Double_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bullish_Double_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bullish_Double_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bullish_Double_Screen_Swing_Correction_15_Minutes    + ';' else '' end) +
';Bu-Single-Swg-' +
(case when a.Bullish_Single_Screen_Swing_Yearly                   > 0 then dp.Bullish_Single_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Quarterly                > 0 then dp.Bullish_Single_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Monthly                  > 0 then dp.Bullish_Single_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Weekly                   > 0 then dp.Bullish_Single_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Daily                    > 0 then dp.Bullish_Single_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_4_Hourly                 > 0 then dp.Bullish_Single_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_1_Hourly                 > 0 then dp.Bullish_Single_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_15_Minutes               > 0 then dp.Bullish_Single_Screen_Swing_15_Minutes               + ';' else '' end) +
';Bu-Single-Swg-Corr-' +
(case when a.Bullish_Single_Screen_Swing_Correction_Yearly        > 0 then dp.Bullish_Single_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_Quarterly     > 0 then dp.Bullish_Single_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_Monthly       > 0 then dp.Bullish_Single_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_Weekly        > 0 then dp.Bullish_Single_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_Daily         > 0 then dp.Bullish_Single_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bullish_Single_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bullish_Single_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bullish_Single_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bullish_Single_Screen_Swing_Correction_15_Minutes    + ';' else '' end) +
+ ';' + CHAR(13) + CHAR(10) + ';Be-Triple-Stg-' +
(case when a.Bearish_Triple_Screen_Strong_Yearly                  > 0 then dp.Bearish_Triple_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Quarterly               > 0 then dp.Bearish_Triple_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Monthly                 > 0 then dp.Bearish_Triple_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Weekly                  > 0 then dp.Bearish_Triple_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Daily                   > 0 then dp.Bearish_Triple_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_4_Hourly                > 0 then dp.Bearish_Triple_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_1_Hourly                > 0 then dp.Bearish_Triple_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_15_Minutes              > 0 then dp.Bearish_Triple_Screen_Strong_15_Minutes              + ';' else '' end) +
';Be-Triple-Stg-Corr-' +
(case when a.Bearish_Triple_Screen_Strong_Correction_Yearly       > 0 then dp.Bearish_Triple_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_Quarterly    > 0 then dp.Bearish_Triple_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_Monthly      > 0 then dp.Bearish_Triple_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_Weekly       > 0 then dp.Bearish_Triple_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_Daily        > 0 then dp.Bearish_Triple_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bearish_Triple_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bearish_Triple_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bearish_Triple_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Be-Double-Stg-' +
(case when a.Bearish_Double_Screen_Strong_Yearly                  > 0 then dp.Bearish_Double_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Quarterly               > 0 then dp.Bearish_Double_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Monthly                 > 0 then dp.Bearish_Double_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Weekly                  > 0 then dp.Bearish_Double_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Daily                   > 0 then dp.Bearish_Double_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_4_Hourly                > 0 then dp.Bearish_Double_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_1_Hourly                > 0 then dp.Bearish_Double_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_15_Minutes              > 0 then dp.Bearish_Double_Screen_Strong_15_Minutes              + ';' else '' end) +
';Be-Double-Stg-Corr-' +
(case when a.Bearish_Double_Screen_Strong_Correction_Yearly       > 0 then dp.Bearish_Double_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_Quarterly    > 0 then dp.Bearish_Double_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_Monthly      > 0 then dp.Bearish_Double_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_Weekly       > 0 then dp.Bearish_Double_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_Daily        > 0 then dp.Bearish_Double_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bearish_Double_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bearish_Double_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bearish_Double_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bearish_Double_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Be-Single-Stg-' +
(case when a.Bearish_Single_Screen_Strong_Yearly                  > 0 then dp.Bearish_Single_Screen_Strong_Yearly                  + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Quarterly               > 0 then dp.Bearish_Single_Screen_Strong_Quarterly               + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Monthly                 > 0 then dp.Bearish_Single_Screen_Strong_Monthly                 + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Weekly                  > 0 then dp.Bearish_Single_Screen_Strong_Weekly                  + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Daily                   > 0 then dp.Bearish_Single_Screen_Strong_Daily                   + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_4_Hourly                > 0 then dp.Bearish_Single_Screen_Strong_4_Hourly                + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_1_Hourly                > 0 then dp.Bearish_Single_Screen_Strong_1_Hourly                + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_15_Minutes              > 0 then dp.Bearish_Single_Screen_Strong_15_Minutes              + ';' else '' end) +
';Be-Single-Stg-Corr-' +
(case when a.Bearish_Single_Screen_Strong_Correction_Yearly       > 0 then dp.Bearish_Single_Screen_Strong_Correction_Yearly       + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_Quarterly    > 0 then dp.Bearish_Single_Screen_Strong_Correction_Quarterly    + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_Monthly      > 0 then dp.Bearish_Single_Screen_Strong_Correction_Monthly      + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_Weekly       > 0 then dp.Bearish_Single_Screen_Strong_Correction_Weekly       + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_Daily        > 0 then dp.Bearish_Single_Screen_Strong_Correction_Daily        + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_4_Hourly     > 0 then dp.Bearish_Single_Screen_Strong_Correction_4_Hourly     + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_1_Hourly     > 0 then dp.Bearish_Single_Screen_Strong_Correction_1_Hourly     + ';' else '' end) +
(case when a.Bearish_Single_Screen_Strong_Correction_15_Minutes   > 0 then dp.Bearish_Single_Screen_Strong_Correction_15_Minutes   + ';' else '' end) +
';Be-Triple-Mom-' +
(case when a.Bearish_Triple_Screen_Momentum_Yearly                > 0 then dp.Bearish_Triple_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Quarterly             > 0 then dp.Bearish_Triple_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Monthly               > 0 then dp.Bearish_Triple_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Weekly                > 0 then dp.Bearish_Triple_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Daily                 > 0 then dp.Bearish_Triple_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_4_Hourly              > 0 then dp.Bearish_Triple_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_1_Hourly              > 0 then dp.Bearish_Triple_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_15_Minutes            > 0 then dp.Bearish_Triple_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Be-Triple-Mom-Corr-' +
(case when a.Bearish_Triple_Screen_Momentum_Correction_Yearly     > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_Monthly    > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_Weekly     > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_Daily      > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bearish_Triple_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Be-Double-Mom-' +
(case when a.Bearish_Double_Screen_Momentum_Yearly                > 0 then dp.Bearish_Double_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Quarterly             > 0 then dp.Bearish_Double_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Monthly               > 0 then dp.Bearish_Double_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Weekly                > 0 then dp.Bearish_Double_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Daily                 > 0 then dp.Bearish_Double_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_4_Hourly              > 0 then dp.Bearish_Double_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_1_Hourly              > 0 then dp.Bearish_Double_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_15_Minutes            > 0 then dp.Bearish_Double_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Be-Double-Mom-Corr-' +
(case when a.Bearish_Double_Screen_Momentum_Correction_Yearly     > 0 then dp.Bearish_Double_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bearish_Double_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_Monthly    > 0 then dp.Bearish_Double_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_Weekly     > 0 then dp.Bearish_Double_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_Daily      > 0 then dp.Bearish_Double_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bearish_Double_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bearish_Double_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bearish_Double_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bearish_Double_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Be-Single-Mom-' +
(case when a.Bearish_Single_Screen_Momentum_Yearly                > 0 then dp.Bearish_Single_Screen_Momentum_Yearly                + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Quarterly             > 0 then dp.Bearish_Single_Screen_Momentum_Quarterly             + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Monthly               > 0 then dp.Bearish_Single_Screen_Momentum_Monthly               + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Weekly                > 0 then dp.Bearish_Single_Screen_Momentum_Weekly                + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Daily                 > 0 then dp.Bearish_Single_Screen_Momentum_Daily                 + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_4_Hourly              > 0 then dp.Bearish_Single_Screen_Momentum_4_Hourly              + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_1_Hourly              > 0 then dp.Bearish_Single_Screen_Momentum_1_Hourly              + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_15_Minutes            > 0 then dp.Bearish_Single_Screen_Momentum_15_Minutes            + ';' else '' end) +
';Be-Single-Mom-Corr-' +
(case when a.Bearish_Single_Screen_Momentum_Correction_Yearly     > 0 then dp.Bearish_Single_Screen_Momentum_Correction_Yearly     + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_Quarterly  > 0 then dp.Bearish_Single_Screen_Momentum_Correction_Quarterly  + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_Monthly    > 0 then dp.Bearish_Single_Screen_Momentum_Correction_Monthly    + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_Weekly     > 0 then dp.Bearish_Single_Screen_Momentum_Correction_Weekly     + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_Daily      > 0 then dp.Bearish_Single_Screen_Momentum_Correction_Daily      + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_4_Hourly   > 0 then dp.Bearish_Single_Screen_Momentum_Correction_4_Hourly   + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_1_Hourly   > 0 then dp.Bearish_Single_Screen_Momentum_Correction_1_Hourly   + ';' else '' end) +
(case when a.Bearish_Single_Screen_Momentum_Correction_15_Minutes > 0 then dp.Bearish_Single_Screen_Momentum_Correction_15_Minutes + ';' else '' end) +
';Be-Triple-Swg-' +
(case when a.Bearish_Triple_Screen_Swing_Yearly                   > 0 then dp.Bearish_Triple_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Quarterly                > 0 then dp.Bearish_Triple_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Monthly                  > 0 then dp.Bearish_Triple_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Weekly                   > 0 then dp.Bearish_Triple_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Daily                    > 0 then dp.Bearish_Triple_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_4_Hourly                 > 0 then dp.Bearish_Triple_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_1_Hourly                 > 0 then dp.Bearish_Triple_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_15_Minutes               > 0 then dp.Bearish_Triple_Screen_Swing_15_Minutes               + ';' else '' end) +
';Be-Triple-Swg-Corr-' +
(case when a.Bearish_Triple_Screen_Swing_Correction_Yearly        > 0 then dp.Bearish_Triple_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_Quarterly     > 0 then dp.Bearish_Triple_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_Monthly       > 0 then dp.Bearish_Triple_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_Weekly        > 0 then dp.Bearish_Triple_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_Daily         > 0 then dp.Bearish_Triple_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bearish_Triple_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bearish_Triple_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bearish_Triple_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bearish_Triple_Screen_Swing_Correction_15_Minutes    + ';' else '' end) +
';Be-Double-Swg-' +
(case when a.Bearish_Double_Screen_Swing_Yearly                   > 0 then dp.Bearish_Double_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Quarterly                > 0 then dp.Bearish_Double_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Monthly                  > 0 then dp.Bearish_Double_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Weekly                   > 0 then dp.Bearish_Double_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Daily                    > 0 then dp.Bearish_Double_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_4_Hourly                 > 0 then dp.Bearish_Double_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_1_Hourly                 > 0 then dp.Bearish_Double_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_15_Minutes               > 0 then dp.Bearish_Double_Screen_Swing_15_Minutes               + ';' else '' end) +
';Be-Double-Swg-Corr-' +
(case when a.Bearish_Double_Screen_Swing_Correction_Yearly        > 0 then dp.Bearish_Double_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_Quarterly     > 0 then dp.Bearish_Double_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_Monthly       > 0 then dp.Bearish_Double_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_Weekly        > 0 then dp.Bearish_Double_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_Daily         > 0 then dp.Bearish_Double_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bearish_Double_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bearish_Double_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bearish_Double_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bearish_Double_Screen_Swing_Correction_15_Minutes    + ';' else '' end) +
';Be-Single-Swg-' +
(case when a.Bearish_Single_Screen_Swing_Yearly                   > 0 then dp.Bearish_Single_Screen_Swing_Yearly                   + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Quarterly                > 0 then dp.Bearish_Single_Screen_Swing_Quarterly                + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Monthly                  > 0 then dp.Bearish_Single_Screen_Swing_Monthly                  + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Weekly                   > 0 then dp.Bearish_Single_Screen_Swing_Weekly                   + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Daily                    > 0 then dp.Bearish_Single_Screen_Swing_Daily                    + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_4_Hourly                 > 0 then dp.Bearish_Single_Screen_Swing_4_Hourly                 + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_1_Hourly                 > 0 then dp.Bearish_Single_Screen_Swing_1_Hourly                 + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_15_Minutes               > 0 then dp.Bearish_Single_Screen_Swing_15_Minutes               + ';' else '' end) +
';Be-Single-Swg-Corr-' +
(case when a.Bearish_Single_Screen_Swing_Correction_Yearly        > 0 then dp.Bearish_Single_Screen_Swing_Correction_Yearly        + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_Quarterly     > 0 then dp.Bearish_Single_Screen_Swing_Correction_Quarterly     + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_Monthly       > 0 then dp.Bearish_Single_Screen_Swing_Correction_Monthly       + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_Weekly        > 0 then dp.Bearish_Single_Screen_Swing_Correction_Weekly        + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_Daily         > 0 then dp.Bearish_Single_Screen_Swing_Correction_Daily         + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_4_Hourly      > 0 then dp.Bearish_Single_Screen_Swing_Correction_4_Hourly      + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_1_Hourly      > 0 then dp.Bearish_Single_Screen_Swing_Correction_1_Hourly      + ';' else '' end) +
(case when a.Bearish_Single_Screen_Swing_Correction_15_Minutes    > 0 then dp.Bearish_Single_Screen_Swing_Correction_15_Minutes    + ';' else '' end) + 
';')
,'Bu-Tri-Stg-',''),'Bu-Tri-Stg-Corr-',''),'Bu-Dbl-Stg-',''),'Bu-Dbl-Stg-Corr-',''),'Bu-Sgl-Stg-',''),'Bu-Sgl-Stg-Corr-',''),'Bu-Tri-Mom-',''),'Bu-Tri-Mom-Corr-',''),'Bu-Dbl-Mom-',''),'Bu-Dbl-Mom-Corr-',''),'Bu-Sgl-Mom-',''),'Bu-Sgl-Mom-Corr-',''),'Bu-Tri-Swg-',''),'Bu-Tri-Swg-Corr-',''),'Bu-Dbl-Swg-',''),'Bu-Dbl-Swg-Corr-',''),'Bu-Sgl-Swg-',''),'Bu-Sgl-Swg-Corr-',''),'Be-Tri-Stg-',''),'Be-Tri-Stg-Corr-',''),'Be-Dbl-Stg-',''),'Be-Dbl-Stg-Corr-',''),'Be-Sgl-Stg-',''),'Be-Sgl-Stg-Corr-',''),'Be-Tri-Mom-',''),'Be-Tri-Mom-Corr-',''),'Be-Dbl-Mom-',''),'Be-Dbl-Mom-Corr-',''),'Be-Sgl-Mom-',''),'Be-Sgl-Mom-Corr-',''),'Be-Tri-Swg-',''),'Be-Tri-Swg-Corr-',''),'Be-Dbl-Swg-',''),'Be-Dbl-Swg-Corr-',''),'Be-Sgl-Swg-',''),'Be-Sgl-Swg-Corr-',''),'Bu-Triple-Stg-;',''),'Bu-Triple-Stg-Corr-;',''),'Bu-Double-Stg-;',''),'Bu-Double-Stg-Corr-;',''),'Bu-Single-Stg-;',''),'Bu-Single-Stg-Corr-;',''),'Bu-Triple-Mom-;',''),'Bu-Triple-Mom-Corr-;',''),'Bu-Double-Mom-;',''),'Bu-Double-Mom-Corr-;',''),'Bu-Single-Mom-;',''),'Bu-Single-Mom-Corr-;',''),'Bu-Triple-Swg-;',''),'Bu-Triple-Swg-Corr-;',''),'Bu-Double-Swg-Corr-;',''),'Bu-Double-Swg-Corr-;',''),'Bu-Single-Swg-;',''),'Bu-Single-Swg-Corr-;',''),'Be-Triple-Stg-;',''),'Be-Triple-Stg-Corr-;',''),'Be-Double-Stg-;',''),'Be-Double-Stg-Corr-;',''),'Be-Single-Stg-;',''),'Be-Single-Stg-Corr-;',''),'Be-Triple-Mom-;',''),'Be-Triple-Mom-Corr-;',''),'Be-Double-Mom-;',''),'Be-Double-Mom-Corr-;',''),'Be-Single-Mom-;',''),'Be-Single-Mom-Corr-;',''),'Be-Triple-Swg-;',''),'Be-Triple-Swg-Corr-;',''),'Be-Double-Swg-;',''),'Be-Double-Swg-Corr-;',''),'Be-Single-Swg-;',''),'Be-Single-Swg-Corr-;',''),';;',';')

FROM dbo.Analyse_Stocks a 
JOIN DescPivot dp  ON dp.Batch_No = @batch_num 
and a.Batch_No = @batch_no -- (select max(batch_no) from Analyse_Stocks) 
JOIN ValuePivot vp ON vp.Batch_No = @batch_num
;
end

begin -- update trade_type.... calculated fields 
declare @batch_no bigint
,@batch_num bigint = 4
,@cteupdatequery nvarchar(max),@cteupdatequery1 nvarchar(max),@cteupdatequery2 nvarchar(max),@cteupdatequery3 nvarchar(max),@cteupdatequery4 nvarchar(max)
,@updatequery nvarchar(max)
,@Trade_Type nvarchar(max)
,@Trade_Type_Details nvarchar(max)
,@Trade_Type_Details_Sum nvarchar(max)
,@ScreenNames nvarchar(max)
,@Trade_Type_Bullish_Sum nvarchar(max)
,@Trade_Type_Bearish_Sum nvarchar(max)

SELECT -- + CHAR(13) + CHAR(10) 
 @updatequery = STRING_AGG(CAST((Screen_Names + ' = b.'+ Screen_Names + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
,@ScreenNames = STRING_AGG(CAST(('[' + Screen_Names + ']' /*+ CHAR(13) + CHAR(10)*/) AS nvarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then ''' + left(Screen_Names,2) + ';'' else '''' end) +' + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then dp.' + Screen_Names + ' + '';'' else '''' end) +' + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' else 0 end) +' + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num;

SELECT @Trade_Type_Bullish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' else 0 end) +' + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num and Screen_Names like 'Bullish%';

SELECT @Trade_Type_Bearish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' else 0 end) +' + CHAR(13) + CHAR(10)) AS nvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num and Screen_Names like 'Bearish%';
select @batch_no = max(batch_no) from Analyse_Stocks;
/*
select @ScreenNames ScreenNames;
select @updatequery updatequery;
select @Trade_Type Trade_Type;
select @Trade_Type_Details Trade_Type_Details;
select @Trade_Type_Details_Sum Trade_Type_Details_Sum;
select @Trade_Type_Bearish_Sum Trade_Type_Bearish_Sum;
select @Trade_Type_Bullish_Sum Trade_Type_Bullish_Sum;
select @batch_no batch_no
UPDATE a SET 
	Trade_Type = null
	,Trade_Type_Details = null
	,Trade_Type_Details_Sum = null
	,Trade_Type_Bullish_Sum = null
	,Trade_Type_Bearish_Sum = null
FROM dbo.Analyse_Stocks a where a.Batch_No = @batch_no
;
select Trade_Type
	,Trade_Type_Details
	,Trade_Type_Details_Sum
	,Trade_Type_Bullish_Sum
	,Trade_Type_Bearish_Sum
from dbo.Analyse_Stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
;
*/
set @cteupdatequery = CAST('' AS NVARCHAR(MAX))  + '
;WITH ValueSource AS 
(   SELECT Batch_No, Screen_Names, Value
	FROM dbo.Master_Screen_Name_Values WHERE Batch_No = ' + cast(@batch_num as nvarchar)+'
)
,ValuePivot AS 
(   SELECT * FROM ValueSource
	PIVOT (SUM(Value) FOR Screen_Names IN ('+ @ScreenNames +') ) AS vp
)
,DescSource AS 
(   SELECT Batch_No, Screen_Names, Description 
	FROM dbo.Master_Screen_Name_Values
	WHERE Batch_No = ' + cast(@batch_num as nvarchar)+'
)
,DescPivot AS 
(   SELECT * FROM DescSource a 
	PIVOT (MAX(Description) FOR Screen_Names IN ('+  @ScreenNames +') ) AS dp
)
UPDATE a SET -- SELECT a.Symbol, a.Batch_No, 
	Trade_Type = '+ @Trade_Type + '	''''
	,Trade_Type_Details = ' + @Trade_Type_Details + '		''''
	,Trade_Type_Details_Sum = ' + @Trade_Type_Details_Sum + '0
	,Trade_Type_Bullish_Sum = ' + @Trade_Type_Bullish_Sum + '0
	,Trade_Type_Bearish_Sum = ' + @Trade_Type_Bearish_Sum + '0
FROM dbo.Analyse_Stocks a 
JOIN DescPivot dp  ON dp.Batch_No = ' + cast(@batch_num as nvarchar) +' and a.Batch_No = ' + cast(@batch_no as nvarchar) +'
JOIN ValuePivot vp ON vp.Batch_No =' + cast(@batch_num as nvarchar) +';'

EXEC sp_executesql @cteupdatequery;
----------------------------------------------------------------
declare @ScreenNames nvarchar(max),@updatequery nvarchar(max)
SELECT @ScreenNames = STRING_AGG(CAST((Screen_Names + ' = b.'+ Screen_Names + CHAR(13) + CHAR(10)) AS NVarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = 4 -- @batch_num;
select @ScreenNames 
set @updatequery = 'update a set ' + CHAR(13) + CHAR(10) + @ScreenNames + '
from dbo.Analyse_Stocks a
inner join dbo.Temp_Analyse_Stocks b 
on a.batch_no = b.batch_no 
and a.symbol = b.symbol;'
EXEC sp_executesql @updatequery;
----------------------------------------------------------------

declare @updatequery nvarchar(max), @Trade_Type nvarchar(max), @Trade_Type_Details nvarchar(max), @Trade_Type_Details_Sum nvarchar(max), @ScreenNames nvarchar(max)
SELECT 
@updatequery = STRING_AGG(CAST((Screen_Names + ' = b.'+ Screen_Names + CHAR(13) + CHAR(10)) AS Nnvarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
,@ScreenNames = STRING_AGG(CAST(('[' + Screen_Names + ']') AS Nnvarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then ''' + left(Screen_Names,2) + ';'' else '''' end) +') AS Nnvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then dp.' + Screen_Names + ' + '';'' else '''' end) +') AS Nnvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
,@Trade_Type_Details_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS Nnvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num;
select @ScreenNames,@Trade_Type,@Trade_Type_Details,@Trade_Type_Details_Sum;

declare @Trade_Type_Bullish_Sum nnvarchar(max)
SELECT
@Trade_Type_Bullish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS Nnvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num and Screen_Names like 'Bullish%';
select @Trade_Type_Bullish_Sum;
declare @Trade_Type_Bearish_Sum nnvarchar(max)
SELECT
@Trade_Type_Bearish_Sum = STRING_AGG(CAST(('(case when a.' + Screen_Names + ' > 0 then vp.' + Screen_Names + ' + '';'' else '''' end) +') AS Nnvarchar(MAX)), '')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = @batch_num and Screen_Names like 'Bearish%';
select @Trade_Type_Bearish_Sum;
----------------------------------------------------------------

end

begin -- sort the string in Trade type details 
;WITH InputData AS (
    SELECT Batch_No, Sno, Trade_Type_Details
    FROM dbo.Analyse_Stocks 
	where 1=1
	and Batch_No = @batch_no
	and Trade_Type_Details != ''
), Split1 AS (		-- Split input strings per row into groups separated by ';'
    SELECT	Batch_No, Sno,
			value AS GroupStr
    FROM InputData
	cross apply STRING_SPLIT(Trade_Type_Details, ';')
    WHERE value <> ''
), Split2 AS (		-- Split groups further by ',' into individual codes
    SELECT	Batch_No, Sno,
			TRIM(value) AS Code
    FROM Split1
    CROSS APPLY STRING_SPLIT(GroupStr, ',')
    WHERE TRIM(value) <> ''
), Parts AS (	-- Parse code into Brand, Type, Stg, SubType
    SELECT	Batch_No, Sno, Code,
        -- LEFT(Code, CHARINDEX('-', Code) - 1) AS Brand,
		PARSENAME(REPLACE(Code, '-', '.'), 4) AS Brand,
        PARSENAME(REPLACE(Code, '-', '.'), 3) AS Type,
        PARSENAME(REPLACE(Code, '-', '.'), 2) AS Stg,
        PARSENAME(REPLACE(Code, '-', '.'), 1) AS SubType
    FROM Split2
), DistinctParts AS (		-- Remove duplicate Brand-Type-Stg-SubType combinations per Id
    SELECT DISTINCT Batch_No, Sno, Brand, Type, Stg, SubType
    FROM Parts
), Grouped AS (		-- Aggregate subtypes, ordered and distinct, per Brand-Type-Stg for each Id
    SELECT	Batch_No, Sno, Brand, Type, Stg,
        STRING_AGG(SubType, ',') WITHIN GROUP (
            ORDER BY 
                CASE SubType 
					WHEN 'Y' THEN 1 WHEN 'Q' THEN 2 WHEN 'M' THEN 3 WHEN 'W' THEN 4
					WHEN 'D' THEN 5 WHEN '4H' THEN 6 WHEN '1H' THEN 7 WHEN '15' THEN 8 ELSE 100 end
        ) AS SubTypes
    FROM DistinctParts
    GROUP BY Batch_No, Sno, Brand, Type, Stg
), BrandOrderFix AS (		-- Assign ordering for brand and type to control output order
    SELECT	Batch_No, Sno, Brand, Type, Stg, SubTypes,
        CASE Brand WHEN 'Bu' THEN 1 WHEN 'Be' THEN 2 ELSE 99 end AS BrandOrder,
        CASE WHEN Type='Tri' THEN 1 WHEN Type='Dbl' THEN 2 WHEN Type='Sgl' THEN 3 ELSE 99 end AS TypeOrder
    FROM Grouped
), SectionNumbered AS (		-- Number sections to know which is first for the brand and hence add prefix
    SELECT	Batch_No, Sno, Brand, BrandOrder, Type, TypeOrder, Stg, SubTypes,
			ROW_NUMBER() OVER (PARTITION BY Batch_No, Sno, Brand ORDER BY TypeOrder) AS SeqInBrand
    FROM BrandOrderFix
), SectionPrep AS (
    SELECT Batch_No, Sno, Brand, BrandOrder, TypeOrder, SeqInBrand,
        CASE WHEN SeqInBrand = 1 THEN CONCAT(Brand,'-',Type,'-',Stg,'-',SubTypes)
             ELSE CONCAT(Type,'-',Stg,'-',SubTypes)
        end AS SectionStr
    FROM SectionNumbered
), BrandAggregate AS (		-- Aggregate segments per brand per Id
    SELECT Batch_No, Sno, Brand, BrandOrder,
        STRING_AGG(SectionStr, ';') WITHIN GROUP (ORDER BY BrandOrder,TypeOrder) AS BrandSection
    FROM SectionPrep
    GROUP BY Batch_No, Sno, Brand, BrandOrder
),Final as (		-- Aggregate full output per Id joining brands with ';;', ordered by BrandOrder (Bu then Be)
SELECT Batch_No, Sno,
	STRING_AGG(BrandSection, ';;') WITHIN GROUP (ORDER BY BrandOrder,BrandSection) AS transformed_Trade_Type_Details
FROM BrandAggregate
group by Batch_No, Sno
) -- select * from Final
update a set trade_type_details = transformed_Trade_Type_Details
from dbo.Analyse_Stocks a inner join Final b on a.Batch_No = b.Batch_No and a.Sno = b.Sno;
end

begin
-- update a set Description = REPLACE(Description,'Swg-','Swg-Corr-')
select * from Master_Screen_Name_Values a where Batch_No = 4 
-- and Screen_Names like '%Correction%' and Description not like '%Corr%'
order by sno
end
begin
declare @ScreenNames nvarchar(max),@updatequery nvarchar(max)
SELECT @ScreenNames = STRING_AGG(CAST((Screen_Names + ' = b.'+ Screen_Names + CHAR(13) + CHAR(10)) AS NVarchar(MAX)), ',')  WITHIN GROUP (ORDER BY Sno)
from dbo.Master_Screen_Name_Values where Batch_No = 4 -- @batch_num;
select @ScreenNames
select * from dbo.Master_Screen_Name_Values where Batch_No = 4 -- @batch_num;
end
begin
select * from [dbo].[Cash_Stocks]
where Batch_No = (select max(batch_no) from Cash_Stocks)
and Indicator like '%double%'
;
select * from Analyse_Stocks_v;

EXEC sp_rename 'Analyse_15Minutes_Stocks.Volume_Shockers', 'Other_Setups';
EXEC sp_rename 'Analyse_Stocks.Volume_Shockers', 'Other_Setups';
end



rollback transaction
