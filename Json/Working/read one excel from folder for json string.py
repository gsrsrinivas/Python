import json
import os
from collections import defaultdict

import pandas as pd


def collect_types(obj):
    """Recursively collect types of keys and values in JSON objects/lists."""
    key_types = set()
    value_types = set()
    if isinstance(obj, dict):
        for k, v in obj.items():
            key_types.add(type(k).__name__)
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


def get_json_data_types_store_in_excel_file():
    # Set your input and output file paths
    input_folder = '../Input'
    input_filename = 'json_data.xlsx'
    output_filename = 'json_types_summary.xlsx'

    input_path = os.path.join(input_folder, input_filename)
    output_path = os.path.join("../In_Out/Output", output_filename)

    # Read the Excel file
    df = pd.read_excel(input_path)

    # Store key and value types per column
    column_key_types = defaultdict(set)
    column_value_types = defaultdict(set)

    for col in df.columns:
        for cell in df[col]:
            if isinstance(cell, str):
                try:
                    parsed = json.loads(cell)
                    key_types, value_types = collect_types(parsed)
                    column_key_types[col].update(key_types)
                    column_value_types[col].update(value_types)
                except Exception:
                    continue

    # Prepare results for saving
    results = []
    for col in df.columns:
        results.append({
            'Column': col,
            'JSON Key Types': ', '.join(sorted(column_key_types[col])),
            'JSON Value Types': ', '.join(sorted(column_value_types[col]))
        })

    # Convert to DataFrame and save to Excel
    summary_df = pd.DataFrame(results)
    summary_df.to_excel(output_path, index=False)

    print(f"Summary saved to: {output_path}")

    '''----------------------------------------------------------------------------------'''


if __name__ == "__main__":
    get_json_data_types_store_in_excel_file()
