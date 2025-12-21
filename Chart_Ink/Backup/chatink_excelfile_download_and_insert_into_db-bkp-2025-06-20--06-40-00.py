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
        return start_date, start_time, "continue"
    else:
        print(f"Current Time: {current_timestamp} is outside of trading Hours i.e., 7:30 am to 15:30 pm "
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
    insert_query = '''INSERT INTO dbo.Cash_Stocks(sno,stock_name,symbol,bsecode,Percent_Change,price,volume,Indicator,TimeLine,Direction,Segments,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
    # Iterate over the DataFrame and insert data into the SQL Server table
    for index, row in df_all.iterrows():
        cursor.execute(insert_query, row['sno'], row['stock_name'], row['symbol'], row['bsecode'],
                       row['percent_change'],
                       row['price'], row['volume'], row['Indicator'], row['TimeLine'], row['Direction'],
                       row['segments'],
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


def download_chart_ink_technical_analysis_scanner(data_each_list):
    with requests.Session() as s:
        key, data = next(iter(data_each_list.items()))
        # for _, value in data_each_list.items():
        #     data = value
        # r = s.get(url_list[i])
        r = s.get('https://chartink.com/screener/watch-list-stocks-5')
        soup = Bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        print(f"Value: {r["scan_error"]} for rule: {key} {data}") if "scan_error" in r else None
        df = pd.DataFrame(r['data'])
        return df


def insert_new_columns_in_data_frame(df, tf_l_i, each_segment_list, start_date):
    # reorder columns
    if len(df) > 0:
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # Rename columns
        df.rename(columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                           'close': 'price'}, inplace=True)
        # insert new columns
        part1, part2, part3 = tf_l_i.split('__')
        df.insert(7, 'Indicator', part1.replace("_", " "), allow_duplicates=True)
        df.insert(8, 'TimeLine', part2.replace("_", " "), allow_duplicates=True)
        df.insert(9, 'Direction', part3.replace("_", " "), allow_duplicates=True)
        df.insert(10, 'segments', each_segment_list, allow_duplicates=True)
        df.insert(11, 'Batch_No', start_date.strftime('%Y%m%d'), allow_duplicates=True)
    return df


def chart_ink_excel_file_download_and_insert_into_db():
    start_date, start_time, status = print_start_timestamp()
    sys.exit() if status == "exit" else None
    # chart ink rule condition to download the stocks
    data_list = [
        # {'all_stocks' : {'scan_clause': '( {segments_filter} ( latest close >= 0 ) )'}},
        {'macd__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) >= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) <= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) >= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) <= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) <= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) <= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},

        {'stochastic__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) >= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) <= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) >= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) <= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) <= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) <= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},

        {'ema_5_13__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) >= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) <= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) >= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) <= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) <= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) <= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},

        {'ema_13_26__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) >= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) <= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) >= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) <= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) <= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) <= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},

        {'ema_50_100__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) >= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) <= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) >= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) <= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) <= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) <= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},

        {'ema_100_200__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) >= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) <= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) >= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) <= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) <= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) <= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},

        {'rsi__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}},

        {'upper_bollinger_band3__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) >= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) <= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) >= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) <= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) <= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) <= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},

        {'lower_bollinger_band3__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) >= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) <= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) >= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) <= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) >= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) >= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},

        {'upper_bollinger_band2__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) >= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) <= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) >= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) <= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) <= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) <= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},

        {'lower_bollinger_band2__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) >= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) <= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) >= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) <= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) >= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) >= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},

        {'volume__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly volume >= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly volume <= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly volume >= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly volume <= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly volume <= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly volume <= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},

        {'adx__yearly__crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) >= yearly adx di negative( 14 ) ) )'}},
        {'adx__yearly__crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) <= yearly adx di negative( 14 ) ) )'}},
        {'adx__quarterly__crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) >= quarterly adx di negative( 14 ) ) )'}},
        {'adx__quarterly__crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) <= quarterly adx di negative( 14 ) ) )'}},
        {'adx__monthly__crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) ) )'}},
        {'adx__monthly__crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) <= monthly adx di negative( 14 ) ) )'}},
        {'adx__weekly__crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) ) )'}},
        {'adx__weekly__crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) <= weekly adx di negative( 14 ) ) )'}},
        {'adx__daily__crosses_above': {
            'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}},
        {'adx__daily__crosses_below': {
            'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}},

        {'adx_up_tick__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly adx( 14 ) >= 1 year ago adx( 14 ) ) )'}},
        {'adx_down_tick__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly adx( 14 ) <= 1 year ago adx( 14 ) ) )'}},
        {'adx_up_tick__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) >= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_down_tick__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) <= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_up_tick__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly adx( 14 ) >= 1 month ago adx( 14 ) ) )'}},
        {'adx_down_tick__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly adx( 14 ) <= 1 month ago adx( 14 ) ) )'}},
        {'adx_up_tick__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly adx( 14 ) >= 1 week ago adx( 14 ) ) )'}},
        {'adx_down_tick__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly adx( 14 ) <= 1 week ago adx( 14 ) ) )'}},
        {'adx_up_tick__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}},
        {'adx_down_tick__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}},
        {'adx_up_tick__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_down_tick__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_up_tick__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_down_tick__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_up_tick__15_minutes__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}},
        {'adx_down_tick__15_minutes__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}},

        {' 0_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (    yearly close    >=  1 year ago close  ) )'}},
        {' 1_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 year ago close  >=  2 years ago close ) )'}},
        {' 2_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 years ago close >=  3 years ago close ) )'}},
        {' 3_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 years ago close >=  4 years ago close ) )'}},
        {' 4_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 years ago close >=  5 years ago close ) )'}},
        {' 5_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 years ago close >=  6 years ago close ) )'}},
        {' 6_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 years ago close >=  7 years ago close ) )'}},
        {' 7_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 years ago close >=  8 years ago close ) )'}},
        {' 8_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 years ago close >=  9 years ago close ) )'}},
        {' 9_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 years ago close >= 10 years ago close ) )'}},
        {'10_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 years ago close >= 11 years ago close ) )'}},
        {'11_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 years ago close >= 12 years ago close ) )'}},
        {'12_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 years ago close >= 13 years ago close ) )'}},
        {'13_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 years ago close >= 14 years ago close ) )'}},
        {'14_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 years ago close >= 15 years ago close ) )'}},
        {'15_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 years ago close >= 16 years ago close ) )'}},
        {'16_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 years ago close >= 17 years ago close ) )'}},
        {'17_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 years ago close >= 18 years ago close ) )'}},
        {'18_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 years ago close >= 19 years ago close ) )'}},
        {'19_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 years ago close >= 20 years ago close ) )'}},
        {'20_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 years ago close >= 21 years ago close ) )'}},
        {'21_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 years ago close >= 22 years ago close ) )'}},
        {'22_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 years ago close >= 23 years ago close ) )'}},
        {'23_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 years ago close >= 24 years ago close ) )'}},
        {'24_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 years ago close >= 25 years ago close ) )'}},
        {'25_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 years ago close >= 26 years ago close ) )'}},
        {'26_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 years ago close >= 27 years ago close ) )'}},
        {'27_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 years ago close >= 28 years ago close ) )'}},
        {'28_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 years ago close >= 29 years ago close ) )'}},
        {'29_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 years ago close >= 30 years ago close ) )'}},
        {'30_year__yearly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 years ago close >= 31 years ago close ) )'}},
        {' 0_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (    yearly close    <=  1 year ago close  ) )'}},
        {' 1_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 year ago close  <=  2 years ago close ) )'}},
        {' 2_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 years ago close <=  3 years ago close ) )'}},
        {' 3_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 years ago close <=  4 years ago close ) )'}},
        {' 4_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 years ago close <=  5 years ago close ) )'}},
        {' 5_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 years ago close <=  6 years ago close ) )'}},
        {' 6_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 years ago close <=  7 years ago close ) )'}},
        {' 7_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 years ago close <=  8 years ago close ) )'}},
        {' 8_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 years ago close <=  9 years ago close ) )'}},
        {' 9_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 years ago close <= 10 years ago close ) )'}},
        {'10_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 years ago close <= 11 years ago close ) )'}},
        {'11_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 years ago close <= 12 years ago close ) )'}},
        {'12_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 years ago close <= 13 years ago close ) )'}},
        {'13_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 years ago close <= 14 years ago close ) )'}},
        {'14_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 years ago close <= 15 years ago close ) )'}},
        {'15_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 years ago close <= 16 years ago close ) )'}},
        {'16_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 years ago close <= 17 years ago close ) )'}},
        {'17_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 years ago close <= 18 years ago close ) )'}},
        {'18_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 years ago close <= 19 years ago close ) )'}},
        {'19_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 years ago close <= 20 years ago close ) )'}},
        {'20_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 years ago close <= 21 years ago close ) )'}},
        {'21_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 years ago close <= 22 years ago close ) )'}},
        {'22_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 years ago close <= 23 years ago close ) )'}},
        {'23_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 years ago close <= 24 years ago close ) )'}},
        {'24_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 years ago close <= 25 years ago close ) )'}},
        {'25_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 years ago close <= 26 years ago close ) )'}},
        {'26_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 years ago close <= 27 years ago close ) )'}},
        {'27_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 years ago close <= 28 years ago close ) )'}},
        {'28_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 years ago close <= 29 years ago close ) )'}},
        {'29_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 years ago close <= 30 years ago close ) )'}},
        {'30_year__yearly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 years ago close <= 31 years ago close ) )'}},

        {' 0_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (    quarterly close    >=  1 quarter ago close  ) )'}},
        {' 1_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 quarter ago close  >=  2 quarters ago close ) )'}},
        {' 2_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 quarters ago close >=  3 quarters ago close ) )'}},
        {' 3_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 quarters ago close >=  4 quarters ago close ) )'}},
        {' 4_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 quarters ago close >=  5 quarters ago close ) )'}},
        {' 5_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 quarters ago close >=  6 quarters ago close ) )'}},
        {' 6_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 quarters ago close >=  7 quarters ago close ) )'}},
        {' 7_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 quarters ago close >=  8 quarters ago close ) )'}},
        {' 8_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 quarters ago close >=  9 quarters ago close ) )'}},
        {' 9_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 quarters ago close >= 10 quarters ago close ) )'}},
        {'10_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 quarters ago close >= 11 quarters ago close ) )'}},
        {'11_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 quarters ago close >= 12 quarters ago close ) )'}},
        {'12_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 quarters ago close >= 13 quarters ago close ) )'}},
        {'13_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 quarters ago close >= 14 quarters ago close ) )'}},
        {'14_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 quarters ago close >= 15 quarters ago close ) )'}},
        {'15_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 quarters ago close >= 16 quarters ago close ) )'}},
        {'16_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 quarters ago close >= 17 quarters ago close ) )'}},
        {'17_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 quarters ago close >= 18 quarters ago close ) )'}},
        {'18_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 quarters ago close >= 19 quarters ago close ) )'}},
        {'19_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 quarters ago close >= 20 quarters ago close ) )'}},
        {'20_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 quarters ago close >= 21 quarters ago close ) )'}},
        {'21_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 quarters ago close >= 22 quarters ago close ) )'}},
        {'22_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 quarters ago close >= 23 quarters ago close ) )'}},
        {'23_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 quarters ago close >= 24 quarters ago close ) )'}},
        {'24_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 quarters ago close >= 25 quarters ago close ) )'}},
        {'25_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 quarters ago close >= 26 quarters ago close ) )'}},
        {'26_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 quarters ago close >= 27 quarters ago close ) )'}},
        {'27_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 quarters ago close >= 28 quarters ago close ) )'}},
        {'28_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 quarters ago close >= 29 quarters ago close ) )'}},
        {'29_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 quarters ago close >= 30 quarters ago close ) )'}},
        {'30_quarter__quarterly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 quarters ago close >= 31 quarters ago close ) )'}},
        {' 0_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (    quarterly close    <=  1 quarter ago close  ) )'}},
        {' 1_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 quarter ago close  <=  2 quarters ago close ) )'}},
        {' 2_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 quarters ago close <=  3 quarters ago close ) )'}},
        {' 3_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 quarters ago close <=  4 quarters ago close ) )'}},
        {' 4_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 quarters ago close <=  5 quarters ago close ) )'}},
        {' 5_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 quarters ago close <=  6 quarters ago close ) )'}},
        {' 6_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 quarters ago close <=  7 quarters ago close ) )'}},
        {' 7_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 quarters ago close <=  8 quarters ago close ) )'}},
        {' 8_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 quarters ago close <=  9 quarters ago close ) )'}},
        {' 9_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 quarters ago close <= 10 quarters ago close ) )'}},
        {'10_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 quarters ago close <= 11 quarters ago close ) )'}},
        {'11_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 quarters ago close <= 12 quarters ago close ) )'}},
        {'12_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 quarters ago close <= 13 quarters ago close ) )'}},
        {'13_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 quarters ago close <= 14 quarters ago close ) )'}},
        {'14_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 quarters ago close <= 15 quarters ago close ) )'}},
        {'15_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 quarters ago close <= 16 quarters ago close ) )'}},
        {'16_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 quarters ago close <= 17 quarters ago close ) )'}},
        {'17_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 quarters ago close <= 18 quarters ago close ) )'}},
        {'18_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 quarters ago close <= 19 quarters ago close ) )'}},
        {'19_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 quarters ago close <= 20 quarters ago close ) )'}},
        {'20_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 quarters ago close <= 21 quarters ago close ) )'}},
        {'21_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 quarters ago close <= 22 quarters ago close ) )'}},
        {'22_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 quarters ago close <= 23 quarters ago close ) )'}},
        {'23_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 quarters ago close <= 24 quarters ago close ) )'}},
        {'24_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 quarters ago close <= 25 quarters ago close ) )'}},
        {'25_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 quarters ago close <= 26 quarters ago close ) )'}},
        {'26_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 quarters ago close <= 27 quarters ago close ) )'}},
        {'27_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 quarters ago close <= 28 quarters ago close ) )'}},
        {'28_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 quarters ago close <= 29 quarters ago close ) )'}},
        {'29_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 quarters ago close <= 30 quarters ago close ) )'}},
        {'30_quarter__quarterly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 quarters ago close <= 31 quarters ago close ) )'}},

        {' 0_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (    monthly close    >=  1 month ago close  ) )'}},
        {' 1_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 month ago close  >=  2 months ago close ) )'}},
        {' 2_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 months ago close >=  3 months ago close ) )'}},
        {' 3_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 months ago close >=  4 months ago close ) )'}},
        {' 4_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 months ago close >=  5 months ago close ) )'}},
        {' 5_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 months ago close >=  6 months ago close ) )'}},
        {' 6_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 months ago close >=  7 months ago close ) )'}},
        {' 7_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 months ago close >=  8 months ago close ) )'}},
        {' 8_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 months ago close >=  9 months ago close ) )'}},
        {' 9_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 months ago close >= 10 months ago close ) )'}},
        {'10_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 months ago close >= 11 months ago close ) )'}},
        {'11_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 months ago close >= 12 months ago close ) )'}},
        {'12_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 months ago close >= 13 months ago close ) )'}},
        {'13_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 months ago close >= 14 months ago close ) )'}},
        {'14_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 months ago close >= 15 months ago close ) )'}},
        {'15_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 months ago close >= 16 months ago close ) )'}},
        {'16_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 months ago close >= 17 months ago close ) )'}},
        {'17_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 months ago close >= 18 months ago close ) )'}},
        {'18_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 months ago close >= 19 months ago close ) )'}},
        {'19_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 months ago close >= 20 months ago close ) )'}},
        {'20_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 months ago close >= 21 months ago close ) )'}},
        {'21_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 months ago close >= 22 months ago close ) )'}},
        {'22_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 months ago close >= 23 months ago close ) )'}},
        {'23_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 months ago close >= 24 months ago close ) )'}},
        {'24_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 months ago close >= 25 months ago close ) )'}},
        {'25_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 months ago close >= 26 months ago close ) )'}},
        {'26_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 months ago close >= 27 months ago close ) )'}},
        {'27_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 months ago close >= 28 months ago close ) )'}},
        {'28_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 months ago close >= 29 months ago close ) )'}},
        {'29_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 months ago close >= 30 months ago close ) )'}},
        {'30_month__monthly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 months ago close >= 31 months ago close ) )'}},
        {' 0_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (    monthly close    <=  1 month ago close  ) )'}},
        {' 1_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 month ago close  <=  2 months ago close ) )'}},
        {' 2_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 months ago close <=  3 months ago close ) )'}},
        {' 3_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 months ago close <=  4 months ago close ) )'}},
        {' 4_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 months ago close <=  5 months ago close ) )'}},
        {' 5_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 months ago close <=  6 months ago close ) )'}},
        {' 6_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 months ago close <=  7 months ago close ) )'}},
        {' 7_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 months ago close <=  8 months ago close ) )'}},
        {' 8_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 months ago close <=  9 months ago close ) )'}},
        {' 9_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 months ago close <= 10 months ago close ) )'}},
        {'10_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 months ago close <= 11 months ago close ) )'}},
        {'11_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 months ago close <= 12 months ago close ) )'}},
        {'12_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 months ago close <= 13 months ago close ) )'}},
        {'13_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 months ago close <= 14 months ago close ) )'}},
        {'14_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 months ago close <= 15 months ago close ) )'}},
        {'15_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 months ago close <= 16 months ago close ) )'}},
        {'16_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 months ago close <= 17 months ago close ) )'}},
        {'17_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 months ago close <= 18 months ago close ) )'}},
        {'18_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 months ago close <= 19 months ago close ) )'}},
        {'19_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 months ago close <= 20 months ago close ) )'}},
        {'20_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 months ago close <= 21 months ago close ) )'}},
        {'21_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 months ago close <= 22 months ago close ) )'}},
        {'22_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 months ago close <= 23 months ago close ) )'}},
        {'23_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 months ago close <= 24 months ago close ) )'}},
        {'24_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 months ago close <= 25 months ago close ) )'}},
        {'25_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 months ago close <= 26 months ago close ) )'}},
        {'26_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 months ago close <= 27 months ago close ) )'}},
        {'27_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 months ago close <= 28 months ago close ) )'}},
        {'28_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 months ago close <= 29 months ago close ) )'}},
        {'29_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 months ago close <= 30 months ago close ) )'}},
        {'30_month__monthly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 months ago close <= 31 months ago close ) )'}},

        {' 0_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (    weekly close    >=  1 week ago close  ) )'}},
        {' 1_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 week ago close  >=  2 weeks ago close ) )'}},
        {' 2_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 weeks ago close >=  3 weeks ago close ) )'}},
        {' 3_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 weeks ago close >=  4 weeks ago close ) )'}},
        {' 4_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 weeks ago close >=  5 weeks ago close ) )'}},
        {' 5_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 weeks ago close >=  6 weeks ago close ) )'}},
        {' 6_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 weeks ago close >=  7 weeks ago close ) )'}},
        {' 7_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 weeks ago close >=  8 weeks ago close ) )'}},
        {' 8_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 weeks ago close >=  9 weeks ago close ) )'}},
        {' 9_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 weeks ago close >= 10 weeks ago close ) )'}},
        {'10_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 weeks ago close >= 11 weeks ago close ) )'}},
        {'11_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 weeks ago close >= 12 weeks ago close ) )'}},
        {'12_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 weeks ago close >= 13 weeks ago close ) )'}},
        {'13_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 weeks ago close >= 14 weeks ago close ) )'}},
        {'14_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 weeks ago close >= 15 weeks ago close ) )'}},
        {'15_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 weeks ago close >= 16 weeks ago close ) )'}},
        {'16_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 weeks ago close >= 17 weeks ago close ) )'}},
        {'17_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 weeks ago close >= 18 weeks ago close ) )'}},
        {'18_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 weeks ago close >= 19 weeks ago close ) )'}},
        {'19_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 weeks ago close >= 20 weeks ago close ) )'}},
        {'20_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 weeks ago close >= 21 weeks ago close ) )'}},
        {'21_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 weeks ago close >= 22 weeks ago close ) )'}},
        {'22_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 weeks ago close >= 23 weeks ago close ) )'}},
        {'23_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 weeks ago close >= 24 weeks ago close ) )'}},
        {'24_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 weeks ago close >= 25 weeks ago close ) )'}},
        {'25_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 weeks ago close >= 26 weeks ago close ) )'}},
        {'26_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 weeks ago close >= 27 weeks ago close ) )'}},
        {'27_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 weeks ago close >= 28 weeks ago close ) )'}},
        {'28_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 weeks ago close >= 29 weeks ago close ) )'}},
        {'29_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 weeks ago close >= 30 weeks ago close ) )'}},
        {'30_week__weekly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 weeks ago close >= 31 weeks ago close ) )'}},
        {' 0_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (    weekly close    <=  1 week ago close  ) )'}},
        {' 1_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  1 week ago close  <=  2 weeks ago close ) )'}},
        {' 2_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  2 weeks ago close <=  3 weeks ago close ) )'}},
        {' 3_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  3 weeks ago close <=  4 weeks ago close ) )'}},
        {' 4_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  4 weeks ago close <=  5 weeks ago close ) )'}},
        {' 5_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  5 weeks ago close <=  6 weeks ago close ) )'}},
        {' 6_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  6 weeks ago close <=  7 weeks ago close ) )'}},
        {' 7_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  7 weeks ago close <=  8 weeks ago close ) )'}},
        {' 8_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  8 weeks ago close <=  9 weeks ago close ) )'}},
        {' 9_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  9 weeks ago close <= 10 weeks ago close ) )'}},
        {'10_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 weeks ago close <= 11 weeks ago close ) )'}},
        {'11_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 weeks ago close <= 12 weeks ago close ) )'}},
        {'12_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 weeks ago close <= 13 weeks ago close ) )'}},
        {'13_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 weeks ago close <= 14 weeks ago close ) )'}},
        {'14_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 weeks ago close <= 15 weeks ago close ) )'}},
        {'15_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 weeks ago close <= 16 weeks ago close ) )'}},
        {'16_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 weeks ago close <= 17 weeks ago close ) )'}},
        {'17_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 weeks ago close <= 18 weeks ago close ) )'}},
        {'18_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 weeks ago close <= 19 weeks ago close ) )'}},
        {'19_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 weeks ago close <= 20 weeks ago close ) )'}},
        {'20_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 weeks ago close <= 21 weeks ago close ) )'}},
        {'21_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 weeks ago close <= 22 weeks ago close ) )'}},
        {'22_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 weeks ago close <= 23 weeks ago close ) )'}},
        {'23_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 weeks ago close <= 24 weeks ago close ) )'}},
        {'24_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 weeks ago close <= 25 weeks ago close ) )'}},
        {'25_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 weeks ago close <= 26 weeks ago close ) )'}},
        {'26_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 weeks ago close <= 27 weeks ago close ) )'}},
        {'27_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 weeks ago close <= 28 weeks ago close ) )'}},
        {'28_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 weeks ago close <= 29 weeks ago close ) )'}},
        {'29_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 weeks ago close <= 30 weeks ago close ) )'}},
        {'30_week__weekly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 weeks ago close <= 31 weeks ago close ) )'}},

        {' 0_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest close     >= 1 day ago close   ) )'}},
        {' 1_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 1 day ago close  >= 2 days ago close  ) )'}},
        {' 2_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 2 day ago close  >= 3 days ago close  ) )'}},
        {' 3_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 3 day ago close  >= 4 days ago close  ) )'}},
        {' 4_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 4 day ago close  >= 5 days ago close  ) )'}},
        {' 5_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 5 day ago close  >= 6 days ago close  ) )'}},
        {' 6_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 6 day ago close  >= 7 days ago close  ) )'}},
        {' 7_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 7 day ago close  >= 8 days ago close  ) )'}},
        {' 8_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 8 day ago close  >= 9 days ago close  ) )'}},
        {' 9_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 9 day ago close  >= 10 days ago close ) )'}},
        {'10_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 day ago close >= 11 days ago close ) )'}},
        {'11_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 day ago close >= 12 days ago close ) )'}},
        {'12_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 day ago close >= 13 days ago close ) )'}},
        {'13_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 day ago close >= 14 days ago close ) )'}},
        {'14_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 day ago close >= 15 days ago close ) )'}},
        {'15_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 day ago close >= 16 days ago close ) )'}},
        {'16_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 day ago close >= 17 days ago close ) )'}},
        {'17_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 day ago close >= 18 days ago close ) )'}},
        {'18_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 day ago close >= 19 days ago close ) )'}},
        {'19_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 day ago close >= 20 days ago close ) )'}},
        {'20_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 day ago close >= 21 days ago close ) )'}},
        {'21_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 day ago close >= 22 days ago close ) )'}},
        {'22_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 day ago close >= 23 days ago close ) )'}},
        {'23_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 day ago close >= 24 days ago close ) )'}},
        {'24_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 day ago close >= 25 days ago close ) )'}},
        {'25_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 day ago close >= 26 days ago close ) )'}},
        {'26_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 day ago close >= 27 days ago close ) )'}},
        {'27_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 day ago close >= 28 days ago close ) )'}},
        {'28_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 day ago close >= 29 days ago close ) )'}},
        {'29_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 day ago close >= 30 days ago close ) )'}},
        {'30_day__daily__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 day ago close >= 31 days ago close ) )'}},
        {'0_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest close <= 1 day ago close ) )'}},
        {'1_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 1 day ago close <= 2 days ago close ) )'}},
        {'2_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 2 day ago close <= 3 days ago close ) )'}},
        {'3_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 3 day ago close <= 4 days ago close ) )'}},
        {'4_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 4 day ago close <= 5 days ago close ) )'}},
        {'5_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 5 day ago close <= 6 days ago close ) )'}},
        {'6_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 6 day ago close <= 7 days ago close ) )'}},
        {'7_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 7 day ago close <= 8 days ago close ) )'}},
        {'8_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 8 day ago close <= 9 days ago close ) )'}},
        {'9_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 9 day ago close <= 10 days ago close  ) )'}},
        {'10_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 10 day ago close <= 11 days ago close ) )'}},
        {'11_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 11 day ago close <= 12 days ago close ) )'}},
        {'12_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 12 day ago close <= 13 days ago close ) )'}},
        {'13_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 13 day ago close <= 14 days ago close ) )'}},
        {'14_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 14 day ago close <= 15 days ago close ) )'}},
        {'15_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 15 day ago close <= 16 days ago close ) )'}},
        {'16_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 16 day ago close <= 17 days ago close ) )'}},
        {'17_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 17 day ago close <= 18 days ago close ) )'}},
        {'18_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 18 day ago close <= 19 days ago close ) )'}},
        {'19_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 19 day ago close <= 20 days ago close ) )'}},
        {'20_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 20 day ago close <= 21 days ago close ) )'}},
        {'21_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 21 day ago close <= 22 days ago close ) )'}},
        {'22_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 22 day ago close <= 23 days ago close ) )'}},
        {'23_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 23 day ago close <= 24 days ago close ) )'}},
        {'24_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 24 day ago close <= 25 days ago close ) )'}},
        {'25_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 25 day ago close <= 26 days ago close ) )'}},
        {'26_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 26 day ago close <= 27 days ago close ) )'}},
        {'27_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 27 day ago close <= 28 days ago close ) )'}},
        {'28_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 28 day ago close <= 29 days ago close ) )'}},
        {'29_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 29 day ago close <= 30 days ago close ) )'}},
        {'30_day__daily__less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( 30 day ago close <= 31 days ago close ) )'}},

        {' 0_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 4 hour close >=  [-1] 4 hour close ) )'}},
        {' 1_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 4 hour close >=  [-2] 4 hour close ) )'}},
        {' 2_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 4 hour close >=  [-3] 4 hour close ) )'}},
        {' 3_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 4 hour close >=  [-4] 4 hour close ) )'}},
        {' 4_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 4 hour close >=  [-5] 4 hour close ) )'}},
        {' 5_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 4 hour close >=  [-6] 4 hour close ) )'}},
        {' 6_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 4 hour close >=  [-7] 4 hour close ) )'}},
        {' 7_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 4 hour close >=  [-8] 4 hour close ) )'}},
        {' 8_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 4 hour close >=  [-9] 4 hour close ) )'}},
        {' 9_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 4 hour close >= [-10] 4 hour close ) )'}},
        {'10_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-10] 4 hour close >= [-11] 4 hour close ) )'}},
        {'11_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-11] 4 hour close >= [-12] 4 hour close ) )'}},
        {'12_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-12] 4 hour close >= [-13] 4 hour close ) )'}},
        {'13_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-13] 4 hour close >= [-14] 4 hour close ) )'}},
        {'14_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-14] 4 hour close >= [-15] 4 hour close ) )'}},
        {'15_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-15] 4 hour close >= [-16] 4 hour close ) )'}},
        {'16_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-16] 4 hour close >= [-17] 4 hour close ) )'}},
        {'17_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-17] 4 hour close >= [-18] 4 hour close ) )'}},
        {'18_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-18] 4 hour close >= [-19] 4 hour close ) )'}},
        {'19_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-19] 4 hour close >= [-20] 4 hour close ) )'}},
        {'20_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-20] 4 hour close >= [-21] 4 hour close ) )'}},
        {'21_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-21] 4 hour close >= [-22] 4 hour close ) )'}},
        {'22_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-22] 4 hour close >= [-23] 4 hour close ) )'}},
        {'23_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-23] 4 hour close >= [-24] 4 hour close ) )'}},
        {'24_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-24] 4 hour close >= [-25] 4 hour close ) )'}},
        {'25_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-25] 4 hour close >= [-26] 4 hour close ) )'}},
        {'26_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-26] 4 hour close >= [-27] 4 hour close ) )'}},
        {'27_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-27] 4 hour close >= [-28] 4 hour close ) )'}},
        {'28_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-28] 4 hour close >= [-29] 4 hour close ) )'}},
        {'29_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-29] 4 hour close >= [-30] 4 hour close ) )'}},
        {'30_4_hour__4_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-30] 4 hour close >= [-31] 4 hour close ) )'}},
        {' 0_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 4 hour close <=  [-1] 4 hour close ) )'}},
        {' 1_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 4 hour close <=  [-2] 4 hour close ) )'}},
        {' 2_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 4 hour close <=  [-3] 4 hour close ) )'}},
        {' 3_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 4 hour close <=  [-4] 4 hour close ) )'}},
        {' 4_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 4 hour close <=  [-5] 4 hour close ) )'}},
        {' 5_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 4 hour close <=  [-6] 4 hour close ) )'}},
        {' 6_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 4 hour close <=  [-7] 4 hour close ) )'}},
        {' 7_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 4 hour close <=  [-8] 4 hour close ) )'}},
        {' 8_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 4 hour close <=  [-9] 4 hour close ) )'}},
        {' 9_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 4 hour close <= [-10] 4 hour close ) )'}},
        {'10_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [10] 4 hour close <= [-11] 4 hour close ) )'}},
        {'11_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [11] 4 hour close <= [-12] 4 hour close ) )'}},
        {'12_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [12] 4 hour close <= [-13] 4 hour close ) )'}},
        {'13_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [13] 4 hour close <= [-14] 4 hour close ) )'}},
        {'14_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [14] 4 hour close <= [-15] 4 hour close ) )'}},
        {'15_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [15] 4 hour close <= [-16] 4 hour close ) )'}},
        {'16_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [16] 4 hour close <= [-17] 4 hour close ) )'}},
        {'17_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [17] 4 hour close <= [-18] 4 hour close ) )'}},
        {'18_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [18] 4 hour close <= [-19] 4 hour close ) )'}},
        {'19_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [19] 4 hour close <= [-20] 4 hour close ) )'}},
        {'20_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [20] 4 hour close <= [-21] 4 hour close ) )'}},
        {'21_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [21] 4 hour close <= [-22] 4 hour close ) )'}},
        {'22_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [22] 4 hour close <= [-23] 4 hour close ) )'}},
        {'23_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [23] 4 hour close <= [-24] 4 hour close ) )'}},
        {'24_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [24] 4 hour close <= [-25] 4 hour close ) )'}},
        {'25_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [25] 4 hour close <= [-26] 4 hour close ) )'}},
        {'26_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [26] 4 hour close <= [-27] 4 hour close ) )'}},
        {'27_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [27] 4 hour close <= [-28] 4 hour close ) )'}},
        {'28_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [28] 4 hour close <= [-29] 4 hour close ) )'}},
        {'29_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [29] 4 hour close <= [-30] 4 hour close ) )'}},
        {'30_4_hour__4_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [30] 4 hour close <= [-31] 4 hour close ) )'}},
        {' 0_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 1 hour close >=  [-1] 1 hour close ) )'}},
        {' 1_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 1 hour close >=  [-2] 1 hour close ) )'}},
        {' 2_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 1 hour close >=  [-3] 1 hour close ) )'}},
        {' 3_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 1 hour close >=  [-4] 1 hour close ) )'}},
        {' 4_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 1 hour close >=  [-5] 1 hour close ) )'}},
        {' 5_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 1 hour close >=  [-6] 1 hour close ) )'}},
        {' 6_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 1 hour close >=  [-7] 1 hour close ) )'}},
        {' 7_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 1 hour close >=  [-8] 1 hour close ) )'}},
        {' 8_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 1 hour close >=  [-9] 1 hour close ) )'}},
        {' 9_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 1 hour close >= [-10] 1 hour close ) )'}},
        {'10_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-10] 1 hour close >= [-11] 1 hour close ) )'}},
        {'11_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-11] 1 hour close >= [-12] 1 hour close ) )'}},
        {'12_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-12] 1 hour close >= [-13] 1 hour close ) )'}},
        {'13_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-13] 1 hour close >= [-14] 1 hour close ) )'}},
        {'14_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-14] 1 hour close >= [-15] 1 hour close ) )'}},
        {'15_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-15] 1 hour close >= [-16] 1 hour close ) )'}},
        {'16_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-16] 1 hour close >= [-17] 1 hour close ) )'}},
        {'17_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-17] 1 hour close >= [-18] 1 hour close ) )'}},
        {'18_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-18] 1 hour close >= [-19] 1 hour close ) )'}},
        {'19_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-19] 1 hour close >= [-20] 1 hour close ) )'}},
        {'20_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-20] 1 hour close >= [-21] 1 hour close ) )'}},
        {'21_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-21] 1 hour close >= [-22] 1 hour close ) )'}},
        {'22_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-22] 1 hour close >= [-23] 1 hour close ) )'}},
        {'23_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-23] 1 hour close >= [-24] 1 hour close ) )'}},
        {'24_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-24] 1 hour close >= [-25] 1 hour close ) )'}},
        {'25_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-25] 1 hour close >= [-26] 1 hour close ) )'}},
        {'26_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-26] 1 hour close >= [-27] 1 hour close ) )'}},
        {'27_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-27] 1 hour close >= [-28] 1 hour close ) )'}},
        {'28_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-28] 1 hour close >= [-29] 1 hour close ) )'}},
        {'29_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-29] 1 hour close >= [-30] 1 hour close ) )'}},
        {'30_1_hour__1_hourly__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-30] 1 hour close >= [-31] 1 hour close ) )'}},
        {' 0_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 1 hour close <=  [-1] 1 hour close ) )'}},
        {' 1_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 1 hour close <=  [-2] 1 hour close ) )'}},
        {' 2_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 1 hour close <=  [-3] 1 hour close ) )'}},
        {' 3_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 1 hour close <=  [-4] 1 hour close ) )'}},
        {' 4_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 1 hour close <=  [-5] 1 hour close ) )'}},
        {' 5_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 1 hour close <=  [-6] 1 hour close ) )'}},
        {' 6_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 1 hour close <=  [-7] 1 hour close ) )'}},
        {' 7_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 1 hour close <=  [-8] 1 hour close ) )'}},
        {' 8_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 1 hour close <=  [-9] 1 hour close ) )'}},
        {' 9_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 1 hour close <= [-10] 1 hour close ) )'}},
        {'10_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [10] 1 hour close <= [-11] 1 hour close ) )'}},
        {'11_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [11] 1 hour close <= [-12] 1 hour close ) )'}},
        {'12_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [12] 1 hour close <= [-13] 1 hour close ) )'}},
        {'13_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [13] 1 hour close <= [-14] 1 hour close ) )'}},
        {'14_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [14] 1 hour close <= [-15] 1 hour close ) )'}},
        {'15_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [15] 1 hour close <= [-16] 1 hour close ) )'}},
        {'16_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [16] 1 hour close <= [-17] 1 hour close ) )'}},
        {'17_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [17] 1 hour close <= [-18] 1 hour close ) )'}},
        {'18_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [18] 1 hour close <= [-19] 1 hour close ) )'}},
        {'19_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [19] 1 hour close <= [-20] 1 hour close ) )'}},
        {'20_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [20] 1 hour close <= [-21] 1 hour close ) )'}},
        {'21_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [21] 1 hour close <= [-22] 1 hour close ) )'}},
        {'22_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [22] 1 hour close <= [-23] 1 hour close ) )'}},
        {'23_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [23] 1 hour close <= [-24] 1 hour close ) )'}},
        {'24_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [24] 1 hour close <= [-25] 1 hour close ) )'}},
        {'25_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [25] 1 hour close <= [-26] 1 hour close ) )'}},
        {'26_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [26] 1 hour close <= [-27] 1 hour close ) )'}},
        {'27_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [27] 1 hour close <= [-28] 1 hour close ) )'}},
        {'28_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [28] 1 hour close <= [-29] 1 hour close ) )'}},
        {'29_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [29] 1 hour close <= [-30] 1 hour close ) )'}},
        {'30_1_hour__1_hourly__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [30] 1 hour close <= [-31] 1 hour close ) )'}},

        {' 0_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 15 minute close >=  [-1] 15 minute close ) )'}},
        {' 1_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 15 minute close >=  [-2] 15 minute close ) )'}},
        {' 2_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 15 minute close >=  [-3] 15 minute close ) )'}},
        {' 3_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 15 minute close >=  [-4] 15 minute close ) )'}},
        {' 4_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 15 minute close >=  [-5] 15 minute close ) )'}},
        {' 5_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 15 minute close >=  [-6] 15 minute close ) )'}},
        {' 6_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 15 minute close >=  [-7] 15 minute close ) )'}},
        {' 7_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 15 minute close >=  [-8] 15 minute close ) )'}},
        {' 8_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 15 minute close >=  [-9] 15 minute close ) )'}},
        {' 9_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 15 minute close >= [-10] 15 minute close ) )'}},
        {'10_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-10] 15 minute close >= [-11] 15 minute close ) )'}},
        {'11_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-11] 15 minute close >= [-12] 15 minute close ) )'}},
        {'12_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-12] 15 minute close >= [-13] 15 minute close ) )'}},
        {'13_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-13] 15 minute close >= [-14] 15 minute close ) )'}},
        {'14_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-14] 15 minute close >= [-15] 15 minute close ) )'}},
        {'15_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-15] 15 minute close >= [-16] 15 minute close ) )'}},
        {'16_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-16] 15 minute close >= [-17] 15 minute close ) )'}},
        {'17_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-17] 15 minute close >= [-18] 15 minute close ) )'}},
        {'18_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-18] 15 minute close >= [-19] 15 minute close ) )'}},
        {'19_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-19] 15 minute close >= [-20] 15 minute close ) )'}},
        {'20_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-20] 15 minute close >= [-21] 15 minute close ) )'}},
        {'21_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-21] 15 minute close >= [-22] 15 minute close ) )'}},
        {'22_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-22] 15 minute close >= [-23] 15 minute close ) )'}},
        {'23_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-23] 15 minute close >= [-24] 15 minute close ) )'}},
        {'24_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-24] 15 minute close >= [-25] 15 minute close ) )'}},
        {'25_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-25] 15 minute close >= [-26] 15 minute close ) )'}},
        {'26_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-26] 15 minute close >= [-27] 15 minute close ) )'}},
        {'27_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-27] 15 minute close >= [-28] 15 minute close ) )'}},
        {'28_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-28] 15 minute close >= [-29] 15 minute close ) )'}},
        {'29_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-29] 15 minute close >= [-30] 15 minute close ) )'}},
        {'30_15_minute__15_minute__greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [-30] 15 minute close >= [-31] 15 minute close ) )'}},
        {' 0_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [0] 15 minute close <=  [-1] 15 minute close ) )'}},
        {' 1_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [1] 15 minute close <=  [-2] 15 minute close ) )'}},
        {' 2_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [2] 15 minute close <=  [-3] 15 minute close ) )'}},
        {' 3_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [3] 15 minute close <=  [-4] 15 minute close ) )'}},
        {' 4_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [4] 15 minute close <=  [-5] 15 minute close ) )'}},
        {' 5_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [5] 15 minute close <=  [-6] 15 minute close ) )'}},
        {' 6_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [6] 15 minute close <=  [-7] 15 minute close ) )'}},
        {' 7_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [7] 15 minute close <=  [-8] 15 minute close ) )'}},
        {' 8_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [8] 15 minute close <=  [-9] 15 minute close ) )'}},
        {' 9_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (   [9] 15 minute close <= [-10] 15 minute close ) )'}},
        {'10_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [10] 15 minute close <= [-11] 15 minute close ) )'}},
        {'11_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [11] 15 minute close <= [-12] 15 minute close ) )'}},
        {'12_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [12] 15 minute close <= [-13] 15 minute close ) )'}},
        {'13_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [13] 15 minute close <= [-14] 15 minute close ) )'}},
        {'14_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [14] 15 minute close <= [-15] 15 minute close ) )'}},
        {'15_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [15] 15 minute close <= [-16] 15 minute close ) )'}},
        {'16_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [16] 15 minute close <= [-17] 15 minute close ) )'}},
        {'17_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [17] 15 minute close <= [-18] 15 minute close ) )'}},
        {'18_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [18] 15 minute close <= [-19] 15 minute close ) )'}},
        {'19_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [19] 15 minute close <= [-20] 15 minute close ) )'}},
        {'20_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [20] 15 minute close <= [-21] 15 minute close ) )'}},
        {'21_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [21] 15 minute close <= [-22] 15 minute close ) )'}},
        {'22_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [22] 15 minute close <= [-23] 15 minute close ) )'}},
        {'23_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [23] 15 minute close <= [-24] 15 minute close ) )'}},
        {'24_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [24] 15 minute close <= [-25] 15 minute close ) )'}},
        {'25_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [25] 15 minute close <= [-26] 15 minute close ) )'}},
        {'26_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [26] 15 minute close <= [-27] 15 minute close ) )'}},
        {'27_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [27] 15 minute close <= [-28] 15 minute close ) )'}},
        {'28_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [28] 15 minute close <= [-29] 15 minute close ) )'}},
        {'29_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [29] 15 minute close <= [-30] 15 minute close ) )'}},
        {'30_15_minute__15_minute__less_than_equal_to': {
            'scan_clause': '( {segments_filter} (  [30] 15 minute close <= [-31] 15 minute close ) )'}},
        # {'price action 0 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly close >= 1 year ago close ) )'}},
        # {'price action 1 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 year ago close >= 2 years ago close ) )'}},
        # {'price action 2 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 years ago close >= 3 years ago close ) )'}},
        # {'price action 3 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 years ago close >= 4 years ago close ) )'}},
        # {'price action 4 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 years ago close >= 5 years ago close ) )'}},
        # {'price action 5 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 years ago close >= 6 years ago close ) )'}},
        # {'price action 6 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 years ago close >= 7 years ago close ) )'}},
        # {'price action 7 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 years ago close >= 8 years ago close ) )'}},
        # {'price action 8 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 years ago close >= 9 years ago close ) )'}},
        # {'price action 9 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 years ago close >= 10 years ago close ) )'}},
        # {'price action 10 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 years ago close >= 11 years ago close ) )'}},
        # {'price action 11 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 years ago close >= 12 years ago close ) )'}},
        # {'price action 12 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 years ago close >= 13 years ago close ) )'}},
        # {'price action 13 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 years ago close >= 14 years ago close ) )'}},
        # {'price action 14 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 years ago close >= 15 years ago close ) )'}},
        # {'price action 15 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 years ago close >= 16 years ago close ) )'}},
        # {'price action 16 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 years ago close >= 17 years ago close ) )'}},
        # {'price action 17 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 years ago close >= 18 years ago close ) )'}},
        # {'price action 18 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 years ago close >= 19 years ago close ) )'}},
        # {'price action 19 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 years ago close >= 20 years ago close ) )'}},
        # {'price action 20 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 years ago close >= 21 years ago close ) )'}},
        # {'price action 21 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 years ago close >= 22 years ago close ) )'}},
        # {'price action 22 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 years ago close >= 23 years ago close ) )'}},
        # {'price action 23 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 years ago close >= 24 years ago close ) )'}},
        # {'price action 24 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 years ago close >= 25 years ago close ) )'}},
        # {'price action 25 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 years ago close >= 26 years ago close ) )'}},
        # {'price action 26 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 years ago close >= 27 years ago close ) )'}},
        # {'price action 27 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 years ago close >= 28 years ago close ) )'}},
        # {'price action 28 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 years ago close >= 29 years ago close ) )'}},
        # {'price action 29 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 years ago close >= 30 years ago close ) )'}},
        # {'price action 30 candle__yearly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 years ago close >= 31 years ago close ) )'}},
        #
        # {'price action 0 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( yearly close <= 1 year ago close ) )'}},
        # {'price action 1 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 year ago close <= 2 years ago close ) )'}},
        # {'price action 2 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 years ago close <= 3 years ago close ) )'}},
        # {'price action 3 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 years ago close <= 4 years ago close ) )'}},
        # {'price action 4 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 years ago close <= 5 years ago close ) )'}},
        # {'price action 5 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 years ago close <= 6 years ago close ) )'}},
        # {'price action 6 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 years ago close <= 7 years ago close ) )'}},
        # {'price action 7 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 years ago close <= 8 years ago close ) )'}},
        # {'price action 8 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 years ago close <= 9 years ago close ) )'}},
        # {'price action 9 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 years ago close <= 10 years ago close ) )'}},
        # {'price action 10 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 years ago close <= 11 years ago close ) )'}},
        # {'price action 11 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 years ago close <= 12 years ago close ) )'}},
        # {'price action 12 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 years ago close <= 13 years ago close ) )'}},
        # {'price action 13 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 years ago close <= 14 years ago close ) )'}},
        # {'price action 14 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 years ago close <= 15 years ago close ) )'}},
        # {'price action 15 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 years ago close <= 16 years ago close ) )'}},
        # {'price action 16 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 years ago close <= 17 years ago close ) )'}},
        # {'price action 17 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 years ago close <= 18 years ago close ) )'}},
        # {'price action 18 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 years ago close <= 19 years ago close ) )'}},
        # {'price action 19 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 years ago close <= 20 years ago close ) )'}},
        # {'price action 20 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 years ago close <= 21 years ago close ) )'}},
        # {'price action 21 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 years ago close <= 22 years ago close ) )'}},
        # {'price action 22 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 years ago close <= 23 years ago close ) )'}},
        # {'price action 23 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 years ago close <= 24 years ago close ) )'}},
        # {'price action 24 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 years ago close <= 25 years ago close ) )'}},
        # {'price action 25 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 years ago close <= 26 years ago close ) )'}},
        # {'price action 26 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 years ago close <= 27 years ago close ) )'}},
        # {'price action 27 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 years ago close <= 28 years ago close ) )'}},
        # {'price action 28 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 years ago close <= 29 years ago close ) )'}},
        # {'price action 29 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 years ago close <= 30 years ago close ) )'}},
        # {'price action 30 candle__yearly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 years ago close <= 31 years ago close ) )'}},
        #
        # {'price action 0 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly close >= 1 quarter ago close ) )'}},
        # {'price action 1 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 quarter ago close >= 2 quarters ago close ) )'}},
        # {'price action 2 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 quarters ago close >= 3 quarters ago close ) )'}},
        # {'price action 3 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 quarters ago close >= 4 quarters ago close ) )'}},
        # {'price action 4 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 quarters ago close >= 5 quarters ago close ) )'}},
        # {'price action 5 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 quarters ago close >= 6 quarters ago close ) )'}},
        # {'price action 6 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 quarters ago close >= 7 quarters ago close ) )'}},
        # {'price action 7 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 quarters ago close >= 8 quarters ago close ) )'}},
        # {'price action 8 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 quarters ago close >= 9 quarters ago close ) )'}},
        # {'price action 9 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 quarters ago close >= 10 quarters ago close ) )'}},
        # {'price action 10 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 quarters ago close >= 11 quarters ago close ) )'}},
        # {'price action 11 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 quarters ago close >= 12 quarters ago close ) )'}},
        # {'price action 12 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 quarters ago close >= 13 quarters ago close ) )'}},
        # {'price action 13 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 quarters ago close >= 14 quarters ago close ) )'}},
        # {'price action 14 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 quarters ago close >= 15 quarters ago close ) )'}},
        # {'price action 15 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 quarters ago close >= 16 quarters ago close ) )'}},
        # {'price action 16 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 quarters ago close >= 17 quarters ago close ) )'}},
        # {'price action 17 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 quarters ago close >= 18 quarters ago close ) )'}},
        # {'price action 18 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 quarters ago close >= 19 quarters ago close ) )'}},
        # {'price action 19 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 quarters ago close >= 20 quarters ago close ) )'}},
        # {'price action 20 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 quarters ago close >= 21 quarters ago close ) )'}},
        # {'price action 21 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 quarters ago close >= 22 quarters ago close ) )'}},
        # {'price action 22 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 quarters ago close >= 23 quarters ago close ) )'}},
        # {'price action 23 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 quarters ago close >= 24 quarters ago close ) )'}},
        # {'price action 24 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 quarters ago close >= 25 quarters ago close ) )'}},
        # {'price action 25 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 quarters ago close >= 26 quarters ago close ) )'}},
        # {'price action 26 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 quarters ago close >= 27 quarters ago close ) )'}},
        # {'price action 27 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 quarters ago close >= 28 quarters ago close ) )'}},
        # {'price action 28 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 quarters ago close >= 29 quarters ago close ) )'}},
        # {'price action 29 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 quarters ago close >= 30 quarters ago close ) )'}},
        # {'price action 30 candle__quarterly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 quarters ago close >= 31 quarters ago close ) )'}},
        #
        # {'price action 0 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( quarterly close <= 1 quarter ago close ) )'}},
        # {'price action 1 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 quarter ago close <= 2 quarters ago close ) )'}},
        # {'price action 2 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 quarters ago close <= 3 quarters ago close ) )'}},
        # {'price action 3 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 quarters ago close <= 4 quarters ago close ) )'}},
        # {'price action 4 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 quarters ago close <= 5 quarters ago close ) )'}},
        # {'price action 5 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 quarters ago close <= 6 quarters ago close ) )'}},
        # {'price action 6 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 quarters ago close <= 7 quarters ago close ) )'}},
        # {'price action 7 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 quarters ago close <= 8 quarters ago close ) )'}},
        # {'price action 8 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 quarters ago close <= 9 quarters ago close ) )'}},
        # {'price action 9 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 quarters ago close <= 10 quarters ago close ) )'}},
        # {'price action 10 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 quarters ago close <= 11 quarters ago close ) )'}},
        # {'price action 11 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 quarters ago close <= 12 quarters ago close ) )'}},
        # {'price action 12 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 quarters ago close <= 13 quarters ago close ) )'}},
        # {'price action 13 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 quarters ago close <= 14 quarters ago close ) )'}},
        # {'price action 14 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 quarters ago close <= 15 quarters ago close ) )'}},
        # {'price action 15 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 quarters ago close <= 16 quarters ago close ) )'}},
        # {'price action 16 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 quarters ago close <= 17 quarters ago close ) )'}},
        # {'price action 17 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 quarters ago close <= 18 quarters ago close ) )'}},
        # {'price action 18 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 quarters ago close <= 19 quarters ago close ) )'}},
        # {'price action 19 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 quarters ago close <= 20 quarters ago close ) )'}},
        # {'price action 20 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 quarters ago close <= 21 quarters ago close ) )'}},
        # {'price action 21 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 quarters ago close <= 22 quarters ago close ) )'}},
        # {'price action 22 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 quarters ago close <= 23 quarters ago close ) )'}},
        # {'price action 23 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 quarters ago close <= 24 quarters ago close ) )'}},
        # {'price action 24 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 quarters ago close <= 25 quarters ago close ) )'}},
        # {'price action 25 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 quarters ago close <= 26 quarters ago close ) )'}},
        # {'price action 26 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 quarters ago close <= 27 quarters ago close ) )'}},
        # {'price action 27 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 quarters ago close <= 28 quarters ago close ) )'}},
        # {'price action 28 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 quarters ago close <= 29 quarters ago close ) )'}},
        # {'price action 29 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 quarters ago close <= 30 quarters ago close ) )'}},
        # {'price action 30 candle__quarterly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 quarters ago close <= 31 quarters ago close ) )'}},
        #
        # {'price action 0 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly close >= 1 month ago close ) )'}},
        # {'price action 1 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 month ago close >= 2 months ago close ) )'}},
        # {'price action 2 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 months ago close >= 3 months ago close ) )'}},
        # {'price action 3 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 months ago close >= 4 months ago close ) )'}},
        # {'price action 4 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 months ago close >= 5 months ago close ) )'}},
        # {'price action 5 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 months ago close >= 6 months ago close ) )'}},
        # {'price action 6 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 months ago close >= 7 months ago close ) )'}},
        # {'price action 7 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 months ago close >= 8 months ago close ) )'}},
        # {'price action 8 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 months ago close >= 9 months ago close ) )'}},
        # {'price action 9 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 months ago close >= 10 months ago close ) )'}},
        # {'price action 10 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 months ago close >= 11 months ago close ) )'}},
        # {'price action 11 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 months ago close >= 12 months ago close ) )'}},
        # {'price action 12 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 months ago close >= 13 months ago close ) )'}},
        # {'price action 13 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 months ago close >= 14 months ago close ) )'}},
        # {'price action 14 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 months ago close >= 15 months ago close ) )'}},
        # {'price action 15 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 months ago close >= 16 months ago close ) )'}},
        # {'price action 16 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 months ago close >= 17 months ago close ) )'}},
        # {'price action 17 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 months ago close >= 18 months ago close ) )'}},
        # {'price action 18 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 months ago close >= 19 months ago close ) )'}},
        # {'price action 19 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 months ago close >= 20 months ago close ) )'}},
        # {'price action 20 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 months ago close >= 21 months ago close ) )'}},
        # {'price action 21 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 months ago close >= 22 months ago close ) )'}},
        # {'price action 22 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 months ago close >= 23 months ago close ) )'}},
        # {'price action 23 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 months ago close >= 24 months ago close ) )'}},
        # {'price action 24 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 months ago close >= 25 months ago close ) )'}},
        # {'price action 25 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 months ago close >= 26 months ago close ) )'}},
        # {'price action 26 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 months ago close >= 27 months ago close ) )'}},
        # {'price action 27 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 months ago close >= 28 months ago close ) )'}},
        # {'price action 28 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 months ago close >= 29 months ago close ) )'}},
        # {'price action 29 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 months ago close >= 30 months ago close ) )'}},
        # {'price action 30 candle__monthly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 months ago close >= 31 months ago close ) )'}},
        #
        # {'price action 0 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( monthly close <= 1 month ago close ) )'}},
        # {'price action 1 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 month ago close <= 2 months ago close ) )'}},
        # {'price action 2 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 months ago close <= 3 months ago close ) )'}},
        # {'price action 3 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 months ago close <= 4 months ago close ) )'}},
        # {'price action 4 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 months ago close <= 5 months ago close ) )'}},
        # {'price action 5 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 months ago close <= 6 months ago close ) )'}},
        # {'price action 6 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 months ago close <= 7 months ago close ) )'}},
        # {'price action 7 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 months ago close <= 8 months ago close ) )'}},
        # {'price action 8 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 months ago close <= 9 months ago close ) )'}},
        # {'price action 9 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 months ago close <= 10 months ago close ) )'}},
        # {'price action 10 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 months ago close <= 11 months ago close ) )'}},
        # {'price action 11 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 months ago close <= 12 months ago close ) )'}},
        # {'price action 12 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 months ago close <= 13 months ago close ) )'}},
        # {'price action 13 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 months ago close <= 14 months ago close ) )'}},
        # {'price action 14 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 months ago close <= 15 months ago close ) )'}},
        # {'price action 15 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 months ago close <= 16 months ago close ) )'}},
        # {'price action 16 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 months ago close <= 17 months ago close ) )'}},
        # {'price action 17 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 months ago close <= 18 months ago close ) )'}},
        # {'price action 18 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 months ago close <= 19 months ago close ) )'}},
        # {'price action 19 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 months ago close <= 20 months ago close ) )'}},
        # {'price action 20 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 months ago close <= 21 months ago close ) )'}},
        # {'price action 21 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 months ago close <= 22 months ago close ) )'}},
        # {'price action 22 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 months ago close <= 23 months ago close ) )'}},
        # {'price action 23 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 months ago close <= 24 months ago close ) )'}},
        # {'price action 24 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 months ago close <= 25 months ago close ) )'}},
        # {'price action 25 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 months ago close <= 26 months ago close ) )'}},
        # {'price action 26 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 months ago close <= 27 months ago close ) )'}},
        # {'price action 27 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 months ago close <= 28 months ago close ) )'}},
        # {'price action 28 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 months ago close <= 29 months ago close ) )'}},
        # {'price action 29 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 months ago close <= 30 months ago close ) )'}},
        # {'price action 30 candle__monthly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 months ago close <= 31 months ago close ) )'}},
        #
        # {'price action 0 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly close >= 1 week ago close ) )'}},
        # {'price action 1 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 week ago close >= 2 weeks ago close ) )'}},
        # {'price action 2 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 weeks ago close >= 3 weeks ago close ) )'}},
        # {'price action 3 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 weeks ago close >= 4 weeks ago close ) )'}},
        # {'price action 4 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 weeks ago close >= 5 weeks ago close ) )'}},
        # {'price action 5 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 weeks ago close >= 6 weeks ago close ) )'}},
        # {'price action 6 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 weeks ago close >= 7 weeks ago close ) )'}},
        # {'price action 7 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 weeks ago close >= 8 weeks ago close ) )'}},
        # {'price action 8 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 weeks ago close >= 9 weeks ago close ) )'}},
        # {'price action 9 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 weeks ago close >= 10 weeks ago close ) )'}},
        # {'price action 10 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 weeks ago close >= 11 weeks ago close ) )'}},
        # {'price action 11 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 weeks ago close >= 12 weeks ago close ) )'}},
        # {'price action 12 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 weeks ago close >= 13 weeks ago close ) )'}},
        # {'price action 13 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 weeks ago close >= 14 weeks ago close ) )'}},
        # {'price action 14 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 weeks ago close >= 15 weeks ago close ) )'}},
        # {'price action 15 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 weeks ago close >= 16 weeks ago close ) )'}},
        # {'price action 16 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 weeks ago close >= 17 weeks ago close ) )'}},
        # {'price action 17 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 weeks ago close >= 18 weeks ago close ) )'}},
        # {'price action 18 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 weeks ago close >= 19 weeks ago close ) )'}},
        # {'price action 19 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 weeks ago close >= 20 weeks ago close ) )'}},
        # {'price action 20 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 weeks ago close >= 21 weeks ago close ) )'}},
        # {'price action 21 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 weeks ago close >= 22 weeks ago close ) )'}},
        # {'price action 22 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 weeks ago close >= 23 weeks ago close ) )'}},
        # {'price action 23 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 weeks ago close >= 24 weeks ago close ) )'}},
        # {'price action 24 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 weeks ago close >= 25 weeks ago close ) )'}},
        # {'price action 25 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 weeks ago close >= 26 weeks ago close ) )'}},
        # {'price action 26 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 weeks ago close >= 27 weeks ago close ) )'}},
        # {'price action 27 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 weeks ago close >= 28 weeks ago close ) )'}},
        # {'price action 28 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 weeks ago close >= 29 weeks ago close ) )'}},
        # {'price action 29 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 weeks ago close >= 30 weeks ago close ) )'}},
        # {'price action 30 candle__weekly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 weeks ago close >= 31 weeks ago close ) )'}},
        #
        # {'price action 0 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( weekly close <= 1 week ago close ) )'}},
        # {'price action 1 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 1 week ago close <= 2 weeks ago close ) )'}},
        # {'price action 2 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 2 weeks ago close <= 3 weeks ago close ) )'}},
        # {'price action 3 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 3 weeks ago close <= 4 weeks ago close ) )'}},
        # {'price action 4 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 4 weeks ago close <= 5 weeks ago close ) )'}},
        # {'price action 5 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 5 weeks ago close <= 6 weeks ago close ) )'}},
        # {'price action 6 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 6 weeks ago close <= 7 weeks ago close ) )'}},
        # {'price action 7 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 7 weeks ago close <= 8 weeks ago close ) )'}},
        # {'price action 8 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 8 weeks ago close <= 9 weeks ago close ) )'}},
        # {'price action 9 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 9 weeks ago close <= 10 weeks ago close ) )'}},
        # {'price action 10 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 10 weeks ago close <= 11 weeks ago close ) )'}},
        # {'price action 11 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 11 weeks ago close <= 12 weeks ago close ) )'}},
        # {'price action 12 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 12 weeks ago close <= 13 weeks ago close ) )'}},
        # {'price action 13 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 13 weeks ago close <= 14 weeks ago close ) )'}},
        # {'price action 14 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 14 weeks ago close <= 15 weeks ago close ) )'}},
        # {'price action 15 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 15 weeks ago close <= 16 weeks ago close ) )'}},
        # {'price action 16 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 16 weeks ago close <= 17 weeks ago close ) )'}},
        # {'price action 17 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 17 weeks ago close <= 18 weeks ago close ) )'}},
        # {'price action 18 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 18 weeks ago close <= 19 weeks ago close ) )'}},
        # {'price action 19 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 19 weeks ago close <= 20 weeks ago close ) )'}},
        # {'price action 20 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 20 weeks ago close <= 21 weeks ago close ) )'}},
        # {'price action 21 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 21 weeks ago close <= 22 weeks ago close ) )'}},
        # {'price action 22 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 22 weeks ago close <= 23 weeks ago close ) )'}},
        # {'price action 23 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 23 weeks ago close <= 24 weeks ago close ) )'}},
        # {'price action 24 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 24 weeks ago close <= 25 weeks ago close ) )'}},
        # {'price action 25 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 25 weeks ago close <= 26 weeks ago close ) )'}},
        # {'price action 26 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 26 weeks ago close <= 27 weeks ago close ) )'}},
        # {'price action 27 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 27 weeks ago close <= 28 weeks ago close ) )'}},
        # {'price action 28 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 28 weeks ago close <= 29 weeks ago close ) )'}},
        # {'price action 29 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 29 weeks ago close <= 30 weeks ago close ) )'}},
        # {'price action 30 candle__weekly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( 30 weeks ago close <= 31 weeks ago close ) )'}},
        #
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
            data_each_list = {key: {k: val.replace(old_str, new_str)} for key, value in data_each_list.items() for
                              k, val in value.items()}
            old_str = new_str
            key = next(iter(data_each_list))  # Gets the first key
            # end - iterate through the segments for one single url
            df = download_chart_ink_technical_analysis_scanner(data_each_list)
            df = insert_new_columns_in_data_frame(df, key, each_segment_list, start_date)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(f"complete '{key.replace("__", ";").replace("_", " ")}' for {each_segment_list}")
    print(f"\ndownloading data from the website is complete.")
    insert_into_database_tables(df_all)
    print_end_timestamp(start_date, start_time)


if __name__ == "__main__":
    chart_ink_excel_file_download_and_insert_into_db()
