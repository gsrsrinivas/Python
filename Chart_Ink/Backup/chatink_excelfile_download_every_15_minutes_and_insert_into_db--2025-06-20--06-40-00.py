# pip install --upgrade pandas --target="C:\Program Files\Python312\Lib\site-packages"
import sys
import time
from datetime import datetime

import pandas as pd
import pyodbc
import requests
from bs4 import BeautifulSoup as Bs


def print_start_timestamp():
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
        print(f"Current Time: {current_timestamp} is within the trading Hours i.e., 9:30 am to 15:30 pm "
              f"so continuing the program")
        return start_date, start_time, "continue"
    else:
        print(f"Current Time: {current_timestamp} is outside of trading Hours i.e., 9:30 am to 15:30 pm "
              f"so existing the program")
        time.sleep(15)
        return start_date, start_time, "exit"
    # ##################################################################################################################


def print_end_timestamp(start_date, start_time):
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


def insert_into_database_tables(df_all):
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
    # ##################################################################################################################
    print(f'Analysing the inserted data and inserting into report table')
    # Read SQL script file
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/InsertScript_15Minutes.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    print(f'start: executing the sql queries')
    cursor.execute(sql_script)
    print(f'end: executing the sql queries')
    print(f'Commiting the records in Analyse_15minutes_Stocks')
    conn.commit()
    # ##################################################################################################################
    print(f'update the Analysis records in report table')
    # Read SQL script file
    script_file = 'C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks/update_Report_15minutes_Queries.sql'
    with open(script_file, 'r') as file:
        sql_script = file.read()
    # Execute SQL script
    cursor.execute(sql_script)
    print(f'Commiting the records in Analyse_15minutes_Stocks for reporting')
    conn.commit()
    # ##################################################################################################################
    print(f'Closing the connections')
    # Close the connection
    cursor.close()
    conn.close()


def download_chart_ink_technical_analysis_scanner(data_each_list):
    with requests.Session() as s:
        key, data = next(iter(data_each_list.items()))
        # for _, value in data_each_list.items():
        #     data = value
        # # r = s.get(url_list[i])
        r = s.get('https://chartink.com/screener/watch-list-stocks-5')
        soup = Bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        print(f"Value: {r["scan_error"]} for rule: {key} {data}") if "scan_error" in r else None
        df = pd.DataFrame(r['data'])
        return df


def insert_new_columns_in_data_frame(df,tf_l_i,each_segment_list,start_date):
    # reorder columns
    if len(df) > 0:
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # Rename columns
        df.rename(columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                           'close': 'price'}, inplace=True)
        # insert new columns
        part1, part2, part3 = tf_l_i.split('__')
        df.insert(7, 'Indicator', part1.replace("_"," "), allow_duplicates=True)
        df.insert(8, 'TimeLine', part2.replace("_"," "), allow_duplicates=True)
        df.insert(9, 'Direction', part3.replace("_"," "), allow_duplicates=True)
        df.insert(10, 'segments', each_segment_list, allow_duplicates=True)
        df.insert(11, 'Batch_No', start_date.strftime('%Y%m%d'), allow_duplicates=True)
    return df


def chat_ink_excel_file_download_every_15_minutes_and_insert_into_db():
    start_date, start_time, status = print_start_timestamp()
    sys.exit() if status == "exit" else None
    # chart ink rule condition to download the stocks
    data_list = [
        # {'all_stocks' : {'scan_clause': '( {segments_filter} ( latest close >= 0 ) )'}},
        {'macd__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},

        {'stochastic__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},

        {'ema_5_13__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},

        {'ema_13_26__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},

        {'ema_50_100__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},

        {'ema_100_200__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},

        {'rsi__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}},

        {'upper_bollinger_band3__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},

        {'lower_bollinger_band3__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},

        {'upper_bollinger_band2__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},

        {'lower_bollinger_band2__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},

        {'volume__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},

        {'adx__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}},
        {'adx__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}},

        {'adx_up_tick__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}},
        {'adx_down_tick__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}},
        {'adx_up_tick__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_down_tick__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_up_tick__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_down_tick__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_up_tick__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}},
        {'adx_down_tick__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}},

        {' 0_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest close     >= 1 day ago close   ) )'}},
        {' 1_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 day ago close  >= 2 days ago close  ) )'}},
        {' 2_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 day ago close  >= 3 days ago close  ) )'}},
        {' 3_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 day ago close  >= 4 days ago close  ) )'}},
        {' 4_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 day ago close  >= 5 days ago close  ) )'}},
        {' 5_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 day ago close  >= 6 days ago close  ) )'}},
        {' 6_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 day ago close  >= 7 days ago close  ) )'}},
        {' 7_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 day ago close  >= 8 days ago close  ) )'}},
        {' 8_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 day ago close  >= 9 days ago close  ) )'}},
        {' 9_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 day ago close  >= 10 days ago close ) )'}},
        {'10_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 day ago close >= 11 days ago close ) )'}},
        {'11_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 day ago close >= 12 days ago close ) )'}},
        {'12_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 day ago close >= 13 days ago close ) )'}},
        {'13_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 day ago close >= 14 days ago close ) )'}},
        {'14_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 day ago close >= 15 days ago close ) )'}},
        {'15_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 day ago close >= 16 days ago close ) )'}},
        {'16_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 day ago close >= 17 days ago close ) )'}},
        {'17_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 day ago close >= 18 days ago close ) )'}},
        {'18_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 day ago close >= 19 days ago close ) )'}},
        {'19_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 day ago close >= 20 days ago close ) )'}},
        {'20_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 day ago close >= 21 days ago close ) )'}},
        {'21_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 day ago close >= 22 days ago close ) )'}},
        {'22_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 day ago close >= 23 days ago close ) )'}},
        {'23_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 day ago close >= 24 days ago close ) )'}},
        {'24_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 day ago close >= 25 days ago close ) )'}},
        {'25_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 day ago close >= 26 days ago close ) )'}},
        {'26_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 day ago close >= 27 days ago close ) )'}},
        {'27_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 day ago close >= 28 days ago close ) )'}},
        {'28_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 day ago close >= 29 days ago close ) )'}},
        {'29_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 day ago close >= 30 days ago close ) )'}},
        {'30_day__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 day ago close >= 31 days ago close ) )'}},
        {'0_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest close <= 1 day ago close ) )'}},
        {'1_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 day ago close <= 2 days ago close ) )'}},
        {'2_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 day ago close <= 3 days ago close ) )'}},
        {'3_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 day ago close <= 4 days ago close ) )'}},
        {'4_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 day ago close <= 5 days ago close ) )'}},
        {'5_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 day ago close <= 6 days ago close ) )'}},
        {'6_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 day ago close <= 7 days ago close ) )'}},
        {'7_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 day ago close <= 8 days ago close ) )'}},
        {'8_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 day ago close <= 9 days ago close ) )'}},
        {'9_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 day ago close <= 10 days ago close  ) )'}},
        {'10_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 day ago close <= 11 days ago close ) )'}},
        {'11_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 day ago close <= 12 days ago close ) )'}},
        {'12_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 day ago close <= 13 days ago close ) )'}},
        {'13_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 day ago close <= 14 days ago close ) )'}},
        {'14_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 day ago close <= 15 days ago close ) )'}},
        {'15_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 day ago close <= 16 days ago close ) )'}},
        {'16_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 day ago close <= 17 days ago close ) )'}},
        {'17_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 day ago close <= 18 days ago close ) )'}},
        {'18_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 day ago close <= 19 days ago close ) )'}},
        {'19_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 day ago close <= 20 days ago close ) )'}},
        {'20_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 day ago close <= 21 days ago close ) )'}},
        {'21_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 day ago close <= 22 days ago close ) )'}},
        {'22_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 day ago close <= 23 days ago close ) )'}},
        {'23_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 day ago close <= 24 days ago close ) )'}},
        {'24_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 day ago close <= 25 days ago close ) )'}},
        {'25_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 day ago close <= 26 days ago close ) )'}},
        {'26_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 day ago close <= 27 days ago close ) )'}},
        {'27_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 day ago close <= 28 days ago close ) )'}},
        {'28_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 day ago close <= 29 days ago close ) )'}},
        {'29_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 day ago close <= 30 days ago close ) )'}},
        {'30_day__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 day ago close <= 31 days ago close ) )'}},

        {' 0_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [0] 4 hour close >=  [-1] 4 hour close ) )'}},
        {' 1_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [1] 4 hour close >=  [-2] 4 hour close ) )'}},
        {' 2_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [2] 4 hour close >=  [-3] 4 hour close ) )'}},
        {' 3_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [3] 4 hour close >=  [-4] 4 hour close ) )'}},
        {' 4_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [4] 4 hour close >=  [-5] 4 hour close ) )'}},
        {' 5_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [5] 4 hour close >=  [-6] 4 hour close ) )'}},
        {' 6_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [6] 4 hour close >=  [-7] 4 hour close ) )'}},
        {' 7_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [7] 4 hour close >=  [-8] 4 hour close ) )'}},
        {' 8_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [8] 4 hour close >=  [-9] 4 hour close ) )'}},
        {' 9_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [9] 4 hour close >= [-10] 4 hour close ) )'}},
        {'10_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 4 hour close >= [-11] 4 hour close ) )'}},
        {'11_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 4 hour close >= [-12] 4 hour close ) )'}},
        {'12_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 4 hour close >= [-13] 4 hour close ) )'}},
        {'13_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 4 hour close >= [-14] 4 hour close ) )'}},
        {'14_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 4 hour close >= [-15] 4 hour close ) )'}},
        {'15_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 4 hour close >= [-16] 4 hour close ) )'}},
        {'16_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 4 hour close >= [-17] 4 hour close ) )'}},
        {'17_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 4 hour close >= [-18] 4 hour close ) )'}},
        {'18_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 4 hour close >= [-19] 4 hour close ) )'}},
        {'19_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 4 hour close >= [-20] 4 hour close ) )'}},
        {'20_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 4 hour close >= [-21] 4 hour close ) )'}},
        {'21_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 4 hour close >= [-22] 4 hour close ) )'}},
        {'22_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 4 hour close >= [-23] 4 hour close ) )'}},
        {'23_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 4 hour close >= [-24] 4 hour close ) )'}},
        {'24_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 4 hour close >= [-25] 4 hour close ) )'}},
        {'25_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 4 hour close >= [-26] 4 hour close ) )'}},
        {'26_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 4 hour close >= [-27] 4 hour close ) )'}},
        {'27_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 4 hour close >= [-28] 4 hour close ) )'}},
        {'28_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 4 hour close >= [-29] 4 hour close ) )'}},
        {'29_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 4 hour close >= [-30] 4 hour close ) )'}},
        {'30_4_hour__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 4 hour close >= [-31] 4 hour close ) )'}},
        {' 0_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [0] 4 hour close <=  [-1] 4 hour close ) )'}},
        {' 1_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [1] 4 hour close <=  [-2] 4 hour close ) )'}},
        {' 2_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [2] 4 hour close <=  [-3] 4 hour close ) )'}},
        {' 3_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [3] 4 hour close <=  [-4] 4 hour close ) )'}},
        {' 4_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [4] 4 hour close <=  [-5] 4 hour close ) )'}},
        {' 5_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [5] 4 hour close <=  [-6] 4 hour close ) )'}},
        {' 6_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [6] 4 hour close <=  [-7] 4 hour close ) )'}},
        {' 7_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [7] 4 hour close <=  [-8] 4 hour close ) )'}},
        {' 8_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [8] 4 hour close <=  [-9] 4 hour close ) )'}},
        {' 9_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [9] 4 hour close <= [-10] 4 hour close ) )'}},
        {'10_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [10] 4 hour close <= [-11] 4 hour close ) )'}},
        {'11_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [11] 4 hour close <= [-12] 4 hour close ) )'}},
        {'12_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [12] 4 hour close <= [-13] 4 hour close ) )'}},
        {'13_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [13] 4 hour close <= [-14] 4 hour close ) )'}},
        {'14_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [14] 4 hour close <= [-15] 4 hour close ) )'}},
        {'15_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [15] 4 hour close <= [-16] 4 hour close ) )'}},
        {'16_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [16] 4 hour close <= [-17] 4 hour close ) )'}},
        {'17_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [17] 4 hour close <= [-18] 4 hour close ) )'}},
        {'18_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [18] 4 hour close <= [-19] 4 hour close ) )'}},
        {'19_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [19] 4 hour close <= [-20] 4 hour close ) )'}},
        {'20_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [20] 4 hour close <= [-21] 4 hour close ) )'}},
        {'21_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [21] 4 hour close <= [-22] 4 hour close ) )'}},
        {'22_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [22] 4 hour close <= [-23] 4 hour close ) )'}},
        {'23_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [23] 4 hour close <= [-24] 4 hour close ) )'}},
        {'24_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [24] 4 hour close <= [-25] 4 hour close ) )'}},
        {'25_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [25] 4 hour close <= [-26] 4 hour close ) )'}},
        {'26_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [26] 4 hour close <= [-27] 4 hour close ) )'}},
        {'27_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [27] 4 hour close <= [-28] 4 hour close ) )'}},
        {'28_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [28] 4 hour close <= [-29] 4 hour close ) )'}},
        {'29_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [29] 4 hour close <= [-30] 4 hour close ) )'}},
        {'30_4_hour__4_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [30] 4 hour close <= [-31] 4 hour close ) )'}},
        {' 0_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [0] 1 hour close >=  [-1] 1 hour close ) )'}},
        {' 1_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [1] 1 hour close >=  [-2] 1 hour close ) )'}},
        {' 2_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [2] 1 hour close >=  [-3] 1 hour close ) )'}},
        {' 3_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [3] 1 hour close >=  [-4] 1 hour close ) )'}},
        {' 4_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [4] 1 hour close >=  [-5] 1 hour close ) )'}},
        {' 5_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [5] 1 hour close >=  [-6] 1 hour close ) )'}},
        {' 6_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [6] 1 hour close >=  [-7] 1 hour close ) )'}},
        {' 7_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [7] 1 hour close >=  [-8] 1 hour close ) )'}},
        {' 8_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [8] 1 hour close >=  [-9] 1 hour close ) )'}},
        {' 9_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [9] 1 hour close >= [-10] 1 hour close ) )'}},
        {'10_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 1 hour close >= [-11] 1 hour close ) )'}},
        {'11_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 1 hour close >= [-12] 1 hour close ) )'}},
        {'12_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 1 hour close >= [-13] 1 hour close ) )'}},
        {'13_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 1 hour close >= [-14] 1 hour close ) )'}},
        {'14_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 1 hour close >= [-15] 1 hour close ) )'}},
        {'15_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 1 hour close >= [-16] 1 hour close ) )'}},
        {'16_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 1 hour close >= [-17] 1 hour close ) )'}},
        {'17_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 1 hour close >= [-18] 1 hour close ) )'}},
        {'18_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 1 hour close >= [-19] 1 hour close ) )'}},
        {'19_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 1 hour close >= [-20] 1 hour close ) )'}},
        {'20_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 1 hour close >= [-21] 1 hour close ) )'}},
        {'21_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 1 hour close >= [-22] 1 hour close ) )'}},
        {'22_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 1 hour close >= [-23] 1 hour close ) )'}},
        {'23_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 1 hour close >= [-24] 1 hour close ) )'}},
        {'24_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 1 hour close >= [-25] 1 hour close ) )'}},
        {'25_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 1 hour close >= [-26] 1 hour close ) )'}},
        {'26_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 1 hour close >= [-27] 1 hour close ) )'}},
        {'27_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 1 hour close >= [-28] 1 hour close ) )'}},
        {'28_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 1 hour close >= [-29] 1 hour close ) )'}},
        {'29_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 1 hour close >= [-30] 1 hour close ) )'}},
        {'30_1_hour__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 1 hour close >= [-31] 1 hour close ) )'}},
        {' 0_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [0] 1 hour close <=  [-1] 1 hour close ) )'}},
        {' 1_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [1] 1 hour close <=  [-2] 1 hour close ) )'}},
        {' 2_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [2] 1 hour close <=  [-3] 1 hour close ) )'}},
        {' 3_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [3] 1 hour close <=  [-4] 1 hour close ) )'}},
        {' 4_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [4] 1 hour close <=  [-5] 1 hour close ) )'}},
        {' 5_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [5] 1 hour close <=  [-6] 1 hour close ) )'}},
        {' 6_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [6] 1 hour close <=  [-7] 1 hour close ) )'}},
        {' 7_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [7] 1 hour close <=  [-8] 1 hour close ) )'}},
        {' 8_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [8] 1 hour close <=  [-9] 1 hour close ) )'}},
        {' 9_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [9] 1 hour close <= [-10] 1 hour close ) )'}},
        {'10_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [10] 1 hour close <= [-11] 1 hour close ) )'}},
        {'11_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [11] 1 hour close <= [-12] 1 hour close ) )'}},
        {'12_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [12] 1 hour close <= [-13] 1 hour close ) )'}},
        {'13_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [13] 1 hour close <= [-14] 1 hour close ) )'}},
        {'14_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [14] 1 hour close <= [-15] 1 hour close ) )'}},
        {'15_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [15] 1 hour close <= [-16] 1 hour close ) )'}},
        {'16_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [16] 1 hour close <= [-17] 1 hour close ) )'}},
        {'17_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [17] 1 hour close <= [-18] 1 hour close ) )'}},
        {'18_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [18] 1 hour close <= [-19] 1 hour close ) )'}},
        {'19_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [19] 1 hour close <= [-20] 1 hour close ) )'}},
        {'20_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [20] 1 hour close <= [-21] 1 hour close ) )'}},
        {'21_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [21] 1 hour close <= [-22] 1 hour close ) )'}},
        {'22_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [22] 1 hour close <= [-23] 1 hour close ) )'}},
        {'23_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [23] 1 hour close <= [-24] 1 hour close ) )'}},
        {'24_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [24] 1 hour close <= [-25] 1 hour close ) )'}},
        {'25_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [25] 1 hour close <= [-26] 1 hour close ) )'}},
        {'26_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [26] 1 hour close <= [-27] 1 hour close ) )'}},
        {'27_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [27] 1 hour close <= [-28] 1 hour close ) )'}},
        {'28_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [28] 1 hour close <= [-29] 1 hour close ) )'}},
        {'29_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [29] 1 hour close <= [-30] 1 hour close ) )'}},
        {'30_1_hour__1_hourly__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [30] 1 hour close <= [-31] 1 hour close ) )'}},

        {' 0_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [0] 15 minute close >=  [-1] 15 minute close ) )'}},
        {' 1_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [1] 15 minute close >=  [-2] 15 minute close ) )'}},
        {' 2_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [2] 15 minute close >=  [-3] 15 minute close ) )'}},
        {' 3_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [3] 15 minute close >=  [-4] 15 minute close ) )'}},
        {' 4_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [4] 15 minute close >=  [-5] 15 minute close ) )'}},
        {' 5_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [5] 15 minute close >=  [-6] 15 minute close ) )'}},
        {' 6_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [6] 15 minute close >=  [-7] 15 minute close ) )'}},
        {' 7_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [7] 15 minute close >=  [-8] 15 minute close ) )'}},
        {' 8_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [8] 15 minute close >=  [-9] 15 minute close ) )'}},
        {' 9_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} (   [9] 15 minute close >= [-10] 15 minute close ) )'}},
        {'10_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 15 minute close >= [-11] 15 minute close ) )'}},
        {'11_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 15 minute close >= [-12] 15 minute close ) )'}},
        {'12_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 15 minute close >= [-13] 15 minute close ) )'}},
        {'13_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 15 minute close >= [-14] 15 minute close ) )'}},
        {'14_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 15 minute close >= [-15] 15 minute close ) )'}},
        {'15_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 15 minute close >= [-16] 15 minute close ) )'}},
        {'16_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 15 minute close >= [-17] 15 minute close ) )'}},
        {'17_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 15 minute close >= [-18] 15 minute close ) )'}},
        {'18_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 15 minute close >= [-19] 15 minute close ) )'}},
        {'19_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 15 minute close >= [-20] 15 minute close ) )'}},
        {'20_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 15 minute close >= [-21] 15 minute close ) )'}},
        {'21_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 15 minute close >= [-22] 15 minute close ) )'}},
        {'22_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 15 minute close >= [-23] 15 minute close ) )'}},
        {'23_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 15 minute close >= [-24] 15 minute close ) )'}},
        {'24_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 15 minute close >= [-25] 15 minute close ) )'}},
        {'25_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 15 minute close >= [-26] 15 minute close ) )'}},
        {'26_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 15 minute close >= [-27] 15 minute close ) )'}},
        {'27_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 15 minute close >= [-28] 15 minute close ) )'}},
        {'28_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 15 minute close >= [-29] 15 minute close ) )'}},
        {'29_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 15 minute close >= [-30] 15 minute close ) )'}},
        {'30_15_minute__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 15 minute close >= [-31] 15 minute close ) )'}},
        {' 0_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [0] 15 minute close <=  [-1] 15 minute close ) )'}},
        {' 1_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [1] 15 minute close <=  [-2] 15 minute close ) )'}},
        {' 2_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [2] 15 minute close <=  [-3] 15 minute close ) )'}},
        {' 3_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [3] 15 minute close <=  [-4] 15 minute close ) )'}},
        {' 4_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [4] 15 minute close <=  [-5] 15 minute close ) )'}},
        {' 5_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [5] 15 minute close <=  [-6] 15 minute close ) )'}},
        {' 6_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [6] 15 minute close <=  [-7] 15 minute close ) )'}},
        {' 7_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [7] 15 minute close <=  [-8] 15 minute close ) )'}},
        {' 8_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [8] 15 minute close <=  [-9] 15 minute close ) )'}},
        {' 9_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (   [9] 15 minute close <= [-10] 15 minute close ) )'}},
        {'10_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [10] 15 minute close <= [-11] 15 minute close ) )'}},
        {'11_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [11] 15 minute close <= [-12] 15 minute close ) )'}},
        {'12_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [12] 15 minute close <= [-13] 15 minute close ) )'}},
        {'13_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [13] 15 minute close <= [-14] 15 minute close ) )'}},
        {'14_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [14] 15 minute close <= [-15] 15 minute close ) )'}},
        {'15_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [15] 15 minute close <= [-16] 15 minute close ) )'}},
        {'16_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [16] 15 minute close <= [-17] 15 minute close ) )'}},
        {'17_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [17] 15 minute close <= [-18] 15 minute close ) )'}},
        {'18_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [18] 15 minute close <= [-19] 15 minute close ) )'}},
        {'19_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [19] 15 minute close <= [-20] 15 minute close ) )'}},
        {'20_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [20] 15 minute close <= [-21] 15 minute close ) )'}},
        {'21_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [21] 15 minute close <= [-22] 15 minute close ) )'}},
        {'22_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [22] 15 minute close <= [-23] 15 minute close ) )'}},
        {'23_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [23] 15 minute close <= [-24] 15 minute close ) )'}},
        {'24_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [24] 15 minute close <= [-25] 15 minute close ) )'}},
        {'25_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [25] 15 minute close <= [-26] 15 minute close ) )'}},
        {'26_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [26] 15 minute close <= [-27] 15 minute close ) )'}},
        {'27_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [27] 15 minute close <= [-28] 15 minute close ) )'}},
        {'28_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [28] 15 minute close <= [-29] 15 minute close ) )'}},
        {'29_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [29] 15 minute close <= [-30] 15 minute close ) )'}},
        {'30_15_minute__15_minute__less_than_equal_to'    : {'scan_clause': '( {segments_filter} (  [30] 15 minute close <= [-31] 15 minute close ) )'}},
        # {'price action 0 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest close >= 1 day ago close ) )'}},
        # {'price action 1 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 day ago close >= 2 days ago close ) )'}},
        # {'price action 2 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 day ago close >= 3 days ago close ) )'}},
        # {'price action 3 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 day ago close >= 4 days ago close ) )'}},
        # {'price action 4 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 day ago close >= 5 days ago close ) )'}},
        # {'price action 5 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 day ago close >= 6 days ago close ) )'}},
        # {'price action 6 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 day ago close >= 7 days ago close ) )'}},
        # {'price action 7 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 day ago close >= 8 days ago close ) )'}},
        # {'price action 8 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 day ago close >= 9 days ago close ) )'}},
        # {'price action 9 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 day ago close >= 10 days ago close ) )'}},
        # {'price action 10 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 day ago close >= 11 days ago close ) )'}},
        # {'price action 11 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 day ago close >= 12 days ago close ) )'}},
        # {'price action 12 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 day ago close >= 13 days ago close ) )'}},
        # {'price action 13 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 day ago close >= 14 days ago close ) )'}},
        # {'price action 14 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 day ago close >= 15 days ago close ) )'}},
        # {'price action 15 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 day ago close >= 16 days ago close ) )'}},
        # {'price action 16 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 day ago close >= 17 days ago close ) )'}},
        # {'price action 17 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 day ago close >= 18 days ago close ) )'}},
        # {'price action 18 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 day ago close >= 19 days ago close ) )'}},
        # {'price action 19 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 day ago close >= 20 days ago close ) )'}},
        # {'price action 20 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 day ago close >= 21 days ago close ) )'}},
        # {'price action 21 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 day ago close >= 22 days ago close ) )'}},
        # {'price action 22 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 day ago close >= 23 days ago close ) )'}},
        # {'price action 23 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 day ago close >= 24 days ago close ) )'}},
        # {'price action 24 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 day ago close >= 25 days ago close ) )'}},
        # {'price action 25 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 day ago close >= 26 days ago close ) )'}},
        # {'price action 26 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 day ago close >= 27 days ago close ) )'}},
        # {'price action 27 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 day ago close >= 28 days ago close ) )'}},
        # {'price action 28 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 day ago close >= 29 days ago close ) )'}},
        # {'price action 29 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 day ago close >= 30 days ago close ) )'}},
        # {'price action 30 candle__daily__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 day ago close >= 31 days ago close ) )'}},
        #
        # {'price action 0 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( latest close <= 1 day ago close ) )'}},
        # {'price action 1 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 day ago close <= 2 days ago close ) )'}},
        # {'price action 2 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 day ago close <= 3 days ago close ) )'}},
        # {'price action 3 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 day ago close <= 4 days ago close ) )'}},
        # {'price action 4 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 day ago close <= 5 days ago close ) )'}},
        # {'price action 5 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 day ago close <= 6 days ago close ) )'}},
        # {'price action 6 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 day ago close <= 7 days ago close ) )'}},
        # {'price action 7 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 day ago close <= 8 days ago close ) )'}},
        # {'price action 8 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 day ago close <= 9 days ago close ) )'}},
        # {'price action 9 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 day ago close <= 10 days ago close ) )'}},
        # {'price action 10 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 day ago close <= 11 days ago close ) )'}},
        # {'price action 11 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 day ago close <= 12 days ago close ) )'}},
        # {'price action 12 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 day ago close <= 13 days ago close ) )'}},
        # {'price action 13 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 day ago close <= 14 days ago close ) )'}},
        # {'price action 14 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 day ago close <= 15 days ago close ) )'}},
        # {'price action 15 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 day ago close <= 16 days ago close ) )'}},
        # {'price action 16 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 day ago close <= 17 days ago close ) )'}},
        # {'price action 17 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 day ago close <= 18 days ago close ) )'}},
        # {'price action 18 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 day ago close <= 19 days ago close ) )'}},
        # {'price action 19 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 day ago close <= 20 days ago close ) )'}},
        # {'price action 20 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 day ago close <= 21 days ago close ) )'}},
        # {'price action 21 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 day ago close <= 22 days ago close ) )'}},
        # {'price action 22 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 day ago close <= 23 days ago close ) )'}},
        # {'price action 23 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 day ago close <= 24 days ago close ) )'}},
        # {'price action 24 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 day ago close <= 25 days ago close ) )'}},
        # {'price action 25 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 day ago close <= 26 days ago close ) )'}},
        # {'price action 26 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 day ago close <= 27 days ago close ) )'}},
        # {'price action 27 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 day ago close <= 28 days ago close ) )'}},
        # {'price action 28 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 day ago close <= 29 days ago close ) )'}},
        # {'price action 29 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 day ago close <= 30 days ago close ) )'}},
        # {'price action 30 candle__daily__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 day ago close <= 31 days ago close ) )'}},
        #
        # {'price action 0 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour close >= [-1] 4 hour close ) )'}},
        # {'price action 1 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 4 hour close >= [-2] 4 hour close ) )'}},
        # {'price action 2 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 4 hour close >= [-3] 4 hour close ) )'}},
        # {'price action 3 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 4 hour close >= [-4] 4 hour close ) )'}},
        # {'price action 4 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 4 hour close >= [-5] 4 hour close ) )'}},
        # {'price action 5 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 4 hour close >= [-6] 4 hour close ) )'}},
        # {'price action 6 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 4 hour close >= [-7] 4 hour close ) )'}},
        # {'price action 7 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 4 hour close >= [-8] 4 hour close ) )'}},
        # {'price action 8 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 4 hour close >= [-9] 4 hour close ) )'}},
        # {'price action 9 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 4 hour close >= [-10] 4 hour close ) )'}},
        # {'price action 10 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 4 hour close >= [-11] 4 hour close ) )'}},
        # {'price action 11 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 4 hour close >= [-12] 4 hour close ) )'}},
        # {'price action 12 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 4 hour close >= [-13] 4 hour close ) )'}},
        # {'price action 13 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 4 hour close >= [-14] 4 hour close ) )'}},
        # {'price action 14 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 4 hour close >= [-15] 4 hour close ) )'}},
        # {'price action 15 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 4 hour close >= [-16] 4 hour close ) )'}},
        # {'price action 16 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 4 hour close >= [-17] 4 hour close ) )'}},
        # {'price action 17 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 4 hour close >= [-18] 4 hour close ) )'}},
        # {'price action 18 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 4 hour close >= [-19] 4 hour close ) )'}},
        # {'price action 19 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 4 hour close >= [-20] 4 hour close ) )'}},
        # {'price action 20 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 4 hour close >= [-21] 4 hour close ) )'}},
        # {'price action 21 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 4 hour close >= [-22] 4 hour close ) )'}},
        # {'price action 22 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 4 hour close >= [-23] 4 hour close ) )'}},
        # {'price action 23 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 4 hour close >= [-24] 4 hour close ) )'}},
        # {'price action 24 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 4 hour close >= [-25] 4 hour close ) )'}},
        # {'price action 25 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 4 hour close >= [-26] 4 hour close ) )'}},
        # {'price action 26 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 4 hour close >= [-27] 4 hour close ) )'}},
        # {'price action 27 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 4 hour close >= [-28] 4 hour close ) )'}},
        # {'price action 28 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 4 hour close >= [-29] 4 hour close ) )'}},
        # {'price action 29 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 4 hour close >= [-30] 4 hour close ) )'}},
        # {'price action 30 candle__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 4 hour close >= [-31] 4 hour close ) )'}},
        #
        # {'price action 0 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour close <= [-1] 4 hour close ) )'}},
        # {'price action 1 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 4 hour close <= [-2] 4 hour close ) )'}},
        # {'price action 2 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 4 hour close <= [-3] 4 hour close ) )'}},
        # {'price action 3 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 4 hour close <= [-4] 4 hour close ) )'}},
        # {'price action 4 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 4 hour close <= [-5] 4 hour close ) )'}},
        # {'price action 5 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 4 hour close <= [-6] 4 hour close ) )'}},
        # {'price action 6 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 4 hour close <= [-7] 4 hour close ) )'}},
        # {'price action 7 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 4 hour close <= [-8] 4 hour close ) )'}},
        # {'price action 8 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 4 hour close <= [-9] 4 hour close ) )'}},
        # {'price action 9 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 4 hour close <= [-10] 4 hour close ) )'}},
        # {'price action 10 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [10] 4 hour close <= [-11] 4 hour close ) )'}},
        # {'price action 11 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [11] 4 hour close <= [-12] 4 hour close ) )'}},
        # {'price action 12 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [12] 4 hour close <= [-13] 4 hour close ) )'}},
        # {'price action 13 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [13] 4 hour close <= [-14] 4 hour close ) )'}},
        # {'price action 14 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [14] 4 hour close <= [-15] 4 hour close ) )'}},
        # {'price action 15 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [15] 4 hour close <= [-16] 4 hour close ) )'}},
        # {'price action 16 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [16] 4 hour close <= [-17] 4 hour close ) )'}},
        # {'price action 17 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [17] 4 hour close <= [-18] 4 hour close ) )'}},
        # {'price action 18 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [18] 4 hour close <= [-19] 4 hour close ) )'}},
        # {'price action 19 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [19] 4 hour close <= [-20] 4 hour close ) )'}},
        # {'price action 20 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [20] 4 hour close <= [-21] 4 hour close ) )'}},
        # {'price action 21 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [21] 4 hour close <= [-22] 4 hour close ) )'}},
        # {'price action 22 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [22] 4 hour close <= [-23] 4 hour close ) )'}},
        # {'price action 23 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [23] 4 hour close <= [-24] 4 hour close ) )'}},
        # {'price action 24 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [24] 4 hour close <= [-25] 4 hour close ) )'}},
        # {'price action 25 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [25] 4 hour close <= [-26] 4 hour close ) )'}},
        # {'price action 26 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [26] 4 hour close <= [-27] 4 hour close ) )'}},
        # {'price action 27 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [27] 4 hour close <= [-28] 4 hour close ) )'}},
        # {'price action 28 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [28] 4 hour close <= [-29] 4 hour close ) )'}},
        # {'price action 29 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [29] 4 hour close <= [-30] 4 hour close ) )'}},
        # {'price action 30 candle__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [30] 4 hour close <= [-31] 4 hour close ) )'}},
        #
        # {'price action 0 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour close >= [-1] 1 hour close ) )'}},
        # {'price action 1 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 1 hour close >= [-2] 1 hour close ) )'}},
        # {'price action 2 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 1 hour close >= [-3] 1 hour close ) )'}},
        # {'price action 3 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 1 hour close >= [-4] 1 hour close ) )'}},
        # {'price action 4 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 1 hour close >= [-5] 1 hour close ) )'}},
        # {'price action 5 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 1 hour close >= [-6] 1 hour close ) )'}},
        # {'price action 6 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 1 hour close >= [-7] 1 hour close ) )'}},
        # {'price action 7 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 1 hour close >= [-8] 1 hour close ) )'}},
        # {'price action 8 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 1 hour close >= [-9] 1 hour close ) )'}},
        # {'price action 9 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 1 hour close >= [-10] 1 hour close ) )'}},
        # {'price action 10 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 1 hour close >= [-11] 1 hour close ) )'}},
        # {'price action 11 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 1 hour close >= [-12] 1 hour close ) )'}},
        # {'price action 12 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 1 hour close >= [-13] 1 hour close ) )'}},
        # {'price action 13 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 1 hour close >= [-14] 1 hour close ) )'}},
        # {'price action 14 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 1 hour close >= [-15] 1 hour close ) )'}},
        # {'price action 15 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 1 hour close >= [-16] 1 hour close ) )'}},
        # {'price action 16 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 1 hour close >= [-17] 1 hour close ) )'}},
        # {'price action 17 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 1 hour close >= [-18] 1 hour close ) )'}},
        # {'price action 18 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 1 hour close >= [-19] 1 hour close ) )'}},
        # {'price action 19 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 1 hour close >= [-20] 1 hour close ) )'}},
        # {'price action 20 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 1 hour close >= [-21] 1 hour close ) )'}},
        # {'price action 21 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 1 hour close >= [-22] 1 hour close ) )'}},
        # {'price action 22 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 1 hour close >= [-23] 1 hour close ) )'}},
        # {'price action 23 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 1 hour close >= [-24] 1 hour close ) )'}},
        # {'price action 24 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 1 hour close >= [-25] 1 hour close ) )'}},
        # {'price action 25 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 1 hour close >= [-26] 1 hour close ) )'}},
        # {'price action 26 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 1 hour close >= [-27] 1 hour close ) )'}},
        # {'price action 27 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 1 hour close >= [-28] 1 hour close ) )'}},
        # {'price action 28 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 1 hour close >= [-29] 1 hour close ) )'}},
        # {'price action 29 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 1 hour close >= [-30] 1 hour close ) )'}},
        # {'price action 30 candle__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 1 hour close >= [-31] 1 hour close ) )'}},
        #
        # {'price action 0 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour close <= [-1] 1 hour close ) )'}},
        # {'price action 1 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 1 hour close <= [-2] 1 hour close ) )'}},
        # {'price action 2 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 1 hour close <= [-3] 1 hour close ) )'}},
        # {'price action 3 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 1 hour close <= [-4] 1 hour close ) )'}},
        # {'price action 4 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 1 hour close <= [-5] 1 hour close ) )'}},
        # {'price action 5 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 1 hour close <= [-6] 1 hour close ) )'}},
        # {'price action 6 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 1 hour close <= [-7] 1 hour close ) )'}},
        # {'price action 7 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 1 hour close <= [-8] 1 hour close ) )'}},
        # {'price action 8 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 1 hour close <= [-9] 1 hour close ) )'}},
        # {'price action 9 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 1 hour close <= [-10] 1 hour close ) )'}},
        # {'price action 10 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [10] 1 hour close <= [-11] 1 hour close ) )'}},
        # {'price action 11 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [11] 1 hour close <= [-12] 1 hour close ) )'}},
        # {'price action 12 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [12] 1 hour close <= [-13] 1 hour close ) )'}},
        # {'price action 13 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [13] 1 hour close <= [-14] 1 hour close ) )'}},
        # {'price action 14 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [14] 1 hour close <= [-15] 1 hour close ) )'}},
        # {'price action 15 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [15] 1 hour close <= [-16] 1 hour close ) )'}},
        # {'price action 16 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [16] 1 hour close <= [-17] 1 hour close ) )'}},
        # {'price action 17 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [17] 1 hour close <= [-18] 1 hour close ) )'}},
        # {'price action 18 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [18] 1 hour close <= [-19] 1 hour close ) )'}},
        # {'price action 19 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [19] 1 hour close <= [-20] 1 hour close ) )'}},
        # {'price action 20 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [20] 1 hour close <= [-21] 1 hour close ) )'}},
        # {'price action 21 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [21] 1 hour close <= [-22] 1 hour close ) )'}},
        # {'price action 22 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [22] 1 hour close <= [-23] 1 hour close ) )'}},
        # {'price action 23 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [23] 1 hour close <= [-24] 1 hour close ) )'}},
        # {'price action 24 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [24] 1 hour close <= [-25] 1 hour close ) )'}},
        # {'price action 25 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [25] 1 hour close <= [-26] 1 hour close ) )'}},
        # {'price action 26 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [26] 1 hour close <= [-27] 1 hour close ) )'}},
        # {'price action 27 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [27] 1 hour close <= [-28] 1 hour close ) )'}},
        # {'price action 28 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [28] 1 hour close <= [-29] 1 hour close ) )'}},
        # {'price action 29 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [29] 1 hour close <= [-30] 1 hour close ) )'}},
        # {'price action 30 candle__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [30] 1 hour close <= [-31] 1 hour close ) )'}},
        #
        # {'price action 0 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute close >= [-1] 15 minute close ) )'}},
        # {'price action 1 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 15 minute close >= [-2] 15 minute close ) )'}},
        # {'price action 2 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 15 minute close >= [-3] 15 minute close ) )'}},
        # {'price action 3 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 15 minute close >= [-4] 15 minute close ) )'}},
        # {'price action 4 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 15 minute close >= [-5] 15 minute close ) )'}},
        # {'price action 5 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 15 minute close >= [-6] 15 minute close ) )'}},
        # {'price action 6 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 15 minute close >= [-7] 15 minute close ) )'}},
        # {'price action 7 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 15 minute close >= [-8] 15 minute close ) )'}},
        # {'price action 8 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 15 minute close >= [-9] 15 minute close ) )'}},
        # {'price action 9 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 15 minute close >= [-10] 15 minute close ) )'}},
        # {'price action 10 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-10] 15 minute close >= [-11] 15 minute close ) )'}},
        # {'price action 11 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-11] 15 minute close >= [-12] 15 minute close ) )'}},
        # {'price action 12 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-12] 15 minute close >= [-13] 15 minute close ) )'}},
        # {'price action 13 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-13] 15 minute close >= [-14] 15 minute close ) )'}},
        # {'price action 14 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-14] 15 minute close >= [-15] 15 minute close ) )'}},
        # {'price action 15 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-15] 15 minute close >= [-16] 15 minute close ) )'}},
        # {'price action 16 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-16] 15 minute close >= [-17] 15 minute close ) )'}},
        # {'price action 17 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-17] 15 minute close >= [-18] 15 minute close ) )'}},
        # {'price action 18 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-18] 15 minute close >= [-19] 15 minute close ) )'}},
        # {'price action 19 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-19] 15 minute close >= [-20] 15 minute close ) )'}},
        # {'price action 20 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-20] 15 minute close >= [-21] 15 minute close ) )'}},
        # {'price action 21 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-21] 15 minute close >= [-22] 15 minute close ) )'}},
        # {'price action 22 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-22] 15 minute close >= [-23] 15 minute close ) )'}},
        # {'price action 23 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-23] 15 minute close >= [-24] 15 minute close ) )'}},
        # {'price action 24 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-24] 15 minute close >= [-25] 15 minute close ) )'}},
        # {'price action 25 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-25] 15 minute close >= [-26] 15 minute close ) )'}},
        # {'price action 26 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-26] 15 minute close >= [-27] 15 minute close ) )'}},
        # {'price action 27 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-27] 15 minute close >= [-28] 15 minute close ) )'}},
        # {'price action 28 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-28] 15 minute close >= [-29] 15 minute close ) )'}},
        # {'price action 29 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-29] 15 minute close >= [-30] 15 minute close ) )'}},
        # {'price action 30 candle__15_minute__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [-30] 15 minute close >= [-31] 15 minute close ) )'}},
        #
        # {'price action 0 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute close <= [-1] 15 minute close ) )'}},
        # {'price action 1 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [1] 15 minute close <= [-2] 15 minute close ) )'}},
        # {'price action 2 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [2] 15 minute close <= [-3] 15 minute close ) )'}},
        # {'price action 3 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [3] 15 minute close <= [-4] 15 minute close ) )'}},
        # {'price action 4 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [4] 15 minute close <= [-5] 15 minute close ) )'}},
        # {'price action 5 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [5] 15 minute close <= [-6] 15 minute close ) )'}},
        # {'price action 6 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [6] 15 minute close <= [-7] 15 minute close ) )'}},
        # {'price action 7 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [7] 15 minute close <= [-8] 15 minute close ) )'}},
        # {'price action 8 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [8] 15 minute close <= [-9] 15 minute close ) )'}},
        # {'price action 9 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [9] 15 minute close <= [-10] 15 minute close ) )'}},
        # {'price action 10 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [10] 15 minute close <= [-11] 15 minute close ) )'}},
        # {'price action 11 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [11] 15 minute close <= [-12] 15 minute close ) )'}},
        # {'price action 12 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [12] 15 minute close <= [-13] 15 minute close ) )'}},
        # {'price action 13 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [13] 15 minute close <= [-14] 15 minute close ) )'}},
        # {'price action 14 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [14] 15 minute close <= [-15] 15 minute close ) )'}},
        # {'price action 15 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [15] 15 minute close <= [-16] 15 minute close ) )'}},
        # {'price action 16 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [16] 15 minute close <= [-17] 15 minute close ) )'}},
        # {'price action 17 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [17] 15 minute close <= [-18] 15 minute close ) )'}},
        # {'price action 18 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [18] 15 minute close <= [-19] 15 minute close ) )'}},
        # {'price action 19 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [19] 15 minute close <= [-20] 15 minute close ) )'}},
        # {'price action 20 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [20] 15 minute close <= [-21] 15 minute close ) )'}},
        # {'price action 21 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [21] 15 minute close <= [-22] 15 minute close ) )'}},
        # {'price action 22 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [22] 15 minute close <= [-23] 15 minute close ) )'}},
        # {'price action 23 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [23] 15 minute close <= [-24] 15 minute close ) )'}},
        # {'price action 24 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [24] 15 minute close <= [-25] 15 minute close ) )'}},
        # {'price action 25 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [25] 15 minute close <= [-26] 15 minute close ) )'}},
        # {'price action 26 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [26] 15 minute close <= [-27] 15 minute close ) )'}},
        # {'price action 27 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [27] 15 minute close <= [-28] 15 minute close ) )'}},
        # {'price action 28 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [28] 15 minute close <= [-29] 15 minute close ) )'}},
        # {'price action 29 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [29] 15 minute close <= [-30] 15 minute close ) )'}},
        # {'price action 30 candle__15_minute__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [30] 15 minute close <= [-31] 15 minute close ) )'}},
    ]
    segments = {'Cash': 'cash',
                # 'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
                }
    df_all = pd.DataFrame()
    for data_each_list in data_list:
        # start - iterate through the segments for one single url
        old_str = 'segments_filter'
        for each_segment_list in segments:
            new_str = segments[each_segment_list]
            data_each_list = {key: {k: val.replace(old_str, new_str)} for key, value in data_each_list.items() for k, val in value.items()}
            old_str = new_str
            key = next(iter(data_each_list))  # Gets the first key
        # end - iterate through the segments for one single url
            df = download_chart_ink_technical_analysis_scanner(data_each_list)
            df = insert_new_columns_in_data_frame(df, key, each_segment_list, start_date)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(f"complete '{key.replace("__",";").replace("_"," ")}' for {each_segment_list}")
    print(f"\ndownloading data from the website is complete.")
    insert_into_database_tables(df_all)
    print_end_timestamp(start_date, start_time)


if __name__ == "__main__":
    chat_ink_excel_file_download_every_15_minutes_and_insert_into_db()
