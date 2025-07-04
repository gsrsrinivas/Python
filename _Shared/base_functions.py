import os, sys, time, psutil, pyodbc, requests, pandas as pd
from datetime import datetime
from pathlib import Path
from bs4 import BeautifulSoup as Bs

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file and add to sys.path


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
        print(f"Current Time: {current_time} is within trading hours (07:00 to 15:30). Continuing the program.")
        return "continue"
    else:
        print(f"Current Time: {current_time} is outside trading hours (07:00 to 15:30). Exiting the program.")
        return "exit"


def print_start_timestamp():
    """ Prints the start date and time of the script execution."""
    start_date = datetime.now()
    print(f"Script start timestamp: {start_date}")


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
    print(f"Script end timestamp  : {end_date}")
    end_time = time.time()
    elapsed_seconds = end_time - start_time
    elapsed_duration = datetime.fromtimestamp(end_time) - datetime.fromtimestamp(start_time)
    print(f"Total time in seconds : {elapsed_seconds}\nand formatted time is : {elapsed_duration}\n")
    # time.sleep(15)


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
            # print("Database connection successful.")
            return conn
    except pyodbc.Error as e:
        print(f"Database connection failed: {e}")
        return None


def insert_into_database_tables(df_all, table_names):
    """
    Inserts data from a DataFrame into a SQL Server database table and executes SQL scripts.
    Args:
        df_all (pd.DataFrame): DataFrame containing the data to be inserted.
        table_names (list): List containing the names of the database tables.
    Returns:
        None
    """
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
            print(f"Executing {label.replace('_', ' ').capitalize()} SQL script")
            with open(path, 'r', encoding='utf-8') as file_path:
                cursor.execute(file_path.read())
            conn.commit()
            print(f"Committed {label.replace('_', ' ').capitalize()} SQL script")
    print("Completed all files execution and database insertions.\n")


def download_chart_ink_technical_analysis_scanner(data_each_list):
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
    """
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
        print(
            f"Scan error:{result["scan_error"]} for rule: {key} with data: {data}") if "scan_error" in result else None
        # Step 4: Convert to DataFrame
        return pd.DataFrame(result.get('data', []))


def insert_new_columns_in_data_frame(df, tf_l_i, each_segment_list):
    """
    Reorders, renames, and appends additional metadata columns to the stock DataFrame.
    Args:
        df (pd.DataFrame): The DataFrame containing stock data.
        tf_l_i (str): A string containing indicator, timeline, and direction information.
        each_segment_list (str): The segment of the stock market (e.g., 'Cash').
        start_date (datetime): The date when the data was fetched.
    Returns:
        pd.DataFrame: The modified DataFrame with new columns and reordered data.
    """
    if df.empty:
        return df
    # Reorder columns by name to avoid hardcoded indexes
    expected_order = ['sr', 'nsecode', 'name', 'bsecode', 'per_chg', 'close', 'volume']
    df = df[expected_order]
    # Rename columns
    df.rename(columns={'sr': 'sr#', 'name': 'stock name', 'nsecode': 'symbol', 'bsecode': 'Links', 'per_chg': '% Chg',
                       'close': 'price'}, inplace=True)
    # Extract and clean metadata  # insert new columns
    indicator, timeline, direction = (part.replace("_", " ") for part in tf_l_i.split("__"))
    batch_no = datetime.now().strftime('%Y%m%d')
    # Insert new metadata columns
    df.loc[:, ['Indicator', 'TimeLine', 'Direction', 'Segment', 'Batch_No']] = [indicator, timeline, direction,
                                                                                each_segment_list, batch_no]
    return df


def chart_ink_excel_file_download_and_insert_into_db(data_list, table_names):
    """
    Downloads technical analysis data from Chart ink for multiple segments and inserts it into a database.
    :param data_list: it contains the scan parameters for Chart ink.
    :param table_names: it contains the names of the database tables.
    :param start_date: the date when the data was fetched, used for batch number and metadata.
    :return:
    1. Downloads technical analysis data from Chart ink for multiple segments.
    2. Inserts the downloaded data into a database table.
    3. Prints progress messages to the console.
    :raises KeyError: If the expected keys are not found in the response.
    :raises requests.RequestException: If there is an issue with the HTTP request.
    """
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
            df = insert_new_columns_in_data_frame(df, key, each_segment_list)
            df_all = pd.concat([df_all, df], ignore_index=True)
            print(
                f"complete '{key.replace("__", ";").replace("_", " ")}' for {each_segment_list} segment as of {datetime.now()}")
    print(f"\ndownloading data from the website is complete.")
    insert_into_database_tables(df_all, table_names)
