# this is working fine
# can be used to prevent sleep during long-running tasks
import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent dir of this file and add to sys.path
from _Common_Functions.base_functions import *

# import ctypes
# import time
#
# # Constants from Windows API
# ES_CONTINUOUS = 0x80000000
# ES_SYSTEM_REQUIRED = 0x00000001
# ES_AWAY_MODE_REQUIRED = 0x00000040  # Optional for media apps
# # flags = 0x80000000 | 0x00000001 | 0x00000040 # ES_Continuous, ES_System_Required, ES_Away_Mode_Required
#
# def prevent_sleep():
#     # This tells Windows: “Stay awake while this process is running”
#     ctypes.windll.kernel32.SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_AWAY_MODE_REQUIRED)
#
#
# def allow_sleep():
#     # Restore the system’s sleep settings
#     ctypes.windll.kernel32.SetThreadExecutionState(ES_CONTINUOUS)

if __name__ == "__main__":
    try:
        prevent_sleep()
        print("System will stay awake. Running your task...")

        # Simulate a long-running task
        time.sleep(15)  # Replace this with your actual logic (e.g., ETL, queries)

        print("Task complete.")
    finally:
        allow_sleep()
        print("System can now sleep normally.")
