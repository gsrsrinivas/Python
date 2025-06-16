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
    else:
        print(f"Current Time: {current_timestamp} is outside of trading Hours i.e., 7:30 am to 15:30 pm "
              f"so existing the program")
        time.sleep(15)
        return None, None, "exit"

    return start_date, start_time, "continue"


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


def download_chart_ink_technical_analysis_scanner(data_each_list):
    with requests.Session() as s:
        for _, value in data_each_list.items():
            data = value
        # r = s.get(url_list[i])
        r = s.get('https://chartink.com/screener/watch-list-stocks-5')
        soup = Bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        return df


def insert_new_columns_in_data_frame(df,tf_l_i,each_segment_list,start_date):
    # reorder columns
    if len(df) > 0:
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # Rename columns
        df.rename(columns={'sr': 'sr#', 'name': 'stock name', 'nsecode': 'symbol', 'bsecode': 'Links',
                           'per_chg': '% Chg', 'close': 'price'}, inplace=True)
        # insert new columns
        part1, part2, part3 = tf_l_i.split('__')
        df.insert(7, 'Indicator', part1.replace("_"," "), allow_duplicates=True)
        df.insert(8, 'TimeLine', part2.replace("_"," "), allow_duplicates=True)
        df.insert(9, 'Direction', part3.replace("_"," "), allow_duplicates=True)
        df.insert(10, 'Segment', each_segment_list, allow_duplicates=True)
        df.insert(11, 'Batch_No', start_date.strftime('%Y%m%d'), allow_duplicates=True)
    return df


def chat_ink_excel_file_download_and_insert_into_db():
    start_date, start_time, status = print_start_timestamp()
    sys.exit() if status == "exit" else None
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
    ]
    segments = {'Cash': 'cash',
                'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
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
            df = insert_new_columns_in_data_frame(df,key,each_segment_list,start_date)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(f"complete '{key.replace("__",";").replace("_"," ")}' for {each_segment_list}")
    print(f"\ndownloading data from the website is complete.")
    insert_into_database_tables(df_all)
    print_end_timestamp(start_date, start_time)


if __name__ == "__main__":
    chat_ink_excel_file_download_and_insert_into_db()
