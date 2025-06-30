import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from stock_thumb_nails import *


if __name__ == "__main__":
    _, start_date, start_time = print_start_timestamp()  # Print start timestamp and check trading hours
    stock_thumb_nails("15minutes")  # Call the function to create stock thumbnails
    print_end_timestamp(start_date, start_time)  # Print end timestamp

