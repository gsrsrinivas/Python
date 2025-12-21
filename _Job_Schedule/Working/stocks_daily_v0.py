import subprocess
import time

if __name__ == "__main__":
    run_chart_ink_file = r"/Chart_Ink/chart-ink-files-download.py"
    run_thumb_nails = r"C:\Users\gsrsr\Documents\PythonProject\YahooFinance\stock_thumb_nails.py"
    # Start the process (non-blocking)
    process_1 = subprocess.Popen(["python", run_chart_ink_file])
    process_2 = subprocess.Popen(["python", run_thumb_nails])
    # Loop until the process finishes
    while True:
        # Check if either process is still running
        if process_1.poll() is not None and process_2.poll() is not None:
            print("Both processes have finished.")
            break
        time.sleep(1)
