import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Get parent directory of current file # Add it to sys.path
from _Common_Functions.base_functions import *
import pandas as pd

# df = pd.DataFrame()
# chart_ink_to_csv(df)
bulk_file_path = 'c:\\Users\\User\\Documents\\Chart_Ink\\chart_ink_data.csv'
table_names = ['chart_ink_data','dad','asdfasdf']
bulk_insert_query = (
        f" BULK INSERT dbo.{table_names[0]} FROM '{bulk_file_path}' WITH \n"  # noqa
        + f" (   FIELDTERMINATOR = ',', -- Column delimiter, e.g., comma for CSV \n"  # noqa
        + f"     ROWTERMINATOR = '\\n',  -- Row delimiter, newline character \n"  # noqa
        + f"     FIRSTROW = 2,          -- Skip header row if present (start at row 2) \n"  # noqa
        + f"     TABLOCK,               -- Optional: improve performance by locking the table \n"  # noqa
        + f"     KEEPIDENTITY           -- keep identity values from file \n"  # noqa
        + f" );")
print(f"{bulk_insert_query}")