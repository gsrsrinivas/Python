import sys, concurrent.futures
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[1]))
from Chart_Ink.chart_ink_excel_file_download_every_15_minutes_and_insert_into_db import chart_ink_download_15minutes
from YahooFinance.stock_thumb_nails_15minutes import stock_thumb_nails_15min
from _Shared.base_functions import *


if __name__ == "__main__":
    printlog = setup_logger(__file__, __file__.replace('.py', '.log'))
    try:
        print_start_timestamp()
        # prevent_sleep()
        # sys.exit() if trading_hours_check() == "exit" else None
        with concurrent.futures.ThreadPoolExecutor() as executor:
            chart_ink = executor.submit(chart_ink_download_15minutes)
            thumb_nails = executor.submit(stock_thumb_nails_15min)
            concurrent.futures.wait([chart_ink, thumb_nails])
    except Exception as e:
        print(f"An error occurred: {e} \nPlease check the logs for more details.")
        sys.exit(1)
    finally:
        # allow_sleep()
        print_end_timestamp()

