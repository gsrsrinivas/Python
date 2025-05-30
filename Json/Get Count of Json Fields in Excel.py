# pip install pandas openpyxl
import pandas as pd
import json


# Read the Excel file
df = pd.read_excel('path/to/your_file.xlsx')
json_field_count = 0


# Function to check if a value is a JSON object or array
def is_json(val):
    if not isinstance(val, str):
        return False
    try:
        obj = json.loads(val)
        return isinstance(obj, (dict, list))
    except (ValueError, TypeError):
        return False


# Iterate over all cells in the DataFrame
for col in df.columns:
    json_field_count += df[col].apply(is_json).sum()

print(f"Number of JSON fields in the Excel file: {json_field_count}")


'''----------------------------------------------------------------------------------'''
