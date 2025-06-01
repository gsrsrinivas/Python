## from ChatGPT
import os
import json
import pandas as pd
from collections import defaultdict

def clean_json_structure(json_data):
    """ Recursively remove None values while ensuring proper key-value pairing """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)  # Convert string to JSON object
        except json.JSONDecodeError:
            return json_data  # Return original string if parsing fails

    if isinstance(json_data, list):
        result = {}
        for entry in json_data:
            if isinstance(entry, dict) and "key" in entry and "value" in entry:
                value_data = entry["value"]

                # Ensure value_data is a dictionary before calling .items()
                if isinstance(value_data, dict):
                    valid_values = {k: v for k, v in value_data.items() if v is not None}
                    result[entry["key"]] = next(iter(valid_values.values()), None)  # Take first non-None value
                else:
                    result[entry["key"]] = value_data  # Direct assignment if not a dictionary

        return result  # Return structured dictionary instead of JSON string

    if isinstance(json_data, dict):
        return {k: clean_json_structure(v) for k, v in json_data.items() if v is not None}  # Handle nested dicts

    return json_data  # Return as-is for primitive types

def flatten_json(obj, parent_key='', sep='.'):
    """Recursively flattens nested JSON into dotted keys."""
    items = {}
    if isinstance(obj, dict):
        for k, v in obj.items():
            new_key = f"{parent_key}{sep}{k}" if parent_key else k
            items.update(flatten_json(v, new_key, sep=sep))
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            new_key = f"{parent_key}[]" if parent_key else "[]"
            items.update(flatten_json(item, new_key, sep=sep))
    else:
        items[parent_key] = obj
    return items

def process_file(file_path, type_map):
    ext = os.path.splitext(file_path)[1].lower()
    try:
        df = pd.read_excel(file_path) if ext == '.xlsx' else pd.read_csv(file_path)
    except Exception as e:
        print(f"❌ Error reading {file_path}: {e}")
        return

    for _, row in df.iterrows():
        for col in df.columns:
            cell = row[col]
            if isinstance(cell, str):
                try:
                    cell = clean_json_structure(cell)
                    parsed = json.loads(cell)
                    flat = flatten_json(parsed)
                    for key, val in flat.items():
                        type_str = type(val).__name__
                        type_map[(os.path.basename(file_path), col, key)].add(type_str)
                except Exception:
                    continue

def process_folder_with_type_tracking(folder_path, output_excel):
    type_map = defaultdict(set)

    for fname in os.listdir(folder_path):
        if fname.endswith('.xlsx') or fname.endswith('.csv'):
            file_path = os.path.join(folder_path, fname)
            process_file(file_path, type_map)

    # Convert to DataFrame
    rows = [
        {"Filename": f, "Column": c, "JSON Key": k, "Types": ", ".join(sorted(types))}
        for (f, c, k), types in type_map.items()
    ]

    df = pd.DataFrame(rows).sort_values(by=["Filename", "Column", "JSON Key"])
    df.to_excel(output_excel, index=False)
    print(f"✅ Exported type summary to: {output_excel}")
    return df

def process_folder_with_type_tracking_example():
    # Example usage:
    # Replace this with the actual folder path
    folder_path = "../Files Input"
    output_df = process_folder_with_type_tracking(folder_path,folder_path+"/Files Output/2025-05-30--07-40-00--json_nested_type_summary.xlsx")
    print(output_df)

if __name__ == "__main__":
    process_folder_with_type_tracking_example()
