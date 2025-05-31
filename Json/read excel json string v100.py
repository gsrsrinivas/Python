import pandas as pd
import json
from collections import defaultdict
import os
import glob
## --------------------------------------------------------------------------------------------- ##
from datetime import datetime, timedelta
from pathlib import Path
import os


file_timestamp = datetime.now().strftime("%Y-%m-%d--%H-%M-%S--")
# Gets the parent directory of the current working directory
parent_folder = Path.cwd().parent
folder_path = parent_folder / "Src Files Json"
output_folder = folder_path / "Files Output"
output_filename = f"{file_timestamp}json_types_summary_all_files.xlsx"

input_path = folder_path
output_path = os.path.join(output_folder, output_filename)

# read the file and output the data as Data Frame.
def read_file(file_path, file_types):
    if file_types == 'csv':
        df = pd.read_csv(file_path)
    elif file_types == 'excel':
        df = pd.read_excel(file_path)
    elif file_types == 'txt':
        df = pd.read_csv(file_path, delimiter='\t')
    elif file_types == 'parquet':
        df = pd.read_parquet(file_path)
    else:
        raise ValueError("Unsupported file type")
    return df

## --------------------------------------------------------------------------------------------- ##


def infer_types_recursive(obj, prefix='', type_map=None):
    if type_map is None:
        type_map = defaultdict(set)
    if isinstance(obj, dict):
        for k, v in obj.items():
            full_key = f"{prefix}.{k}" if prefix else k
            if isinstance(v, dict):
                infer_types_recursive(v, full_key, type_map)
            elif isinstance(v, list):
                type_map[full_key].add('list')
                for item in v:
                    infer_types_recursive(item, full_key + '[]', type_map)
            else:
                type_map[full_key].add(type(v).__name__)
    elif isinstance(obj, list):
        for item in obj:
            infer_types_recursive(item, prefix + '[]', type_map)
    return type_map

def infer_json_key_types(df, json_column):
    type_map = defaultdict(set)
    for idx, val in df[json_column].dropna().items():
        try:
            if isinstance(val, dict):
                record = val
            else:
                record = json.loads(val)
            infer_types_recursive(record, '', type_map)
        except Exception as e:
            print(f"Error parsing row {idx}: {e}")
    return type_map

def process_folder(folder_path, file_type, json_column):
    ext_map = {'csv': '*.csv', 'excel': '*.xlsx', 'txt': '*.txt', 'parquet': '*.parquet'}
    pattern = os.path.join(folder_path, ext_map[file_type])
    files = glob.glob(pattern)
    if not files:
        print(f"No {file_type} files found in {folder_path}")
        return pd.DataFrame()

    all_results = []
    for file_path in files:
        file_name = os.path.basename(file_path)
        print(f"Processing file: {file_name}")
        try:
            df = read_file(file_path, file_type)
            if json_column not in df.columns:
                print(f"  Column '{json_column}' not found. Columns: {list(df.columns)}")
                continue
            type_map = infer_json_key_types(df, json_column)
            for key, types in sorted(type_map.items()):
                all_results.append({
                    "File Name": file_name,
                    "JSON Key Path": key,
                    "Data Types": ', '.join(sorted(types))
                })
        except Exception as e:
            print(f"  Error processing file: {e}")
    return pd.DataFrame(all_results)

if __name__ == '__main__':
    # ==== USER INPUTS ====
    folder_path = input_path      # Folder containing your files
    file_type = 'csv'               # 'csv', 'excel', 'txt', or 'parquet'
    json_column = 'location'        # Name of the column containing JSON
    output_excel = output_path

    result_df = process_folder(folder_path, file_type, json_column)
    if not result_df.empty:
        result_df.to_excel(output_excel, index=False)  # [1][2][5]
        print(f"\nSummary written to {output_excel}")
    else:
        print("No results to write.")
