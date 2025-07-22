import sys, subprocess
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[1]))
from _Common_Functions.base_functions import *


def stocks_daily_15min():
    """
    This function runs two scripts concurrently:
    1. Downloads chart ink data every 15 minutes and insert it into the database.
    2. Create stock thumbnails for all stock names from the database into a folder.
    """
    setup_logger(__file__, "15_minutes_stocks_daily.log")
    try:
        print_start_timestamp()
        prevent_sleep()
        # sys.exit() if trading_hours_check() == "exit" else None

        project_folder_path = str(project_directory_path())
        scripts = [project_folder_path + f'\\Chart_Ink\\chart_ink_excel_file_download_every_15_minutes_and_insert_into_db.py',
                   project_folder_path + f'\\YahooFinance\\stock_thumb_nails_15minutes.py']

        processes = []
        for script in scripts:
            title = f'"Running {os.path.basename(script)}"'  # Title for the window
            # Each process opens in a new window and waits until it finishes
            cmd = f'start /wait {title} cmd /c "python {script}"'
            proc = subprocess.Popen(cmd, shell=True)
            processes.append(proc)

        # Wait for all to complete
        for proc in processes:
            if proc.poll() is None:  # The Process is still running
                proc.wait()
            else:
                print(f"Process {proc.pid} already completed or crashed. Check logs for details.")

        print("✅ All scripts completed. Closing launcher.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    stocks_daily_15min()
