import matplotlib
from yfinance.utils import auto_adjust

matplotlib.use('Agg')  # Use a non-GUI backend
import matplotlib.pyplot as plt
import yfinance as yf
from datetime import datetime
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Shared.base_functions import *


def plot_stock(thumb_dir, symbol_name, i=0, total_len=0, interval_value='1d', period_value='30d'):
    """
    Download stock data and plot it.
    :param i: the index of the current stock being processed.
    :param total_len: total number of stocks to be processed.
    :param thumb_dir: folder to save thumbnails.
    :param symbol_name: Stock symbol to download data for.
    :param period_value: Period for which to download data.
    :param interval_value: Interval of the data.
    :return: None
    """
    # Download historical data
    data = yf.download(symbol_name, period=period_value, interval=interval_value, auto_adjust=True, progress=False)
    if data.empty:
        print(f"No data found for {symbol_name} with period {period_value} and interval {interval_value}.")
        return
    # Plot closing price
    plt.figure(figsize=(2, 1.5))  # Small thumbnail size
    plt.plot(data['Close'], linewidth=1)
    plt.title(f"{symbol_name.replace(".NS", "")}-{interval_value}-{period_value} prd", fontsize=8)
    plt.xticks([], [])
    plt.yticks([], [])
    plt.tight_layout()
    plt.savefig(os.path.join(thumb_dir, f'{symbol_name}_{interval_value}_{period_value}.png'), dpi=100, format='png')
    plt.close()
    print(f"{i} out of {total_len} Thumbnail saved for {symbol_name} with period {period_value} and interval {interval_value}.")


def stock_thumb_nails():
    """
    Create stock thumbnails for all stocks names from the database into a folder.
    This function retrieves stock symbols from the database, downloads their historical data,
    and creates thumbnails for each stock symbol with various intervals and periods.
    It saves the thumbnails in a specified directory.
    The function also handles different intervals and periods based on the current date,
    ensuring that the thumbnails are relevant to the current trading conditions.
    """
    conn = get_database_connection()
    cursor = conn.cursor()
    cursor.execute("select Symbol,Stock_Name from _sis.Master_Stocks_In_Segments")
    records = cursor.fetchall()  # Fetch all results into a variable
    first_elements = [str(item[0]) + ".NS" for item in records]  # Extract the first element from each tuple
    conn.close()
    symbols = first_elements  # ['HAL.NS',]
    len_symbols = len(symbols)
    print(f"count of symbols: {len_symbols}")
    thumb_dir = 'thumbnails'  # Folder to save thumbnails
    os.makedirs(thumb_dir, exist_ok=True)  # Create thumbnails directory if it doesn't exist
    # Valid intervals: [1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 4h, 1d, 5d, 1wk, 1mo, 3mo]
    # Valid period: 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max, etc.,
    # Add short intervals for daily runs, and longer intervals for weekly, monthly, etc.
    # Always add daily intervals
    today = datetime.today()
    weekday = today.weekday()  # Monday is 0, Sunday is 6
    valid_interval_period = [{'15m': '5d'}, {'1h': '5d'}, {'4h': '1mo'}, {'1d': '6mo'},]
    # Add weekly intervals at the start of the week (Monday)
    valid_interval_period += [{'1wk': '3mo' }, {'1wk': '6mo'}, {'1wk': '1y'},] if weekday == 0 else []
    # Add monthly intervals at the start of the month
    valid_interval_period += [{'1mo': '5y'}, {'1mo': '10y'}] if today.day == 1 else []
    # Add quarterly intervals at the start of a quarter
    valid_interval_period += [{'3mo': '5y'},{'3mo': '10y'},] if today.month in [1, 4, 7, 10] and today.day == 1 else []
    # Add half-yearly intervals at the start of a half year
    valid_interval_period += [{'6mo': '5y'}, {'6mo': '10y'}] if today.month in [1, 7] and today.day == 1 else []
    # Add yearly intervals at the start of the year
    valid_interval_period += [{'1y': 'max'},] if today.month == 1 and today.day == 1 else []
    # valid_intervals_periods = [ {'15m': '5d'}, {'1h': '5d'}, {'4h': '1mo'}, {'1d': '3mo'},{'1wk': '6mo'}, {'1wk': '1y'},{'1mo':'5y'}, ]  # Valid periods and intervals
    len_valid_intervals_periods = len(valid_interval_period)
    print(f"count of valid intervals and periods: {len_valid_intervals_periods}")
    total_len = len_symbols * len_valid_intervals_periods
    print(f"Total thumbnails to be created: {total_len}")
    # Download historical data and create thumbnails
    i=1
    for symbol in symbols:
        for interval_period_dict in valid_interval_period:
            interval, period = next(iter(interval_period_dict.items()))
            plot_stock(thumb_dir, symbol, i, total_len, interval_value=interval, period_value=period)  # Plot stock data
            i+= 1

    print(f'Total {total_len} Thumbnails processed and saved in "{thumb_dir}" directory.')


if __name__ == "__main__":
    start_date, start_time, status = print_start_timestamp()  # Print start timestamp and check trading hours
    stock_thumb_nails()  # Call the function to create stock thumbnails
    print(f"Script completed successfully.")
    print_end_timestamp(start_date, start_time)  # Print end timestamp

