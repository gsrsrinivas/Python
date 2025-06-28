import matplotlib
matplotlib.use('Agg')  # Use a non-GUI backend
import matplotlib.pyplot as plt
import yfinance as yf
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Shared.base_functions import *


def plot_stock(thumb_dir, symbol_name, period_value='30d', interval_value='1d'):
    """
    Download stock data and plot it.
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
    plt.title(f"{symbol_name} - {interval_value} Interval of {period_value} Period", fontsize=8)
    plt.xticks([], [])
    plt.yticks([], [])
    plt.tight_layout()
    plt.savefig(os.path.join(thumb_dir, f'{symbol_name}_{interval_value}_{period_value}.png'), dpi=100, format='png')
    plt.close()
    print(f"Thumbnail saved for {symbol_name} with period {period_value} and interval {interval_value}.")


def stock_thumb_nails():
    conn = get_database_connection()
    cursor = conn.cursor()
    cursor.execute("select Symbol,Stock_Name from _sis.Master_Stocks_In_Segments")
    records = cursor.fetchall()  # Fetch all results into a variable
    first_elements = [str(item[0]) + ".NS" for item in records]  # Extract the first element from each tuple
    conn.close()
    symbols = first_elements  # ['HAL.NS',]
    thumb_dir = 'thumbnails'  # Folder to save thumbnails
    os.makedirs(thumb_dir, exist_ok=True)  # Create thumbnails directory if it doesn't exist
    # Valid intervals: [1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 4h, 1d, 5d, 1wk, 1mo, 3mo]
    # Valid period: 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max, etc.,
    valid_intervals_periods = [ {'15m': '5d'}, {'1h': '5d'}, {'4h': '1mo'}, {'1d': '3mo'}, {'1wk': '6mo'}, {'1wk': '1y'}, {'1mo':'5y'} ]  # Valid periods and intervals
    # Download historical data and create thumbnails
    for symbol in symbols:
        for period_dict in valid_intervals_periods:
            interval, period = next(iter(period_dict.items()))
            plot_stock(thumb_dir, symbol, period_value=period, interval_value=interval)  # Plot stock data

    print(f'Thumbnails saved in "{thumb_dir}" directory.')


if __name__ == "__main__":
    start_date, start_time, status = print_start_timestamp()  # Print start timestamp and check trading hours
    stock_thumb_nails()  # Call the function to create stock thumbnails
    print(f"Script completed successfully.")
    print_end_timestamp(start_date, start_time)  # Print end timestamp

