import sys
import time
from time import sleep

def sleep_time():
    # Initial print statement
    print("this is the example of print on same line")
    sys.stdout.write("\rLoading...")
    sys.stdout.flush()

    # Simulate some work
    time.sleep(2)

    # Update the line with new information
    ##################### \r will print the output from the begging of the line  ####################
    sys.stdout.write(f"\rProcess complete!")
    sys.stdout.flush()

    print()  # Move to a new line

if __name__ == "__main__":
    sleep_time()
