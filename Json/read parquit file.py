# pip install pandas pyarrow openpyxl
import pandas as pd

def read_parquet_example():
    # Read the Parquet file into a DataFrame
    df = pd.read_parquet('../Files Input/json_data.parquet')
    # Write the DataFrame to an Excel file
    df.to_excel('../Files Output/your_file.xlsx', index=False)
    '''----------------------------------------------------------------------------------'''

if __name__ == "__main__":
    read_parquet_example()
