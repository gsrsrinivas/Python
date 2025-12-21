import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Common_Functions.base_functions import *


def chart_ink_download():
    setup_logger(__file__, f"daily_{Path(__file__).stem}.log")
    try:
        print_start_timestamp()
        # prevent_sleep()
        # sys.exit() if trading_hours_check() == "exit" else None
        chat_ink_xls2db(Path(__file__).stem)
        purge_tables()
        shrink_databases()
        purge_log_files('daily_chart_ink')
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    chart_ink_download()
