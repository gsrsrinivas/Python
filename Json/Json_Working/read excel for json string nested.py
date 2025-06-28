import json
from collections import defaultdict

import pandas as pd


def get_json_data_types_example():
    # Read the Excel file
    df = pd.read_excel('../Input/json_data.xlsx')

    # Store key and value types per column
    column_key_types = defaultdict(set)
    column_value_types = defaultdict(set)

    def collect_types(obj):
        """Recursively collect types of keys and values in JSON objects/lists."""
        key_types = set()
        value_types = set()
        if isinstance(obj, dict):
            for k, v in obj.items():
                key_types.add(type(k).__name__)  # JSON keys are always str[4]
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

    # Print results
    for col in df.columns:
        print(f"Column '{col}':")
        print(f"  JSON key types: {column_key_types[col]}")
        print(f"  JSON value types: {column_value_types[col]}")

    '''----------------------------------------------------------------------------------'''


if __name__ == "__main__":
    get_json_data_types_example()
