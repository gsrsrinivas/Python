import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Common_Functions.base_functions import *


def chat_ink_xls2db():
    """
    Download Chart-ink Excel file and insert into a database.
    This function downloads the Chart Ink Excel file, processes it, and inserts the data into the database.
    It also prints the start timestamp and handles any exit conditions.
    Returns: None
    Raises: SystemExit: If the status is "exit", the program will terminate.
    Usage: chat_ink_xls2db()
    """
    data_list = [
        # {'all_stocks' : {'scan_clause': '( {segments_filter} ( latest close >= 0 ) )'}},
        {'macd__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) >= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) <= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) >= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) <= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) <= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) <= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},

        {'stochastic__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) >= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) <= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) >= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) <= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) <= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) <= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},

        {'ema_5_13__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) >= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) <= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) >= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) <= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) <= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) <= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},

        {'ema_13_26__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) >= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) <= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) >= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) <= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) <= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) <= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},

        {'ema_50_100__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) >= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) <= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) >= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) <= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) <= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) <= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},

        {'ema_100_200__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) >= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) <= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) >= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) <= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) <= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) <= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},

        {'rsi__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}},

        {'upper_bollinger_band3__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) >= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) <= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) >= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) <= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) <= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) <= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},

        {'lower_bollinger_band3__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) >= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) <= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) >= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) <= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) >= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) >= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},

        {'upper_bollinger_band2__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) >= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) <= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) >= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) <= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) <= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) <= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},

        {'lower_bollinger_band2__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) >= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) <= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) >= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) <= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) >= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) >= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},

        {'volume__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly volume >= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly volume <= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly volume >= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly volume <= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly volume <= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly volume <= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},

        {'adx__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) >= yearly adx di negative( 14 ) ) )'}},
        {'adx__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) <= yearly adx di negative( 14 ) ) )'}},
        {'adx__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) >= quarterly adx di negative( 14 ) ) )'}},
        {'adx__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) <= quarterly adx di negative( 14 ) ) )'}},
        {'adx__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) ) )'}},
        {'adx__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) <= monthly adx di negative( 14 ) ) )'}},
        {'adx__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) ) )'}},
        {'adx__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) <= weekly adx di negative( 14 ) ) )'}},
        {'adx__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}},
        {'adx__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}},

        {'adx_up_tick__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly adx( 14 ) >= 1 year ago adx( 14 ) ) )'}},
        {'adx_down_tick__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly adx( 14 ) <= 1 year ago adx( 14 ) ) )'}},
        {'adx_up_tick__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) >= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_down_tick__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) <= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_up_tick__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly adx( 14 ) >= 1 month ago adx( 14 ) ) )'}},
        {'adx_down_tick__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly adx( 14 ) <= 1 month ago adx( 14 ) ) )'}},
        {'adx_up_tick__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly adx( 14 ) >= 1 week ago adx( 14 ) ) )'}},
        {'adx_down_tick__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly adx( 14 ) <= 1 week ago adx( 14 ) ) )'}},
        {'adx_up_tick__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}},
        {'adx_down_tick__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}},
        {'adx_up_tick__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_down_tick__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_up_tick__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_down_tick__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_up_tick__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}},
        {'adx_down_tick__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}},

        {'volume__yearly__shockers': {'scan_clause': '( {segments_filter} ( yearly volume > yearly sma( volume,20 ) * 5 ) )'}},
        {'volume__quarterly__shockers': {'scan_clause': '( {segments_filter} ( quarterly volume > quarterly sma( volume,20 ) * 5 ) )'}},
        {'volume__monthly__shockers': {'scan_clause': '( {segments_filter} ( monthly volume > monthly sma( volume,20 ) * 5 ) )'}},
        {'volume__weekly__shockers': {'scan_clause': '( {segments_filter} ( weekly volume > weekly sma( volume,20 ) * 5 ) )'}},
        {'volume__daily__shockers': {'scan_clause': '( {segments_filter} ( latest volume > latest sma( volume,20 ) * 5 ) )'}},
        {'volume__4_hourly__shockers': {'scan_clause': '( {segments_filter} ( [0] 4 hour volume > [ 0 ] 4 hour sma( volume,20 ) * 5 ) )'}},
        {'volume__1_hourly__shockers': {'scan_clause': '( {segments_filter} ( [0] 1 hour volume > [ 0 ] 1 hour sma( volume,20 ) * 5 ) )'}},
        {'volume__15_minutes__shockers': {'scan_clause': '( {segments_filter} ( [0] 15 minute volume > [ 0 ] 15 minute sma( volume,20 ) * 5 ) )'}},

    ]
    table_script_names = ["Cash_Stocks","Insert-Script","Update-Report--Queries"]
    df_all = chart_ink_excel_file_download_and_insert_into_db(data_list)
    file_path = chart_ink_to_csv(df_all, Path(__file__).stem)
    insert_into_database_tables(table_script_names, bulk_file_path=file_path)


def chart_ink_download():
    setup_logger(__file__, f"daily_{Path(__file__).stem}.log") # 'daily_chart_ink_download_and_insert.log' )
    try:
        print_start_timestamp()
        # prevent_sleep()
        # sys.exit() if trading_hours_check() == "exit" else None
        chat_ink_xls2db()
        purge_tables()
        shrink_databases()
        purge_log_files('daily_chart_ink')
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    chart_ink_download()

