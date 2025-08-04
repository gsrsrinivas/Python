import os, sys, time, psutil, pyodbc, requests, pandas as pd, ctypes, logging
from logging.handlers import RotatingFileHandler
from concurrent.futures import ThreadPoolExecutor
from bs4 import BeautifulSoup as Bs
from datetime import datetime, timedelta
from pathlib import Path

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
    start_time = datetime.strptime("07:00", "%H:%M").time()
    end_time = datetime.strptime("15:30", "%H:%M").time()

    if start_time <= current_time <= end_time:
        print(f"⏱️ Trading hours are (07:00 to 15:30) and current time is {current_time} ")
        print(f"Which is within trading hours. So continuing...")
        return "continue"
    else:
        print(f"⏱️ Trading hours are (07:00 to 15:30) and current time is {current_time} ")
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


def insert_into_db_from_data_frame(data_frame, table_names):
    """ Inserts data from a DataFrame into an SQL Server database table using batch insert.
    :param data_frame:
    :param table_names:
    :return:
    """
    with get_database_connection() as conn:
        cursor = conn.cursor()
        # start - Insert data into the database table using batch insert from DataFrame
        df_all = data_frame.fillna(0)  # Fill NaN values with 0 for numeric columns
        records = df_all[['sno', 'stock_name', 'symbol', 'bsecode', 'percent_change', 'price', 'volume',
                          'Indicator', 'TimeLine', 'Direction', 'segments', 'Batch_No']].values.tolist()
        # Define the insert statement
        insert_query = f'''INSERT INTO dbo.{table_names[0]}(sno,stock_name,symbol,bsecode,Percent_Change,price,volume,Indicator,TimeLine,Direction,Segments,Batch_No)
        VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
        cursor.executemany(insert_query, records)
        conn.commit()
        print(f"✅ {len(records)} records inserted in {table_names[0]} table using batch insert!")
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
            "insert_script_sql_file": Path(f"{input_folder_path}/{table_names[1]}.sql"),
            "update_report_sql_file": Path(f"{input_folder_path}/{table_names[2]}.sql")
        }
        # end - Get the file path of both SQL Script files
        # start - Execute both SQL Script files
        for label, path in file_paths.items():
            print(f"⏳ Executing {label.replace('_', ' ').capitalize()}")
            with open(path, 'r', encoding='utf-8') as file_path:
                cursor.execute(file_path.read())
            conn.commit()
            print(f"✅ Committed {label.replace('_', ' ').capitalize()}")
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
        bulk_insert_from_csv(bulk_file_path, table_names[0])  # Insert data from CSV file into the database table
    else:
        insert_into_db_from_data_frame(data_frame, table_names)  # Insert data from DataFrame into the database table
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


def chart_ink_excel_file_download_and_insert_into_db(data_list):
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


def chart_ink_to_csv(df, file_name):
    print(f"📥 started saving data to CSV file")
    str_datetime = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
    file_nm = f'{file_name}---{str_datetime}' if '15_min' not in file_name else file_name
    output_file = Path(project_directory_path()) / 'Chart_Ink/Source' / f'{file_nm}.csv'
    print(f"📥 Saving data to CSV file: {output_file}")
    if df.empty:
        print("❌ No data to save. DataFrame is empty.")
        return None
    df.to_csv(output_file, index=False) # Save to CSV
    print("✅ Data saved to csv file successfully.")
    return output_file


def chat_ink_xls2db(file_name=None):
    """
    Download Chart-ink Excel file and insert into a database.
    This function downloads the Chart Ink Excel file, processes it, and inserts the data into the database.
    It also prints the start timestamp and handles any exit conditions.
    Returns: None
    Raises: SystemExit: If the status is "exit", the program will terminate.
    Usage: chat_ink_xls2db()
    """
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

    ]
    data_list2 = [
        {'macd__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},

        {'stochastic__4_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__4_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__1_hourly__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_above' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic__15_minutes__crosses_below' : {'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},

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

    ]

    if '15Minutes' in file_name:
        table_script_names = ["Cash_15minutes_Stocks","Insert-Script--15minutes","Report-Update-Queries--15Minutes",]
        data_list = data_list2
        csv_file = f"{Path(__file__).stem}-15Mins.csv"
    else:
        table_script_names = ["Cash_Stocks", "Insert-Script", "Report-Update-Queries"]
        data_list = data_list1 + data_list2
        csv_file = f"{Path(__file__).stem}.csv"

    df_all = chart_ink_excel_file_download_and_insert_into_db(data_list)
    file_path = chart_ink_to_csv(df_all, csv_file)
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
        days_to_keep = 5
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

