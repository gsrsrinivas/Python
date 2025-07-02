import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from stock_thumb_nails import *


if __name__ == "__main__":
    print_start_timestamp()
    sys.exit() if trading_hours_check() == "exit" else None

    stock_thumb_nails("15minutes")  # Call the function to create stock thumbnails

    print_end_timestamp()

