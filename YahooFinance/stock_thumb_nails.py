from concurrent.futures import ThreadPoolExecutor
import matplotlib
# Ensure matplotlib uses a non-GUI backend to avoid display issues in headless environments
matplotlib.use('Agg')  # Use a non-GUI backend
import matplotlib.pyplot as plt
import yfinance as yf
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Common_Functions.base_functions import *


def plot_stock(thumb_dir, symbol_name, i=0, total_len=0, interval_value='1d', period_value='30d'):
    """
    download stock data and plot it.
    :param i: the index of the current stock being processed.
    :param total_len: total number of stocks to be processed.
    :param thumb_dir: folder to save thumbnails.
    :param symbol_name: stock symbol to download data for.
    :param period_value: period for which to download data.
    :param interval_value: interval of the data.
    :return: none
    """
    # Download historical data
    data = yf.download(symbol_name, period=period_value, interval=interval_value, auto_adjust=True, progress=False)
    if data.empty:
        print(f"No data found for {symbol_name} with period {period_value} and interval {interval_value}.")
        return
    # Plot closing price
    plt.figure(figsize=(2, 1.5))  # Small thumbnail size
    plt.plot(data['Close'], linewidth=1)
    plt.title(f"{symbol_name.replace(".NS", "")}-{interval_value}-{period_value}", fontsize=8)
    plt.xticks([], [])
    plt.yticks([], [])
    plt.tight_layout()
    plt.savefig(os.path.join(thumb_dir, f'{symbol_name}_{interval_value}_{period_value}.png'), dpi=100, format='png')
    plt.close()
    print(f"{str(i).zfill(4)}/{str(total_len).ljust(5,' ')} - {str(symbol_name).ljust(20,' ')} - {period_value.ljust(3,' ')} - {interval_value.ljust(3,' ')}")


def valid_intervals_periods():
    """
    Returns a list of dictionaries with valid intervals and periods for stock data.
    The intervals and periods are chosen based on the current date to ensure relevance.
    Valid intervals: [1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 4h, 1d, 5d, 1wk, 1mo, 3mo]
    Valid period: 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max, etc.,
    :return: List of dictionaries with interval and period pairs.
    """
    # Add short intervals for daily runs, and longer intervals for weekly, monthly, etc.
    # Always add daily intervals
    today = datetime.today()
    weekday = today.weekday()  # Monday is 0, Sunday is 6
    valid_interval_period  = [{'15m': '5d'}, {'1h': '5d'}, {'4h': '1mo'}, {'1d': '1y'},]
    valid_interval_period += [{'1wk': '2y'},] if weekday == 0 else [] # Add weekly intervals at the start of the week (Monday)
    valid_interval_period += [{'1mo': '10y'}] if today.day == 1 else [] # Add monthly intervals at the start of the month
    valid_interval_period += [{'3mo': '5y'},{'3mo': '10y'},] if today.month in [1, 4, 7, 10] and today.day == 1 else [] # Add quarterly intervals at the start of a quarter
    valid_interval_period += [{'6mo': '5y'}, {'6mo': '10y'}] if today.month in [1, 7] and today.day == 1 else [] # Add half-yearly intervals at the start of a half-year
    valid_interval_period += [{'1y': 'max'},] if today.month == 1 and today.day == 1 else []     # Add yearly intervals at the start of the year
    # valid_intervals_periods = [ {'15m': '5d'}, {'1h': '5d'}, {'4h': '1mo'}, {'1d': '3mo'},{'1wk': '6mo'}, {'1wk': '1y'},{'1mo':'5y'}, ]  # Valid periods and intervals
    return valid_interval_period  # Return the list of valid intervals and periods


def connect_to_db():
    """
    Connect to the database and retrieve stock symbols.
    This function connects to the database, retrieves stock symbols,
    and returns a list of symbols and their count.
    """
    conn = get_database_connection()
    cursor = conn.cursor()
    # cursor.execute("select distinct Symbol from dbo.Master_Stocks_In_Segments")
    cursor.execute("select distinct Symbol from dbo.Analyse_Stocks_v with (nolock)")
    records = cursor.fetchall()  # Fetch all results into a variable
    first_elements = [str(item[0]) + ".NS" for item in records]  # Extract the first element from each tuple
    conn.close()
    symbols = first_elements  # ['HAL.NS',]
    len_symbols = len(symbols)
    print(f"count of symbols: {len_symbols}")
    return len_symbols, symbols  # Return the list of symbols and their count


def stock_thumb_nails(timeframe=None):
    """
    Create stock thumbnails for all stocks names from the database into a folder.
    This function retrieves stock symbols from the database, downloads their historical data,
    and creates thumbnails for each stock symbol with various intervals and periods.
    It saves the thumbnails in a specified directory.
    The function also handles different intervals and periods based on the current date,
    ensuring that the thumbnails are relevant to the current trading conditions.
    """
    thumb_dir = os.path.dirname(os.path.dirname(project_directory_path())) + r'\Pictures\Thumbnails' # Get the path to the Pictures folder; Folder to save thumbnails
    os.makedirs(thumb_dir, exist_ok=True) # Create thumbnails directory if it doesn't exist
    print(f'Thumbnails will be saved in: "{thumb_dir}"')

    len_symbols, symbols = connect_to_db() # Connect to the database and get stock symbols
    valid_interval_period = valid_intervals_periods() if timeframe is None else timeframe # Get valid intervals and periods and specific timeframe for every 15-minute screening

    len_valid_intervals_periods = len(valid_interval_period) # Count the number of valid intervals and periods
    print(f"count of valid intervals and periods: {len_valid_intervals_periods}")
    total_len = len_symbols * len_valid_intervals_periods
    print(f"Total thumbnails to be created: {total_len}")
    # ------------------------------------------------------------------------------------
    try:
        requests.Session().get('https://google.com')
    except Exception as e:
        print(f"No Internet Connection: {e}")
        sys.exit(1)

    # def plot(symbol_nm, increment, total_count, interval_val, period_val):
    #     plot_stock(thumb_dir, symbol_nm, increment, total_count, interval_value=interval_val, period_value=period_val)
    # -------------------
    with ThreadPoolExecutor(max_workers=12) as executor:
        i = 1
        for symbol in symbols:
            for interval_period_dict in valid_interval_period:
                interval, period = next(iter(interval_period_dict.items()))
                executor.submit(plot_stock, thumb_dir, symbol, i, total_len, interval, period)
                i+=1
    #------------------------------------------------------------------------------------
    print(f'Total {total_len} Thumbnails processed & saved: "{thumb_dir}"')
    # # Download historical data and create thumbnails
    # i=1
    # for symbol in symbols:
    #     for interval_period_dict in valid_interval_period:
    #         interval, period = next(iter(interval_period_dict.items()))
    #         plot_stock(thumb_dir, symbol, i, total_len, interval_value=interval, period_value=period)  # Plot stock data
    #         i+= 1
    # print(f'Total {total_len} Thumbnails processed & saved: "{thumb_dir}"')


def stock_thumb_nails_all_times():
    setup_logger(__file__, f"daily_{Path(__file__).stem}.log") # "daily_stock_thumb_nails.log")
    try:
        print_start_timestamp()
        # sys.exit() if trading_hours_check() == "exit" else None
        # prevent_sleep()
        stock_thumb_nails()
        purge_log_files('daily_stock')
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)
    finally:
        # allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    stock_thumb_nails_all_times()
