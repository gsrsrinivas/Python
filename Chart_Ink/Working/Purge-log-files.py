# This script is used to purge log files in the Chart Ink project.
# It imports necessary functions from a shared module and calls the purge_log_files function.
# Import necessary functions from the shared module

from _Common_Functions.base_functions import *

if __name__ == "__main__":
    # Call the function to purge log files
    print("Purging log files...")
    purge_log_files()


