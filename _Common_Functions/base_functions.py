import os, sys, time, psutil, pyodbc, requests, pandas as pd, ctypes, logging
from logging.handlers import RotatingFileHandler
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


# 🔄 Redirect print and stderr to logger
class StreamToLogger:
    def __init__(self, logger, log_level=logging.INFO):
        self.logger = logger
        self.log_level = log_level

    def write(self, message):
        message = message.strip()
        if message:
            self.logger.log(self.log_level, message)

    def flush(self):
        pass


# 🔁 Setup logger with rotating file +color console + print/sys.stderr redirection
def setup_logger(name="my_logger", log_file="execution.log", max_bytes=1024*1024*5, backup_count=5):
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
        print(f"⏱️ Current Time: {current_time} is within trading hours (07:00 to 15:30). Continuing the program.")
        return "continue"
    else:
        print(f"⏱️ Current Time: {current_time} is outside trading hours (07:00 to 15:30). Exiting the program.")
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
        conn_str = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=DESKTOP-EP99LTB;DATABASE=Stocks_Analysis;Trusted_Connection=yes;'
        with pyodbc.connect(conn_str) as conn:
            # print("🗄️Database connection successful.")
            return conn
    except pyodbc.Error as e:
        print(f"❌ Database connection failed: {e}")
        return None


def insert_into_database_tables(df_all, table_names):
    """ Inserts data from a DataFrame into an SQL Server database table and executes SQL scripts.
    Args:
        df_all (pd.DataFrame): DataFrame containing the data to be inserted
        table_names (list): List containing the names of the database tables.
    Returns:
        None
    """
    print(f'📥 started inserting into the database table')
    df_all = df_all.fillna(0)
    # Define connection string to SQL Server with Windows Authentication
    conn_str = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=DESKTOP-EP99LTB;DATABASE=Stocks_Analysis;Trusted_Connection=yes;'
    # Define the insert statement
    insert_query = f'''INSERT INTO dbo.{table_names[0]}(sno,stock_name,symbol,bsecode,Percent_Change,price,volume,Indicator,TimeLine,Direction,Segments,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''
    pictures_path = project_directory_path()
    input_folder_path = pictures_path + r"\Database_Scripts\Analysis of Stocks"
    file_paths = {
        "insert_script_sql_file": Path(f"{input_folder_path}/{table_names[1]}.sql"),
        "update_report_sql_file": Path(f"{input_folder_path}/{table_names[2]}.sql")
    }
    # Establish connection to SQL Server
    with pyodbc.connect(conn_str) as conn:
        cursor = conn.cursor()
        records = df_all[[
            'sno', 'stock_name', 'symbol', 'bsecode', 'percent_change',
            'price', 'volume', 'Indicator', 'TimeLine',
            'Direction', 'segments', 'Batch_No'
        ]].values.tolist()
        cursor.executemany(insert_query, records)
        conn.commit()
        print(f"✅ {len(records)} records inserted in {table_names[0]} table using batch insert!")
        # Execute both SQL Script files
        for label, path in file_paths.items():
            print(f"⏳ Executing {label.replace('_', ' ').capitalize()}")
            with open(path, 'r', encoding='utf-8') as file_path:
                cursor.execute(file_path.read())
                # -------------------------------
                # rows = cursor.fetchall()
                # print(*rows, sep='\n')
                # -------------------------------
            conn.commit()
            print(f"✅ Committed {label.replace('_', ' ').capitalize()}")
    print("✅ Completed all files execution and database insertions.\n")


def download_chart_ink_technical_analysis_scanner(data_each_list, max_retries = 5):
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
        :param data_each_list:
        :param max_retries:
    """
    key, data = next(iter(data_each_list.items()))
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
                    print(f"❌ Scan error:{result["scan_error"]} for rule: {key} with data: {data}")
                return pd.DataFrame(result.get('data', [])) # Step 4: Convert to DataFrame
            except requests.RequestException as e:
                print(f"❌ {data_each_list} Request failed on attempt {attempt + 1}: {e}")
                time.sleep(2 ** attempt)  # Exponential backoff
                return "❌ Maximum retry limit reached. Request failed."
        return None


def insert_new_columns_in_data_frame(df, tf_l_i, each_segment_list, batch_no):
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
        :param batch_no:
    """
    if df.empty:
        return df
    # Reorder columns by name to avoid hardcoded indexes
    expected_order = ['sr', 'nsecode', 'name', 'bsecode', 'per_chg', 'close', 'volume']
    df = df[expected_order]
    # Rename columns
    df.rename(columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                       'close': 'price'}, inplace=True)
    # Extract and clean metadata # insert new columns
    indicator, timeline, direction = (part.replace("_", " ") for part in tf_l_i.split("__"))
    # Insert new metadata columns
    df.loc[:, ['Indicator', 'TimeLine', 'Direction', 'segments', 'Batch_No']] = [indicator, timeline, direction,
                                                                                each_segment_list, batch_no]
    return df


def chart_ink_excel_file_download_and_insert_into_db(data_list, table_names):
    """
    Downloads technical analysis data from Chart ink for multiple segments and inserts it into a database.
    :param data_list: It contains the scan parameters for Chart ink.
    :param table_names: It contains the names of the database tables.
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
    batch_no = datetime.now().strftime('%Y%m%d%H%M%S')
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
            df = insert_new_columns_in_data_frame(df, key, each_segment_list,batch_no)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(f"complete - '{str(key.replace("__", ";").replace("_", " ")).ljust(56,' ')}' - {each_segment_list} segments ")
    print(f"\n🔄 downloading data from the website is complete.")
    insert_into_database_tables(df_all, table_names)


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
                    # Extract timestamp from the beginning of the line: '2025-07-17 16:48:59,056'
                    timestamp_str = line.split(" - ")[0]  # This grabs just the timestamp portion
                    log_date = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M:%S,%f')
                    if log_date >= cutoff_date:
                        new_logs.append(line)
                except Exception as e:
                    print(f"❌ Malformed line in log file {log_file_path}: {line.strip()} \nand error message is: {e}")
                    # Optionally log or skip malformed lines
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
    WHERE batch_no NOT IN (SELECT distinct TOP 15 batch_no FROM dbo.Cash_{table_part_name}Stocks ORDER BY batch_no DESC)
    ;
    DELETE FROM dbo.Analyse_{table_part_name}Stocks 
    WHERE batch_no NOT IN (SELECT distinct TOP 15 batch_no FROM dbo.Analyse_{table_part_name}Stocks ORDER BY batch_no DESC)
    ;
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
    sql_query = f""" -- shrink database log file
    USE Stocks_Analysis;
    GO;
    ALTER DATABASE Stocks_Analysis SET RECOVERY SIMPLE;
    DBCC SHRINKFILE (Stocks_Analysis_log, 1); -- Shrinks to 1MB
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

