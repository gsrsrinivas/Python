import sys
import time
from datetime import datetime

import pandas as pd
import pyodbc
import requests
from bs4 import BeautifulSoup as Bs


def chat_ink_excel_file_download_every_15_minutes_and_insert_into_db():
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
    morning_time_difference = dt3 - dt1  # >0
    evening_time_difference = dt3 - dt2  # <0

    # Get the difference in hours and minutes
    total_seconds_in_morning = morning_time_difference.total_seconds()
    total_seconds_in_evening = evening_time_difference.total_seconds()

    if total_seconds_in_morning > 0 > total_seconds_in_evening:
        print(
            f"Current Time: {current_timestamp} is within the trading Hours i.e., 9:30 am to 15:30 pm \nso continuing the script")
    else:
        print(
            f"Current Time: {current_timestamp} is outside of the trading Hours i.e., 9:30 am to 15:30 pm \nso existing the script")
        time.sleep(5)
        sys.exit()
    # ######################################################################################################################
    # condition to download the stocks
    # all_stocks = {'scan_clause': '( {segments_filter} ( latest close >= latest ema( latest close , 5 ) or latest close <= latest ema( latest close , 5 ) ) )'}
    macd_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}
    macd_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}
    macd_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}
    macd_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}
    macd_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}
    macd_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}
    macd_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}
    macd_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}

    stochastic_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}

    ema_5_13_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}
    ema_5_13_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}
    ema_5_13_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}
    ema_5_13_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}
    ema_5_13_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}
    ema_5_13_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}
    ema_5_13_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}
    ema_5_13_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}

    ema_13_26_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}
    ema_13_26_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}
    ema_13_26_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}
    ema_13_26_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}
    ema_13_26_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}
    ema_13_26_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}
    ema_13_26_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}
    ema_13_26_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}

    ema_50_100_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}
    ema_50_100_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}
    ema_50_100_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}
    ema_50_100_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}
    ema_50_100_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}
    ema_50_100_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}
    ema_50_100_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}
    ema_50_100_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}

    ema_100_200_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}
    ema_100_200_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}
    ema_100_200_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}
    ema_100_200_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}
    ema_100_200_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}
    ema_100_200_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}
    ema_100_200_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}
    ema_100_200_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}

    rsi_daily_crosses_above = {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
    rsi_daily_crosses_below = {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
    rsi_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}
    rsi_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}
    rsi_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}
    rsi_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}
    rsi_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}
    rsi_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}

    upper_bollinger_band3_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}

    lower_bollinger_band3_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}

    upper_bollinger_band2_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}

    lower_bollinger_band2_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}

    volume_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}

    adx_daily_crosses_above = {
        'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}
    adx_daily_crosses_below = {
        'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}
    adx_4_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}
    adx_4_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}
    adx_1_hourly_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}
    adx_1_hourly_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}
    adx_15_minutes_crosses_above = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}
    adx_15_minutes_crosses_below = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}

    adx_up_tick_daily_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}
    adx_down_tick_daily_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}
    adx_up_tick_4_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}
    adx_down_tick_4_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}
    adx_up_tick_1_hourly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}
    adx_down_tick_1_hourly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}
    adx_up_tick_15_minutes_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}
    adx_down_tick_15_minutes_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}
    data_list = [  # all_stocks,
        macd_daily_crosses_above,
        macd_4_hourly_crosses_above,
        macd_1_hourly_crosses_above,
        macd_15_minutes_crosses_above,

        macd_daily_crosses_below,
        macd_4_hourly_crosses_below,
        macd_1_hourly_crosses_below,
        macd_15_minutes_crosses_below,

        stochastic_daily_crosses_above,
        stochastic_4_hourly_crosses_above,
        stochastic_1_hourly_crosses_above,
        stochastic_15_minutes_crosses_above,

        stochastic_daily_crosses_below,
        stochastic_4_hourly_crosses_below,
        stochastic_1_hourly_crosses_below,
        stochastic_15_minutes_crosses_below,

        ema_5_13_daily_crosses_above,
        ema_5_13_4_hourly_crosses_above,
        ema_5_13_1_hourly_crosses_above,
        ema_5_13_15_minutes_crosses_above,

        ema_5_13_daily_crosses_below,
        ema_5_13_4_hourly_crosses_below,
        ema_5_13_1_hourly_crosses_below,
        ema_5_13_15_minutes_crosses_below,

        ema_13_26_daily_crosses_above,
        ema_13_26_4_hourly_crosses_above,
        ema_13_26_1_hourly_crosses_above,
        ema_13_26_15_minutes_crosses_above,

        ema_13_26_daily_crosses_below,
        ema_13_26_4_hourly_crosses_below,
        ema_13_26_1_hourly_crosses_below,
        ema_13_26_15_minutes_crosses_below,

        ema_50_100_daily_crosses_above,
        ema_50_100_4_hourly_crosses_above,
        ema_50_100_1_hourly_crosses_above,
        ema_50_100_15_minutes_crosses_above,

        ema_50_100_daily_crosses_below,
        ema_50_100_4_hourly_crosses_below,
        ema_50_100_1_hourly_crosses_below,
        ema_50_100_15_minutes_crosses_below,

        ema_100_200_daily_crosses_above,
        ema_100_200_4_hourly_crosses_above,
        ema_100_200_1_hourly_crosses_above,
        ema_100_200_15_minutes_crosses_above,

        ema_100_200_daily_crosses_below,
        ema_100_200_4_hourly_crosses_below,
        ema_100_200_1_hourly_crosses_below,
        ema_100_200_15_minutes_crosses_below,

        adx_daily_crosses_above,
        adx_4_hourly_crosses_above,
        adx_1_hourly_crosses_above,
        adx_15_minutes_crosses_above,

        adx_daily_crosses_below,
        adx_4_hourly_crosses_below,
        adx_1_hourly_crosses_below,
        adx_15_minutes_crosses_below,

        rsi_daily_crosses_above,
        rsi_4_hourly_crosses_above,
        rsi_1_hourly_crosses_above,
        rsi_15_minutes_crosses_above,

        rsi_daily_crosses_below,
        rsi_4_hourly_crosses_below,
        rsi_1_hourly_crosses_below,
        rsi_15_minutes_crosses_below,

        upper_bollinger_band3_daily_greater_than_equal_to,
        upper_bollinger_band3_4_hourly_greater_than_equal_to,
        upper_bollinger_band3_1_hourly_greater_than_equal_to,
        upper_bollinger_band3_15_minutes_greater_than_equal_to,

        upper_bollinger_band3_daily_less_than_equal_to,
        upper_bollinger_band3_4_hourly_less_than_equal_to,
        upper_bollinger_band3_1_hourly_less_than_equal_to,
        upper_bollinger_band3_15_minutes_less_than_equal_to,

        lower_bollinger_band3_daily_greater_than_equal_to,
        lower_bollinger_band3_4_hourly_greater_than_equal_to,
        lower_bollinger_band3_1_hourly_greater_than_equal_to,
        lower_bollinger_band3_15_minutes_greater_than_equal_to,

        lower_bollinger_band3_daily_less_than_equal_to,
        lower_bollinger_band3_4_hourly_less_than_equal_to,
        lower_bollinger_band3_1_hourly_less_than_equal_to,
        lower_bollinger_band3_15_minutes_less_than_equal_to,

        upper_bollinger_band2_daily_greater_than_equal_to,
        upper_bollinger_band2_4_hourly_greater_than_equal_to,
        upper_bollinger_band2_1_hourly_greater_than_equal_to,
        upper_bollinger_band2_15_minutes_greater_than_equal_to,

        upper_bollinger_band2_daily_less_than_equal_to,
        upper_bollinger_band2_4_hourly_less_than_equal_to,
        upper_bollinger_band2_1_hourly_less_than_equal_to,
        upper_bollinger_band2_15_minutes_less_than_equal_to,

        lower_bollinger_band2_daily_greater_than_equal_to,
        lower_bollinger_band2_4_hourly_greater_than_equal_to,
        lower_bollinger_band2_1_hourly_greater_than_equal_to,
        lower_bollinger_band2_15_minutes_greater_than_equal_to,

        lower_bollinger_band2_daily_less_than_equal_to,
        lower_bollinger_band2_4_hourly_less_than_equal_to,
        lower_bollinger_band2_1_hourly_less_than_equal_to,
        lower_bollinger_band2_15_minutes_less_than_equal_to,

        volume_daily_greater_than_equal_to,
        volume_4_hourly_greater_than_equal_to,
        volume_1_hourly_greater_than_equal_to,
        volume_15_minutes_greater_than_equal_to,

        volume_daily_less_than_equal_to,
        volume_4_hourly_less_than_equal_to,
        volume_1_hourly_less_than_equal_to,
        volume_15_minutes_less_than_equal_to,

        adx_up_tick_daily_greater_than_equal_to,
        adx_up_tick_4_hourly_greater_than_equal_to,
        adx_up_tick_1_hourly_greater_than_equal_to,
        adx_up_tick_15_minutes_greater_than_equal_to,

        adx_down_tick_daily_less_than_equal_to,
        adx_down_tick_4_hourly_less_than_equal_to,
        adx_down_tick_1_hourly_less_than_equal_to,
        adx_down_tick_15_minutes_less_than_equal_to,
    ]
    tf_l = [  # 'all;time;any'
        'macd;daily;crosses above',
        'macd;4 hourly;crosses above',
        'macd;1 hourly;crosses above',
        'macd;15 minutes;crosses above',

        'macd;daily;crosses below',
        'macd;4 hourly;crosses below',
        'macd;1 hourly;crosses below',
        'macd;15 minutes;crosses below',

        'stochastic;daily;crosses above',
        'stochastic;4 hourly;crosses above',
        'stochastic;1 hourly;crosses above',
        'stochastic;15 minutes;crosses above',

        'stochastic;daily;crosses below',
        'stochastic;4 hourly;crosses below',
        'stochastic;1 hourly;crosses below',
        'stochastic;15 minutes;crosses below',

        'ema 5 13;daily;crosses above',
        'ema 5 13;4 hourly;crosses above',
        'ema 5 13;1 hourly;crosses above',
        'ema 5 13;15 minutes;crosses above',

        'ema 5 13;daily;crosses below',
        'ema 5 13;4 hourly;crosses below',
        'ema 5 13;1 hourly;crosses below',
        'ema 5 13;15 minutes;crosses below',

        'ema 13 26;daily;crosses above',
        'ema 13 26;4 hourly;crosses above',
        'ema 13 26;1 hourly;crosses above',
        'ema 13 26;15 minutes;crosses above',

        'ema 13 26;daily;crosses below',
        'ema 13 26;4 hourly;crosses below',
        'ema 13 26;1 hourly;crosses below',
        'ema 13 26;15 minutes;crosses below',

        'ema 50 100;daily;crosses above',
        'ema 50 100;4 hourly;crosses above',
        'ema 50 100;1 hourly;crosses above',
        'ema 50 100;15 minutes;crosses above',

        'ema 50 100;daily;crosses below',
        'ema 50 100;4 hourly;crosses below',
        'ema 50 100;1 hourly;crosses below',
        'ema 50 100;15 minutes;crosses below',

        'ema 100 200;daily;crosses above',
        'ema 100 200;4 hourly;crosses above',
        'ema 100 200;1 hourly;crosses above',
        'ema 100 200;15 minutes;crosses above',

        'ema 100 200;daily;crosses below',
        'ema 100 200;4 hourly;crosses below',
        'ema 100 200;1 hourly;crosses below',
        'ema 100 200;15 minutes;crosses below',

        'adx;daily;crosses above',
        'adx;4 hourly;crosses above',
        'adx;1 hourly;crosses above',
        'adx;15 minutes;crosses above',

        'adx;daily;crosses below',
        'adx;4 hourly;crosses below',
        'adx;1 hourly;crosses below',
        'adx;15 minutes;crosses below',

        'rsi;daily;crosses above',
        'rsi;4 hourly;crosses above',
        'rsi;1 hourly;crosses above',
        'rsi;15 minutes;crosses above',

        'rsi;daily;crosses below',
        'rsi;4 hourly;crosses below',
        'rsi;1 hourly;crosses below',
        'rsi;15 minutes;crosses below',

        'upper bollinger band3;daily;greater than equal to',
        'upper bollinger band3;4 hourly;greater than equal to',
        'upper bollinger band3;1 hourly;greater than equal to',
        'upper bollinger band3;15 minutes;greater than equal to',

        'upper bollinger band3;daily;less than equal to',
        'upper bollinger band3;4 hourly;less than equal to',
        'upper bollinger band3;1 hourly;less than equal to',
        'upper bollinger band3;15 minutes;less than equal to',

        'lower bollinger band3;daily;greater than equal to',
        'lower bollinger band3;4 hourly;greater than equal to',
        'lower bollinger band3;1 hourly;greater than equal to',
        'lower bollinger band3;15 minutes;greater than equal to',

        'lower bollinger band3;daily;less than equal to',
        'lower bollinger band3;4 hourly;less than equal to',
        'lower bollinger band3;1 hourly;less than equal to',
        'lower bollinger band3;15 minutes;less than equal to',

        'upper bollinger band2;daily;greater than equal to',
        'upper bollinger band2;4 hourly;greater than equal to',
        'upper bollinger band2;1 hourly;greater than equal to',
        'upper bollinger band2;15 minutes;greater than equal to',

        'upper bollinger band2;daily;less than equal to',
        'upper bollinger band2;4 hourly;less than equal to',
        'upper bollinger band2;1 hourly;less than equal to',
        'upper bollinger band2;15 minutes;less than equal to',

        'lower bollinger band2;daily;greater than equal to',
        'lower bollinger band2;4 hourly;greater than equal to',
        'lower bollinger band2;1 hourly;greater than equal to',
        'lower bollinger band2;15 minutes;greater than equal to',

        'lower bollinger band2;daily;less than equal to',
        'lower bollinger band2;4 hourly;less than equal to',
        'lower bollinger band2;1 hourly;less than equal to',
        'lower bollinger band2;15 minutes;less than equal to',

        'volume;daily;greater than equal to',
        'volume;4 hourly;greater than equal to',
        'volume;1 hourly;greater than equal to',
        'volume;15 minutes;greater than equal to',

        'volume;daily;less than equal to',
        'volume;4 hourly;less than equal to',
        'volume;1 hourly;less than equal to',
        'volume;15 minutes;less than equal to',

        'adx up tick;daily;greater than equal to',
        'adx up tick;4 hourly;greater than equal to',
        'adx up tick;1 hourly;greater than equal to',
        'adx up tick;15 minutes;greater than equal to',

        'adx down tick;daily;less than equal to',
        'adx down tick;4 hourly;less than equal to',
        'adx down tick;1 hourly;less than equal to',
        'adx down tick;15 minutes;less than equal to',
    ]
    segments = {
        # 'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
        'Cash': 'cash'
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
                    df.rename(columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol',
                                       'per_chg': 'percent_change', 'close': 'price'}, inplace=True)
                    # insert new column timeframe
                    part1, part2, part3 = tf_l[i].split(';')
                    df.insert(7, 'Indicator', part1, allow_duplicates=True)
                    df.insert(8, 'TimeLine', part2, allow_duplicates=True)
                    df.insert(9, 'Direction', part3, allow_duplicates=True)
                    df.insert(10, 'segments', each_segment_list, allow_duplicates=True)
                    df.insert(11, 'Batch_No', start_date.strftime('%Y%m%d'), allow_duplicates=True)
                    # print(df)
                if i == 0 and j == 0:
                    # df_all = df
                    df_all = pd.DataFrame()
                df_all = pd.concat([df_all, df], ignore_index=True)
                # df.to_excel('C:/Users/gsrsr/Output/bullish-15-minutes-of-triple-screen.xlsx', index=False)
            print(f"complete '{tf_l[i]}' for {each_segment_list}")
    print(f"\ndownloading data from the website is complete.")
    # print(f"\nStarted writing to excel file\n")
    df_all = df_all.fillna(0)
    # write to Excel file
    # df_all.to_excel('C:/Users/gsrsr/Output/ChartInk-Stocks.xlsx', index=False)
    # print("download to excel file complete")
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
    insert_query = '''INSERT INTO dbo.Cash_15minutes_Stocks(sno,[stock_name],symbol,bsecode,Percent_Change,price,volume,Indicator,TimeLine,Direction,segments,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
    # Iterate over the DataFrame and insert data into the SQL Server table
    for index, row in df_all.iterrows():
        cursor.execute(insert_query, row['sno'], row['stock_name'], row['symbol'], row['bsecode'], row['percent_change'],
                       row['price'], row['volume'], row['Indicator'], row['TimeLine'], row['Direction'], row['segments'],
                       row['Batch_No'])
        sys.stdout.write(f"\r{index} records inserted out of {df_all.shape[0] - 1}")
        sys.stdout.flush()
    print(f'\nCommiting the records in Cash_15minutes_Stocks table')
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
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/InsertScript_15minutes.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    print(f'start: executing the sql queries')
    cursor.execute(sql_script)
    print(f'end: executing the sql queries')
    print(f'Commiting the records in Analyse_15minutes_Stocks Table')
    conn.commit()
    # ######################################################################################################################
    print(f'update the Analysis records in report table')
    # Read SQL script file
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/update_Report_15minutes_Queries.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    cursor.execute(sql_script)
    print(f'Commiting the records in Analyse_15minutes_Stocks for reporting')
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
    print(f"total time to complete in seconds: {elapsed_time}\nconverted to datetime format: {elapsed_datetime}\n")
    time.sleep(15)
    # ######################################################################################################################


if __name__ == "__main__":
    chat_ink_excel_file_download_every_15_minutes_and_insert_into_db()
