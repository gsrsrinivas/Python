import ctypes
import logging
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timedelta
from functools import wraps
from logging.handlers import RotatingFileHandler
from pathlib import Path

import pandas as pd
import psutil
import pyodbc
import requests
import yfinance as yf
from bs4 import BeautifulSoup as Bs

# Constants from Windows API
ES_CONTINUOUS = 0x80000000
ES_SYSTEM_REQUIRED = 0x00000001
ES_AWAY_MODE_REQUIRED = 0x00000040  # Optional for media apps
window_flags = 0x80000000 | 0x00000001 | 0x00000040 # ES_Continuous, ES_System_Required, ES_Away_Mode_Required

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get the parent directory of the current file and add to sys.path


def project_directory_path():
    """
    Returns the parent directory path of the current file.
    This is useful for constructing paths relative to the script's location.
    """
    # Get the path of the current script
    current_file = Path(__file__).resolve()
    # Traverse upward to find the project root
    # You can define your root marker (like a folder name or a file)
    def find_project_root(start_path, marker=".git"):
        for path in start_path.parents:
            if (path / marker).exists():
                return path
        return start_path.parent  # fallback to one level up if marker not found

    project_root = find_project_root(current_file)
    # print("📁 \U0001F4C1 Project root:", project_root)
    return str(project_root)


def prevent_sleep():
    # This tells Windows: “Stay awake while this process is running”
    ctypes.windll.kernel32.SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_AWAY_MODE_REQUIRED)
    print("☀️ System will stay awake while task is running...")


def allow_sleep():
    # Restore the system’s sleep settings
    ctypes.windll.kernel32.SetThreadExecutionState(ES_CONTINUOUS)
    print("🌙 System can now sleep normally.")


def retry_on_error(max_retries=3, delay=60):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_retries):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_retries - 1:
                        print(f"Failed after {max_retries} attempts: {e}")
                        return None
                    time.sleep(delay * (2 ** attempt))  # Exponential backoff
            return None
        return wrapper
    return decorator

@retry_on_error(max_retries=3)
def safe_ticker(symbol):
    return yf.Ticker(symbol)


class StreamToLogger:
    # 🔄 Redirect print and stderr to logger
    def __init__(self, logger, log_level=logging.INFO):
        self.logger = logger
        self.log_level = log_level

    def write(self, message):
        message = message.strip()
        if message:
            self.logger.log(self.log_level, message)

    def flush(self):
        pass


def setup_logger(name="my_logger", log_file="execution.log", max_bytes=1024*1024*5, backup_count=5):
    # 🔁 Setup logger with rotating file +color console + print/sys.stderr redirection
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)
    # 🔄 Remove existing handlers to prevent duplicates
    if logger.hasHandlers():
        logger.handlers.clear()
    file_name = os.path.basename(log_file)
    log_file_path = os.path.join(project_directory_path(), '_Logs', file_name) # project_directory_path() + '\\_Logs\\' + file_name
    # 📝 Rotating file handler (UTF-8 compatible)
    file_handler = RotatingFileHandler(log_file_path, maxBytes=max_bytes, backupCount=backup_count, encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
    logger.addHandler(file_handler)
    # 📺 Console handler (UTF-8 compatible)
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.DEBUG)
    console_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
    logger.addHandler(console_handler)
    # 🔁 Redirect print() and sys.stderr to logger
    sys.stdout = StreamToLogger(logger, logging.INFO)
    sys.stderr = StreamToLogger(logger, logging.ERROR)
    return logger


def trading_hours_check():
    """
    Checks if the current time is within trading hours (07:30 to 15:30).
    Returns:
        - "continue" if within trading hours.
        - "exit" if outside trading hours.
    """
    current_time = datetime.now().time()
    start_time = datetime.strptime("09:00", "%H:%M").time()
    end_time = datetime.strptime("16:00", "%H:%M").time()

    if start_time <= current_time <= end_time:
        print(f"⏱️ Trading hours are (09:00 to 16:00) and current time is {current_time} ")
        print(f"Which is within trading hours. So continuing...")
        return "continue"
    else:
        print(f"⏱️ Trading hours are (09:00 to 16:00) and current time is {current_time} ")
        print(f"Which is outside trading hours. So exiting...")
        return "exit"


def print_start_timestamp():
    """ Prints the start date and time of the script execution."""
    start_date = datetime.now()
    print(f" 🚀 Start of script ".center(86, '='))
    print(f"🚀 Script start timestamp".ljust(30,' ') + ":" + f"{start_date}")


def print_end_timestamp():
    """
    Prints the end date and time of the script execution.
    Calculates the total time taken for the script to complete.
    This function also pauses for 15 seconds before exiting.
    It uses the psutil library to get the process creation time and calculates the elapsed time.
    It is useful for logging the execution time of the script.
    It does not take any arguments and does not return any value.
    Prints:
        - Start and end datetime of the script execution.
        - Total time taken in seconds.
        - Converted elapsed time in datetime format.
    Args: None
    Returns: None
    """
    p = psutil.Process(os.getpid())
    start_datetime = datetime.fromtimestamp(p.create_time())
    start_time = start_datetime.timestamp()  # Use timestamp for consistency

    end_date = datetime.now()
    print(f"🏁 Script finish timestamp".ljust(30,' ') + ":" + f"{end_date}")
    end_time = time.time()
    elapsed_seconds = end_time - start_time
    elapsed_duration = datetime.fromtimestamp(end_time) - datetime.fromtimestamp(start_time)

    print(f"⏰ Total time in seconds".ljust(30,' ') + ":" + f"{elapsed_seconds}")
    print(f"⏰ and formatted time is ".ljust(30,' ') + ":" + f"{elapsed_duration}\n")
    print(f" 🏁 end of script ".center(86, '*'))
    time.sleep(15)


def get_database_connection():
    """
    get the database connection and check if it is successful.
    Returns the variable with database connection otherwise return null.
    If the connection fails, it prints an error message and returns None.
    Returns:
        pyodbc.Connection: A connection object if successful, None otherwise.
    """
    try:
        # Define connection string to SQL Server with Windows Authentication
        conn_str = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=DESKTOP-EP99LTB;DATABASE=Stocks_Analysis;Trusted_Connection=yes;'
        with pyodbc.connect(conn_str) as conn:
            # print("🗄️Database connection successful.")
            return conn
    except pyodbc.Error as e:
        print(f"❌ Database connection failed: {e}")
        return None


def insert_into_db_from_data_frame(data_frame, table_name):
    """ Inserts data from a DataFrame into an SQL Server database table using batch insert.
    :param data_frame: DataFrame containing the data to be inserted.
    :param table_name: Name of the database table where data will be inserted.
    :return: None
    """
    with get_database_connection() as conn:
        cursor = conn.cursor()
        # start - Insert data into the database table using batch insert from DataFrame
        df_all = data_frame.fillna(0)  # Fill NaN values with 0 for numeric columns
        records = df_all[['sno', 'stock_name', 'symbol', 'bsecode', 'percent_change', 'price', 'volume',
                          'Indicator', 'TimeLine', 'Direction', 'segments', 'Batch_No']].values.tolist()
        # Define the insert statement
        insert_query = f'''INSERT INTO dbo.{table_name}(sno,stock_name,symbol,bsecode,Percent_Change,price,volume,Indicator,TimeLine,Direction,Segments,Batch_No)
        VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
        cursor.executemany(insert_query, records)
        conn.commit()
        print(f"✅ {len(records)} records inserted in {table_name} table using batch insert!")
        # end - Insert data into the database table using batch insert from DataFrame


def bulk_insert_from_csv(bulk_file_path, table_name):
    """ Inserts data from a CSV file into an SQL Server database table using BULK INSERT.
    :param bulk_file_path: Path to the CSV file to be inserted.
    :param table_name: Name of the database table where data will be inserted.
    :return: None
    """
    with get_database_connection() as conn:
        cursor = conn.cursor()
        # start - Bulk insert data from CSV file into the database table
        bulk_insert_query = (
                f" BULK INSERT dbo.{table_name} FROM '{bulk_file_path}' WITH \n"  # noqa
                + f" (   FIELDTERMINATOR = ',',  -- Column delimiter, e.g., comma for CSV \n"  # noqa
                + f"     ROWTERMINATOR = '\\n',   -- Row delimiter, newline character \n"  # noqa
                + f"     FIRSTROW = 2,           -- Skip header row if present (start at row 2) \n"  # noqa
                + f"     TABLOCK,                -- Optional: improve performance by locking the table \n"  # noqa
                + f"     KEEPIDENTITY            -- keep identity values from file \n"  # noqa
                + f" );")
        cursor.execute(bulk_insert_query)
        conn.commit()
        print(f"✅ Data inserted into {table_name} table using BULK INSERT!")
        # end - Bulk insert data from CSV file into the database table


def execute_sql_script(table_names):
    """ Executes an SQL script file against the Stocks_Analysis database.
    :param table_names: List containing the names of the database tables.
    :return: None
    """
    with get_database_connection() as conn:
        cursor = conn.cursor()
        # start - Get the file path of both SQL Script files
        project_path = project_directory_path()
        input_folder_path = project_path + r"\Database_Scripts\Analysis of Stocks"
        file_paths = {
            "insert_script_sql_file": Path(f"{input_folder_path}/{table_names[0]}.sql"),
            "update_report_sql_file": Path(f"{input_folder_path}/{table_names[1]}.sql") }
        # end - Get the file path of both SQL Script files
        # start - Execute both SQL Script files
        script_timeframe = "15minutes" if '15min' in table_names[2] else "daily"
        for label, path in file_paths.items():
            print(f"⏳ Executing {label.replace('_', ' ').capitalize()} for {script_timeframe}")
            with open(path, 'r', encoding='utf-8') as file_path:
                if '15min' in table_names[2]:
                    sql_script = file_path.read().replace("_Stocks","_15Minutes_Stocks")
                else:
                    sql_script = file_path.read()
                cursor.execute(sql_script)
            conn.commit()
            print(f"✅ Committed {label.replace('_', ' ').capitalize()} for {script_timeframe}")
        # end - Execute both SQL Script files
    print("✅ Completed all script files execution\n")


def insert_into_database_tables(table_names, bulk_file_path=None, data_frame=None):
    """ Inserts data from a DataFrame into an SQL Server database table and executes SQL scripts.
    Args:
        df_all (pd.DataFrame): DataFrame containing the data to be inserted
        table_names (list): List containing the names of the database tables.
    Returns:
        None
        :param table_names:
        :param data_frame:
        :param bulk_file_path:
    """
    print(f'📥 started inserting into the database table')
    if bulk_file_path is not None:
        bulk_insert_from_csv(bulk_file_path, table_names[2])  # Insert data from CSV file into the database table
    else:
        insert_into_db_from_data_frame(data_frame, table_names[2])  # Insert data from DataFrame into the database table
    if table_names[0]!='':
        execute_sql_script(table_names)


def insert_new_columns_in_data_frame(df, tf_l_i, each_segment_list):
    """ reorders, renames, and appends additional metadata columns to the stock DataFrame.
    Args:
        df (pd.DataFrame): The DataFrame containing stock data
        tf_l_i (str): A string containing indicator, timeline, and direction information
        each_segment_list (str): The segments of the stock market (e.g., 'Cash')
    Returns:
        pd.DataFrame: The modified DataFrame with new columns and reordered data.
        :param df:
        :param tf_l_i:
        :param each_segment_list:
    """
    if df.empty:
        return df
    # Reorder columns by name to avoid hardcoded indexes
    expected_order = ['sr', 'nsecode', 'name', 'bsecode', 'per_chg', 'close', 'volume']
    df = df[expected_order]
    # Rename columns
    df.rename(columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change', 'close': 'price'}, inplace=True)
    # Extract and clean metadata # insert new columns
    indicator, timeline, direction = (part.replace("_", " ") for part in tf_l_i.split("__"))
    # Insert new metadata columns
    df.loc[:, ['Indicator', 'TimeLine', 'Direction', 'segments']] = [indicator, timeline, direction, each_segment_list]
    return df


def download_chart_ink_technical_analysis_scanner(key, data, segment_val, max_retries = 5):
    """
    Fetches technical analysis data from Chart ink based on provided scan parameters.
    Args:
        data_each_list (dict): A dictionary containing scan parameters for Chart ink.
    Returns:
        pd.DataFrame: A DataFrame containing the scan results.
    Raises:
        KeyError: If the expected keys are not found in the response.
    Raises:
        requests.RequestException: If there is an issue with the HTTP request.
        :param key:
        :param data:
        :param segment_val:
        :param max_retries:
    """
    # key, data = next(iter(data_each_list.items()))
    with requests.Session() as session:
        response = session.get('https://chartink.com/screener/watch-list-stocks-5') # Step 1: Fetch CSRF token
        soup = Bs(response.content, 'lxml')
        csrf_token = soup.select_one('[name=csrf-token]')['content']
        session.headers['X-CSRF-TOKEN'] = csrf_token
        # session.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
        for attempt in range(max_retries): # Retry logic loop
            try: # Step 2: Submit scan data
                response = session.post('https://chartink.com/screener/process', data=data)
                if response.status_code == 429:
                    retry_after = int(response.headers.get("Retry-After", 2 ** attempt))
                    print(f"❌ Rate limited on attempt {attempt + 1}. Retrying after {retry_after} seconds...")
                    time.sleep(retry_after)
                    continue
                response.raise_for_status()
                result = response.json()
                if "scan_error" in result: # Step 3: Check for errors
                    print(f"❌ Scan error:{result['scan_error']} for rule: {key} with data: {data}")
                df = pd.DataFrame(result.get('data', [])) # Step 4: Convert to DataFrame
                df = insert_new_columns_in_data_frame(df, key, segment_val)
                print(f"complete - '{str(key.replace("__", ";").replace("_", " ")).ljust(56,' ')}' - {segment_val} segments ")
                return df
            except requests.RequestException as e:
                print(f"❌ {key}-{data} Request failed on attempt {attempt + 1}: {e}")
                time.sleep(2 ** attempt)  # Exponential backoff
        return None


def chart_ink_file_download_and_insert_db(data_list):
    """
    Downloads technical analysis data from Chart ink for multiple segments and inserts it into a database.
    :param data_list: It contains the scan parameters for Chart ink.
    :return:
    1. Download technical analysis data from Chart ink for multiple segments.
    2. Insert the downloaded data into a database table.
    3. Prints progress messages to the console.
    :raises KeyError: If the expected keys are not found in the response.
    :raises requests.RequestException: If there is an issue with the HTTP request.
    """
    segments = {'Cash': 'cash',
                # 'Nifty 500':'57960','BankNifty':'136699','ETFs':'166311','Futures':'33489','Gold ETFs':'167068','Indices':'45603','Mid-Cap 50':'136492','Nifty 100':'33619','Nifty 200':'46553','Nifty 50':'33492','Nifty 500 Multi Cap 50:25:25':'1090574','Nifty and BankNifty':'109630','Nifty Large Mid-Cap 250':'1090573','Nifty Micro Cap 250':'1090582','Nifty Mid-Cap 100':'1090585','Nifty Mid-Cap 150':'1090588','Nifty Mid-Cap 50':'1090591','Nifty Mid-Cap Select':'1090579','Nifty Mid-Small Cap 400':'1090575','Nifty Next 50':'1116352','Nifty Small Cap 100':'1090587','Nifty Small Cap 250':'1090572','Nifty Small Cap 50':'1090568','Silver ETFs':'1195362',
                }
    df_all = pd.DataFrame()
    with ThreadPoolExecutor(max_workers=250) as executor:
        futures = []
        for data_each_list in data_list:
    # ------start - iterate through the segments for one single url--------------------
            old_str = 'segments_filter'
            for each_segment_list in segments:
                new_str = segments[each_segment_list]
                data_each_list = {key: {k: val.replace(old_str, new_str)} for key, value in data_each_list.items() for k, val in value.items()}
                old_str = new_str
                key, data = next(iter(data_each_list.items())) # Gets the first key and iterate through the segments for one single url
    # ------ended - iterate through the segments for one single url----------------------
                # Submit the download task to the executor
                futures.append(executor.submit(download_chart_ink_technical_analysis_scanner,key, data, each_segment_list))
        print(f"🔄 started downloading data from the website for {len(futures)} segments.")
        # Collect results as they complete
        for future in futures:
            df = future.result()
            df_all = pd.concat([df_all, df], ignore_index=True)
    print(f"\n🔄 downloading data from the website is complete.")
    batch_no = datetime.now().strftime('%Y%m%d%H%M%S')
    df_all['Batch_No'] = batch_no  # Add batch number to the DataFrame
    # insert_into_database_tables(df_all, table_names)
    return df_all


def chart_ink_to_csv(df, file_name, file_name_with_timestamp=False):
    """ Saves a DataFrame to a CSV file in the Chart_Ink/Source directory.
    :param df:
    :param file_name:
    :param file_name_with_timestamp:
    :return:
    """
    print(f"📥 started saving data to CSV file")
    str_datetime = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
    # file_nm = file_name if '15mins' in file_name else f'{file_name}---{str_datetime}'
    file_nm = file_name if file_name_with_timestamp == False else f'{file_name}---{str_datetime}'
    output_file = Path(project_directory_path()) / 'Chart_Ink/Source' / f'{file_nm}.csv'
    print(f"📥 Saving data to CSV file: {output_file}")
    if df.empty:
        print("❌ No data to save. DataFrame is empty.")
        return None
    df.to_csv(output_file, index=False) # Save to CSV
    print("✅ Data saved to csv file successfully.")
    return output_file


def data_lists_above_daily():
    data_list1 = [
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

        {'ema_50_200__yearly__crosses_above' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) >= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_50_200__yearly__crosses_below' : {'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) <= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_50_200__quarterly__crosses_above' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) >= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_50_200__quarterly__crosses_below' : {'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) <= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_50_200__monthly__crosses_above' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_50_200__monthly__crosses_below' : {'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) <= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_50_200__weekly__crosses_above' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_50_200__weekly__crosses_below' : {'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) <= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_50_200__daily__crosses_above' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 200 ) ) )'}},
        {'ema_50_200__daily__crosses_below' : {'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 200 ) ) )'}},

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

        {'volume__yearly__shockers': {'scan_clause': '( {segments_filter} ( yearly volume > yearly sma( volume,20 ) * 5 ) )'}},
        {'volume__quarterly__shockers': {'scan_clause': '( {segments_filter} ( quarterly volume > quarterly sma( volume,20 ) * 5 ) )'}},
        {'volume__monthly__shockers': {'scan_clause': '( {segments_filter} ( monthly volume > monthly sma( volume,20 ) * 5 ) )'}},
        {'volume__weekly__shockers': {'scan_clause': '( {segments_filter} ( weekly volume > weekly sma( volume,20 ) * 5 ) )'}},
        {'volume__daily__shockers': {'scan_clause': '( {segments_filter} ( latest volume > latest sma( volume,20 ) * 5 ) )'}},

        {'double_bottom__yearly__setup'     : {'scan_clause': '( {segments_filter} ( yearly low <= 1 year ago min( 2000 , yearly close ) and ( {cash} (5 years ago low <= yearly min( 2000 , yearly close ) or  6 years ago low <= yearly min( 2000 , yearly close ) or  7 years ago low <= yearly min( 2000 , yearly close ) or  8 years ago low <= yearly min( 2000 , yearly close ) or  9 years ago low <= yearly min( 2000 , yearly close ) or 10 years ago low <= yearly min( 2000 , yearly close ) or 11 years ago low <= yearly min( 2000 , yearly close ) or 12 years ago low <= yearly min( 2000 , yearly close ) or 13 years ago low <= yearly min( 2000 , yearly close ) or 14 years ago low <= yearly min( 2000 , yearly close ) or 15 years ago low <= yearly min( 2000 , yearly close ) or 16 years ago low <= yearly min( 2000 , yearly close ) or 17 years ago low <= yearly min( 2000 , yearly close ) or 18 years ago low <= yearly min( 2000 , yearly close ) or 19 years ago low <= yearly min( 2000 , yearly close ) or 20 years ago low <= yearly min( 2000 , yearly close ) or 21 years ago low <= yearly min( 2000 , yearly close ) or 22 years ago low <= yearly min( 2000 , yearly close ) or 23 years ago low <= yearly min( 2000 , yearly close ) or 24 years ago low <= yearly min( 2000 , yearly close ) or 25 years ago low <= yearly min( 2000 , yearly close ) or 26 years ago low <= yearly min( 2000 , yearly close ) or 27 years ago low <= yearly min( 2000 , yearly close ) or 28 years ago low <= yearly min( 2000 , yearly close ) or 29 years ago low <= yearly min( 2000 , yearly close ) or 30 years ago low <= yearly min( 2000 , yearly close ) or 31 years ago low <= yearly min( 2000 , yearly close ) or 32 years ago low <= yearly min( 2000 , yearly close ) or 33 years ago low <= yearly min( 2000 , yearly close ) or 34 years ago low <= yearly min( 2000 , yearly close ) or 35 years ago low <= yearly min( 2000 , yearly close ) or 36 years ago low <= yearly min( 2000 , yearly close ) or 37 years ago low <= yearly min( 2000 , yearly close ) or 38 years ago low <= yearly min( 2000 , yearly close ) or 39 years ago low <= yearly min( 2000 , yearly close ) or 40 years ago low <= yearly min( 2000 , yearly close ) or 41 years ago low <= yearly min( 2000 , yearly close ) or 42 years ago low <= yearly min( 2000 , yearly close ) or 43 years ago low <= yearly min( 2000 , yearly close ) or 44 years ago low <= yearly min( 2000 , yearly close ) ) ) ) )'}},
        {'double_bottom__quarterly__setup'  : {'scan_clause': '( {segments_filter} ( quarterly low <= 1 quarter ago min( 2000 , quarterly close ) and ( {cash} (5 quarters ago low <= quarterly min( 2000 , quarterly close ) or  6 quarters ago low <= quarterly min( 2000 , quarterly close ) or  7 quarters ago low <= quarterly min( 2000 , quarterly close ) or  8 quarters ago low <= quarterly min( 2000 , quarterly close ) or  9 quarters ago low <= quarterly min( 2000 , quarterly close ) or 10 quarters ago low <= quarterly min( 2000 , quarterly close ) or 11 quarters ago low <= quarterly min( 2000 , quarterly close ) or 12 quarters ago low <= quarterly min( 2000 , quarterly close ) or 13 quarters ago low <= quarterly min( 2000 , quarterly close ) or 14 quarters ago low <= quarterly min( 2000 , quarterly close ) or 15 quarters ago low <= quarterly min( 2000 , quarterly close ) or 16 quarters ago low <= quarterly min( 2000 , quarterly close ) or 17 quarters ago low <= quarterly min( 2000 , quarterly close ) or 18 quarters ago low <= quarterly min( 2000 , quarterly close ) or 19 quarters ago low <= quarterly min( 2000 , quarterly close ) or 20 quarters ago low <= quarterly min( 2000 , quarterly close ) or 21 quarters ago low <= quarterly min( 2000 , quarterly close ) or 22 quarters ago low <= quarterly min( 2000 , quarterly close ) or 23 quarters ago low <= quarterly min( 2000 , quarterly close ) or 24 quarters ago low <= quarterly min( 2000 , quarterly close ) or 25 quarters ago low <= quarterly min( 2000 , quarterly close ) or 26 quarters ago low <= quarterly min( 2000 , quarterly close ) or 27 quarters ago low <= quarterly min( 2000 , quarterly close ) or 28 quarters ago low <= quarterly min( 2000 , quarterly close ) or 29 quarters ago low <= quarterly min( 2000 , quarterly close ) or 30 quarters ago low <= quarterly min( 2000 , quarterly close ) or 31 quarters ago low <= quarterly min( 2000 , quarterly close ) or 32 quarters ago low <= quarterly min( 2000 , quarterly close ) or 33 quarters ago low <= quarterly min( 2000 , quarterly close ) or 34 quarters ago low <= quarterly min( 2000 , quarterly close ) or 35 quarters ago low <= quarterly min( 2000 , quarterly close ) or 36 quarters ago low <= quarterly min( 2000 , quarterly close ) or 37 quarters ago low <= quarterly min( 2000 , quarterly close ) or 38 quarters ago low <= quarterly min( 2000 , quarterly close ) or 39 quarters ago low <= quarterly min( 2000 , quarterly close ) or 40 quarters ago low <= quarterly min( 2000 , quarterly close ) or 41 quarters ago low <= quarterly min( 2000 , quarterly close ) or 42 quarters ago low <= quarterly min( 2000 , quarterly close ) or 43 quarters ago low <= quarterly min( 2000 , quarterly close ) or 44 quarters ago low <= quarterly min( 2000 , quarterly close ) ) ) ) )'}},
        {'double_bottom__monthly__setup'    : {'scan_clause': '( {segments_filter} ( monthly low <= 1 month ago min( 2000 , monthly close ) and ( {cash} (5 months ago low <= monthly min( 2000 , monthly close ) or  6 months ago low <= monthly min( 2000 , monthly close ) or  7 months ago low <= monthly min( 2000 , monthly close ) or  8 months ago low <= monthly min( 2000 , monthly close ) or  9 months ago low <= monthly min( 2000 , monthly close ) or 10 months ago low <= monthly min( 2000 , monthly close ) or 11 months ago low <= monthly min( 2000 , monthly close ) or 12 months ago low <= monthly min( 2000 , monthly close ) or 13 months ago low <= monthly min( 2000 , monthly close ) or 14 months ago low <= monthly min( 2000 , monthly close ) or 15 months ago low <= monthly min( 2000 , monthly close ) or 16 months ago low <= monthly min( 2000 , monthly close ) or 17 months ago low <= monthly min( 2000 , monthly close ) or 18 months ago low <= monthly min( 2000 , monthly close ) or 19 months ago low <= monthly min( 2000 , monthly close ) or 20 months ago low <= monthly min( 2000 , monthly close ) or 21 months ago low <= monthly min( 2000 , monthly close ) or 22 months ago low <= monthly min( 2000 , monthly close ) or 23 months ago low <= monthly min( 2000 , monthly close ) or 24 months ago low <= monthly min( 2000 , monthly close ) or 25 months ago low <= monthly min( 2000 , monthly close ) or 26 months ago low <= monthly min( 2000 , monthly close ) or 27 months ago low <= monthly min( 2000 , monthly close ) or 28 months ago low <= monthly min( 2000 , monthly close ) or 29 months ago low <= monthly min( 2000 , monthly close ) or 30 months ago low <= monthly min( 2000 , monthly close ) or 31 months ago low <= monthly min( 2000 , monthly close ) or 32 months ago low <= monthly min( 2000 , monthly close ) or 33 months ago low <= monthly min( 2000 , monthly close ) or 34 months ago low <= monthly min( 2000 , monthly close ) or 35 months ago low <= monthly min( 2000 , monthly close ) or 36 months ago low <= monthly min( 2000 , monthly close ) or 37 months ago low <= monthly min( 2000 , monthly close ) or 38 months ago low <= monthly min( 2000 , monthly close ) or 39 months ago low <= monthly min( 2000 , monthly close ) or 40 months ago low <= monthly min( 2000 , monthly close ) or 41 months ago low <= monthly min( 2000 , monthly close ) or 42 months ago low <= monthly min( 2000 , monthly close ) or 43 months ago low <= monthly min( 2000 , monthly close ) or 44 months ago low <= monthly min( 2000 , monthly close ) ) ) ) )'}},
        {'double_bottom__weekly__setup'     : {'scan_clause': '( {segments_filter} ( weekly low <= 1 week ago min( 2000 , weekly close ) and ( {cash} (5 weeks ago low <= weekly min( 2000 , weekly close ) or  6 weeks ago low <= weekly min( 2000 , weekly close ) or  7 weeks ago low <= weekly min( 2000 , weekly close ) or  8 weeks ago low <= weekly min( 2000 , weekly close ) or  9 weeks ago low <= weekly min( 2000 , weekly close ) or 10 weeks ago low <= weekly min( 2000 , weekly close ) or 11 weeks ago low <= weekly min( 2000 , weekly close ) or 12 weeks ago low <= weekly min( 2000 , weekly close ) or 13 weeks ago low <= weekly min( 2000 , weekly close ) or 14 weeks ago low <= weekly min( 2000 , weekly close ) or 15 weeks ago low <= weekly min( 2000 , weekly close ) or 16 weeks ago low <= weekly min( 2000 , weekly close ) or 17 weeks ago low <= weekly min( 2000 , weekly close ) or 18 weeks ago low <= weekly min( 2000 , weekly close ) or 19 weeks ago low <= weekly min( 2000 , weekly close ) or 20 weeks ago low <= weekly min( 2000 , weekly close ) or 21 weeks ago low <= weekly min( 2000 , weekly close ) or 22 weeks ago low <= weekly min( 2000 , weekly close ) or 23 weeks ago low <= weekly min( 2000 , weekly close ) or 24 weeks ago low <= weekly min( 2000 , weekly close ) or 25 weeks ago low <= weekly min( 2000 , weekly close ) or 26 weeks ago low <= weekly min( 2000 , weekly close ) or 27 weeks ago low <= weekly min( 2000 , weekly close ) or 28 weeks ago low <= weekly min( 2000 , weekly close ) or 29 weeks ago low <= weekly min( 2000 , weekly close ) or 30 weeks ago low <= weekly min( 2000 , weekly close ) or 31 weeks ago low <= weekly min( 2000 , weekly close ) or 32 weeks ago low <= weekly min( 2000 , weekly close ) or 33 weeks ago low <= weekly min( 2000 , weekly close ) or 34 weeks ago low <= weekly min( 2000 , weekly close ) or 35 weeks ago low <= weekly min( 2000 , weekly close ) or 36 weeks ago low <= weekly min( 2000 , weekly close ) or 37 weeks ago low <= weekly min( 2000 , weekly close ) or 38 weeks ago low <= weekly min( 2000 , weekly close ) or 39 weeks ago low <= weekly min( 2000 , weekly close ) or 40 weeks ago low <= weekly min( 2000 , weekly close ) or 41 weeks ago low <= weekly min( 2000 , weekly close ) or 42 weeks ago low <= weekly min( 2000 , weekly close ) or 43 weeks ago low <= weekly min( 2000 , weekly close ) or 44 weeks ago low <= weekly min( 2000 , weekly close ) ) ) ) )'}},
        {'double_bottom__daily__setup'      : {'scan_clause': '( {segments_filter} ( latest low <= 1 day ago min( 2000 , latest close ) and( {cash} ( 5 days ago low <= latest min( 2000 , latest close ) or 6 days ago low <= latest min( 2000 , latest close ) or 7 days ago low <= latest min( 2000 , latest close ) or 8 days ago low <= latest min( 2000 , latest close ) or 9 days ago low <= latest min( 2000 , latest close ) or 10 days ago low <= latest min( 2000 , latest close ) or 11 days ago low <= latest min( 2000 , latest close ) or 12 days ago low <= latest min( 2000 , latest close ) or 13 days ago low <= latest min( 2000 , latest close ) or 14 days ago low <= latest min( 2000 , latest close ) or 15 days ago low <= latest min( 2000 , latest close ) or 16 days ago low <= latest min( 2000 , latest close ) or 17 days ago low <= latest min( 2000 , latest close ) or 18 days ago low <= latest min( 2000 , latest close ) or 19 days ago low <= latest min( 2000 , latest close ) or 20 days ago low <= latest min( 2000 , latest close ) or 21 days ago low <= latest min( 2000 , latest close ) or 22 days ago low <= latest min( 2000 , latest close ) or 23 days ago low <= latest min( 2000 , latest close ) or 24 days ago low <= latest min( 2000 , latest close ) or 25 days ago low <= latest min( 2000 , latest close ) or 26 days ago low <= latest min( 2000 , latest close ) or 27 days ago low <= latest min( 2000 , latest close ) or 28 days ago low <= latest min( 2000 , latest close ) or 29 days ago low <= latest min( 2000 , latest close ) or 30 days ago low <= latest min( 2000 , latest close ) or 31 days ago low <= latest min( 2000 , latest close ) or 32 days ago low <= latest min( 2000 , latest close ) or 33 days ago low <= latest min( 2000 , latest close ) or 34 days ago low <= latest min( 2000 , latest close ) or 35 days ago low <= latest min( 2000 , latest close ) or 36 days ago low <= latest min( 2000 , latest close ) or 37 days ago low <= latest min( 2000 , latest close ) or 38 days ago low <= latest min( 2000 , latest close ) or 39 days ago low <= latest min( 2000 , latest close ) or 40 days ago low <= latest min( 2000 , latest close ) or 41 days ago low <= latest min( 2000 , latest close ) or 42 days ago low <= latest min( 2000 , latest close ) or 43 days ago low <= latest min( 2000 , latest close ) or 44 days ago low <= latest min( 2000 , latest close ) ) ) ) )'}},

        {'double_top__yearly__setup'        : {'scan_clause': '( {segments_filter} ( yearly high >= 1 year ago max( 2000 , yearly close ) and ( {cash} (5 years ago high >= yearly max( 2000 , yearly close ) or  6 years ago high >= yearly max( 2000 , yearly close ) or  7 years ago high >= yearly max( 2000 , yearly close ) or  8 years ago high >= yearly max( 2000 , yearly close ) or  9 years ago high >= yearly max( 2000 , yearly close ) or 10 years ago high >= yearly max( 2000 , yearly close ) or 11 years ago high >= yearly max( 2000 , yearly close ) or 12 years ago high >= yearly max( 2000 , yearly close ) or 13 years ago high >= yearly max( 2000 , yearly close ) or 14 years ago high >= yearly max( 2000 , yearly close ) or 15 years ago high >= yearly max( 2000 , yearly close ) or 16 years ago high >= yearly max( 2000 , yearly close ) or 17 years ago high >= yearly max( 2000 , yearly close ) or 18 years ago high >= yearly max( 2000 , yearly close ) or 19 years ago high >= yearly max( 2000 , yearly close ) or 20 years ago high >= yearly max( 2000 , yearly close ) or 21 years ago high >= yearly max( 2000 , yearly close ) or 22 years ago high >= yearly max( 2000 , yearly close ) or 23 years ago high >= yearly max( 2000 , yearly close ) or 24 years ago high >= yearly max( 2000 , yearly close ) or 25 years ago high >= yearly max( 2000 , yearly close ) or 26 years ago high >= yearly max( 2000 , yearly close ) or 27 years ago high >= yearly max( 2000 , yearly close ) or 28 years ago high >= yearly max( 2000 , yearly close ) or 29 years ago high >= yearly max( 2000 , yearly close ) or 30 years ago high >= yearly max( 2000 , yearly close ) or 31 years ago high >= yearly max( 2000 , yearly close ) or 32 years ago high >= yearly max( 2000 , yearly close ) or 33 years ago high >= yearly max( 2000 , yearly close ) or 34 years ago high >= yearly max( 2000 , yearly close ) or 35 years ago high >= yearly max( 2000 , yearly close ) or 36 years ago high >= yearly max( 2000 , yearly close ) or 37 years ago high >= yearly max( 2000 , yearly close ) or 38 years ago high >= yearly max( 2000 , yearly close ) or 39 years ago high >= yearly max( 2000 , yearly close ) or 40 years ago high >= yearly max( 2000 , yearly close ) or 41 years ago high >= yearly max( 2000 , yearly close ) or 42 years ago high >= yearly max( 2000 , yearly close ) or 43 years ago high >= yearly max( 2000 , yearly close ) or 44 years ago high >= yearly max( 2000 , yearly close ) ) ) ) )'}},
        {'double_top__quarterly__setup'     : {'scan_clause': '( {segments_filter} ( quarterly high >= 1 quarter ago max( 2000 , quarterly close ) and ( {cash} (5 quarters ago high >= quarterly max( 2000 , quarterly close ) or  6 quarters ago high >= quarterly max( 2000 , quarterly close ) or  7 quarters ago high >= quarterly max( 2000 , quarterly close ) or  8 quarters ago high >= quarterly max( 2000 , quarterly close ) or  9 quarters ago high >= quarterly max( 2000 , quarterly close ) or 10 quarters ago high >= quarterly max( 2000 , quarterly close ) or 11 quarters ago high >= quarterly max( 2000 , quarterly close ) or 12 quarters ago high >= quarterly max( 2000 , quarterly close ) or 13 quarters ago high >= quarterly max( 2000 , quarterly close ) or 14 quarters ago high >= quarterly max( 2000 , quarterly close ) or 15 quarters ago high >= quarterly max( 2000 , quarterly close ) or 16 quarters ago high >= quarterly max( 2000 , quarterly close ) or 17 quarters ago high >= quarterly max( 2000 , quarterly close ) or 18 quarters ago high >= quarterly max( 2000 , quarterly close ) or 19 quarters ago high >= quarterly max( 2000 , quarterly close ) or 20 quarters ago high >= quarterly max( 2000 , quarterly close ) or 21 quarters ago high >= quarterly max( 2000 , quarterly close ) or 22 quarters ago high >= quarterly max( 2000 , quarterly close ) or 23 quarters ago high >= quarterly max( 2000 , quarterly close ) or 24 quarters ago high >= quarterly max( 2000 , quarterly close ) or 25 quarters ago high >= quarterly max( 2000 , quarterly close ) or 26 quarters ago high >= quarterly max( 2000 , quarterly close ) or 27 quarters ago high >= quarterly max( 2000 , quarterly close ) or 28 quarters ago high >= quarterly max( 2000 , quarterly close ) or 29 quarters ago high >= quarterly max( 2000 , quarterly close ) or 30 quarters ago high >= quarterly max( 2000 , quarterly close ) or 31 quarters ago high >= quarterly max( 2000 , quarterly close ) or 32 quarters ago high >= quarterly max( 2000 , quarterly close ) or 33 quarters ago high >= quarterly max( 2000 , quarterly close ) or 34 quarters ago high >= quarterly max( 2000 , quarterly close ) or 35 quarters ago high >= quarterly max( 2000 , quarterly close ) or 36 quarters ago high >= quarterly max( 2000 , quarterly close ) or 37 quarters ago high >= quarterly max( 2000 , quarterly close ) or 38 quarters ago high >= quarterly max( 2000 , quarterly close ) or 39 quarters ago high >= quarterly max( 2000 , quarterly close ) or 40 quarters ago high >= quarterly max( 2000 , quarterly close ) or 41 quarters ago high >= quarterly max( 2000 , quarterly close ) or 42 quarters ago high >= quarterly max( 2000 , quarterly close ) or 43 quarters ago high >= quarterly max( 2000 , quarterly close ) or 44 quarters ago high >= quarterly max( 2000 , quarterly close ) ) ) ) )'}},
        {'double_top__monthly__setup'       : {'scan_clause': '( {segments_filter} ( monthly high >= 1 month ago max( 2000 , monthly close ) and ( {cash} (5 months ago high >= monthly max( 2000 , monthly close ) or  6 months ago high >= monthly max( 2000 , monthly close ) or  7 months ago high >= monthly max( 2000 , monthly close ) or  8 months ago high >= monthly max( 2000 , monthly close ) or  9 months ago high >= monthly max( 2000 , monthly close ) or 10 months ago high >= monthly max( 2000 , monthly close ) or 11 months ago high >= monthly max( 2000 , monthly close ) or 12 months ago high >= monthly max( 2000 , monthly close ) or 13 months ago high >= monthly max( 2000 , monthly close ) or 14 months ago high >= monthly max( 2000 , monthly close ) or 15 months ago high >= monthly max( 2000 , monthly close ) or 16 months ago high >= monthly max( 2000 , monthly close ) or 17 months ago high >= monthly max( 2000 , monthly close ) or 18 months ago high >= monthly max( 2000 , monthly close ) or 19 months ago high >= monthly max( 2000 , monthly close ) or 20 months ago high >= monthly max( 2000 , monthly close ) or 21 months ago high >= monthly max( 2000 , monthly close ) or 22 months ago high >= monthly max( 2000 , monthly close ) or 23 months ago high >= monthly max( 2000 , monthly close ) or 24 months ago high >= monthly max( 2000 , monthly close ) or 25 months ago high >= monthly max( 2000 , monthly close ) or 26 months ago high >= monthly max( 2000 , monthly close ) or 27 months ago high >= monthly max( 2000 , monthly close ) or 28 months ago high >= monthly max( 2000 , monthly close ) or 29 months ago high >= monthly max( 2000 , monthly close ) or 30 months ago high >= monthly max( 2000 , monthly close ) or 31 months ago high >= monthly max( 2000 , monthly close ) or 32 months ago high >= monthly max( 2000 , monthly close ) or 33 months ago high >= monthly max( 2000 , monthly close ) or 34 months ago high >= monthly max( 2000 , monthly close ) or 35 months ago high >= monthly max( 2000 , monthly close ) or 36 months ago high >= monthly max( 2000 , monthly close ) or 37 months ago high >= monthly max( 2000 , monthly close ) or 38 months ago high >= monthly max( 2000 , monthly close ) or 39 months ago high >= monthly max( 2000 , monthly close ) or 40 months ago high >= monthly max( 2000 , monthly close ) or 41 months ago high >= monthly max( 2000 , monthly close ) or 42 months ago high >= monthly max( 2000 , monthly close ) or 43 months ago high >= monthly max( 2000 , monthly close ) or 44 months ago high >= monthly max( 2000 , monthly close ) ) ) ) )'}},
        {'double_top__weekly__setup'        : {'scan_clause': '( {segments_filter} ( weekly high >= 1 week ago max( 2000 , weekly close ) and ( {cash} (5 weeks ago high >= weekly max( 2000 , weekly close ) or  6 weeks ago high >= weekly max( 2000 , weekly close ) or  7 weeks ago high >= weekly max( 2000 , weekly close ) or  8 weeks ago high >= weekly max( 2000 , weekly close ) or  9 weeks ago high >= weekly max( 2000 , weekly close ) or 10 weeks ago high >= weekly max( 2000 , weekly close ) or 11 weeks ago high >= weekly max( 2000 , weekly close ) or 12 weeks ago high >= weekly max( 2000 , weekly close ) or 13 weeks ago high >= weekly max( 2000 , weekly close ) or 14 weeks ago high >= weekly max( 2000 , weekly close ) or 15 weeks ago high >= weekly max( 2000 , weekly close ) or 16 weeks ago high >= weekly max( 2000 , weekly close ) or 17 weeks ago high >= weekly max( 2000 , weekly close ) or 18 weeks ago high >= weekly max( 2000 , weekly close ) or 19 weeks ago high >= weekly max( 2000 , weekly close ) or 20 weeks ago high >= weekly max( 2000 , weekly close ) or 21 weeks ago high >= weekly max( 2000 , weekly close ) or 22 weeks ago high >= weekly max( 2000 , weekly close ) or 23 weeks ago high >= weekly max( 2000 , weekly close ) or 24 weeks ago high >= weekly max( 2000 , weekly close ) or 25 weeks ago high >= weekly max( 2000 , weekly close ) or 26 weeks ago high >= weekly max( 2000 , weekly close ) or 27 weeks ago high >= weekly max( 2000 , weekly close ) or 28 weeks ago high >= weekly max( 2000 , weekly close ) or 29 weeks ago high >= weekly max( 2000 , weekly close ) or 30 weeks ago high >= weekly max( 2000 , weekly close ) or 31 weeks ago high >= weekly max( 2000 , weekly close ) or 32 weeks ago high >= weekly max( 2000 , weekly close ) or 33 weeks ago high >= weekly max( 2000 , weekly close ) or 34 weeks ago high >= weekly max( 2000 , weekly close ) or 35 weeks ago high >= weekly max( 2000 , weekly close ) or 36 weeks ago high >= weekly max( 2000 , weekly close ) or 37 weeks ago high >= weekly max( 2000 , weekly close ) or 38 weeks ago high >= weekly max( 2000 , weekly close ) or 39 weeks ago high >= weekly max( 2000 , weekly close ) or 40 weeks ago high >= weekly max( 2000 , weekly close ) or 41 weeks ago high >= weekly max( 2000 , weekly close ) or 42 weeks ago high >= weekly max( 2000 , weekly close ) or 43 weeks ago high >= weekly max( 2000 , weekly close ) or 44 weeks ago high >= weekly max( 2000 , weekly close ) ) ) ) )'}},
        {'double_top__daily__setup'         : {'scan_clause': '( {segments_filter} ( latest high >= 1 day ago max( 2000 , latest close ) and( {cash} ( 5 days ago high >= latest max( 2000 , latest close ) or 6 days ago high >= latest max( 2000 , latest close ) or 7 days ago high >= latest max( 2000 , latest close ) or 8 days ago high >= latest max( 2000 , latest close ) or 9 days ago high >= latest max( 2000 , latest close ) or 10 days ago high >= latest max( 2000 , latest close ) or 11 days ago high >= latest max( 2000 , latest close ) or 12 days ago high >= latest max( 2000 , latest close ) or 13 days ago high >= latest max( 2000 , latest close ) or 14 days ago high >= latest max( 2000 , latest close ) or 15 days ago high >= latest max( 2000 , latest close ) or 16 days ago high >= latest max( 2000 , latest close ) or 17 days ago high >= latest max( 2000 , latest close ) or 18 days ago high >= latest max( 2000 , latest close ) or 19 days ago high >= latest max( 2000 , latest close ) or 20 days ago high >= latest max( 2000 , latest close ) or 21 days ago high >= latest max( 2000 , latest close ) or 22 days ago high >= latest max( 2000 , latest close ) or 23 days ago high >= latest max( 2000 , latest close ) or 24 days ago high >= latest max( 2000 , latest close ) or 25 days ago high >= latest max( 2000 , latest close ) or 26 days ago high >= latest max( 2000 , latest close ) or 27 days ago high >= latest max( 2000 , latest close ) or 28 days ago high >= latest max( 2000 , latest close ) or 29 days ago high >= latest max( 2000 , latest close ) or 30 days ago high >= latest max( 2000 , latest close ) or 31 days ago high >= latest max( 2000 , latest close ) or 32 days ago high >= latest max( 2000 , latest close ) or 33 days ago high >= latest max( 2000 , latest close ) or 34 days ago high >= latest max( 2000 , latest close ) or 35 days ago high >= latest max( 2000 , latest close ) or 36 days ago high >= latest max( 2000 , latest close ) or 37 days ago high >= latest max( 2000 , latest close ) or 38 days ago high >= latest max( 2000 , latest close ) or 39 days ago high >= latest max( 2000 , latest close ) or 40 days ago high >= latest max( 2000 , latest close ) or 41 days ago high >= latest max( 2000 , latest close ) or 42 days ago high >= latest max( 2000 , latest close ) or 43 days ago high >= latest max( 2000 , latest close ) or 44 days ago high >= latest max( 2000 , latest close ) ) ) ) )'}},

        {'price__yearly__above_50_Ema'      : {'scan_clause': '( {segments_filter} ( yearly close > yearly ema( yearly close , 50 ) ) )'}},
        {'price__quarterly__above_50_Ema'   : {'scan_clause': '( {segments_filter} ( Quarterly close > Quarterly ema( Quarterly close , 50 ) ) )'}},
        {'price__monthly__above_50_Ema'     : {'scan_clause': '( {segments_filter} ( Monthly close > Monthly ema( Monthly close , 50 ) ) )'}},
        {'price__weekly__above_50_Ema'      : {'scan_clause': '( {segments_filter} ( Weekly close > Weekly ema( Weekly close , 50 ) ) )'}},
        {'price__daily__above_50_Ema'       : {'scan_clause': '( {segments_filter} ( latest close > latest ema( latest close , 50 ) ) )'}},

        {'price__yearly__below_50_Ema'      : {'scan_clause': '( {segments_filter} ( yearly close < yearly ema( yearly close , 50 ) ) )'}},
        {'price__quarterly__below_50_Ema'   : {'scan_clause': '( {segments_filter} ( Quarterly close < Quarterly ema( Quarterly close , 50 ) ) )'}},
        {'price__monthly__below_50_Ema'     : {'scan_clause': '( {segments_filter} ( Monthly close < Monthly ema( Monthly close , 50 ) ) )'}},
        {'price__weekly__below_50_Ema'      : {'scan_clause': '( {segments_filter} ( Weekly close < Weekly ema( Weekly close , 50 ) ) )'}},
        {'price__daily__below_50_Ema'       : {'scan_clause': '( {segments_filter} ( latest close < latest ema( latest close , 50 ) ) )'}},

        {'Elliott_4th_Wave_Completed__Yearly__setup'    : {'scan_clause': '( {segments_filter} ( yearly close <= yearly max( 250 , yearly close ) * 0.9 and yearly ema( yearly rsi( 9 ) , 3 ) > yearly wma( yearly rsi( 9 ) , 21 ) and 1 year ago ema( yearly rsi( 9 ) , 3 )<= 1 year ago wma( yearly rsi( 9 ) , 21 ) and yearly close >= yearly max( 250 , yearly close ) * 0.7 and yearly close >= yearly "ew 4 end" and yearly ema( yearly close , 200 ) < yearly close ) ) '}},
        {'Elliott_4th_Wave_Completed__Quarterly__setup' : {'scan_clause': '( {segments_filter} ( quarterly close <= quarterly max( 250 , quarterly close ) * 0.9 and quarterly ema( quarterly rsi( 9 ) , 3 ) > quarterly wma( quarterly rsi( 9 ) , 21 ) and 1 quarter ago ema( quarterly rsi( 9 ) , 3 )<= 1 quarter ago wma( quarterly rsi( 9 ) , 21 ) and quarterly close >= quarterly max( 250 , quarterly close ) * 0.7 and quarterly close >= quarterly "ew 4 end" and quarterly ema( quarterly close , 200 ) < quarterly close ) ) '}},
        {'Elliott_4th_Wave_Completed__monthly__setup'   : {'scan_clause': '( {segments_filter} ( monthly close <= monthly max( 250 , monthly close ) * 0.9 and monthly ema( monthly rsi( 9 ) , 3 ) > monthly wma( monthly rsi( 9 ) , 21 ) and 1 month ago ema( monthly rsi( 9 ) , 3 )<= 1 month ago wma( monthly rsi( 9 ) , 21 ) and monthly close >= monthly max( 250 , monthly close ) * 0.7 and monthly close >= monthly "ew 4 end" and monthly ema( monthly close , 200 ) < monthly close ) ) '}},
        {'Elliott_4th_Wave_Completed__weekly__setup'    : {'scan_clause': '( {segments_filter} ( weekly close <= weekly max( 250 , weekly close ) * 0.9 and weekly ema( weekly rsi( 9 ) , 3 ) > weekly wma( weekly rsi( 9 ) , 21 ) and 1 week ago ema( weekly rsi( 9 ) , 3 )<= 1 week ago wma( weekly rsi( 9 ) , 21 ) and weekly close >= weekly max( 250 , weekly close ) * 0.7 and weekly close >= weekly "ew 4 end" and weekly ema( weekly close , 200 ) < weekly close ) ) '}},
        {'Elliott_4th_Wave_Completed__Daily__setup'     : {'scan_clause': '( {segments_filter} ( latest close <= latest max( 250 , latest close ) * 0.9 and latest ema( latest rsi( 9 ) , 3 ) > latest wma( latest rsi( 9 ) , 21 ) and 1 day ago ema( latest rsi( 9 ) , 3 )<= 1 day ago wma( latest rsi( 9 ) , 21 ) and latest close >= latest max( 250 , latest close ) * 0.7 and latest close >= latest "ew 4 end" and latest ema( latest close , 200 ) < latest close ) ) '}},

        {'Double_Top_with_RSI__yearly__setup'           : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( yearly high < 1.02 * 8 years ago high and yearly close < 8 years ago low ) ) or( {cash} ( yearly high < 1.02 * 9 years ago high and yearly close < 9 years ago low ) ) or( {cash} ( yearly high < 1.02 * 10 years ago high and yearly close < 10 years ago low ) ) ) ) and yearly volume > yearly sma( yearly volume , 20 ) * 5 and yearly high > 2 years ago high and yearly high > 3 years ago high and yearly high > 4 years ago high and yearly high > 5 years ago high and yearly high > 6 years ago high and yearly high > 7 years ago high and yearly high > 8 years ago high and yearly high > 9 years ago high and yearly rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__quarterly__setup'        : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( quarterly high < 1.02 * 8 quarters ago high and quarterly close < 8 quarters ago low ) ) or( {cash} ( quarterly high < 1.02 * 9 quarters ago high and quarterly close < 9 quarters ago low ) ) or( {cash} ( quarterly high < 1.02 * 10 quarters ago high and quarterly close < 10 quarters ago low ) ) ) ) and quarterly volume > quarterly sma( quarterly volume , 20 ) * 5 and quarterly high > 2 quarters ago high and quarterly high > 3 quarters ago high and quarterly high > 4 quarters ago high and quarterly high > 5 quarters ago high and quarterly high > 6 quarters ago high and quarterly high > 7 quarters ago high and quarterly high > 8 quarters ago high and quarterly high > 9 quarters ago high and quarterly rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__monthly__setup'          : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( monthly high < 1.02 * 8 months ago high and monthly close < 8 months ago low ) ) or( {cash} ( monthly high < 1.02 * 9 months ago high and monthly close < 9 months ago low ) ) or( {cash} ( monthly high < 1.02 * 10 months ago high and monthly close < 10 months ago low ) ) ) ) and monthly volume > monthly sma( monthly volume , 20 ) * 5 and monthly high > 2 months ago high and monthly high > 3 months ago high and monthly high > 4 months ago high and monthly high > 5 months ago high and monthly high > 6 months ago high and monthly high > 7 months ago high and monthly high > 8 months ago high and monthly high > 9 months ago high and monthly rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__weekly__setup'           : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( weekly high < 1.02 * 8 weeks ago high and weekly close < 8 weeks ago low ) ) or( {cash} ( weekly high < 1.02 * 9 weeks ago high and weekly close < 9 weeks ago low ) ) or( {cash} ( weekly high < 1.02 * 10 weeks ago high and weekly close < 10 weeks ago low ) ) ) ) and weekly volume > weekly sma( weekly volume , 20 ) * 5 and weekly high > 2 weeks ago high and weekly high > 3 weeks ago high and weekly high > 4 weeks ago high and weekly high > 5 weeks ago high and weekly high > 6 weeks ago high and weekly high > 7 weeks ago high and weekly high > 8 weeks ago high and weekly high > 9 weeks ago high and weekly rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__Daily__setup'            : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( latest high < 1.02 * 8 days ago high and latest close < 8 days ago low ) ) or( {cash} ( latest high < 1.02 * 9 days ago high and latest close < 9 days ago low ) ) or( {cash} ( latest high < 1.02 * 10 days ago high and latest close < 10 days ago low ) ) ) ) and latest volume > latest sma( latest volume , 20 ) * 5 and latest high > 2 days ago high and latest high > 3 days ago high and latest high > 4 days ago high and latest high > 5 days ago high and latest high > 6 days ago high and latest high > 7 days ago high and latest high > 8 days ago high and latest high > 9 days ago high and latest rsi( 14 ) <= 40 ) )'}},

        {'Price_above_200_EMI__yearly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( yearly close / yearly ema( yearly close , 200 ) - 1 <= 0.01 and yearly close / yearly ema( yearly close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__quarterly__setup'  : {'scan_clause': '( {segments_filter} ( {cash} ( quarterly close / quarterly ema( quarterly close , 200 ) - 1 <= 0.01 and quarterly close / quarterly ema( quarterly close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__monthly__setup'    : {'scan_clause': '( {segments_filter} ( {cash} ( monthly close / monthly ema( monthly close , 200 ) - 1 <= 0.01 and monthly close / monthly ema( monthly close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__weekly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( weekly close / weekly ema( weekly close , 200 ) - 1 <= 0.01 and weekly close / weekly ema( weekly close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__daily__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( daily close / daily ema( daily close , 200 ) - 1 <= 0.01 and daily close / daily ema( daily close , 200 ) - 1 >= 0.00 ) ))'}},

        {'Price_below_200_EMI__yearly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( yearly close / yearly ema( yearly close , 200 ) - 1 < 0.00 and yearly close / yearly ema( yearly close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__quarterly__setup'  : {'scan_clause': '( {segments_filter} ( {cash} ( quarterly close / quarterly ema( quarterly close , 200 ) - 1 < 0.00 and quarterly close / quarterly ema( quarterly close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__monthly__setup'    : {'scan_clause': '( {segments_filter} ( {cash} ( monthly close / monthly ema( monthly close , 200 ) - 1 < 0.00 and monthly close / monthly ema( monthly close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__weekly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( weekly close / weekly ema( weekly close , 200 ) - 1 < 0.00 and weekly close / weekly ema( weekly close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__daily__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( daily close / daily ema( daily close , 200 ) - 1 < 0.00 and daily close / daily ema( daily close , 200 ) - 1 >= -0.01 ) ))'}},

        {'Price_above_50_EMI__yearly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( yearly close / yearly ema( yearly close , 50 ) - 1 <= 0.01 and yearly close / yearly ema( yearly close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__quarterly__setup'   : {'scan_clause': '( {segments_filter} ( {cash} ( quarterly close / quarterly ema( quarterly close , 50 ) - 1 <= 0.01 and quarterly close / quarterly ema( quarterly close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__monthly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( monthly close / monthly ema( monthly close , 50 ) - 1 <= 0.01 and monthly close / monthly ema( monthly close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__weekly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( weekly close / weekly ema( weekly close , 50 ) - 1 <= 0.01 and weekly close / weekly ema( weekly close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__daily__setup'       : {'scan_clause': '( {segments_filter} ( {cash} ( daily close / daily ema( daily close , 50 ) - 1 <= 0.01 and daily close / daily ema( daily close , 50 ) - 1 >= 0.00 ) ))'}},

        {'Price_below_50_EMI__yearly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( yearly close / yearly ema( yearly close , 50 ) - 1 < 0.00 and yearly close / yearly ema( yearly close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__quarterly__setup'   : {'scan_clause': '( {segments_filter} ( {cash} ( quarterly close / quarterly ema( quarterly close , 50 ) - 1 < 0.00 and quarterly close / quarterly ema( quarterly close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__monthly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( monthly close / monthly ema( monthly close , 50 ) - 1 < 0.00 and monthly close / monthly ema( monthly close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__weekly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( weekly close / weekly ema( weekly close , 50 ) - 1 < 0.00 and weekly close / weekly ema( weekly close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__daily__setup'       : {'scan_clause': '( {segments_filter} ( {cash} ( daily close / daily ema( daily close , 50 ) - 1 < 0.00 and daily close / daily ema( daily close , 50 ) - 1 >= -0.01 ) ))'}},

    ]
    return data_list1


def data_lists_below_daily():
    data_list2 = [
        {'macd__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},

        {'stochastic__4_hourly__crosses_above'      : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_below'      : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_above'      : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_below'      : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_above'    : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_below'    : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},

        {'ema_5_13__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        {'ema_5_13__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},

        {'ema_13_26__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        {'ema_13_26__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},

        {'ema_50_100__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        {'ema_50_100__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},

        {'ema_50_200__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_50_200__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_50_200__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_50_200__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_50_200__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_50_200__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},

        {'ema_100_200__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_100_200__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},

        {'rsi__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}},
        {'rsi__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}},

        {'upper_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},

        {'lower_bollinger_band3__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},

        {'upper_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},

        {'lower_bollinger_band2__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},

        {'volume__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},

        {'adx__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}},
        {'adx__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}},

        {'adx_up_tick__4_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_down_tick__4_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_up_tick__1_hourly__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_down_tick__1_hourly__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_up_tick__15_minutes__greater_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}},
        {'adx_down_tick__15_minutes__less_than_equal_to' : {'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}},

        {'volume__4_hourly__shockers': {'scan_clause': '( {segments_filter} ( [0] 4 hour volume > [ 0 ] 4 hour sma( volume,20 ) * 5 ) )'}},
        {'volume__1_hourly__shockers': {'scan_clause': '( {segments_filter} ( [0] 1 hour volume > [ 0 ] 1 hour sma( volume,20 ) * 5 ) )'}},
        {'volume__15_minutes__shockers': {'scan_clause': '( {segments_filter} ( [0] 15 minute volume > [ 0 ] 15 minute sma( volume,20 ) * 5 ) )'}},

        {'double_bottom__4_hourly__setup'   : {'scan_clause': '( {segments_filter} ( [0] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) and ( {cash} ( [-5] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-6] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-7] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-8] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-9] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-10] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-11] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-12] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-13] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-14] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-15] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-16] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-17] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-18] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-19] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-20] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-21] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-22] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-23] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-24] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-25] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-26] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-27] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-28] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-29] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-30] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-31] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-32] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-33] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-34] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-35] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-36] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-37] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-38] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-39] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-40] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-41] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-42] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-43] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) or [-44] 4 hour low <= [0] 4 hour min( 2000 , [0] 4 hour close ) ) ) ) )'}},
        {'double_bottom__1_hourly__setup'   : {'scan_clause': '( {segments_filter} ( [0] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) and ( {cash} ( [-5] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-6] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-7] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-8] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-9] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-10] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-11] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-12] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-13] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-14] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-15] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-16] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-17] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-18] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-19] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-20] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-21] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-22] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-23] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-24] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-25] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-26] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-27] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-28] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-29] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-30] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-31] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-32] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-33] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-34] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-35] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-36] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-37] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-38] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-39] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-40] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-41] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-42] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-43] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) or [-44] 1 hour low <= [0] 1 hour min( 2000 , [0] 1 hour close ) ) ) ) )'}},
        {'double_bottom__15_minutes__setup' : {'scan_clause': '( {segments_filter} ( [0] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) and ( {cash} ( [-5] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-6] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-7] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-8] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-9] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-10] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-11] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-12] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-13] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-14] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-15] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-16] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-17] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-18] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-19] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-20] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-21] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-22] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-23] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-24] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-25] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-26] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-27] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-28] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-29] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-30] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-31] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-32] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-33] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-34] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-35] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-36] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-37] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-38] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-39] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-40] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-41] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-42] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-43] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) or [-44] 15 minute low <= [0] 15 minute min( 2000 , [0] 15 minute close ) ) ) ) )'}},

        {'double_top__4_hourly__setup'      : {'scan_clause': '( {segments_filter} ( [0] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) and ( {cash} ( [-5] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-6] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-7] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-8] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-9] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-10] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-11] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-12] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-13] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-14] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-15] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-16] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-17] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-18] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-19] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-20] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-21] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-22] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-23] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-24] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-25] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-26] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-27] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-28] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-29] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-30] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-31] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-32] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-33] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-34] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-35] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-36] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-37] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-38] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-39] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-40] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-41] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-42] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-43] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) or [-44] 4 hour high >= [0] 4 hour max( 2000 , [0] 4 hour close ) ) ) ) )'}},
        {'double_top__1_hourly__setup'      : {'scan_clause': '( {segments_filter} ( [0] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) and ( {cash} ( [-5] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-6] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-7] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-8] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-9] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-10] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-11] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-12] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-13] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-14] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-15] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-16] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-17] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-18] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-19] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-20] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-21] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-22] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-23] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-24] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-25] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-26] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-27] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-28] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-29] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-30] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-31] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-32] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-33] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-34] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-35] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-36] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-37] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-38] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-39] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-40] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-41] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-42] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-43] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) or [-44] 1 hour high >= [0] 1 hour max( 2000 , [0] 1 hour close ) ) ) ) )'}},
        {'double_top__15_minutes__setup'    : {'scan_clause': '( {segments_filter} ( [0] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) and ( {cash} ( [-5] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-6] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-7] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-8] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-9] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-10] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-11] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-12] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-13] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-14] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-15] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-16] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-17] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-18] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-19] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-20] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-21] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-22] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-23] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-24] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-25] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-26] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-27] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-28] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-29] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-30] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-31] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-32] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-33] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-34] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-35] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-36] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-37] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-38] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-39] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-40] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-41] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-42] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-43] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) or [-44] 15 minute high >= [0] 15 minute max( 2000 , [0] 15 minute close ) ) ) ) )'}},

        {'price__4_hourly__above_50_Ema'    : {'scan_clause': '( {segments_filter} ( [0] 4 hour close > [0] 4 hour ema( [0] 4 hour close , 50 ) ) )'}},
        {'price__1_hourly__above_50_Ema'    : {'scan_clause': '( {segments_filter} ( [0] 1 hour close > [0] 1 hour ema( [0] 1 hour close , 50 ) ) )'}},
        {'price__15_minutes__above_50_Ema'  : {'scan_clause': '( {segments_filter} ( [0] 15 minute close > [0] 15 minute ema( [0] 15 minute close , 50 ) ) )'}},

        {'price__4_hourly__below_50_Ema'    : {'scan_clause': '( {segments_filter} ( [0] 4 hour close < [0] 4 hour ema( [0] 4 hour close , 50 ) ) )'}},
        {'price__1_hourly__below_50_Ema'    : {'scan_clause': '( {segments_filter} ( [0] 1 hour close < [0] 1 hour ema( [0] 1 hour close , 50 ) ) )'}},
        {'price__15_minutes__below_50_Ema'  : {'scan_clause': '( {segments_filter} ( [0] 15 minute close < [0] 15 minute ema( [0] 15 minute close , 50 ) ) )'}},

        {'Elliott_4th_Wave_Completed__4_hourly__setup'  : {'scan_clause': '( {segments_filter} ( [0] 4 hour close <= [0] 4 hour max( 250 , [0] 4 hour close ) * 0.9 and [0] 4 hour ema( [0] 4 hour rsi( 9 ) , 3 ) > [0] 4 hour wma( [0] 4 hour rsi( 9 ) , 21 ) and [-1] 4 hour ema( [0] 4 hour rsi( 9 ) , 3 )<= [-1] 4 hour wma( [0] 4 hour rsi( 9 ) , 21 ) and [0] 4 hour close >= [0] 4 hour max( 250 , [0] 4 hour close ) * 0.7 and [0] 4 hour close >= [0] 4 hour "ew 4 end" and [0] 4 hour ema( [0] 4 hour close , 200 ) < [0] 4 hour close ) ) '}},
        {'Elliott_4th_Wave_Completed__1_hourly__setup'  : {'scan_clause': '( {segments_filter} ( [0] 1 hour close <= [0] 1 hour max( 250 , [0] 1 hour close ) * 0.9 and [0] 1 hour ema( [0] 1 hour rsi( 9 ) , 3 ) > [0] 1 hour wma( [0] 1 hour rsi( 9 ) , 21 ) and [-1] 1 hour ema( [0] 1 hour rsi( 9 ) , 3 )<= [-1] 1 hour wma( [0] 1 hour rsi( 9 ) , 21 ) and [0] 1 hour close >= [0] 1 hour max( 250 , [0] 1 hour close ) * 0.7 and [0] 1 hour close >= [0] 1 hour "ew 4 end" and [0] 1 hour ema( [0] 1 hour close , 200 ) < [0] 1 hour close ) ) '}},
        {'Elliott_4th_Wave_Completed__15_minutes__setup': {'scan_clause': '( {segments_filter} ( [0] 15 minute close <= [0] 15 minute max( 250 , [0] 15 minute close ) * 0.9 and [0] 15 minute ema( [0] 15 minute rsi( 9 ) , 3 ) > [0] 15 minute wma( [0] 15 minute rsi( 9 ) , 21 ) and [-1] 15 minute ema( [0] 15 minute rsi( 9 ) , 3 )<= [-1] 15 minute wma( [0] 15 minute rsi( 9 ) , 21 ) and [0] 15 minute close >= [0] 15 minute max( 250 , [0] 15 minute close ) * 0.7 and [0] 15 minute close >= [0] 15 minute "ew 4 end" and [0] 15 minute ema( [0] 15 minute close , 200 ) < [0] 15 minute close ) ) '}},

        {'Double_Top_with_RSI__4_hourly__setup'         : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( [0] 4 hour high < 1.02 * [-8] 4 hour high and [0] 4 hour close < [-8] 4 hour low ) ) or( {cash} ( [0] 4 hour high < 1.02 * [-9] 4 hour high and [0] 4 hour close < [-9] 4 hour low ) ) or( {cash} ( [0] 4 hour high < 1.02 * [-10] 4 hour high and [0] 4 hour close < [-10] 4 hour low ) ) ) ) and [0] 4 hour volume > [0] 4 hour sma( [0] 4 hour volume , 20 ) * 5 and [0] 4 hour high > [-2] 4 hour high and [0] 4 hour high > [-3] 4 hour high and [0] 4 hour high > [-4] 4 hour high and [0] 4 hour high > [-5] 4 hour high and [0] 4 hour high > [-6] 4 hour high and [0] 4 hour high > [-7] 4 hour high and [0] 4 hour high > [-8] 4 hour high and [0] 4 hour high > [-9] 4 hour high and [0] 4 hour rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__1_hourly__setup'         : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( [0] 1 hour high < 1.02 * [-8] 1 hour high and [0] 1 hour close < [-8] 1 hour low ) ) or( {cash} ( [0] 1 hour high < 1.02 * [-9] 1 hour high and [0] 1 hour close < [-9] 1 hour low ) ) or( {cash} ( [0] 1 hour high < 1.02 * [-10] 1 hour high and [0] 1 hour close < [-10] 1 hour low ) ) ) ) and [0] 1 hour volume > [0] 1 hour sma( [0] 1 hour volume , 20 ) * 5 and [0] 1 hour high > [-2] 1 hour high and [0] 1 hour high > [-3] 1 hour high and [0] 1 hour high > [-4] 1 hour high and [0] 1 hour high > [-5] 1 hour high and [0] 1 hour high > [-6] 1 hour high and [0] 1 hour high > [-7] 1 hour high and [0] 1 hour high > [-8] 1 hour high and [0] 1 hour high > [-9] 1 hour high and [0] 1 hour rsi( 14 ) <= 40 ) )'}},
        {'Double_Top_with_RSI__15_minutes__setup'       : {'scan_clause': '( {segments_filter} ( ( {cash} ( ( {cash} ( [0] 15 minute high < 1.02 * [-8] 15 minute high and [0] 15 minute close < [-8] 15 minute low ) ) or( {cash} ( [0] 15 minute high < 1.02 * [-9] 15 minute high and [0] 15 minute close < [-9] 15 minute low ) ) or( {cash} ( [0] 15 minute high < 1.02 * [-10] 15 minute high and [0] 15 minute close < [-10] 15 minute low ) ) ) ) and [0] 15 minute volume > [0] 15 minute sma( [0] 15 minute volume , 20 ) * 5 and [0] 15 minute high > [-2] 15 minute high and [0] 15 minute high > [-3] 15 minute high and [0] 15 minute high > [-4] 15 minute high and [0] 15 minute high > [-5] 15 minute high and [0] 15 minute high > [-6] 15 minute high and [0] 15 minute high > [-7] 15 minute high and [0] 15 minute high > [-8] 15 minute high and [0] 15 minute high > [-9] 15 minute high and [0] 15 minute rsi( 14 ) <= 40 ) )'}},

        {'Price_above_200_EMI__4_hourly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 200 ) - 1 <= 0.01 and [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__1_hourly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 200 ) - 1 <= 0.01 and [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 200 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_200_EMI__15_minutes__setup'   : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 200 ) - 1 <= 0.01 and [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 200 ) - 1 >= 0.00 ) ))'}},

        {'Price_below_200_EMI__4_hourly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 200 ) - 1 < 0.00 and [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__1_hourly__setup'     : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 200 ) - 1 < 0.00 and [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 200 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_200_EMI__15_minutes__setup'   : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 200 ) - 1 < 0.00 and [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 200 ) - 1 >= -0.01 ) ))'}},

        {'Price_above_50_EMI__4_hourly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 50 ) - 1 <= 0.01 and [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__1_hourly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 50 ) - 1 <= 0.01 and [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 50 ) - 1 >= 0.00 ) ))'}},
        {'Price_above_50_EMI__15_minutes__setup'    : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 50 ) - 1 <= 0.01 and [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 50 ) - 1 >= 0.00 ) ))'}},

        {'Price_below_50_EMI__4_hourly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 50 ) - 1 < 0.00 and [0] 4 hour close / [0] 4 hour ema( [0] 4 hour close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__1_hourly__setup'      : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 50 ) - 1 < 0.00 and [0] 1 hour close / [0] 1 hour ema( [0] 1 hour close , 50 ) - 1 >= -0.01 ) ))'}},
        {'Price_below_50_EMI__15_minutes__setup'    : {'scan_clause': '( {segments_filter} ( {cash} ( [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 50 ) - 1 < 0.00 and [0] 15 minute close / [0] 15 minute ema( [0] 15 minute close , 50 ) - 1 >= -0.01 ) ))'}},

    ]
    return data_list2


def chat_ink_xls2db(file_name=''):
    """
    Download Chart-ink Excel file and insert into a database.
    This function downloads the Chart Ink Excel file, processes it, and inserts the data into the database.
    It also prints the start timestamp and handles any exit conditions.
    Returns: None
    Raises: SystemExit: If the status is "exit", the program will terminate.
    Usage: chat_ink_xls2db()
    """
    data_list1 = data_lists_above_daily()
    data_list2 = data_lists_below_daily()
    data_list =  data_list2 if '15mins' in file_name else data_list1 + data_list2
    table_script_names = ["Insert-Script", "Report-Update-Queries"]
    if '15mins' in file_name:
        table_script_names.append("Cash_15minutes_Stocks")
    else:
        table_script_names.append("Cash_Stocks")

    df_all = chart_ink_file_download_and_insert_db(data_list)
    file_path = chart_ink_to_csv(df_all, file_name)
    insert_into_database_tables(table_script_names, bulk_file_path=file_path)


def purge_log_files(filetype='daily_chart_ink'):
    """
    Purges log files older than 7 days from the _Logs directory.
    This function is useful for maintaining clean log entries and preventing excessive disk usage.
    """
    print("🚀 start - Purging log files older than 5 days...")
    log_dir = Path(project_directory_path()) / '_Logs'
    if not log_dir.exists():
        print(f"❌ Log directory {log_dir} does not exist. No logs to purge.")
        return
    file_type = f"{filetype}*.log"
    for file_name in log_dir.glob(file_type):
        log_file_path = file_name.resolve()  # Get the absolute path of the log file
        days_to_keep = 1
        cutoff_date = datetime.now() - timedelta(days=days_to_keep)
        new_logs = []
        with open(log_file_path, 'r', encoding='utf-8') as file:
            for line in file:
                try:
                    if line.startswith("❌ Malformed line in log file"):
                        continue  # Skip lines that are error messages
                    # Extract timestamp from the beginning of the line: '2025-07-17 16:48:59,056'
                    timestamp_str = line.split(" - ")[0]  # This grabs just the timestamp portion
                    log_date = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M:%S,%f')
                    if log_date >= cutoff_date:
                        new_logs.append(line)
                except Exception as e: # noqa
                    # Optionally log or skip malformed lines
                    # print(f"❌ Malformed line in log file {log_file_path}: {line.strip()} \nand error message is: {e}")
                    # Only log the first occurrence, or skip logging error lines entirely
                    pass
        with open(log_file_path, 'w', encoding='utf-8') as file:
            file.writelines(new_logs)
    print("✅ completed - Purging log files older than 5 days...")


def purge_tables(table_part_name = ''):
    """
    Purges the dbo.stocks_daily table in the Stocks_Analysis database.
    This function is useful for clearing old data before inserting new data.
    """
    print("🚀 start - removing old records from tables...")
    conn = get_database_connection()
    if conn is None:
        print("❌ Failed to connect to the database. Cannot purge tables.")
        return

    sql_query = f"""
    DELETE FROM dbo.Cash_{table_part_name}Stocks 
    WHERE batch_no NOT IN (SELECT distinct TOP 5 batch_no FROM dbo.Cash_{table_part_name}Stocks ORDER BY batch_no DESC);
    DELETE FROM dbo.Analyse_{table_part_name}Stocks 
    WHERE batch_no NOT IN (SELECT distinct TOP 25 batch_no FROM dbo.Analyse_{table_part_name}Stocks ORDER BY batch_no DESC);
    """
    cursor = conn.cursor()
    try:
        cursor.execute(sql_query)
        conn.commit()
        print("✅ Successfully purged all tables.")
    except pyodbc.Error as e:
        print(f"❌ Error purging the tables: {e}")
    finally:
        cursor.close()
        conn.close()
        print("✅ completed - removing old records from tables...")


def shrink_databases():
    """
    Shrinks the Stocks_Analysis database to reclaim unused space.
    This function is useful for optimizing database storage.
    """
    today = datetime.today()
    if today.day == 1:
        print(f"🗓️ Today is the 1st of the Month so Shrinking the database log files.")
        print("🚀 start - Shrinking the Stocks_Analysis database log files...")
    else:
        sys.exit()

    conn = get_database_connection()
    if conn is None:
        print("❌ Failed to connect to the database. Cannot shrink databases.")
        return
    sql_query = f""" 
        -- shrink database log file
        USE Stocks_Analysis;
        ALTER DATABASE Stocks_Analysis SET RECOVERY SIMPLE;
        DBCC SHRINKFILE (Stocks_Analysis_log, 1); -- Shrinks to 1MB
        
        USE Stocks_db;
        ALTER DATABASE Stocks_db SET RECOVERY SIMPLE;
        DBCC SHRINKFILE (Stocks_db_log, 1); -- Shrinks to 1MB
    """
    cursor = conn.cursor()
    try:
        cursor.execute(sql_query)
        conn.commit()
        print("✅ Successfully shrunk the Stocks_Analysis database.")
    except pyodbc.Error as e:
        print(f"❌ Error shrinking the database: {e}")
    finally:
        cursor.close()
        conn.close()
        print("✅ completed - Shrinking the Stocks_Analysis database log files...")

