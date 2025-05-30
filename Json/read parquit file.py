# pip install pandas pyarrow openpyxl
import pandas as pd

# Read the Parquet file into a DataFrame
df = pd.read_parquet('path/to/your_file.parquet')
# Write the DataFrame to an Excel file
df.to_excel('path/to/your_file.xlsx', index=False)


'''----------------------------------------------------------------------------------'''
