import time
from datetime import datetime

import pandas as pd
import requests
from bs4 import BeautifulSoup as Bs


def chatink_excelfile_download():
    # pip install --upgrade pandas --target="C:\Program Files\Python312\Lib\site-packages"
    # script time calculation
    # Start time
    start_time = time.time()
    # Start datetime
    start_datetime = datetime.now()
    print(f"Start date of the script is: {start_datetime} and time is: {start_time}")
    # triple screen system
    data_15 = {
        'scan_clause': '( {cash} ( ( {cash} ( [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) and [0] 1 hour macd line( 26,12,9 ) >= [0] 1 hour macd signal( 26,12,9 ) and [0] 1 hour macd line( 26,12,9 ) >= [-1] 1 hour macd line( 26 , 12 , 9 ) and [0] 15 minute macd line( 26,12,9 ) >= [0] 15 minute macd signal( 26,12,9 ) and [0] 15 minute macd line( 26,12,9 ) >= [-1] 15 minute macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) and [0] 15 minute slow stochastic %k( 14 , 3 ) >= [-1] 15 minute slow stochastic %k( 14 , 3 ) ) ) or [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) ) and( {cash} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) and [0] 15 minute adx( 14 ) >= [-1] 15 minute adx( 14 ) ) ) and( {cash} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) and [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) ) and( {cash} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) and [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) and [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) and [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) ) ) )'}
    data_1 = {
        'scan_clause': '( {cash} ( ( {cash} ( latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) and [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) and [0] 1 hour macd line( 26,12,9 ) >= [0] 1 hour macd signal( 26,12,9 ) and [0] 1 hour macd line( 26,12,9 ) >= [-1] 1 hour macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) and [0] 1 hour slow stochastic %k( 14 , 3 ) >= [-1] 1 hour slow stochastic %k( 14 , 3 ) ) ) or [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) ) and( {cash} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) and [0] 1 hour adx( 14 ) >= [-1] 1 hour adx( 14 ) ) ) and( {cash} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) and [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) and [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) and [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) and [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) and [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) ) and( {cash} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [-1] 1 hour upper bollinger band( 20 , 3 ) and [0] 1 hour lower bollinger band( 20 , 3 ) <= [-1] 1 hour lower bollinger band( 20 , 3 ) and [0] 1 hour upper bollinger band( 20 , 2 ) >= [-1] 1 hour upper bollinger band( 20 , 2 ) and [0] 1 hour lower bollinger band( 20 , 2 ) <= [-1] 1 hour lower bollinger band( 20 , 2 ) ) ) ) )'}
    data_4 = {
        'scan_clause': '( {cash} ( ( {cash} ( weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) and latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) and [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) and [0] 4 hour slow stochastic %k( 14 , 3 ) >= [-1] 4 hour slow stochastic %k( 14 , 3 ) ) ) or [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) ) and( {cash} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) and [0] 4 hour adx( 14 ) >= [-1] 4 hour adx( 14 ) ) ) and( {cash} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) and [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) and [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) and [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) and [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) and [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) ) and( {cash} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [-1] 4 hour upper bollinger band( 20 , 3 ) and [0] 4 hour lower bollinger band( 20 , 3 ) <= [-1] 4 hour lower bollinger band( 20 , 3 ) and [0] 4 hour upper bollinger band( 20 , 2 ) >= [-1] 4 hour upper bollinger band( 20 , 2 ) and [0] 4 hour lower bollinger band( 20 , 2 ) <= [-1] 4 hour lower bollinger band( 20 , 2 ) ) ) ) )'}
    data_d = {
        'scan_clause': '( {cash} ( ( {cash} ( monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) and weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) and latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) and latest slow stochastic %k( 14 , 3 ) >= 1 day ago slow stochastic %k( 14 , 3 ) ) ) or latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) ) and( {cash} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) and latest adx( 14 ) >= 1 day ago adx( 14 ) ) ) and( {cash} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" and latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) and latest ema( latest close , 5 ) >= latest ema( latest close , 26 ) and latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) and latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) and latest ema( latest close , 50 ) >= latest ema( latest close , 200 ) and latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) ) and( {cash} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) and latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) and latest upper bollinger band( 20 , 2 ) > 1 day ago upper bollinger band( 20 , 2 ) and latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) ) ) )'}
    data_w = {
        'scan_clause': '( {cash} ( ( {cash} ( quarterly macd line( 26,12,9 ) >= quarterly macd signal( 26,12,9 ) and quarterly macd line( 26,12,9 ) >= 1 quarter ago macd line( 26 , 12 , 9 ) and monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) and weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) and weekly slow stochastic %k( 14 , 3 ) >= 1 week ago slow stochastic %k( 14 , 3 ) ) ) or weekly rsi( 14 ) >= 1 week ago rsi( 14 ) ) ) and( {cash} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) and weekly adx( 14 ) >= 1 week ago adx( 14 ) ) ) and( {cash} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" and weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) and weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 26 ) and weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) and weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) and weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 200 ) and weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) ) and( {cash} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) and weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) and weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) and weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) ) ) )'}
    data_m = {
        'scan_clause': '( {cash} ( ( {cash} ( yearly macd line( 26,12,9 ) >= yearly macd signal( 26,12,9 ) and yearly macd line( 26,12,9 ) >= 1 year ago macd line( 26 , 12 , 9 ) and quarterly macd line( 26,12,9 ) >= quarterly macd signal( 26,12,9 ) and quarterly macd line( 26,12,9 ) >= 1 quarter ago macd line( 26 , 12 , 9 ) and monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) and monthly slow stochastic %k( 14 , 3 ) >= 1 month ago slow stochastic %k( 14 , 3 ) ) ) or monthly rsi( 14 ) >= 1 month ago rsi( 14 ) ) ) and( {cash} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) and monthly adx( 14 ) >= 1 month ago adx( 14 ) ) ) and( {cash} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" and monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) and monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 26 ) and monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) and monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) and monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 200 ) and monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) ) and( {cash} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) and monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) and monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) and monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) ) ) )'}
    macd_hook_daily = {
        'scan_clause': '( {cash} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) and latest macd line( 26 , 12 , 9 ) - latest macd signal( 26 , 12 , 9 ) >= 0.01 and latest macd line( 26 , 12 , 9 ) - latest macd signal( 26 , 12 , 9 ) <= 2 and 1 day ago macd line( 26 , 12 , 9 ) - 1 day ago macd signal( 26 , 12 , 9 ) > 0.01 and 2 days ago macd line( 26 , 12 , 9 ) - 2 days ago macd signal( 26 , 12 , 9 ) > 0.01 and latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}
    macd_hook_weekly = {
        'scan_clause': '( {cash} ( weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) and weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) and weekly macd line( 26 , 12 , 9 ) - weekly macd signal( 26 , 12 , 9 ) >= 0.01 and weekly macd line( 26 , 12 , 9 ) - weekly macd signal( 26 , 12 , 9 ) <= 2 and 1 week ago macd line( 26 , 12 , 9 ) - 1 week ago macd signal( 26 , 12 , 9 ) > 0.01 and 2 weeks ago macd line( 26 , 12 , 9 ) - 2 weeks ago macd signal( 26 , 12 , 9 ) > 0.01 ) )'}
    macd_hook_monthly = {
        'scan_clause': '( {cash} ( monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) and monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) and monthly macd line( 26 , 12 , 9 ) - monthly macd signal( 26 , 12 , 9 ) >= 0.01 and monthly macd line( 26 , 12 , 9 ) - monthly macd signal( 26 , 12 , 9 ) <= 2 and 1 month ago macd line( 26 , 12 , 9 ) - 1 month ago macd signal( 26 , 12 , 9 ) > 0.01 and 2 months ago macd line( 26 , 12 , 9 ) - 2 months ago macd signal( 26 , 12 , 9 ) > 0.01 ) )'}
    # divergence 15 minutes
    div_15m02 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-2] 15 minute close and [-1] 15 minute rsi( 14 ) < [-2] 15 minute rsi( 14 ) and [-1] 15 minute close - [-2] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m03 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-3] 15 minute close and [-1] 15 minute rsi( 14 ) < [-3] 15 minute rsi( 14 ) and [-1] 15 minute close - [-3] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m04 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-4] 15 minute close and [-1] 15 minute rsi( 14 ) < [-4] 15 minute rsi( 14 ) and [-1] 15 minute close - [-4] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m05 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-5] 15 minute close and [-1] 15 minute rsi( 14 ) < [-5] 15 minute rsi( 14 ) and [-1] 15 minute close - [-5] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m06 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-6] 15 minute close and [-1] 15 minute rsi( 14 ) < [-6] 15 minute rsi( 14 ) and [-1] 15 minute close - [-6] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m07 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-7] 15 minute close and [-1] 15 minute rsi( 14 ) < [-7] 15 minute rsi( 14 ) and [-1] 15 minute close - [-7] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m08 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-8] 15 minute close and [-1] 15 minute rsi( 14 ) < [-8] 15 minute rsi( 14 ) and [-1] 15 minute close - [-8] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m09 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-9] 15 minute close and [-1] 15 minute rsi( 14 ) < [-9] 15 minute rsi( 14 ) and [-1] 15 minute close - [-9] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m10 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-10] 15 minute close and [-1] 15 minute rsi( 14 ) < [-10] 15 minute rsi( 14 ) and [-1] 15 minute close - [-10] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m11 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-11] 15 minute close and [-1] 15 minute rsi( 14 ) < [-11] 15 minute rsi( 14 ) and [-1] 15 minute close - [-11] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m12 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-12] 15 minute close and [-1] 15 minute rsi( 14 ) < [-12] 15 minute rsi( 14 ) and [-1] 15 minute close - [-12] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m13 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-13] 15 minute close and [-1] 15 minute rsi( 14 ) < [-13] 15 minute rsi( 14 ) and [-1] 15 minute close - [-13] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m14 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-14] 15 minute close and [-1] 15 minute rsi( 14 ) < [-14] 15 minute rsi( 14 ) and [-1] 15 minute close - [-14] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_15m15 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 15 minute close >= [-15] 15 minute close and [-1] 15 minute rsi( 14 ) < [-15] 15 minute rsi( 14 ) and [-1] 15 minute close - [-15] 15 minute close > [0] 15 minute close * 0.01 and [-1] 15 minute close > [-1] 15 minute open and [0] 15 minute close < [-1] 15 minute close and [0] 15 minute close < [0] 15 minute open and [0] 15 minute close * [0] 15 minute volume > 10000000 and( {cash} ( ( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute sma( close,20 ) * .50 and [0] 15 minute low > [0] 15 minute sma( close,20 ) ) ) or( {cash} ( [0] 15 minute high - [0] 15 minute low < [0] 15 minute low - [0] 15 minute lower bollinger band( 20,2 ) and [0] 15 minute close < [0] 15 minute sma( close,20 ) ) ) ) ) ) ) ) )'}
    # divergence Hourly
    div_h02 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-2] 1 hour close and [-1] 1 hour rsi( 14 ) < [-2] 1 hour rsi( 14 ) and [-1] 1 hour close - [-2] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h03 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-3] 1 hour close and [-1] 1 hour rsi( 14 ) < [-3] 1 hour rsi( 14 ) and [-1] 1 hour close - [-3] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h04 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-4] 1 hour close and [-1] 1 hour rsi( 14 ) < [-4] 1 hour rsi( 14 ) and [-1] 1 hour close - [-4] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h05 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-5] 1 hour close and [-1] 1 hour rsi( 14 ) < [-5] 1 hour rsi( 14 ) and [-1] 1 hour close - [-5] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h06 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-6] 1 hour close and [-1] 1 hour rsi( 14 ) < [-6] 1 hour rsi( 14 ) and [-1] 1 hour close - [-6] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h07 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-7] 1 hour close and [-1] 1 hour rsi( 14 ) < [-7] 1 hour rsi( 14 ) and [-1] 1 hour close - [-7] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h08 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-8] 1 hour close and [-1] 1 hour rsi( 14 ) < [-8] 1 hour rsi( 14 ) and [-1] 1 hour close - [-8] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h09 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-9] 1 hour close and [-1] 1 hour rsi( 14 ) < [-9] 1 hour rsi( 14 ) and [-1] 1 hour close - [-9] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h10 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-10] 1 hour close and [-1] 1 hour rsi( 14 ) < [-10] 1 hour rsi( 14 ) and [-1] 1 hour close - [-10] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h11 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-11] 1 hour close and [-1] 1 hour rsi( 14 ) < [-11] 1 hour rsi( 14 ) and [-1] 1 hour close - [-11] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h12 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-12] 1 hour close and [-1] 1 hour rsi( 14 ) < [-12] 1 hour rsi( 14 ) and [-1] 1 hour close - [-12] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h13 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-13] 1 hour close and [-1] 1 hour rsi( 14 ) < [-13] 1 hour rsi( 14 ) and [-1] 1 hour close - [-13] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h14 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-14] 1 hour close and [-1] 1 hour rsi( 14 ) < [-14] 1 hour rsi( 14 ) and [-1] 1 hour close - [-14] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_h15 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 1 hour close >= [-15] 1 hour close and [-1] 1 hour rsi( 14 ) < [-15] 1 hour rsi( 14 ) and [-1] 1 hour close - [-15] 1 hour close > [0] 1 hour close * 0.01 and [-1] 1 hour close > [-1] 1 hour open and [0] 1 hour close < [0] 1 hour open and [0] 1 hour close < [-1] 1 hour close and [0] 1 hour close * [0] 1 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour sma( close,20 ) * .50 and [0] 1 hour low > [0] 1 hour sma( close,20 ) ) ) or( {cash} ( [0] 1 hour high - [0] 1 hour low < [0] 1 hour low - [0] 1 hour lower bollinger band( 20,2 ) and [0] 1 hour close < [0] 1 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    # divergence 4 Hourly
    div_4h02 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-2] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-2] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-2] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h03 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-3] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-3] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-3] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h04 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-4] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-4] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-4] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h05 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-5] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-5] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-5] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h06 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-6] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-6] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-6] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h07 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-7] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-7] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-7] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h08 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-8] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-8] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-8] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h09 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >=  [-9] 4 hour close and [-1] 4 hour rsi( 14 ) <  [-9] 4 hour rsi( 14 ) and [-1] 4 hour close -  [-9] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h10 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-10] 4 hour close and [-1] 4 hour rsi( 14 ) < [-10] 4 hour rsi( 14 ) and [-1] 4 hour close - [-10] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h11 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-11] 4 hour close and [-1] 4 hour rsi( 14 ) < [-11] 4 hour rsi( 14 ) and [-1] 4 hour close - [-11] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h12 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-12] 4 hour close and [-1] 4 hour rsi( 14 ) < [-12] 4 hour rsi( 14 ) and [-1] 4 hour close - [-12] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h13 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-13] 4 hour close and [-1] 4 hour rsi( 14 ) < [-13] 4 hour rsi( 14 ) and [-1] 4 hour close - [-13] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h14 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-14] 4 hour close and [-1] 4 hour rsi( 14 ) < [-14] 4 hour rsi( 14 ) and [-1] 4 hour close - [-14] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_4h15 = {
        'scan_clause': '( {cash} ( ( {cash} ( [-1] 4 hour close >= [-15] 4 hour close and [-1] 4 hour rsi( 14 ) < [-15] 4 hour rsi( 14 ) and [-1] 4 hour close - [-15] 4 hour close > [0] 4 hour close * 0.01 and [-1] 4 hour close > [-1] 4 hour open and [0] 4 hour close < [-1] 4 hour close and [0] 4 hour close < [0] 4 hour open and [0] 4 hour close * [0] 4 hour volume > 10000000 and( {cash} ( ( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour sma( close,20 ) * .50 and [0] 4 hour low > [0] 4 hour sma( close,20 ) ) ) or( {cash} ( [0] 4 hour high - [0] 4 hour low < [0] 4 hour low - [0] 4 hour lower bollinger band( 20,2 ) and [0] 4 hour close < [0] 4 hour sma( close,20 ) ) ) ) ) ) ) ) )'}
    # divergence daily
    div_d02 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 2 days ago close and 1 day ago rsi( 14 ) < 2 days ago rsi( 14 ) and 1 day ago close - 2 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d03 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 3 days ago close and 1 day ago rsi( 14 ) < 3 days ago rsi( 14 ) and 1 day ago close - 3 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d04 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 4 days ago close and 1 day ago rsi( 14 ) < 4 days ago rsi( 14 ) and 1 day ago close - 4 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d05 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 5 days ago close and 1 day ago rsi( 14 ) < 5 days ago rsi( 14 ) and 1 day ago close - 5 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d06 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 6 days ago close and 1 day ago rsi( 14 ) < 6 days ago rsi( 14 ) and 1 day ago close - 6 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d07 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 7 days ago close and 1 day ago rsi( 14 ) < 7 days ago rsi( 14 ) and 1 day ago close - 7 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d08 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 8 days ago close and 1 day ago rsi( 14 ) < 8 days ago rsi( 14 ) and 1 day ago close - 8 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d09 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 9 days ago close and 1 day ago rsi( 14 ) < 9 days ago rsi( 14 ) and 1 day ago close - 9 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d10 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 10 days ago close and 1 day ago rsi( 14 ) < 10 days ago rsi( 14 ) and 1 day ago close - 10 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d11 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 11 days ago close and 1 day ago rsi( 14 ) < 11 days ago rsi( 14 ) and 1 day ago close - 11 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d12 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 12 days ago close and 1 day ago rsi( 14 ) < 12 days ago rsi( 14 ) and 1 day ago close - 12 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d13 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 13 days ago close and 1 day ago rsi( 14 ) < 13 days ago rsi( 14 ) and 1 day ago close - 13 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d14 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 14 days ago close and 1 day ago rsi( 14 ) < 14 days ago rsi( 14 ) and 1 day ago close - 14 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_d15 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 day ago close >= 15 days ago close and 1 day ago rsi( 14 ) < 15 days ago rsi( 14 ) and 1 day ago close - 15 days ago close > latest close * 0.01 and 1 day ago close > 1 day ago open and latest close < latest open and latest close < 1 day ago close and latest close * latest volume > 10000000 and( {cash} ( ( {cash} ( latest high - latest low < latest low - latest sma( close,20 ) * .50 and latest low > latest sma( close,20 ) ) ) or( {cash} ( latest high - latest low < latest low - latest lower bollinger band( 20,2 ) and latest close < latest sma( close,20 ) ) ) ) ) ) ) ) )'}
    # divergence weekly
    div_w02 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 2 weeks ago close and 1 week ago rsi( 14 ) < 2 weeks ago rsi( 14 ) and 1 week ago close - 2 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w03 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 3 weeks ago close and 1 week ago rsi( 14 ) < 3 weeks ago rsi( 14 ) and 1 week ago close - 3 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w04 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 4 weeks ago close and 1 week ago rsi( 14 ) < 4 weeks ago rsi( 14 ) and 1 week ago close - 4 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w05 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 5 weeks ago close and 1 week ago rsi( 14 ) < 5 weeks ago rsi( 14 ) and 1 week ago close - 5 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w06 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 6 weeks ago close and 1 week ago rsi( 14 ) < 6 weeks ago rsi( 14 ) and 1 week ago close - 6 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w07 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 7 weeks ago close and 1 week ago rsi( 14 ) < 7 weeks ago rsi( 14 ) and 1 week ago close - 7 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w08 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 8 weeks ago close and 1 week ago rsi( 14 ) < 8 weeks ago rsi( 14 ) and 1 week ago close - 8 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w09 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 9 weeks ago close and 1 week ago rsi( 14 ) < 9 weeks ago rsi( 14 ) and 1 week ago close - 9 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w10 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 10 weeks ago close and 1 week ago rsi( 14 ) < 10 weeks ago rsi( 14 ) and 1 week ago close - 10 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w11 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 11 weeks ago close and 1 week ago rsi( 14 ) < 11 weeks ago rsi( 14 ) and 1 week ago close - 11 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w12 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 12 weeks ago close and 1 week ago rsi( 14 ) < 12 weeks ago rsi( 14 ) and 1 week ago close - 12 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w13 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 13 weeks ago close and 1 week ago rsi( 14 ) < 13 weeks ago rsi( 14 ) and 1 week ago close - 13 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w14 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 14 weeks ago close and 1 week ago rsi( 14 ) < 14 weeks ago rsi( 14 ) and 1 week ago close - 14 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_w15 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 week ago close >= 15 weeks ago close and 1 week ago rsi( 14 ) < 15 weeks ago rsi( 14 ) and 1 week ago close - 15 weeks ago close > weekly close * 0.01 and 1 week ago close > 1 week ago open and weekly close < weekly open and weekly close < 1 week ago close and weekly close * weekly volume > 10000000 and( {cash} ( ( {cash} ( weekly high - weekly low < weekly low - weekly sma( close,20 ) * .50 and weekly low > weekly sma( close,20 ) ) ) or( {cash} ( weekly high - weekly low < weekly low - weekly lower bollinger band( 20,2 ) and weekly close < weekly sma( close,20 ) ) ) ) ) ) ) ) )'}
    # divergence monthly
    div_m02 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  2 months ago close and 1 month ago rsi( 14 ) <  2 months ago rsi( 14 ) and 1 month ago close -  2 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m03 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  3 months ago close and 1 month ago rsi( 14 ) <  3 months ago rsi( 14 ) and 1 month ago close -  3 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m04 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  4 months ago close and 1 month ago rsi( 14 ) <  4 months ago rsi( 14 ) and 1 month ago close -  4 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m05 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  5 months ago close and 1 month ago rsi( 14 ) <  5 months ago rsi( 14 ) and 1 month ago close -  5 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m06 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  6 months ago close and 1 month ago rsi( 14 ) <  6 months ago rsi( 14 ) and 1 month ago close -  6 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m07 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  7 months ago close and 1 month ago rsi( 14 ) <  7 months ago rsi( 14 ) and 1 month ago close -  7 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m08 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  8 months ago close and 1 month ago rsi( 14 ) <  8 months ago rsi( 14 ) and 1 month ago close -  8 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m09 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >=  9 months ago close and 1 month ago rsi( 14 ) <  9 months ago rsi( 14 ) and 1 month ago close -  9 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m10 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 10 months ago close and 1 month ago rsi( 14 ) < 10 months ago rsi( 14 ) and 1 month ago close - 10 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m11 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 11 months ago close and 1 month ago rsi( 14 ) < 11 months ago rsi( 14 ) and 1 month ago close - 11 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m12 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 12 months ago close and 1 month ago rsi( 14 ) < 12 months ago rsi( 14 ) and 1 month ago close - 12 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m13 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 13 months ago close and 1 month ago rsi( 14 ) < 13 months ago rsi( 14 ) and 1 month ago close - 13 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m14 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 14 months ago close and 1 month ago rsi( 14 ) < 14 months ago rsi( 14 ) and 1 month ago close - 14 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    div_m15 = {
        'scan_clause': '( {cash} ( ( {cash} ( 1 month ago close >= 15 months ago close and 1 month ago rsi( 14 ) < 15 months ago rsi( 14 ) and 1 month ago close - 15 months ago close > monthly close * 0.01 and 1 month ago close > 1 month ago open and monthly close < monthly open and monthly close < 1 month ago close and monthly close * monthly volume > 10000000 and( {cash} ( ( {cash} ( monthly high - monthly low < monthly low - monthly sma( close,20 ) * .50 and monthly low > monthly sma( close,20 ) ) ) or( {cash} ( monthly high - monthly low < monthly low - monthly lower bollinger band( 20,2 ) and monthly close < monthly sma( close,20 ) ) ) ) ) ) ) ) )'}
    data_list = [
        data_15, data_1, data_4, data_d, data_w, data_m, macd_hook_daily, macd_hook_weekly, macd_hook_monthly,
        div_15m02, div_15m03, div_15m04, div_15m05, div_15m06, div_15m07, div_15m08, div_15m09, div_15m10, div_15m11,
        div_15m12, div_15m13, div_15m14, div_15m15,
        div_h02, div_h03, div_h04, div_h05, div_h06, div_h07, div_h08, div_h09, div_h10, div_h11, div_h12, div_h13,
        div_h14,
        div_h15,
        div_4h02, div_4h03, div_4h04, div_4h05, div_4h06, div_4h07, div_4h08, div_4h09, div_4h10, div_4h11, div_4h12,
        div_4h13, div_4h14, div_4h15,
        div_d02, div_d03, div_d04, div_d05, div_d06, div_d07, div_d08, div_d09, div_d10, div_d11, div_d12, div_d13,
        div_d14,
        div_d15,
        div_w02, div_w03, div_w04, div_w05, div_w06, div_w07, div_w08, div_w09, div_w10, div_w11, div_w12, div_w13,
        div_w14,
        div_w15,
        div_m02, div_m03, div_m04, div_m05, div_m06, div_m07, div_m08, div_m09, div_m10, div_m11, div_m12, div_m13,
        div_m14,
        div_m15
    ]

    # Urls
    # # triple screen system
    # url_15 = 'https://chartink.com/screener/bullish-15-minutes-of-triple-screen2'
    # url_1 = 'https://chartink.com/screener/bullish-hourly-of-triple-screen1'
    # url_4 = 'https://chartink.com/screener/bullish-4-hourly-of-triple-screen1'
    # url_d = 'https://chartink.com/screener/bullish-daily-of-triple-screen-system1'
    # url_w = 'https://chartink.com/screener/bullish-weekly-of-triple-screen1'
    # url_m = 'https://chartink.com/screener/bullish-monthly-of-triple-screen1'
    # url_hd = 'https://chartink.com/screener/macd-hook-daily-5'
    # url_hw = 'https://chartink.com/screener/macd-hook-weekly'
    # url_hm = 'https://chartink.com/screener/macd-hook-daily-5'
    # # divergence 15 Minutes
    # url_div_15m02 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-2-candles'
    # url_div_15m03 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-3-candles'
    # url_div_15m04 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-4-candles'
    # url_div_15m05 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-5-candles'
    # url_div_15m06 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-6-candles'
    # url_div_15m07 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-7-candles'
    # url_div_15m08 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-8-candles'
    # url_div_15m09 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-9-candles'
    # url_div_15m10 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-10-candles'
    # url_div_15m11 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-11-candles'
    # url_div_15m12 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-12-candles'
    # url_div_15m13 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-13-candles'
    # url_div_15m14 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-14-candles'
    # url_div_15m15 = 'https://chartink.com/screener/rsi-ve-divergence-15-minutes-15-candles'
    # # divergence 4 Hourly
    # url_div_h02 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-2-candles'
    # url_div_h03 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-3-candles'
    # url_div_h04 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-4-candles'
    # url_div_h05 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-5-candles'
    # url_div_h06 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-6-candles'
    # url_div_h07 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-7-candles'
    # url_div_h08 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-8-candles'
    # url_div_h09 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-9-candles'
    # url_div_h10 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-10-candles'
    # url_div_h11 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-11-candles'
    # url_div_h12 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-12-candles'
    # url_div_h13 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-13-candles'
    # url_div_h14 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-14-candles'
    # url_div_h15 = 'https://chartink.com/screener/rsi-ve-divergence-hourly-15-candles'
    # # divergence 4 Hourly
    # url_div_4h02 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-2-candles'
    # url_div_4h03 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-3-candles'
    # url_div_4h04 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-4-candles'
    # url_div_4h05 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-5-candles'
    # url_div_4h06 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-6-candles'
    # url_div_4h07 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-7-candles'
    # url_div_4h08 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-8-candles'
    # url_div_4h09 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-9-candles'
    # url_div_4h10 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-10-candles'
    # url_div_4h11 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-11-candles'
    # url_div_4h12 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-12-candles'
    # url_div_4h13 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-13-candles'
    # url_div_4h14 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-14-candles'
    # url_div_4h15 = 'https://chartink.com/screener/rsi-ve-divergence-4-hourly-15-candles'
    # # divergence Daily
    # url_div_d02 = 'https://chartink.com/screener/rsi-ve-divergence-2-days'
    # url_div_d03 = 'https://chartink.com/screener/rsi-ve-divergence-3-days'
    # url_div_d04 = 'https://chartink.com/screener/rsi-ve-divergence-4-days'
    # url_div_d05 = 'https://chartink.com/screener/rsi-ve-divergence-5-days'
    # url_div_d06 = 'https://chartink.com/screener/rsi-ve-divergence-6-days'
    # url_div_d07 = 'https://chartink.com/screener/rsi-ve-divergence-7-days'
    # url_div_d08 = 'https://chartink.com/screener/rsi-ve-divergence-8-days'
    # url_div_d09 = 'https://chartink.com/screener/rsi-ve-divergence-9-days'
    # url_div_d10 = 'https://chartink.com/screener/rsi-ve-divergence-10-days'
    # url_div_d11 = 'https://chartink.com/screener/rsi-ve-divergence-11-days'
    # url_div_d12 = 'https://chartink.com/screener/rsi-ve-divergence-12-days'
    # url_div_d13 = 'https://chartink.com/screener/rsi-ve-divergence-13-days'
    # url_div_d14 = 'https://chartink.com/screener/rsi-ve-divergence-14-days'
    # url_div_d15 = 'https://chartink.com/screener/rsi-ve-divergence-15-days'
    # # divergence Weekly
    # url_div_w02 = 'https://chartink.com/screener/rsi-ve-divergence-2-weeks'
    # url_div_w03 = 'https://chartink.com/screener/rsi-ve-divergence-3-weeks'
    # url_div_w04 = 'https://chartink.com/screener/rsi-ve-divergence-4-weeks'
    # url_div_w05 = 'https://chartink.com/screener/rsi-ve-divergence-5-weeks'
    # url_div_w06 = 'https://chartink.com/screener/rsi-ve-divergence-6-weeks'
    # url_div_w07 = 'https://chartink.com/screener/rsi-ve-divergence-7-weeks'
    # url_div_w08 = 'https://chartink.com/screener/rsi-ve-divergence-8-weeks'
    # url_div_w09 = 'https://chartink.com/screener/rsi-ve-divergence-9-weeks'
    # url_div_w10 = 'https://chartink.com/screener/rsi-ve-divergence-10-weeks'
    # url_div_w11 = 'https://chartink.com/screener/rsi-ve-divergence-11-weeks'
    # url_div_w12 = 'https://chartink.com/screener/rsi-ve-divergence-12-weeks'
    # url_div_w13 = 'https://chartink.com/screener/rsi-ve-divergence-13-weeks'
    # url_div_w14 = 'https://chartink.com/screener/rsi-ve-divergence-14-weeks'
    # url_div_w15 = 'https://chartink.com/screener/rsi-ve-divergence-15-weeks'
    # # divergence Monthly
    # url_div_m02 = 'https://chartink.com/screener/rsi-ve-divergence-2-months'
    # url_div_m03 = 'https://chartink.com/screener/rsi-ve-divergence-3-months'
    # url_div_m04 = 'https://chartink.com/screener/rsi-ve-divergence-4-months'
    # url_div_m05 = 'https://chartink.com/screener/rsi-ve-divergence-5-months'
    # url_div_m06 = 'https://chartink.com/screener/rsi-ve-divergence-6-months'
    # url_div_m07 = 'https://chartink.com/screener/rsi-ve-divergence-7-months'
    # url_div_m08 = 'https://chartink.com/screener/rsi-ve-divergence-8-months'
    # url_div_m09 = 'https://chartink.com/screener/rsi-ve-divergence-9-months'
    # url_div_m10 = 'https://chartink.com/screener/rsi-ve-divergence-10-months'
    # url_div_m11 = 'https://chartink.com/screener/rsi-ve-divergence-11-months'
    # url_div_m12 = 'https://chartink.com/screener/rsi-ve-divergence-12-months'
    # url_div_m13 = 'https://chartink.com/screener/rsi-ve-divergence-13-months'
    # url_div_m14 = 'https://chartink.com/screener/rsi-ve-divergence-14-months'
    # url_div_m15 = 'https://chartink.com/screener/rsi-ve-divergence-15-months'
    # url_list = [
    #     url_15, url_1, url_4, url_d, url_w, url_m, url_hd, url_hw, url_hm,
    #     url_div_15m02, url_div_15m03, url_div_15m04, url_div_15m05, url_div_15m06, url_div_15m07, url_div_15m08,
    #     url_div_15m09, url_div_15m10, url_div_15m11, url_div_15m12, url_div_15m13, url_div_15m14, url_div_15m15,
    #     url_div_h02, url_div_h03, url_div_h04, url_div_h05, url_div_h06, url_div_h07, url_div_h08, url_div_h09,
    #     url_div_h10, url_div_h11, url_div_h12, url_div_h13, url_div_h14, url_div_h15,
    #     url_div_4h02, url_div_4h03, url_div_4h04, url_div_4h05, url_div_4h06, url_div_4h07, url_div_4h08, url_div_4h09,
    #     url_div_4h10, url_div_4h11, url_div_4h12, url_div_4h13, url_div_4h14, url_div_4h15,
    #     url_div_d02, url_div_d03, url_div_d04, url_div_d05, url_div_d06, url_div_d07, url_div_d08, url_div_d09, url_div_d10,
    #     url_div_d11, url_div_d12, url_div_d13, url_div_d14, url_div_d15,
    #     url_div_w02, url_div_w03, url_div_w04, url_div_w05, url_div_w06, url_div_w07, url_div_w08, url_div_w09, url_div_w10,
    #     url_div_w11, url_div_w12, url_div_w13, url_div_w14, url_div_w15,
    #     url_div_m02, url_div_m03, url_div_m04, url_div_m05, url_div_m06, url_div_m07, url_div_m08, url_div_m09, url_div_m10,
    #     url_div_m11, url_div_m12, url_div_m13, url_div_m14, url_div_m15
    # ]

    # triple screen system # "of" is mandatory because in ACCESS word is splitting depending on "of" word
    tf_15 = 'Bullish 15 Minutes of Triple Screen, Technical Analysis Scanner'
    tf_1 = 'Bullish Hourly of Triple Screen, Technical Analysis Scanner'
    tf_4 = 'Bullish 4 Hourly of Triple Screen, Technical Analysis Scanner'
    tf_d = 'Bullish Daily of Triple Screen System, Technical Analysis Scanner'
    tf_w = 'Bullish Weekly of Triple Screen, Technical Analysis Scanner'
    tf_m = 'Bullish Monthly of Triple Screen, Technical Analysis Scanner'
    tf_hd = 'MACD Hook in Daily of, Technical Analysis Scanner'
    tf_hw = 'MACD Hook in Weekly of, Technical Analysis Scanner'
    tf_hm = 'MACD Hook in Monthly of, Technical Analysis Scanner'
    # divergence 15 Minutes
    tf_div_15m02 = 'Divergence 15 Minutes in 02 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m03 = 'Divergence 15 Minutes in 03 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m04 = 'Divergence 15 Minutes in 04 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m05 = 'Divergence 15 Minutes in 05 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m06 = 'Divergence 15 Minutes in 06 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m07 = 'Divergence 15 Minutes in 07 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m08 = 'Divergence 15 Minutes in 08 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m09 = 'Divergence 15 Minutes in 09 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m10 = 'Divergence 15 Minutes in 10 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m11 = 'Divergence 15 Minutes in 11 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m12 = 'Divergence 15 Minutes in 12 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m13 = 'Divergence 15 Minutes in 13 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m14 = 'Divergence 15 Minutes in 14 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_15m15 = 'Divergence 15 Minutes in 15 Candles of Triple Screen System, Technical Analysis Scanner'
    # divergence Hourly
    tf_div_h02 = 'Divergence 1 Hourly in 02 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h03 = 'Divergence 1 Hourly in 03 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h04 = 'Divergence 1 Hourly in 04 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h05 = 'Divergence 1 Hourly in 05 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h06 = 'Divergence 1 Hourly in 06 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h07 = 'Divergence 1 Hourly in 07 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h08 = 'Divergence 1 Hourly in 08 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h09 = 'Divergence 1 Hourly in 09 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h10 = 'Divergence 1 Hourly in 10 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h11 = 'Divergence 1 Hourly in 11 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h12 = 'Divergence 1 Hourly in 12 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h13 = 'Divergence 1 Hourly in 13 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h14 = 'Divergence 1 Hourly in 14 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_h15 = 'Divergence 1 Hourly in 15 Candles of Triple Screen System, Technical Analysis Scanner'
    # divergence 4 Hourly
    tf_div_4h02 = 'Divergence 4 Hourly in 02 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h03 = 'Divergence 4 Hourly in 03 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h04 = 'Divergence 4 Hourly in 04 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h05 = 'Divergence 4 Hourly in 05 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h06 = 'Divergence 4 Hourly in 06 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h07 = 'Divergence 4 Hourly in 07 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h08 = 'Divergence 4 Hourly in 08 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h09 = 'Divergence 4 Hourly in 09 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h10 = 'Divergence 4 Hourly in 10 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h11 = 'Divergence 4 Hourly in 11 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h12 = 'Divergence 4 Hourly in 12 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h13 = 'Divergence 4 Hourly in 13 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h14 = 'Divergence 4 Hourly in 14 Candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_4h15 = 'Divergence 4 Hourly in 15 Candles of Triple Screen System, Technical Analysis Scanner'
    # divergence Daily
    tf_div_d02 = 'Divergence Daily in 02 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d03 = 'Divergence Daily in 03 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d04 = 'Divergence Daily in 04 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d05 = 'Divergence Daily in 05 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d06 = 'Divergence Daily in 06 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d07 = 'Divergence Daily in 07 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d08 = 'Divergence Daily in 08 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d09 = 'Divergence Daily in 09 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d10 = 'Divergence Daily in 10 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d11 = 'Divergence Daily in 11 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d12 = 'Divergence Daily in 12 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d13 = 'Divergence Daily in 13 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d14 = 'Divergence Daily in 14 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_d15 = 'Divergence Daily in 15 candles of Triple Screen System, Technical Analysis Scanner'
    # divergence Weekly
    tf_div_w02 = 'Divergence weekly in 02 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w03 = 'Divergence weekly in 03 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w04 = 'Divergence weekly in 04 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w05 = 'Divergence weekly in 05 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w06 = 'Divergence weekly in 06 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w07 = 'Divergence weekly in 07 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w08 = 'Divergence weekly in 08 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w09 = 'Divergence weekly in 09 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w10 = 'Divergence weekly in 10 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w11 = 'Divergence weekly in 11 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w12 = 'Divergence weekly in 12 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w13 = 'Divergence weekly in 13 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w14 = 'Divergence weekly in 14 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_w15 = 'Divergence weekly in 15 candles of Triple Screen System, Technical Analysis Scanner'
    # divergence Monthly
    tf_div_m02 = 'Divergence monthly in 02 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m03 = 'Divergence monthly in 03 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m04 = 'Divergence monthly in 04 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m05 = 'Divergence monthly in 05 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m06 = 'Divergence monthly in 06 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m07 = 'Divergence monthly in 07 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m08 = 'Divergence monthly in 08 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m09 = 'Divergence monthly in 09 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m10 = 'Divergence monthly in 10 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m11 = 'Divergence monthly in 11 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m12 = 'Divergence monthly in 12 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m13 = 'Divergence monthly in 13 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m14 = 'Divergence monthly in 14 candles of Triple Screen System, Technical Analysis Scanner'
    tf_div_m15 = 'Divergence monthly in 15 candles of Triple Screen System, Technical Analysis Scanner'
    tf_l = [
        tf_15, tf_1, tf_4, tf_d, tf_w, tf_m, tf_hd, tf_hw, tf_hm,
        tf_div_15m02, tf_div_15m03, tf_div_15m04, tf_div_15m05, tf_div_15m06, tf_div_15m07, tf_div_15m08, tf_div_15m09,
        tf_div_15m10, tf_div_15m11, tf_div_15m12, tf_div_15m13, tf_div_15m14, tf_div_15m15,
        tf_div_h02, tf_div_h03, tf_div_h04, tf_div_h05, tf_div_h06, tf_div_h07, tf_div_h08, tf_div_h09, tf_div_h10,
        tf_div_h11, tf_div_h12, tf_div_h13, tf_div_h14, tf_div_h15,
        tf_div_4h02, tf_div_4h03, tf_div_4h04, tf_div_4h05, tf_div_4h06, tf_div_4h07, tf_div_4h08, tf_div_4h09,
        tf_div_4h10, tf_div_4h11, tf_div_4h12, tf_div_4h13, tf_div_4h14, tf_div_4h15,
        tf_div_d02, tf_div_d03, tf_div_d04, tf_div_d05, tf_div_d06, tf_div_d07, tf_div_d08, tf_div_d09, tf_div_d10,
        tf_div_d11, tf_div_d12, tf_div_d13, tf_div_d14, tf_div_d15,
        tf_div_w02, tf_div_w03, tf_div_w04, tf_div_w05, tf_div_w06, tf_div_w07, tf_div_w08, tf_div_w09, tf_div_w10,
        tf_div_w11, tf_div_w12, tf_div_w13, tf_div_w14, tf_div_w15,
        tf_div_m02, tf_div_m03, tf_div_m04, tf_div_m05, tf_div_m06, tf_div_m07, tf_div_m08, tf_div_m09, tf_div_m10,
        tf_div_m11, tf_div_m12, tf_div_m13, tf_div_m14, tf_div_m15
    ]

    for i, data_each_list in enumerate(data_list):
        # print(f"iteration {i}")
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
                df.insert(7, 'TimeFrame', tf_l[i], allow_duplicates=True)
                # print(df)
            if i == 0:
                # df_all = df
                df_all = pd.DataFrame()
            df_all = pd.concat([df_all, df], ignore_index=True)
            # df.to_excel('C:/Users/gsrsr/Downloads/bullish-15-minutes-of-triple-screen.xlsx', index=False)
        print(f"complete '{tf_l[i]}'")
    print(f"\nDownloading data from the website is complete.\nWriting to the excel file is complete\n")
    df_all.to_excel('C:/Users/gsrsr/Downloads/chartInk-bullish-Triple Screen.xlsx', index=False)
    # script time calculation
    # End time
    end_time = time.time()
    # End time
    end_datetime = datetime.now()
    # Elapsed time in seconds
    elapsed_time = end_time - start_time
    # Elapsed datetime
    print(f"End date of the script is: {end_datetime} and time is: {end_time}")
    elapsed_datetime = end_datetime - start_datetime
    print(f"Total time to complete in seconds: {elapsed_time} \nconverted to datetime format: {elapsed_datetime}\n")
    print("Download to excel file complete")
    # ############################################################################################


if __name__ == "__main__":
    chatink_excelfile_download()
