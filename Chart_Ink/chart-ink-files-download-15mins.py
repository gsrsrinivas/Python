import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent dir of this file and add to sys.path
from _Common_Functions.base_functions import *


def chart_ink_download_15minutes():
    setup_logger(__file__,f"15Minutes-{Path(__file__).stem}.log")
    try:
        print_start_timestamp()
        sys.exit() if trading_hours_check() == "exit" else None
        chat_ink_xls2db(Path(__file__).stem)
        purge_tables('15Minutes_')
        purge_log_files('15Minutes-chart-ink')
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)
    finally:
        print_end_timestamp()


if __name__ == "__main__":
    chart_ink_download_15minutes()


