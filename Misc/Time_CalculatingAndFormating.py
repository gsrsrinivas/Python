from datetime import datetime, timedelta

def calculate_timestamp():
    # Sample timestamps
    timestamp1 = "09:30:01"
    timestamp2 = "15:45:01"
    timestamp3 = datetime.now().strftime("%H:%M:%S")

    # Define a dummy date
    dummy_date = datetime.now().strftime("%Y-%m-%d")

    # Combine the dummy date with the timestamps to create complete datetime strings
    datetime_str1 = f"{dummy_date} {timestamp1}"
    datetime_str2 = f"{dummy_date} {timestamp2}"
    datetime_str3 = f"{dummy_date} {timestamp3}"

    # Convert timestamps to datetime objects
    dt1 = datetime.strptime(datetime_str1, "%Y-%m-%d %H:%M:%S")
    dt2 = datetime.strptime(datetime_str2, "%Y-%m-%d %H:%M:%S")
    dt3 = datetime.strptime(datetime_str3, "%Y-%m-%d %H:%M:%S")
    # Calculate the difference
    difference = dt3 - dt1  # >0
    difference1 = dt3 - dt2 # <0

    # Get the difference in hours and minutes
    total_seconds = difference.total_seconds()
    total_seconds1 = difference1.total_seconds()

    if total_seconds > 0 > total_seconds1:
        print("time is within the range")
    else:
        print("time is out of the range")

    hours = total_seconds // 3600
    minutes = (total_seconds % 3600) // 60

    print(f"current time is {datetime.now().strftime("%Y-%m-%d %H:%M:%S")} \n"
          f"{total_seconds} >0 and {total_seconds1} <0 \n"
          f"total seconds is {total_seconds} \n"
          f"Difference: {int(hours)} hours and {int(minutes)} minutes")

if __name__ == "__main__":
    calculate_timestamp()
