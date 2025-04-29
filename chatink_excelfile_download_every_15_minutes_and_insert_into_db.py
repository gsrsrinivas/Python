import sys
import time
from datetime import datetime
import pandas as pd
import requests
from bs4 import BeautifulSoup as Bs
import pyodbc
# pip install --upgrade pandas --target="C:\Program Files\Python312\Lib\site-packages"
# Start time
start_time = time.time()
# Start datetime
start_date = datetime.now()
start_date_formated = start_date.strftime('%Y-%m-%d')
print(f"Start date of script is: {start_date_formated} "
      f"and time is: {datetime.fromtimestamp(start_time).strftime("%H:%M:%S")}")
# ######################################################################################################################
# Sample timestamps
morning_timestamp = "09:30:01"
evening_timestamp = "15:45:01"
current_timestamp = start_date.strftime("%H:%M:%S")

# Convert timestamps to datetime objects
dt1 = datetime.strptime(f"{start_date_formated} {morning_timestamp}", "%Y-%m-%d %H:%M:%S")
dt2 = datetime.strptime(f"{start_date_formated} {evening_timestamp}", "%Y-%m-%d %H:%M:%S")
dt3 = datetime.strptime(f"{start_date_formated} {current_timestamp}", "%Y-%m-%d %H:%M:%S")
# Calculate the difference
morning_time_difference = dt3 - dt1 # >0
evening_time_difference = dt3 - dt2 # <0

# Get the difference in hours and minutes
total_seconds_in_morning = morning_time_difference.total_seconds()
total_seconds_in_evening = evening_time_difference.total_seconds()

if total_seconds_in_morning > 0 > total_seconds_in_evening:
    print(f"Current Time: {current_timestamp} is within the trading Hours i.e., 9:30 am to 15:30 pm \nso continuing the script")
else:
    print(f"Current Time: {current_timestamp} is outside of the trading Hours i.e., 9:30 am to 15:30 pm \nso existing the script")
    time.sleep(5)
    sys.exit()
# ######################################################################################################################
# condition to download the stocks
# all_stocks = {'scan_clause': '( {segments_filter} ( latest close >= latest ema( latest close , 5 ) or latest close <= latest ema( latest close , 5 ) ) )'}
Macd_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}
Macd_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}
Macd_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}
Macd_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}
Macd_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}
Macd_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}
Macd_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}
Macd_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}

Stochastic_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}
Stochastic_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}

Ema_5_13_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}
Ema_5_13_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}
Ema_5_13_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}
Ema_5_13_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}
Ema_5_13_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}
Ema_5_13_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}
Ema_5_13_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}
Ema_5_13_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}

Ema_13_26_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}
Ema_13_26_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}
Ema_13_26_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}
Ema_13_26_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}
Ema_13_26_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}
Ema_13_26_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}
Ema_13_26_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}
Ema_13_26_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}

Ema_50_100_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}
Ema_50_100_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}
Ema_50_100_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}
Ema_50_100_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}
Ema_50_100_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}
Ema_50_100_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}
Ema_50_100_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}
Ema_50_100_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}

Ema_100_200_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}
Ema_100_200_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}
Ema_100_200_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}
Ema_100_200_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}
Ema_100_200_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}
Ema_100_200_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}
Ema_100_200_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}
Ema_100_200_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}

Rsi_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
Rsi_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
Rsi_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}
Rsi_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}
Rsi_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}
Rsi_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}
Rsi_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}
Rsi_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}

Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}
Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}

Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}
Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}

Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}
Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}

Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}
Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}

Volume_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
Volume_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}

Adx_Daily_Crosses_Above = {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}
Adx_Daily_Crosses_Below = {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}
Adx_4_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}
Adx_4_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}
Adx_1_Hourly_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}
Adx_1_Hourly_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}
Adx_15_Minutes_Crosses_Above = {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}
Adx_15_Minutes_Crosses_Below = {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}

Adx_Up_Tick_Daily_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}
Adx_Down_Tick_Daily_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}
Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}
Adx_Down_Tick_4_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}
Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}
Adx_Down_Tick_1_Hourly_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}
Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To  = {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}
Adx_Down_Tick_15_Minutes_Less_Than_Equal_To = {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}
data_list = [# all_stocks,
    Macd_Daily_Crosses_Above,
    Macd_4_Hourly_Crosses_Above,
    Macd_1_Hourly_Crosses_Above,
    Macd_15_Minutes_Crosses_Above,

    Macd_Daily_Crosses_Below,
    Macd_4_Hourly_Crosses_Below,
    Macd_1_Hourly_Crosses_Below,
    Macd_15_Minutes_Crosses_Below,

    Stochastic_Daily_Crosses_Above,
    Stochastic_4_Hourly_Crosses_Above,
    Stochastic_1_Hourly_Crosses_Above,
    Stochastic_15_Minutes_Crosses_Above,

    Stochastic_Daily_Crosses_Below,
    Stochastic_4_Hourly_Crosses_Below,
    Stochastic_1_Hourly_Crosses_Below,
    Stochastic_15_Minutes_Crosses_Below,

    Ema_5_13_Daily_Crosses_Above,
    Ema_5_13_4_Hourly_Crosses_Above,
    Ema_5_13_1_Hourly_Crosses_Above,
    Ema_5_13_15_Minutes_Crosses_Above,

    Ema_5_13_Daily_Crosses_Below,
    Ema_5_13_4_Hourly_Crosses_Below,
    Ema_5_13_1_Hourly_Crosses_Below,
    Ema_5_13_15_Minutes_Crosses_Below,

    Ema_13_26_Daily_Crosses_Above,
    Ema_13_26_4_Hourly_Crosses_Above,
    Ema_13_26_1_Hourly_Crosses_Above,
    Ema_13_26_15_Minutes_Crosses_Above,

    Ema_13_26_Daily_Crosses_Below,
    Ema_13_26_4_Hourly_Crosses_Below,
    Ema_13_26_1_Hourly_Crosses_Below,
    Ema_13_26_15_Minutes_Crosses_Below,

    Ema_50_100_Daily_Crosses_Above,
    Ema_50_100_4_Hourly_Crosses_Above,
    Ema_50_100_1_Hourly_Crosses_Above,
    Ema_50_100_15_Minutes_Crosses_Above,

    Ema_50_100_Daily_Crosses_Below,
    Ema_50_100_4_Hourly_Crosses_Below,
    Ema_50_100_1_Hourly_Crosses_Below,
    Ema_50_100_15_Minutes_Crosses_Below,

    Ema_100_200_Daily_Crosses_Above,
    Ema_100_200_4_Hourly_Crosses_Above,
    Ema_100_200_1_Hourly_Crosses_Above,
    Ema_100_200_15_Minutes_Crosses_Above,

    Ema_100_200_Daily_Crosses_Below,
    Ema_100_200_4_Hourly_Crosses_Below,
    Ema_100_200_1_Hourly_Crosses_Below,
    Ema_100_200_15_Minutes_Crosses_Below,

    Adx_Daily_Crosses_Above,
    Adx_4_Hourly_Crosses_Above,
    Adx_1_Hourly_Crosses_Above,
    Adx_15_Minutes_Crosses_Above,

    Adx_Daily_Crosses_Below,
    Adx_4_Hourly_Crosses_Below,
    Adx_1_Hourly_Crosses_Below,
    Adx_15_Minutes_Crosses_Below,

    Rsi_Daily_Crosses_Above,
    Rsi_4_Hourly_Crosses_Above,
    Rsi_1_Hourly_Crosses_Above,
    Rsi_15_Minutes_Crosses_Above,

    Rsi_Daily_Crosses_Below,
    Rsi_4_Hourly_Crosses_Below,
    Rsi_1_Hourly_Crosses_Below,
    Rsi_15_Minutes_Crosses_Below,

    Upper_Bollinger_Band3_Daily_Greater_Than_Equal_To,
    Upper_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,
    Upper_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,
    Upper_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,

    Upper_Bollinger_Band3_Daily_Less_Than_Equal_To,
    Upper_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,
    Upper_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,
    Upper_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,

    Lower_Bollinger_Band3_Daily_Greater_Than_Equal_To,
    Lower_Bollinger_Band3_4_Hourly_Greater_Than_Equal_To,
    Lower_Bollinger_Band3_1_Hourly_Greater_Than_Equal_To,
    Lower_Bollinger_Band3_15_Minutes_Greater_Than_Equal_To,

    Lower_Bollinger_Band3_Daily_Less_Than_Equal_To,
    Lower_Bollinger_Band3_4_Hourly_Less_Than_Equal_To,
    Lower_Bollinger_Band3_1_Hourly_Less_Than_Equal_To,
    Lower_Bollinger_Band3_15_Minutes_Less_Than_Equal_To,

    Upper_Bollinger_Band2_Daily_Greater_Than_Equal_To,
    Upper_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,
    Upper_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,
    Upper_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,

    Upper_Bollinger_Band2_Daily_Less_Than_Equal_To,
    Upper_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,
    Upper_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,
    Upper_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,

    Lower_Bollinger_Band2_Daily_Greater_Than_Equal_To,
    Lower_Bollinger_Band2_4_Hourly_Greater_Than_Equal_To,
    Lower_Bollinger_Band2_1_Hourly_Greater_Than_Equal_To,
    Lower_Bollinger_Band2_15_Minutes_Greater_Than_Equal_To,

    Lower_Bollinger_Band2_Daily_Less_Than_Equal_To,
    Lower_Bollinger_Band2_4_Hourly_Less_Than_Equal_To,
    Lower_Bollinger_Band2_1_Hourly_Less_Than_Equal_To,
    Lower_Bollinger_Band2_15_Minutes_Less_Than_Equal_To,

    Volume_Daily_Greater_Than_Equal_To,
    Volume_4_Hourly_Greater_Than_Equal_To,
    Volume_1_Hourly_Greater_Than_Equal_To,
    Volume_15_Minutes_Greater_Than_Equal_To,

    Volume_Daily_Less_Than_Equal_To,
    Volume_4_Hourly_Less_Than_Equal_To,
    Volume_1_Hourly_Less_Than_Equal_To,
    Volume_15_Minutes_Less_Than_Equal_To,

    Adx_Up_Tick_Daily_Greater_Than_Equal_To,
    Adx_Up_Tick_4_Hourly_Greater_Than_Equal_To,
    Adx_Up_Tick_1_Hourly_Greater_Than_Equal_To,
    Adx_Up_Tick_15_Minutes_Greater_Than_Equal_To,

    Adx_Down_Tick_Daily_Less_Than_Equal_To,
    Adx_Down_Tick_4_Hourly_Less_Than_Equal_To,
    Adx_Down_Tick_1_Hourly_Less_Than_Equal_To,
    Adx_Down_Tick_15_Minutes_Less_Than_Equal_To,
]
tf_l = [ # 'all;time;any'
    'Macd;Daily;Crosses Above',
    'Macd;4 Hourly;Crosses Above',
    'Macd;1 Hourly;Crosses Above',
    'Macd;15 Minutes;Crosses Above',

    'Macd;Daily;Crosses Below',
    'Macd;4 Hourly;Crosses Below',
    'Macd;1 Hourly;Crosses Below',
    'Macd;15 Minutes;Crosses Below',

    'Stochastic;Daily;Crosses Above',
    'Stochastic;4 Hourly;Crosses Above',
    'Stochastic;1 Hourly;Crosses Above',
    'Stochastic;15 Minutes;Crosses Above',

    'Stochastic;Daily;Crosses Below',
    'Stochastic;4 Hourly;Crosses Below',
    'Stochastic;1 Hourly;Crosses Below',
    'Stochastic;15 Minutes;Crosses Below',

    'Ema 5 13;Daily;Crosses Above',
    'Ema 5 13;4 Hourly;Crosses Above',
    'Ema 5 13;1 Hourly;Crosses Above',
    'Ema 5 13;15 Minutes;Crosses Above',

    'Ema 5 13;Daily;Crosses Below',
    'Ema 5 13;4 Hourly;Crosses Below',
    'Ema 5 13;1 Hourly;Crosses Below',
    'Ema 5 13;15 Minutes;Crosses Below',

    'Ema 13 26;Daily;Crosses Above',
    'Ema 13 26;4 Hourly;Crosses Above',
    'Ema 13 26;1 Hourly;Crosses Above',
    'Ema 13 26;15 Minutes;Crosses Above',

    'Ema 13 26;Daily;Crosses Below',
    'Ema 13 26;4 Hourly;Crosses Below',
    'Ema 13 26;1 Hourly;Crosses Below',
    'Ema 13 26;15 Minutes;Crosses Below',

    'Ema 50 100;Daily;Crosses Above',
    'Ema 50 100;4 Hourly;Crosses Above',
    'Ema 50 100;1 Hourly;Crosses Above',
    'Ema 50 100;15 Minutes;Crosses Above',

    'Ema 50 100;Daily;Crosses Below',
    'Ema 50 100;4 Hourly;Crosses Below',
    'Ema 50 100;1 Hourly;Crosses Below',
    'Ema 50 100;15 Minutes;Crosses Below',

    'Ema 100 200;Daily;Crosses Above',
    'Ema 100 200;4 Hourly;Crosses Above',
    'Ema 100 200;1 Hourly;Crosses Above',
    'Ema 100 200;15 Minutes;Crosses Above',

    'Ema 100 200;Daily;Crosses Below',
    'Ema 100 200;4 Hourly;Crosses Below',
    'Ema 100 200;1 Hourly;Crosses Below',
    'Ema 100 200;15 Minutes;Crosses Below',

    'Adx;Daily;Crosses Above',
    'Adx;4 Hourly;Crosses Above',
    'Adx;1 Hourly;Crosses Above',
    'Adx;15 Minutes;Crosses Above',

    'Adx;Daily;Crosses Below',
    'Adx;4 Hourly;Crosses Below',
    'Adx;1 Hourly;Crosses Below',
    'Adx;15 Minutes;Crosses Below',

    'Rsi;Daily;Crosses Above',
    'Rsi;4 Hourly;Crosses Above',
    'Rsi;1 Hourly;Crosses Above',
    'Rsi;15 Minutes;Crosses Above',

    'Rsi;Daily;Crosses Below',
    'Rsi;4 Hourly;Crosses Below',
    'Rsi;1 Hourly;Crosses Below',
    'Rsi;15 Minutes;Crosses Below',

    'Upper Bollinger Band3;Daily;Greater Than Equal To',
    'Upper Bollinger Band3;4 Hourly;Greater Than Equal To',
    'Upper Bollinger Band3;1 Hourly;Greater Than Equal To',
    'Upper Bollinger Band3;15 Minutes;Greater Than Equal To',

    'Upper Bollinger Band3;Daily;Less Than Equal To',
    'Upper Bollinger Band3;4 Hourly;Less Than Equal To',
    'Upper Bollinger Band3;1 Hourly;Less Than Equal To',
    'Upper Bollinger Band3;15 Minutes;Less Than Equal To',

    'Lower Bollinger Band3;Daily;Greater Than Equal To',
    'Lower Bollinger Band3;4 Hourly;Greater Than Equal To',
    'Lower Bollinger Band3;1 Hourly;Greater Than Equal To',
    'Lower Bollinger Band3;15 Minutes;Greater Than Equal To',

    'Lower Bollinger Band3;Daily;Less Than Equal To',
    'Lower Bollinger Band3;4 Hourly;Less Than Equal To',
    'Lower Bollinger Band3;1 Hourly;Less Than Equal To',
    'Lower Bollinger Band3;15 Minutes;Less Than Equal To',

    'Upper Bollinger Band2;Daily;Greater Than Equal To',
    'Upper Bollinger Band2;4 Hourly;Greater Than Equal To',
    'Upper Bollinger Band2;1 Hourly;Greater Than Equal To',
    'Upper Bollinger Band2;15 Minutes;Greater Than Equal To',

    'Upper Bollinger Band2;Daily;Less Than Equal To',
    'Upper Bollinger Band2;4 Hourly;Less Than Equal To',
    'Upper Bollinger Band2;1 Hourly;Less Than Equal To',
    'Upper Bollinger Band2;15 Minutes;Less Than Equal To',

    'Lower Bollinger Band2;Daily;Greater Than Equal To',
    'Lower Bollinger Band2;4 Hourly;Greater Than Equal To',
    'Lower Bollinger Band2;1 Hourly;Greater Than Equal To',
    'Lower Bollinger Band2;15 Minutes;Greater Than Equal To',

    'Lower Bollinger Band2;Daily;Less Than Equal To',
    'Lower Bollinger Band2;4 Hourly;Less Than Equal To',
    'Lower Bollinger Band2;1 Hourly;Less Than Equal To',
    'Lower Bollinger Band2;15 Minutes;Less Than Equal To',

    'Volume;Daily;Greater Than Equal To',
    'Volume;4 Hourly;Greater Than Equal To',
    'Volume;1 Hourly;Greater Than Equal To',
    'Volume;15 Minutes;Greater Than Equal To',

    'Volume;Daily;Less Than Equal To',
    'Volume;4 Hourly;Less Than Equal To',
    'Volume;1 Hourly;Less Than Equal To',
    'Volume;15 Minutes;Less Than Equal To',

    'Adx Up Tick;Daily;Greater Than Equal To',
    'Adx Up Tick;4 Hourly;Greater Than Equal To',
    'Adx Up Tick;1 Hourly;Greater Than Equal To',
    'Adx Up Tick;15 Minutes;Greater Than Equal To',

    'Adx Down Tick;Daily;Less Than Equal To',
    'Adx Down Tick;4 Hourly;Less Than Equal To',
    'Adx Down Tick;1 Hourly;Less Than Equal To',
    'Adx Down Tick;15 Minutes;Less Than Equal To',
]
segments = {
    # 'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
            'Cash':'cash'
            }

for i, data_each_list in enumerate(data_list):
    # print(f"iteration {i}")
    # start - iterate through the segments for one single url
    old_str = 'segments_filter'
    for j, each_segment_list in enumerate(segments):
        # old_str = each_segment_list if j==0 else segments[j-1]
        new_str = segments[each_segment_list]
        for key, value in data_each_list.items():
            # if isinstance(value, str):  # Check if the value is a string
            data_each_list[key] = value.replace(old_str, new_str)
        old_str = new_str
    # end - iterate through the segments for one single url
        with requests.Session() as s:
            data = data_list[i]
            # r = s.get(url_list[i])
            r = s.get('https://chartink.com/screener/watch-list-stocks-5')
            soup = Bs(r.content, 'lxml')
            s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
            r = s.post('https://chartink.com/screener/process', data=data).json()
            df = pd.DataFrame(r['data'])
            # reorder columns
            if len(df) > 0:
                df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
                # print(f"{df}")
                # Rename columns
                df.rename(columns={'sr': 'sr#', 'name': 'stock name', 'nsecode': 'symbol', 'bsecode': 'Links', 'per_chg': '% Chg', 'close': 'price'}, inplace=True)
                # insert new column timeframe
                part1, part2, part3 = tf_l[i].split(';')
                df.insert(7, 'Indicator', part1, allow_duplicates=True)
                df.insert(8, 'TimeLine', part2, allow_duplicates=True)
                df.insert(9, 'Direction', part3, allow_duplicates=True)
                df.insert(10, 'Segment', each_segment_list, allow_duplicates=True)
                df.insert(11, 'Batch_No', start_date.strftime('%Y%m%d'), allow_duplicates=True)
                # print(df)
            if i == 0 and j==0:
                # df_all = df
                df_all = pd.DataFrame()
            df_all = pd.concat([df_all, df], ignore_index=True)
            # df.to_excel('C:/Users/gsrsr/Downloads/bullish-15-minutes-of-triple-screen.xlsx', index=False)
        print(f"complete '{tf_l[i]}' for {each_segment_list}")
print(f"\nDownloading data from the website is complete.")
# print(f"\nStarted writing to excel file\n")
df_all = df_all.fillna(0)
# write to Excel file
# df_all.to_excel('C:/Users/gsrsr/Downloads/ChartInk-Stocks.xlsx', index=False)
# print("Download to excel file complete")
# ######################################################################################################################
print(f'started inserting into the database table')
df_all = df_all.fillna(0)
# Define connection string to SQL Server with Windows Authentication
conn_str = ('DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=DESKTOP-EP99LTB;'
    'DATABASE=Stocks_Analysis;'
    'Trusted_Connection=yes;')
# Establish connection to SQL Server
conn = pyodbc.connect(conn_str)
cursor = conn.cursor()
print(f'connection is established')
# Define the insert statement
insert_query = '''INSERT INTO _sis.Cash_15Minutes_Stocks(sr#,[stock name],symbol,Links,[% Chg],price,volume,Indicator,TimeLine,Direction,Segment,Batch_No)
VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
# Iterate over the DataFrame and insert data into the SQL Server table
for index, row in df_all.iterrows():
    cursor.execute(insert_query, row['sr#'], row['stock name'], row['symbol'], row['Links'], row['% Chg'], row['price'], row['volume'],row['Indicator'], row['TimeLine'], row['Direction'], row['Segment'], row['Batch_No'])
    sys.stdout.write(f"\r{index} records inserted out of {df_all.shape[0]-1}")
    sys.stdout.flush()
print(f'\nCommiting the records in Cash_15Minutes_Stocks table')
# Commit the transaction
conn.commit()
# print(f'Closing the connections')
# Close the connection
# cursor.close()
# conn.close()
print('Data inserted successfully!')
# ######################################################################################################################
print(f'Analysing the inserted data and inserting into report table')
# Read SQL script file
script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/InsertScript_15Minutes.sql'
with open(script_file, 'r') as file:
    sql_script = file.read()
# Execute SQL script
print(f'start: executing the sql queries')
cursor.execute(sql_script)
print(f'end: executing the sql queries')
print(f'Commiting the records in Analyse_15Minutes_Stocks Table')
conn.commit()
# ######################################################################################################################
print(f'update the Analysis records in report table')
# Read SQL script file
script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/Update_Report_15Minutes_Queries.sql'
with open(script_file, 'r') as file:
    sql_script = file.read()
# Execute SQL script
cursor.execute(sql_script)
print(f'Commiting the records in Analyse_15Minutes_Stocks for reporting')
conn.commit()
# ######################################################################################################################
print(f'Closing the connections')
# Close the connection
cursor.close()
conn.close()
# ######################################################################################################################
# End time
end_time = time.time()
# End time
end_date = datetime.now()
end_date_formated = end_date.strftime('%Y-%m-%d')
# Elapsed time in seconds
elapsed_time = end_time - start_time
# Elapsed datetime
print(f"End date of script is: {end_date_formated} "
      f"and time is: {datetime.fromtimestamp(end_time).strftime("%H:%M:%S")}")
elapsed_datetime = end_date - start_date
print(f"Total time to complete in seconds: {elapsed_time}\nconverted to datetime format: {elapsed_datetime}\n")
time.sleep(15)
# ######################################################################################################################

