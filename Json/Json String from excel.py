import pandas as pd
import json
from collections import defaultdict
## --------------------------------------------------------------------------------------------- ##
import os
from pathlib import Path
from datetime import datetime, timedelta

def flatten_json(data, parent_key=''):
    """
    Recursively flattens input JSON array of {"key":..., "value":...} objects,
    prefixing nested keys with their parent key (dot notation).
    """
    if isinstance(data, list):
        result = {}
        for item in data:
            key = item.get('key')
            value = item.get('value')
            # Build the new key with dot notation if parent_key exists
            new_key = f"{parent_key}.{key}" if parent_key else key
            # If value is a list, flatten recursively and prefix keys
            if isinstance(value, list):
                nested = flatten_json(value, new_key)
                result.update(nested)
            # If value is a dict with str_value/int_value, pick the non-null one
            elif isinstance(value, dict):
                if 'str_value' in value and value['str_value'] is not None:
                    result[new_key] = value['str_value']
                elif 'int_value' in value and value['int_value'] is not None:
                    try:
                        result[new_key] = int(value['int_value'])
                    except Exception:
                        result[new_key] = value['int_value']
                else:
                    # If dict but not str_value/int_value, flatten recursively
                    nested = flatten_json([{'key': k, 'value': v} for k, v in value.items()], new_key)
                    result.update(nested)
            else:
                # If value is a primitive
                result[new_key] = value
    return data

def collect_types(obj):
    # Helper function to recursively collect types of keys and values in JSON objects/lists
    key_types = set()
    value_types = set()
    if isinstance(obj, dict):
        for k, v in obj.items():
            # key_types.add(type(k).__name__)
            key_types.add(k)
            value_types.add(type(v).__name__)
            sub_keys, sub_values = collect_types(v)
            key_types.update(sub_keys)
            value_types.update(sub_values)
    elif isinstance(obj, list):
        for item in obj:
            sub_keys, sub_values = collect_types(item)
            key_types.update(sub_keys)
            value_types.update(sub_values)
    return key_types, value_types

def collect_flatten_example():
    file_timestamp = datetime.now().strftime("%Y-%m-%d--%H-%M-%S--")
    # Gets the parent directory of the current working directory
    parent_folder = Path.cwd().parent
    folder_path = parent_folder / "Src Files Json"
    # Set your input and output folder paths
    output_folder = folder_path / "Files Output"
    output_filename = f"{file_timestamp}json_types_summary_all_files.xlsx"

    input_path = folder_path
    output_path = os.path.join(output_folder, output_filename)
    ##---------------------------------------------------------------------------------------------##

    # Prepare to collect results from all files
    all_results = []

    # Loop through all Excel files in the folder
    for filename in os.listdir(input_path):
        if filename.endswith('.xlsx') and not filename.startswith('~$'):  # Skip temporary files
            file_path = os.path.join(input_path, filename)
            df = pd.read_excel(file_path)
            column_key_types = defaultdict(set)
            column_value_types = defaultdict(set)
            for col in df.columns:
                for cell in df[col]:
                    if isinstance(cell, str):
                        try:
                            parsed_json = json.loads(cell)
                            parsed = flatten_json(parsed_json)
                            key_types, value_types = collect_types(parsed)
                            column_key_types[col].update(key_types)
                            column_value_types[col].update(value_types)
                        except Exception as e:
                            print(e)
                            continue
            for col in df.columns:
                all_results.append({
                    'File': filename,
                    'Column': col,
                    'JSON Key Types': ', '.join(sorted(column_key_types[col])),
                    'JSON Value Types': ', '.join(sorted(column_value_types[col]))
                })

    # Convert results to DataFrame and save
    summary_df = pd.DataFrame(all_results)
    summary_df.to_excel(output_path, index=False)

    print(f"Summary of all files saved to: {output_path}")

    '''----------------------------------------------------------------------------------'''

if __name__ == "__main__":
    collect_flatten_example()
