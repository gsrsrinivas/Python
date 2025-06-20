import sys
import time
from datetime import datetime

import pandas as pd
import pyodbc
import requests
from bs4 import BeautifulSoup as Bs


def chart_ink_excel_file_download_and_insert_into_db():
    # pip install --upgrade pandas --target="C:\Program Files\Python312\Lib\site-packages"
    # ##################################################################################################################
    # Start time
    start_time = time.time()
    # Start datetime
    start_date = datetime.now()
    start_date_formated = start_date.strftime('%Y-%m-%d')
    print(f"Start date of script is: {start_date_formated} "
          f"and time is: {datetime.fromtimestamp(start_time).strftime("%H:%M:%S")}")
    # ##################################################################################################################
    # Sample timestamps
    morning_timestamp = "07:29:58"
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
        print(f"Current Time: {current_timestamp} is within the trading Hours i.e., 7:30 am to 15:30 pm "
              f"so continuing the program")
    else:
        print(f"Current Time: {current_timestamp} is outside of trading Hours i.e., 7:30 am to 15:30 pm "
              f"so existing the program")
        time.sleep(15)
        sys.exit()
    # ##################################################################################################################
    # condition to download the stocks
    # all_stocks = {'scan_clause': '( {segments_filter} ( latest close >= 0 ) )'}
    macd_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) >= yearly macd signal( 26 , 12 , 9 ) ) )'}
    macd_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) <= yearly macd signal( 26 , 12 , 9 ) ) )'}
    macd_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) >= quarterly macd signal( 26 , 12 , 9 ) ) )'}
    macd_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) <= quarterly macd signal( 26 , 12 , 9 ) ) )'}
    macd_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) ) )'}
    macd_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) <= monthly macd signal( 26 , 12 , 9 ) ) )'}
    macd_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) ) )'}
    macd_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) <= weekly macd signal( 26 , 12 , 9 ) ) )'}
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
    # ##################################################################################################################
    stochastic_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) >= yearly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) <= yearly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) >= quarterly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) <= quarterly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) <= monthly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) ) )'}
    stochastic_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) <= weekly slow stochastic %d( 14 , 3 ) ) )'}
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
    # ##################################################################################################################
    ema_5_13_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) >= yearly ema( yearly close , 13 ) ) )'}
    ema_5_13_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) <= yearly ema( yearly close , 13 ) ) )'}
    ema_5_13_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) >= quarterly ema( quarterly close , 13 ) ) )'}
    ema_5_13_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) <= quarterly ema( quarterly close , 13 ) ) )'}
    ema_5_13_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) ) )'}
    ema_5_13_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) <= monthly ema( monthly close , 13 ) ) )'}
    ema_5_13_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) ) )'}
    ema_5_13_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) <= weekly ema( weekly close , 13 ) ) )'}
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
    # ##################################################################################################################
    ema_13_26_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) >= yearly ema( yearly close , 26 ) ) )'}
    ema_13_26_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) <= yearly ema( yearly close , 26 ) ) )'}
    ema_13_26_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) >= quarterly ema( quarterly close , 26 ) ) )'}
    ema_13_26_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) <= quarterly ema( quarterly close , 26 ) ) )'}
    ema_13_26_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) ) )'}
    ema_13_26_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) <= monthly ema( monthly close , 26 ) ) )'}
    ema_13_26_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) ) )'}
    ema_13_26_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) <= weekly ema( weekly close , 26 ) ) )'}
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
    # ##################################################################################################################
    ema_50_100_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) >= yearly ema( yearly close , 100 ) ) )'}
    ema_50_100_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) <= yearly ema( yearly close , 100 ) ) )'}
    ema_50_100_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) >= quarterly ema( quarterly close , 100 ) ) )'}
    ema_50_100_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) <= quarterly ema( quarterly close , 100 ) ) )'}
    ema_50_100_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) ) )'}
    ema_50_100_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) <= monthly ema( monthly close , 100 ) ) )'}
    ema_50_100_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) ) )'}
    ema_50_100_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) <= weekly ema( weekly close , 100 ) ) )'}
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
    # ##################################################################################################################
    ema_100_200_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) >= yearly ema( yearly close , 200 ) ) )'}
    ema_100_200_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) <= yearly ema( yearly close , 200 ) ) )'}
    ema_100_200_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) >= quarterly ema( quarterly close , 200 ) ) )'}
    ema_100_200_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) <= quarterly ema( quarterly close , 200 ) ) )'}
    ema_100_200_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) )'}
    ema_100_200_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) <= monthly ema( monthly close , 200 ) ) )'}
    ema_100_200_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) )'}
    ema_100_200_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) <= weekly ema( weekly close , 200 ) ) )'}
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
    # ##################################################################################################################
    rsi_yearly_crosses_above = {'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
    rsi_yearly_crosses_below = {'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
    rsi_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
    rsi_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
    rsi_monthly_crosses_above = {'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
    rsi_monthly_crosses_below = {'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
    rsi_weekly_crosses_above = {'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}
    rsi_weekly_crosses_below = {'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}
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
    # ##################################################################################################################
    upper_bollinger_band3_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) >= 1 year ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) <= 1 year ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) >= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) <= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) <= 1 month ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) ) )'}
    upper_bollinger_band3_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) <= 1 week ago upper bollinger band( 20 , 3 ) ) )'}
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
    # ##################################################################################################################
    lower_bollinger_band3_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) >= 1 year ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) <= 1 year ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) >= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) <= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) >= 1 month ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) >= 1 week ago lower bollinger band( 20 , 3 ) ) )'}
    lower_bollinger_band3_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) ) )'}
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
    # ##################################################################################################################
    upper_bollinger_band2_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) >= 1 year ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) <= 1 year ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) >= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) <= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) <= 1 month ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) ) )'}
    upper_bollinger_band2_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) <= 1 week ago upper bollinger band( 20 , 2 ) ) )'}
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
    # ##################################################################################################################
    lower_bollinger_band2_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) >= 1 year ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) <= 1 year ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) >= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) <= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) >= 1 month ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) >= 1 week ago lower bollinger band( 20 , 2 ) ) )'}
    lower_bollinger_band2_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) )'}
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
    # ##################################################################################################################
    volume_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly volume >= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly volume <= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly volume >= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly volume <= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly volume <= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
    volume_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly volume <= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}
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
    # ##################################################################################################################
    adx_yearly_crosses_above = {
        'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) >= yearly adx di negative( 14 ) ) )'}
    adx_yearly_crosses_below = {
        'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) <= yearly adx di negative( 14 ) ) )'}
    adx_quarterly_crosses_above = {
        'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) >= quarterly adx di negative( 14 ) ) )'}
    adx_quarterly_crosses_below = {
        'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) <= quarterly adx di negative( 14 ) ) )'}
    adx_monthly_crosses_above = {
        'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) ) )'}
    adx_monthly_crosses_below = {
        'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) <= monthly adx di negative( 14 ) ) )'}
    adx_weekly_crosses_above = {
        'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) ) )'}
    adx_weekly_crosses_below = {
        'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) <= weekly adx di negative( 14 ) ) )'}
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
    # ##################################################################################################################
    adx_up_tick_yearly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly adx( 14 ) >= 1 year ago adx( 14 ) ) )'}
    adx_down_tick_yearly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( yearly adx( 14 ) <= 1 year ago adx( 14 ) ) )'}
    adx_up_tick_quarterly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) >= 1 quarter ago adx( 14 ) ) )'}
    adx_down_tick_quarterly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) <= 1 quarter ago adx( 14 ) ) )'}
    adx_up_tick_monthly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly adx( 14 ) >= 1 month ago adx( 14 ) ) )'}
    adx_down_tick_monthly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( monthly adx( 14 ) <= 1 month ago adx( 14 ) ) )'}
    adx_up_tick_weekly_greater_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly adx( 14 ) >= 1 week ago adx( 14 ) ) )'}
    adx_down_tick_weekly_less_than_equal_to = {
        'scan_clause': '( {segments_filter} ( weekly adx( 14 ) <= 1 week ago adx( 14 ) ) )'}
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

    data_list = [
        # all_stocks,
        macd_yearly_crosses_above, macd_yearly_crosses_below, macd_quarterly_crosses_above,
        macd_quarterly_crosses_below, macd_monthly_crosses_above, macd_monthly_crosses_below, macd_daily_crosses_above,
        macd_daily_crosses_below, macd_weekly_crosses_above, macd_weekly_crosses_below, macd_4_hourly_crosses_above,
        macd_4_hourly_crosses_below, macd_1_hourly_crosses_above, macd_1_hourly_crosses_below,
        macd_15_minutes_crosses_above, macd_15_minutes_crosses_below, stochastic_yearly_crosses_above,
        stochastic_yearly_crosses_below, stochastic_quarterly_crosses_above, stochastic_quarterly_crosses_below,
        stochastic_monthly_crosses_above, stochastic_monthly_crosses_below, stochastic_daily_crosses_above,
        stochastic_daily_crosses_below, stochastic_weekly_crosses_above, stochastic_weekly_crosses_below,
        stochastic_4_hourly_crosses_above, stochastic_4_hourly_crosses_below, stochastic_1_hourly_crosses_above,
        stochastic_1_hourly_crosses_below, stochastic_15_minutes_crosses_above, stochastic_15_minutes_crosses_below,
        ema_5_13_yearly_crosses_above, ema_5_13_yearly_crosses_below, ema_5_13_quarterly_crosses_above,
        ema_5_13_quarterly_crosses_below, ema_5_13_monthly_crosses_above, ema_5_13_monthly_crosses_below,
        ema_5_13_daily_crosses_above, ema_5_13_daily_crosses_below, ema_5_13_weekly_crosses_above,
        ema_5_13_weekly_crosses_below, ema_5_13_4_hourly_crosses_above, ema_5_13_4_hourly_crosses_below,
        ema_5_13_1_hourly_crosses_above, ema_5_13_1_hourly_crosses_below, ema_5_13_15_minutes_crosses_above,
        ema_5_13_15_minutes_crosses_below, ema_13_26_yearly_crosses_above, ema_13_26_yearly_crosses_below,
        ema_13_26_quarterly_crosses_above, ema_13_26_quarterly_crosses_below, ema_13_26_monthly_crosses_above,
        ema_13_26_monthly_crosses_below, ema_13_26_daily_crosses_above, ema_13_26_daily_crosses_below,
        ema_13_26_weekly_crosses_above, ema_13_26_weekly_crosses_below, ema_13_26_4_hourly_crosses_above,
        ema_13_26_4_hourly_crosses_below, ema_13_26_1_hourly_crosses_above, ema_13_26_1_hourly_crosses_below,
        ema_13_26_15_minutes_crosses_above, ema_13_26_15_minutes_crosses_below, ema_50_100_yearly_crosses_above,
        ema_50_100_yearly_crosses_below, ema_50_100_quarterly_crosses_above, ema_50_100_quarterly_crosses_below,
        ema_50_100_monthly_crosses_above, ema_50_100_monthly_crosses_below, ema_50_100_daily_crosses_above,
        ema_50_100_daily_crosses_below, ema_50_100_weekly_crosses_above, ema_50_100_weekly_crosses_below,
        ema_50_100_4_hourly_crosses_above, ema_50_100_4_hourly_crosses_below, ema_50_100_1_hourly_crosses_above,
        ema_50_100_1_hourly_crosses_below, ema_50_100_15_minutes_crosses_above, ema_50_100_15_minutes_crosses_below,
        ema_100_200_yearly_crosses_above, ema_100_200_yearly_crosses_below, ema_100_200_quarterly_crosses_above,
        ema_100_200_quarterly_crosses_below, ema_100_200_monthly_crosses_above, ema_100_200_monthly_crosses_below,
        ema_100_200_daily_crosses_above, ema_100_200_daily_crosses_below, ema_100_200_weekly_crosses_above,
        ema_100_200_weekly_crosses_below, ema_100_200_4_hourly_crosses_above, ema_100_200_4_hourly_crosses_below,
        ema_100_200_1_hourly_crosses_above, ema_100_200_1_hourly_crosses_below, ema_100_200_15_minutes_crosses_above,
        ema_100_200_15_minutes_crosses_below, adx_yearly_crosses_above, adx_yearly_crosses_below,
        adx_quarterly_crosses_above, adx_quarterly_crosses_below, adx_monthly_crosses_above, adx_monthly_crosses_below,
        adx_daily_crosses_above, adx_daily_crosses_below, adx_weekly_crosses_above, adx_weekly_crosses_below,
        adx_4_hourly_crosses_above, adx_4_hourly_crosses_below, adx_1_hourly_crosses_above, adx_1_hourly_crosses_below,
        adx_15_minutes_crosses_above, adx_15_minutes_crosses_below, rsi_yearly_crosses_above, rsi_yearly_crosses_below,
        rsi_quarterly_crosses_above, rsi_quarterly_crosses_below, rsi_monthly_crosses_above, rsi_monthly_crosses_below,
        rsi_daily_crosses_above, rsi_daily_crosses_below, rsi_weekly_crosses_above, rsi_weekly_crosses_below,
        rsi_4_hourly_crosses_above, rsi_4_hourly_crosses_below, rsi_1_hourly_crosses_above, rsi_1_hourly_crosses_below,
        rsi_15_minutes_crosses_above, rsi_15_minutes_crosses_below, upper_bollinger_band3_yearly_greater_than_equal_to,
        upper_bollinger_band3_yearly_less_than_equal_to, upper_bollinger_band3_quarterly_greater_than_equal_to,
        upper_bollinger_band3_quarterly_less_than_equal_to, upper_bollinger_band3_monthly_greater_than_equal_to,
        upper_bollinger_band3_monthly_less_than_equal_to, upper_bollinger_band3_daily_greater_than_equal_to,
        upper_bollinger_band3_daily_less_than_equal_to, upper_bollinger_band3_weekly_greater_than_equal_to,
        upper_bollinger_band3_weekly_less_than_equal_to, upper_bollinger_band3_4_hourly_greater_than_equal_to,
        upper_bollinger_band3_4_hourly_less_than_equal_to, upper_bollinger_band3_1_hourly_greater_than_equal_to,
        upper_bollinger_band3_1_hourly_less_than_equal_to, upper_bollinger_band3_15_minutes_greater_than_equal_to,
        upper_bollinger_band3_15_minutes_less_than_equal_to, lower_bollinger_band3_yearly_greater_than_equal_to,
        lower_bollinger_band3_yearly_less_than_equal_to, lower_bollinger_band3_quarterly_greater_than_equal_to,
        lower_bollinger_band3_quarterly_less_than_equal_to, lower_bollinger_band3_monthly_greater_than_equal_to,
        lower_bollinger_band3_monthly_less_than_equal_to, lower_bollinger_band3_daily_greater_than_equal_to,
        lower_bollinger_band3_daily_less_than_equal_to, lower_bollinger_band3_weekly_greater_than_equal_to,
        lower_bollinger_band3_weekly_less_than_equal_to, lower_bollinger_band3_4_hourly_greater_than_equal_to,
        lower_bollinger_band3_4_hourly_less_than_equal_to, lower_bollinger_band3_1_hourly_greater_than_equal_to,
        lower_bollinger_band3_1_hourly_less_than_equal_to, lower_bollinger_band3_15_minutes_greater_than_equal_to,
        lower_bollinger_band3_15_minutes_less_than_equal_to, upper_bollinger_band2_yearly_greater_than_equal_to,
        upper_bollinger_band2_yearly_less_than_equal_to, upper_bollinger_band2_quarterly_greater_than_equal_to,
        upper_bollinger_band2_quarterly_less_than_equal_to, upper_bollinger_band2_monthly_greater_than_equal_to,
        upper_bollinger_band2_monthly_less_than_equal_to, upper_bollinger_band2_daily_greater_than_equal_to,
        upper_bollinger_band2_daily_less_than_equal_to, upper_bollinger_band2_weekly_greater_than_equal_to,
        upper_bollinger_band2_weekly_less_than_equal_to, upper_bollinger_band2_4_hourly_greater_than_equal_to,
        upper_bollinger_band2_4_hourly_less_than_equal_to, upper_bollinger_band2_1_hourly_greater_than_equal_to,
        upper_bollinger_band2_1_hourly_less_than_equal_to, upper_bollinger_band2_15_minutes_greater_than_equal_to,
        upper_bollinger_band2_15_minutes_less_than_equal_to, lower_bollinger_band2_yearly_greater_than_equal_to,
        lower_bollinger_band2_yearly_less_than_equal_to, lower_bollinger_band2_quarterly_greater_than_equal_to,
        lower_bollinger_band2_quarterly_less_than_equal_to, lower_bollinger_band2_monthly_greater_than_equal_to,
        lower_bollinger_band2_monthly_less_than_equal_to, lower_bollinger_band2_daily_greater_than_equal_to,
        lower_bollinger_band2_daily_less_than_equal_to, lower_bollinger_band2_weekly_greater_than_equal_to,
        lower_bollinger_band2_weekly_less_than_equal_to, lower_bollinger_band2_4_hourly_greater_than_equal_to,
        lower_bollinger_band2_4_hourly_less_than_equal_to, lower_bollinger_band2_1_hourly_greater_than_equal_to,
        lower_bollinger_band2_1_hourly_less_than_equal_to, lower_bollinger_band2_15_minutes_greater_than_equal_to,
        lower_bollinger_band2_15_minutes_less_than_equal_to, volume_yearly_greater_than_equal_to,
        volume_yearly_less_than_equal_to, volume_quarterly_greater_than_equal_to, volume_quarterly_less_than_equal_to,
        volume_monthly_greater_than_equal_to, volume_monthly_less_than_equal_to, volume_daily_greater_than_equal_to,
        volume_daily_less_than_equal_to, volume_weekly_greater_than_equal_to, volume_weekly_less_than_equal_to,
        volume_4_hourly_greater_than_equal_to, volume_4_hourly_less_than_equal_to,
        volume_1_hourly_greater_than_equal_to, volume_1_hourly_less_than_equal_to,
        volume_15_minutes_greater_than_equal_to, volume_15_minutes_less_than_equal_to,
        adx_up_tick_yearly_greater_than_equal_to, adx_down_tick_yearly_less_than_equal_to,
        adx_up_tick_quarterly_greater_than_equal_to, adx_down_tick_quarterly_less_than_equal_to,
        adx_up_tick_monthly_greater_than_equal_to, adx_down_tick_monthly_less_than_equal_to,
        adx_up_tick_daily_greater_than_equal_to, adx_down_tick_daily_less_than_equal_to,
        adx_up_tick_weekly_greater_than_equal_to, adx_down_tick_weekly_less_than_equal_to,
        adx_up_tick_4_hourly_greater_than_equal_to, adx_down_tick_4_hourly_less_than_equal_to,
        adx_up_tick_1_hourly_greater_than_equal_to, adx_down_tick_1_hourly_less_than_equal_to,
        adx_up_tick_15_minutes_greater_than_equal_to, adx_down_tick_15_minutes_less_than_equal_to,
    ]
    tf_l = [
        # 'all;time;any'
        'Macd;yearly;crosses above', 'Macd;yearly;crosses below', 'Macd;quarterly;crosses above',
        'Macd;quarterly;crosses below', 'Macd;monthly;crosses above', 'Macd;monthly;crosses below',
        'Macd;daily;crosses above', 'Macd;daily;crosses below', 'Macd;weekly;crosses above',
        'Macd;weekly;crosses below', 'Macd;4 hourly;crosses above', 'Macd;4 hourly;crosses below',
        'Macd;1 hourly;crosses above', 'Macd;1 hourly;crosses below', 'Macd;15 minutes;crosses above',
        'Macd;15 minutes;crosses below', 'stochastic;yearly;crosses above', 'stochastic;yearly;crosses below',
        'stochastic;quarterly;crosses above', 'stochastic;quarterly;crosses below', 'stochastic;monthly;crosses above',
        'stochastic;monthly;crosses below', 'stochastic;daily;crosses above', 'stochastic;daily;crosses below',
        'stochastic;weekly;crosses above', 'stochastic;weekly;crosses below', 'stochastic;4 hourly;crosses above',
        'stochastic;4 hourly;crosses below', 'stochastic;1 hourly;crosses above', 'stochastic;1 hourly;crosses below',
        'stochastic;15 minutes;crosses above', 'stochastic;15 minutes;crosses below', 'ema 5 13;yearly;crosses above',
        'ema 5 13;yearly;crosses below', 'ema 5 13;quarterly;crosses above', 'ema 5 13;quarterly;crosses below',
        'ema 5 13;monthly;crosses above', 'ema 5 13;monthly;crosses below', 'ema 5 13;daily;crosses above',
        'ema 5 13;daily;crosses below', 'ema 5 13;weekly;crosses above', 'ema 5 13;weekly;crosses below',
        'ema 5 13;4 hourly;crosses above', 'ema 5 13;4 hourly;crosses below', 'ema 5 13;1 hourly;crosses above',
        'ema 5 13;1 hourly;crosses below', 'ema 5 13;15 minutes;crosses above', 'ema 5 13;15 minutes;crosses below',
        'ema 13 26;yearly;crosses above', 'ema 13 26;yearly;crosses below', 'ema 13 26;quarterly;crosses above',
        'ema 13 26;quarterly;crosses below', 'ema 13 26;monthly;crosses above', 'ema 13 26;monthly;crosses below',
        'ema 13 26;daily;crosses above', 'ema 13 26;daily;crosses below', 'ema 13 26;weekly;crosses above',
        'ema 13 26;weekly;crosses below', 'ema 13 26;4 hourly;crosses above', 'ema 13 26;4 hourly;crosses below',
        'ema 13 26;1 hourly;crosses above', 'ema 13 26;1 hourly;crosses below', 'ema 13 26;15 minutes;crosses above',
        'ema 13 26;15 minutes;crosses below', 'ema 50 100;yearly;crosses above', 'ema 50 100;yearly;crosses below',
        'ema 50 100;quarterly;crosses above', 'ema 50 100;quarterly;crosses below', 'ema 50 100;monthly;crosses above',
        'ema 50 100;monthly;crosses below', 'ema 50 100;daily;crosses above', 'ema 50 100;daily;crosses below',
        'ema 50 100;weekly;crosses above', 'ema 50 100;weekly;crosses below', 'ema 50 100;4 hourly;crosses above',
        'ema 50 100;4 hourly;crosses below', 'ema 50 100;1 hourly;crosses above', 'ema 50 100;1 hourly;crosses below',
        'ema 50 100;15 minutes;crosses above', 'ema 50 100;15 minutes;crosses below',
        'ema 100 200;yearly;crosses above', 'ema 100 200;yearly;crosses below', 'ema 100 200;quarterly;crosses above',
        'ema 100 200;quarterly;crosses below', 'ema 100 200;monthly;crosses above', 'ema 100 200;monthly;crosses below',
        'ema 100 200;daily;crosses above', 'ema 100 200;daily;crosses below', 'ema 100 200;weekly;crosses above',
        'ema 100 200;weekly;crosses below', 'ema 100 200;4 hourly;crosses above', 'ema 100 200;4 hourly;crosses below',
        'ema 100 200;1 hourly;crosses above', 'ema 100 200;1 hourly;crosses below',
        'ema 100 200;15 minutes;crosses above', 'ema 100 200;15 minutes;crosses below', 'adx;yearly;crosses above',
        'adx;yearly;crosses below', 'adx;quarterly;crosses above', 'adx;quarterly;crosses below',
        'adx;monthly;crosses above', 'adx;monthly;crosses below', 'adx;daily;crosses above', 'adx;daily;crosses below',
        'adx;weekly;crosses above', 'adx;weekly;crosses below', 'adx;4 hourly;crosses above',
        'adx;4 hourly;crosses below', 'adx;1 hourly;crosses above', 'adx;1 hourly;crosses below',
        'adx;15 minutes;crosses above', 'adx;15 minutes;crosses below', 'rsi;yearly;crosses above',
        'rsi;yearly;crosses below', 'rsi;quarterly;crosses above', 'rsi;quarterly;crosses below',
        'rsi;monthly;crosses above', 'rsi;monthly;crosses below', 'rsi;daily;crosses above', 'rsi;daily;crosses below',
        'rsi;weekly;crosses above', 'rsi;weekly;crosses below', 'rsi;4 hourly;crosses above',
        'rsi;4 hourly;crosses below', 'rsi;1 hourly;crosses above', 'rsi;1 hourly;crosses below',
        'rsi;15 minutes;crosses above', 'rsi;15 minutes;crosses below',
        'upper bollinger band3;yearly;greater than equal to ', 'upper bollinger band3;yearly;less than equal to',
        'upper bollinger band3;quarterly;greater than equal to ', 'upper bollinger band3;quarterly;less than equal to',
        'upper bollinger band3;monthly;greater than equal to ', 'upper bollinger band3;monthly;less than equal to',
        'upper bollinger band3;daily;greater than equal to ', 'upper bollinger band3;daily;less than equal to',
        'upper bollinger band3;weekly;greater than equal to ', 'upper bollinger band3;weekly;less than equal to',
        'upper bollinger band3;4 hourly;greater than equal to ', 'upper bollinger band3;4 hourly;less than equal to',
        'upper bollinger band3;1 hourly;greater than equal to ', 'upper bollinger band3;1 hourly;less than equal to',
        'upper bollinger band3;15 minutes;greater than equal to ',
        'upper bollinger band3;15 minutes;less than equal to', 'lower bollinger band3;yearly;greater than equal to ',
        'lower bollinger band3;yearly;less than equal to', 'lower bollinger band3;quarterly;greater than equal to ',
        'lower bollinger band3;quarterly;less than equal to', 'lower bollinger band3;monthly;greater than equal to ',
        'lower bollinger band3;monthly;less than equal to', 'lower bollinger band3;daily;greater than equal to ',
        'lower bollinger band3;daily;less than equal to', 'lower bollinger band3;weekly;greater than equal to ',
        'lower bollinger band3;weekly;less than equal to', 'lower bollinger band3;4 hourly;greater than equal to ',
        'lower bollinger band3;4 hourly;less than equal to', 'lower bollinger band3;1 hourly;greater than equal to ',
        'lower bollinger band3;1 hourly;less than equal to', 'lower bollinger band3;15 minutes;greater than equal to ',
        'lower bollinger band3;15 minutes;less than equal to', 'upper bollinger band2;yearly;greater than equal to ',
        'upper bollinger band2;yearly;less than equal to', 'upper bollinger band2;quarterly;greater than equal to ',
        'upper bollinger band2;quarterly;less than equal to', 'upper bollinger band2;monthly;greater than equal to ',
        'upper bollinger band2;monthly;less than equal to', 'upper bollinger band2;daily;greater than equal to ',
        'upper bollinger band2;daily;less than equal to', 'upper bollinger band2;weekly;greater than equal to ',
        'upper bollinger band2;weekly;less than equal to', 'upper bollinger band2;4 hourly;greater than equal to ',
        'upper bollinger band2;4 hourly;less than equal to', 'upper bollinger band2;1 hourly;greater than equal to ',
        'upper bollinger band2;1 hourly;less than equal to', 'upper bollinger band2;15 minutes;greater than equal to ',
        'upper bollinger band2;15 minutes;less than equal to', 'lower bollinger band2;yearly;greater than equal to ',
        'lower bollinger band2;yearly;less than equal to', 'lower bollinger band2;quarterly;greater than equal to ',
        'lower bollinger band2;quarterly;less than equal to', 'lower bollinger band2;monthly;greater than equal to ',
        'lower bollinger band2;monthly;less than equal to', 'lower bollinger band2;daily;greater than equal to ',
        'lower bollinger band2;daily;less than equal to', 'lower bollinger band2;weekly;greater than equal to ',
        'lower bollinger band2;weekly;less than equal to', 'lower bollinger band2;4 hourly;greater than equal to ',
        'lower bollinger band2;4 hourly;less than equal to', 'lower bollinger band2;1 hourly;greater than equal to ',
        'lower bollinger band2;1 hourly;less than equal to', 'lower bollinger band2;15 minutes;greater than equal to ',
        'lower bollinger band2;15 minutes;less than equal to', 'volume;yearly;greater than equal to ',
        'volume;yearly;less than equal to', 'volume;quarterly;greater than equal to ',
        'volume;quarterly;less than equal to', 'volume;monthly;greater than equal to ',
        'volume;monthly;less than equal to', 'volume;daily;greater than equal to ', 'volume;daily;less than equal to',
        'volume;weekly;greater than equal to ', 'volume;weekly;less than equal to',
        'volume;4 hourly;greater than equal to ', 'volume;4 hourly;less than equal to',
        'volume;1 hourly;greater than equal to ', 'volume;1 hourly;less than equal to',
        'volume;15 minutes;greater than equal to ', 'volume;15 minutes;less than equal to',
        'adx up tick;yearly;greater than equal to ', 'adx down tick;yearly;less than equal to',
        'adx up tick;quarterly;greater than equal to ', 'adx down tick;quarterly;less than equal to',
        'adx up tick;monthly;greater than equal to ', 'adx down tick;monthly;less than equal to',
        'adx up tick;daily;greater than equal to ', 'adx down tick;daily;less than equal to',
        'adx up tick;weekly;greater than equal to ', 'adx down tick;weekly;less than equal to',
        'adx up tick;4 hourly;greater than equal to ', 'adx down tick;4 hourly;less than equal to',
        'adx up tick;1 hourly;greater than equal to ', 'adx down tick;1 hourly;less than equal to',
        'adx up tick;15 minutes;greater than equal to ', 'adx down tick;15 minutes;less than equal to',
    ]
    segments = {'Cash': 'cash'
                # 'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
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
                    df.rename(columns={'sr': 'sr#', 'name': 'stock name', 'nsecode': 'symbol', 'bsecode': 'Links',
                                       'per_chg': '% Chg', 'close': 'price'}, inplace=True)
                    # insert new column timeframe
                    part1, part2, part3 = tf_l[i].split(';')
                    df.insert(7, 'Indicator', part1, allow_duplicates=True)
                    df.insert(8, 'TimeLine', part2, allow_duplicates=True)
                    df.insert(9, 'Direction', part3, allow_duplicates=True)
                    df.insert(10, 'Segment', each_segment_list, allow_duplicates=True)
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
    # ##################################################################################################################
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
    insert_query = '''INSERT INTO _sis.Cash_Stocks(sr#,[stock name],symbol,Links,[% Chg],price,volume,Indicator,TimeLine,Direction,Segment,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
    # Iterate over the DataFrame and insert data into the SQL Server table
    for index, row in df_all.iterrows():
        cursor.execute(insert_query, row['sr#'], row['stock name'], row['symbol'], row['Links'], row['% Chg'],
                       row['price'], row['volume'], row['Indicator'], row['TimeLine'], row['Direction'], row['Segment'],
                       row['Batch_No'])
        sys.stdout.write(f"\r{index} records inserted out of {df_all.shape[0] - 1}")
        sys.stdout.flush()
    print(f'\nCommiting the records in Cash_Stocks table')
    # Commit the transaction
    conn.commit()
    # print(f'Closing the connections')
    # Close the connection
    # cursor.close()
    # conn.close()
    print('Data inserted successfully!')
    # ##################################################################################################################
    print(f'Analysing the inserted data and inserting into report table')
    # Read SQL script file
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/InsertScript.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    print(f'start: executing the sql queries')
    cursor.execute(sql_script)
    print(f'end: executing the sql queries')
    print(f'Commiting the records in Analyse_Stocks')
    conn.commit()
    # ##################################################################################################################
    print(f'update the Analysis records in report table')
    # Read SQL script file
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/update_Report_Queries.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    cursor.execute(sql_script)
    print(f'Commiting the records in Analyse_Stocks for reporting')
    conn.commit()
    # ##################################################################################################################
    print(f'Closing the connections')
    # Close the connection
    cursor.close()
    conn.close()
    # ##################################################################################################################
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
    # ##################################################################################################################


if __name__ == "__main__":
    chart_ink_excel_file_download_and_insert_into_db()
