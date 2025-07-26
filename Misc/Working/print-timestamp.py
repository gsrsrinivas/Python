from datetime import datetime
import time
start_date = datetime.now()
start_time = time.time()
date_str = start_date.strftime('%Y-%m-%d')
time_str = start_date.strftime('%H:%M:%S')
print (f"start time is: {start_time} and time_str is: {time_str}")

