import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))
import concurrent.futures
from multiprocessing import Process

from YahooFinance.stock_thumb_nails import stock_thumb_nails_all_times
from Chart_Ink.chart_ink_excel_file_download_and_insert_into_db import chart_ink_download
from _Shared.base_functions import *


if __name__ == "__main__":
    try:
        print_start_timestamp()
        prevent_sleep()
        print("System will stay awake. Running your task...")
        # sys.exit() if trading_hours_check() == "exit" else None
        with concurrent.futures.ThreadPoolExecutor() as executor:
            future1 = executor.submit(chart_ink_download)
            future2 = executor.submit(stock_thumb_nails_all_times)
            concurrent.futures.wait([future1, future2])
    except Exception as e:
        print(f"An error occurred: {e} \nPlease check the logs for more details.")
        sys.exit(1)
    finally:
        allow_sleep()
        print("System can now sleep normally.")
        print_end_timestamp()

