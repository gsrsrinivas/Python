## from copilot
import os
import pandas as pd
import json
from collections import defaultdict


import json

def clean_json_structure(json_data):
    """ Remove None values and correctly map key-value pairs """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)  # Convert JSON string to object
        except json.JSONDecodeError:
            return "{}"  # Return empty JSON string if parsing fails

    if isinstance(json_data, list):
        result = {}
        for entry in json_data:
            if isinstance(entry, dict) and "key" in entry and "value" in entry:
                value_data = entry["value"]

                # Ensure value_data is a dictionary before processing
                if isinstance(value_data, dict):
                    valid_values = [v for v in value_data.values() if v is not None]
                    result[entry["key"]] = valid_values[0] if valid_values else None  # Take first non-None value
                else:
                    result[entry["key"]] = value_data  # Directly assign if not a dictionary

        return json.dumps(result, sort_keys=True)  # Properly formatted JSON string

    return json.dumps(json_data, sort_keys=True)  # Ensure valid JSON output


def process_json(json_data, data_types):
    """ Parse JSON string, clean its structure, and track data types """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)
        except json.JSONDecodeError:
            return None  # Ignore invalid JSON

    json_data = clean_json_structure(json_data)  # Clean and restructure JSON
    if isinstance(json_data,dict):
        for key, value in json_data.items():
            data_types[key].add(type(value).__name__)

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


def process_folder(folder_path):
    """ Process all files in the folder and clean JSON structures """
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
    output_df.to_csv(folder_path+"/Files Output/2025-05-30--07-40-00--processed_output.csv", index=False)  # Save without index

    # Print tracked data types across processed JSON
    print("Tracked Data Types in Processed JSON:")
    for key, types in data_types.items():
        print(f"{key}: {', '.join(types)}")


# Example usage:
folder_path = "../Files Input"  # Update this with the actual folder path
process_folder(folder_path)
