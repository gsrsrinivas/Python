import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from YahooFinance.stock_thumb_nails import *

def all_stock_thumb_nails():
    """
    Create stock thumbnails for all stocks names from the database into a folder.
    This function retrieves stock symbols from the database, downloads their historical data,
    and creates thumbnails for each stock symbol with a 15-minute interval and various periods.
    It saves the thumbnails in a specified directory.
    """
    # {'1d': '1y'}, {'1wk': '2y'}, {'1mo': '10y'} # noqa

    setup_logger(__file__, f"15minutes_{Path(__file__).stem}.log")
    try:
        print_start_timestamp()
        # sys.exit() if trading_hours_check() == "exit" else None
        stock_thumb_nails('All')  #Call the function to create stock thumbnails
        purge_log_files('Stock_thumb_nails_All')
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print_end_timestamp()


if __name__ == "__main__":
    all_stock_thumb_nails()
