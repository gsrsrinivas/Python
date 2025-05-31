from Get_Input_Output_Paths import get_file_paths
from Get_Folder_FilePaths import list_files_by_extensions
from Flatten_Json_String import *

in_path, out_path = get_file_paths()
print(f"input folder path and output folder path are\n{in_path}\n{out_path}")
##------------------------------------------------------------------------------------------------##

import pandas as pd

df = pd.read_excel(r'C:\Users\gsrsr\Documents\pythonProject\Files InPut\nested_json_as_string_1000.xlsx')  # Replace with your file path
import json

def is_json(val):
    try:
        json.loads(val)
        return True
    except:
        return False

# json_columns = []
# for col in df.columns:
#     if df[col].dropna().apply(lambda x: is_json(str(x))).any():
#         json_columns.append(col)

# output = flatten_json_safe(input_json)

records = []
json_columns = []
for col in df.columns:
# for col in json_columns:
    seen = set()
    for val in df[col].dropna():
        try:
            json_obj = json.loads(val)
            flat = flatten_json_safe(json_obj)
            for key, dtype in flat:
                rec = (col, key, dtype)
                if rec not in seen:
                    records.append({'Column Name': col, 'Key Name': key, 'Value Data Type': dtype})
                    seen.add(rec)
        except:
            continue

result_df = pd.DataFrame(records)
result_df.to_excel('json_key_value_types.xlsx', index=False)
print(result_df)
