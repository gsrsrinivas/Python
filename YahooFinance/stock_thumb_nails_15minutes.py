import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from YahooFinance.stock_thumb_nails import *

def stock_thumb_nails_15min():
    """
    Create stock thumbnails for all stocks names from the database into a folder.
    This function retrieves stock symbols from the database, downloads their historical data,
    and creates thumbnails for each stock symbol with a 15-minute interval and various periods.
    It saves the thumbnails in a specified directory.
    {'1d': '1y'}, {'1wk': '2y'}, {'1mo': '10y'}
    """
    setup_logger(__file__, "15_minutes_stock_thumb_nails.log")
    try:
        print_start_timestamp()
        sys.exit() if trading_hours_check() == "exit" else None
        stock_thumb_nails([{'15m': '5d'},])  #Call the function to create stock thumbnails
        purge_log_files('15_minutes_stock')
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print_end_timestamp()


if __name__ == "__main__":
    stock_thumb_nails_15min()
