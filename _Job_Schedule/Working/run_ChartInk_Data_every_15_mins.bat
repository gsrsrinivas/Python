@echo off
rem echo Starting script >> C:\Users\gsrsr\Documents\PythonProject\_Shared\Logs\ChatInk_15mins.log
rem echo chart Ink script started >> C:\Users\gsrsr\Documents\PythonProject\_Shared\Logs\ChatInk_15mins.log 2>&1
REM Download the ChartInk data in excel file and insert into the database table
REM Analyse the data and insert into report tables

REM Set the path to your Python executable
set PYTHON_PATH=python.exe

REM Set the path to your Python script
set SCRIPT_PATH=C:\Users\gsrsr\Documents\pythonProject\Chart_Ink\chart_ink_excel_file_download_every_15_minutes_and_insert_into_db.py
set THUMBNAILS_PATH=C:\Users\gsrsr\Documents\PythonProject\YahooFinance\stock_thumb_nails_15minutes.py
REM Execute the Python script parallel
start "chart_ink_excel_file_download_every_15_minutes_and_insert_into_db" cmd /c %PYTHON_PATH% %SCRIPT_PATH%
start "stock_thumb_nails_15minutes" cmd /c %PYTHON_PATH% %THUMBNAILS_PATH%
REM Pause the command window to see the output
REM pause
rem echo chart Ink script completed >> C:\Users\gsrsr\Documents\PythonProject\_Shared\Logs\ChatInk_15mins.log 2>&1
