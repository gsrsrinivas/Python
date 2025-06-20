from bs4 import BeautifulSoup as Bs
from datetime import datetime
from pathlib import Path
import pandas as pd  # pip install --upgrade pandas --target="C:\Program Files\Python312\Lib\site-packages"
import requests
import pyodbc
import time
import sys


def print_start_timestamp():
    start_date = datetime.now()
    start_time = time.time()
    date_str = start_date.strftime('%Y-%m-%d')
    time_str = start_date.strftime('%H:%M:%S')
    print(f"Start date of script: {date_str} and time: {time_str}")
    # Define trading hours
    trading_start = datetime.strptime(f"{date_str} 07:30:00", "%Y-%m-%d %H:%M:%S")
    trading_end = datetime.strptime(f"{date_str} 15:30:00", "%Y-%m-%d %H:%M:%S")

    if trading_start <= start_date <= trading_end:
        print(f"Current Time: {time_str} is within trading hours (07:30 to 15:30). Continuing the program.")
        return start_date, start_time, "continue"
    else:
        print(f"Current Time: {time_str} is outside trading hours (07:30 to 15:30). Exiting the program.")
        time.sleep(15)
        return None, None, "exit"


def print_end_timestamp(start_date, start_time):
    end_time = time.time()
    end_date = datetime.now()
    end_date_formated = end_date.strftime('%Y-%m-%d')
    end_time_formatted = end_date.strftime('%H:%M:%S')
    elapsed_seconds = end_time - start_time
    print(f"End date of script: {end_date_formated} and time: {end_time_formatted}")
    elapsed_duration = end_date - start_date
    print(f"total time to complete in seconds: {elapsed_seconds:.2f}\nconverted to datetime format: {elapsed_duration}\n")
    time.sleep(15)


def insert_into_database_tables(df_all, table_names):
    print(f'started inserting into the database table')
    df_all = df_all.fillna(0)
    # Define connection string to SQL Server with Windows Authentication
    conn_str = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=DESKTOP-EP99LTB;DATABASE=Stocks_Analysis;Trusted_Connection=yes;'
    # Define the insert statement
    insert_query = f'''INSERT INTO _sis.{table_names[0]}(sr#,[stock name],symbol,Links,[% Chg],price,volume,Indicator,TimeLine,Direction,Segment,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
    input_folder_path = f"C:/Users/gsrsr/Documents/SQL Server Management Studio/Analysis of Stocks/Analysis of Stocks"
    file_paths = {
        "analysis_insert": Path(f"{input_folder_path}/{table_names[1]}.sql"),
        "report_update": Path(f"{input_folder_path}/{table_names[2]}.sql")
    }
    # Establish connection to SQL Server
    with pyodbc.connect(conn_str) as conn:
        cursor = conn.cursor()
        print(f'connection is established')
        records = df_all[[
            'sr#', 'stock name', 'symbol', 'Links', '% Chg',
            'price', 'volume', 'Indicator', 'TimeLine',
            'Direction', 'Segment', 'Batch_No'
        ]].values.tolist()
        cursor.executemany(insert_query, records)
        conn.commit()
        print(f"{len(records)} records inserted in {table_names[0]} table using batch insert!")
        # Execute both SQL Script files
        for label, path in file_paths.items():
            print(f"Executing {label} SQL script")
            with open(path, 'r', encoding='utf-8') as file_path:
                cursor.execute(file_path.read())
            conn.commit()
            print(f"{label.replace('_', ' ').capitalize()} committed")
    print("All operations completed")


def download_chart_ink_technical_analysis_scanner(data_each_list):
    """Fetches technical analysis data from Chart ink based on provided scan parameters."""
    key, data = next(iter(data_each_list.items()))
    with requests.Session() as session:
        # Step 1: Fetch CSRF token
        response = session.get('https://chartink.com/screener/watch-list-stocks-5')
        soup = Bs(response.content, 'lxml')
        csrf_token = soup.select_one('[name=csrf-token]')['content']
        session.headers['X-CSRF-TOKEN'] = csrf_token
        # Step 2: Submit scan data
        response = session.post('https://chartink.com/screener/process', data=data)
        result = response.json()
        # Step 3: Check for errors
        print(f"Scan error:{result["scan_error"]} for rule: {key} with data: {data}") if "scan_error" in result else None
        # Step 4: Convert to DataFrame
        return pd.DataFrame(result.get('data', []))


def insert_new_columns_in_data_frame(df,tf_l_i,each_segment_list,start_date):
    """
        Reorders, renames, and appends additional metadata columns to the stock DataFrame.
    """
    if df.empty:
        return df
    # Reorder columns by name to avoid hardcoded indexes
    expected_order = ['sr', 'nsecode', 'name', 'bsecode', 'per_chg', 'close', 'volume']
    df = df[expected_order]
    # Rename columns
    df.rename(columns={'sr': 'sr#', 'name': 'stock name', 'nsecode': 'symbol', 'bsecode': 'Links', 'per_chg': '% Chg', 'close': 'price'}, inplace=True)
    # Extract and clean metadata  # insert new columns
    indicator, timeline, direction = (part.replace("_", " ") for part in tf_l_i.split("__"))
    batch_no = start_date.strftime('%Y%m%d')
    # Insert new metadata columns
    df.loc[:, ['Indicator', 'TimeLine', 'Direction', 'Segment', 'Batch_No']] = [indicator, timeline, direction, each_segment_list, batch_no]
    return df


def chat_ink_excel_file_download_and_insert_into_db(data_list, table_names, start_date):
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
            df = insert_new_columns_in_data_frame(df,key,each_segment_list,start_date)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(f"complete '{key.replace("__",";").replace("_"," ")}' for {each_segment_list} segment as of {datetime.now()}")
    print(f"\ndownloading data from the website is complete.")
    insert_into_database_tables(df_all, table_names)

