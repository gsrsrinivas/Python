# getting error
import json
import os
from collections import defaultdict

import pandas as pd


def clean_json_structure(json_data):
    """ Recursively remove None values and restructure JSON into key-value pairs """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)  # Convert JSON string to object
        except json.JSONDecodeError:
            return "{}"  # Return empty JSON string if parsing fails

    def recursive_clean(data):
        """ Recursively remove None values from JSON """
        if isinstance(data, dict):
            return {k: recursive_clean(v) for k, v in data.items() if v is not None}
        elif isinstance(data, list):
            return [recursive_clean(item) for item in data if item is not None]
        else:
            return data

    return json.dumps(recursive_clean(json_data), sort_keys=True)  # Ensure JSON output is clean


def process_json(json_data, data_types):
    """ Parse and recursively process nested JSON, tracking data types """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)
        except json.JSONDecodeError:
            return None  # Ignore invalid JSON

    json_data = json.loads(clean_json_structure(json_data))  # Clean and restructure JSON

    def track_types(data, parent_key="root"):
        """ Recursively track JSON key data types """
        if isinstance(data, dict):
            for key, value in data.items():
                full_key = f"{parent_key}.{key}" if parent_key else key
                data_types[full_key].add(type(value).__name__)
                track_types(value, full_key)
        elif isinstance(data, list):
            for index, item in enumerate(data):
                full_key = f"{parent_key}[{index}]"
                track_types(item, full_key)
        else:
            data_types[parent_key].add(type(data).__name__)

    track_types(json_data)
    return json_data


def process_file(filepath, distinct_rows, data_types):
    """ Process a single CSV or Excel file """
    file_ext = os.path.splitext(filepath)[-1].lower()
    if file_ext == '.csv':
        df = pd.read_csv(filepath, dtype=str)  # Read data as string for JSON parsing
    elif file_ext in ['.xls', '.xlsx']:
        df = pd.read_excel(filepath, dtype=str)
    else:
        return

    for _, row in df.iterrows():
        processed_row = {}
        for col in df.columns:
            json_data = process_json(row[col], data_types)
            if json_data:
                processed_row[col] = json.dumps(json_data, sort_keys=True)
        if processed_row:
            distinct_rows.add(tuple(processed_row.items()))  # Keep distinct rows


def process_folder_input(folder_path):
    """ Process all files in the folder and clean nested JSON structures """
    distinct_rows = set()
    data_types = defaultdict(set)

    for filename in os.listdir(folder_path):
        filepath = os.path.join(folder_path, filename)
        if os.path.isfile(filepath):
            process_file(filepath, distinct_rows, data_types)

    # Convert distinct rows to DataFrame
    output_data = [dict(row) for row in distinct_rows]
    output_df = pd.DataFrame(output_data)

    # Save results
    output_df.to_csv(os.path.join(folder_path, "Files Output", "2025-05-30--07-40-00--processed_output.csv"),
                     index=False)  # Save without index

    # Print tracked data types across processed JSON
    print("Tracked Data Types in Processed JSON:")
    for key, types in data_types.items():
        print(f"{key}: {', '.join(types)}")


def process_folder_input_examples():
    # Example usage:
    folder_path = "../Files Input"  # Update this with the actual folder path
    process_folder_input(folder_path)


if __name__ == '__main__':
    process_folder_input_examples()
