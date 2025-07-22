import sys, concurrent.futures, subprocess
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[1]))
from _Common_Functions.base_functions import *


def run_script(script):
    try:
        return subprocess.run(['python', script], capture_output=True, text=True)
    except Exception as e:
        print(f"Execution failed for {script}: {e}")
        return None


def stocks_daily():
    """
    This function is designed to run daily stock-related tasks.
    It includes downloading chart ink data and creating stock thumbnails.
    The tasks are executed in parallel using a process pool executor.
    """
    printlog = setup_logger(__file__, "daily_stocks.log")
    try:
        print_start_timestamp()
        prevent_sleep()
        # sys.exit() if trading_hours_check() == "exit" else None

        project_folder_path = str(project_directory_path())
        scripts = [project_folder_path + f'\\Chart_Ink\\chart_ink_excel_file_download_and_insert_into_db.py',
                   project_folder_path + f'\\YahooFinance\\stock_thumb_nails.py']
        print(f"Running scripts: {scripts}")
        with concurrent.futures.ProcessPoolExecutor() as executor:
            futures = [executor.submit(run_script, script) for script in scripts]

        # Wait for all futures to complete and print their results
        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            if result:
                print(f"{result.args[-1]} completed with return code {result.returncode}")
                if result.stdout:
                    print("Output:", result.stdout)
                if result.stderr:
                    print("Errors:", result.stderr)
            else:
                print("A script failed or returned no result.")

    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    stocks_daily()