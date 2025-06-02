# pip install pandas pyarrow openpyxl
import glob
import json
import os
import random
from collections import defaultdict
from datetime import datetime
from pathlib import Path

import pandas as pd


def get_file_paths():
    # get the timestamp
    file_timestamp = datetime.now().strftime("%Y-%m-%d--%H-%M-%S--")
    # Gets the parent directory of the current working directory
    parent_folder = Path.cwd().parent
    # get the source file folder
    folder_path = parent_folder / "Files Input"
    # get the output folder
    output_folder = parent_folder / "Files Output"
    # get the output file name along with timestamp
    output_filename = f"{file_timestamp}json_types_summary_all_files.xlsx"

    # get the input folder path to be processed
    input_path = folder_path
    # get the output folder path to be processed
    output_path = os.path.join(output_folder, output_filename)
    return input_path, output_path


def list_files_by_extensions(folder_path, extensions=('.csv', '.xlsx', '.xls', '.parquet')):
    """
    Returns a list of file paths in the folder (and subfolders) matching the given extensions.
    :param folder_path: str, path to the folder
    :param extensions: tuple or list, e.g. ('.csv', '.xlsx', '.parquet')
    :return: list of file paths
    """
    matched_files = []
    for root, dirs, files_nm in os.walk(folder_path):
        for file in files_nm:
            if file.lower().endswith(extensions):
                matched_files.append(os.path.join(root, file))
    return matched_files


def list_files_by_extensions_example():
    # Example usage:
    folder, _ = get_file_paths()
    # folder = 'your_folder_path_here'
    ext = ('.csv', '.xlsx', '.xls', '.parquet')
    files = list_files_by_extensions(folder, ext)
    files_format = json.dumps(files, indent=2)
    print(files_format)


def json_loads_example():
    my_list = '["apple", "banana", "cherry"]'
    parsed_json = json.loads(my_list)
    json_string = json.dumps(my_list)
    print(parsed_json)
    print(json_string)  # Output: ["apple", "banana", "cherry"]

    json_string = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"code","value":{"str_value":null,"int_value":"123"}}]'

    # Check for formatting issues
    json_string = json_string.strip()

    # Parse JSON
    try:
        parsed_json = json.loads(json_string)
        print("Valid JSON:", parsed_json)
    except json.JSONDecodeError as e:
        print("JSON error:", e)


def recursive_json_parse(obj):
    """
    Recursively parse any nested JSON strings within Python dictionaries/lists.
    """
    if isinstance(obj, str):
        try:
            parsed = json.loads(obj)
            # Only recurse further if parsed object is dict or list
            if isinstance(parsed, (dict, list)):
                return recursive_json_parse(parsed)
            else:
                return parsed
        except (json.JSONDecodeError, TypeError):
            return obj  # Not a JSON string
    elif isinstance(obj, list):
        return [recursive_json_parse(item) for item in obj]
    elif isinstance(obj, dict):
        return {key: recursive_json_parse(value) for key, value in obj.items()}
    else:
        return obj  # Return other types (int, float, None, etc.) as is


def recursive_json_parse_example():
    # Example 1: Simple nested JSON
    json_str_1 = '[{"id": 1, "data": "{\\"key\\": \\"value\\"}"}, {"id": 2, "data": "{\\"key\\": \\"another\\"}"}]'

    # Example 2: Deeply nested JSON
    json_str_2 = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"city","value":{"str_value":{"addr":"asdf","pincode":500019},"int_value":null}}]'

    # Parse top-level strings
    parsed_1 = recursive_json_parse(json.loads(json_str_1))
    parsed_2 = recursive_json_parse(json.loads(json_str_2))
    print(parsed_1)
    print(parsed_2)


def flatten_key_value_json(obj, parent_key=''):
    print(f"object value is {obj}")
    flat_dict = {}
    print(f"flat_dict value {flat_dict}")
    if isinstance(obj, dict):
        k = obj.get('key')
        v = obj.get('value')
        if k is not None:
            if isinstance(v, dict) or isinstance(v, list):
                nested = flatten_key_value_json(v, parent_key=k)
                for nk, nv in nested.items():
                    combined_key = f"{k}.{nk}" if nk else k
                    flat_dict[combined_key] = nv
            else:
                flat_dict[k] = v
        else:
            for sub_k, sub_v in obj.items():
                flat_dict.update(flatten_key_value_json(sub_v, parent_key=sub_k))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json(item, parent_key=parent_key))
    return flat_dict


def flatten_key_value_json_example():
    json_obj = '[{"key": "code", "value": {"str_value": "XYZ123"}}, {"key": "code", "value": {"int_value": "123"}}]'
    data = json.loads(json_obj)
    json_dict = flatten_key_value_json(data)
    print(json_dict)


def read_file(file_path, file_types):
    """ read the file and output the data as Data Frame."""
    if file_types == '.csv':
        df = pd.read_csv(file_path)
    elif file_types == '.txt':
        df = pd.read_csv(file_path, delimiter='\t')
    elif file_types == '.xlsx':
        df = pd.read_excel(file_path, dtype=str)  # Read everything as string
    elif file_types == '.xls':
        df = pd.read_excel(file_path)
    elif file_types == '.parquet':
        df = pd.read_parquet(file_path)
    else:
        raise ValueError("Unsupported file type")
    return df


def read_file_example():
    in_path, out_path = get_file_paths()
    file_list = list_files_by_extensions(in_path)
    for each_file in file_list:
        _, ext = os.path.splitext(each_file)
        df1 = read_file(each_file, ext)
        print(f"file details are as follows:\n{df1}")


def get_json_tag_data_type_example():
    # Read the Excel file
    df = pd.read_excel('../Files Input/json_data.xlsx')

    # Dictionary to store data types of 'tag' field per column
    column_tag_types = defaultdict(set)

    # Function to get the data type of the 'tag' field in a JSON object
    def get_tag_type(cell_val):
        if not isinstance(cell_val, str):
            return None
        try:
            obj = json.loads(cell_val)
            if isinstance(obj, dict) and 'tag' in obj:
                return type(obj['tag']).__name__
        except Exception:
            return None
        return None

    # Iterate over each column and each cell
    for col in df.columns:
        for cell in df[col]:
            tag_type = get_tag_type(cell)
            if tag_type:
                column_tag_types[col].add(tag_type)

    # Print the results
    for col, types in column_tag_types.items():
        if types:
            print(f"Column '{col}' has 'tag' field data types: {types}")
        else:
            print(f"Column '{col}' does not contain any JSON objects with a 'tag' field.")


def read_parquet_example():
    # Read the Parquet file into a DataFrame
    df = pd.read_parquet('../Files Input/json_data.parquet')
    # Write the DataFrame to an Excel file
    df.to_excel('../Files Output/your_file.xlsx', index=False)
    '''----------------------------------------------------------------------------------'''


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
    """Recursively collect types of keys and values in JSON objects/lists."""
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


def get_json_data_types_store_in_excel_file():
    # Set your input and output file paths
    input_folder = '../Files Input'
    input_filename = 'json_data.xlsx'
    output_filename = 'json_types_summary.xlsx'

    input_path = os.path.join(input_folder, input_filename)
    output_path = os.path.join("../Files Output", output_filename)

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


def get_input_output_paths():
    file_timestamp = datetime.now().strftime("%Y-%m-%d--%H-%M-%S--")
    # Gets the parent directory of the current working directory
    parent_folder = Path.cwd().parent
    folder_path = parent_folder / "Src Files Json"
    output_folder = folder_path / "Files Output"
    output_filename = f"{file_timestamp}json_types_summary_all_files.xlsx"

    input_path = folder_path
    output_path = os.path.join(output_folder, output_filename)

    return input_path, output_path


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


def process_folder_example():
    # ==== USER INPUTS ====
    input_path, output_path = get_input_output_paths()
    folder_path = input_path  # Folder containing your files
    file_type = 'csv'  # 'csv', 'excel', 'txt', or 'parquet'
    json_column = 'location'  # Name of the column containing JSON
    output_excel = output_path

    result_df = process_folder(folder_path, file_type, json_column)
    if not result_df.empty:
        result_df.to_excel(output_excel, index=False)  # [1][2][5]
        print(f"\nSummary written to {output_excel}")
    else:
        print("No results to write.")


def get_json_data_types_example():
    # Read the Excel file
    df = pd.read_excel('../Files Input/json_data.xlsx')

    # Store key and value types per column
    column_key_types = defaultdict(set)
    column_value_types = defaultdict(set)

    def collect_types_for_dict(obj):
        """Recursively collect types of keys and values in JSON objects/lists."""
        key_type = set()
        value_type = set()
        if isinstance(obj, dict):
            for k, v in obj.items():
                key_type.add(type(k).__name__)  # JSON keys are always str[4]
                value_type.add(type(v).__name__)
                sub_keys, sub_values = collect_types_for_dict(v)
                key_type.update(sub_keys)
                value_type.update(sub_values)
        elif isinstance(obj, list):
            for item in obj:
                sub_keys, sub_values = collect_types_for_dict(item)
                key_type.update(sub_keys)
                value_type.update(sub_values)
        return key_type, value_type

    for col in df.columns:
        for cell in df[col]:
            if isinstance(cell, str):
                try:
                    parsed = json.loads(cell)
                    key_types, value_types = collect_types_for_dict(parsed)
                    column_key_types[col].update(key_types)
                    column_value_types[col].update(value_types)
                except Exception:
                    continue

    # Print results
    for col in df.columns:
        print(f"Column '{col}':")
        print(f"  JSON key types: {column_key_types[col]}")
        print(f"  JSON value types: {column_value_types[col]}")


def find_tag_types(obj):
    """Recursively find all 'tag' fields and return their types."""
    tag_types = set()
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == 'tag':
                tag_types.add(type(v).__name__)
            tag_types.update(find_tag_types(v))
    elif isinstance(obj, list):
        for item in obj:
            tag_types.update(find_tag_types(item))
    return tag_types


def find_tag_types_example():
    # Read the Excel file
    df = pd.read_excel('path/to/your_file.xlsx')

    # Store data types of 'tag' field per column
    column_tag_types = defaultdict(set)

    for col in df.columns:
        for cell in df[col]:
            if isinstance(cell, str):
                try:
                    parsed = json.loads(cell)
                    tag_types = find_tag_types(parsed)
                    column_tag_types[col].update(tag_types)
                except Exception:
                    continue

    # Print results
    for col, types in column_tag_types.items():
        if types:
            print(f"Column '{col}' has nested 'tag' field data types: {types}")
        else:
            print(f"Column '{col}' does not contain any nested JSON 'tag' fields.")

    '''----------------------------------------------------------------------------------'''


def clean_json_structure_recursive(json_data):
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

    json_data = json.loads(clean_json_structure_recursive(json_data))  # Clean and restructure JSON

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


def clean_json_structure(json_data):
    """ Remove null values and map key to valid values """
    result = defaultdict(set)

    for entry in json_data:
        if isinstance(entry, dict) and "key" in entry and "value" in entry:
            value_data = entry["value"]

            if isinstance(value_data, dict):
                for k, v in value_data.items():
                    if v is not None:
                        result[entry["key"]].add(v)  # Store valid values

    # Convert default dict to standard dictionary with list values
    cleaned_output = {k: list(v) for k, v in result.items()}
    return cleaned_output


def extract_data_types(cleaned_json):
    """ Track data types for each key """
    data_types = {}
    for key, values in cleaned_json.items():
        data_types[key] = ", ".join(set(type(v).__name__ for v in values))
    return data_types


def extract_data_types_example():
    # Example usage:
    json_input = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"city","value":{"str_value":{"addr":"asdf","pincode":500019},"int_value":null}}]'
    parsed_data = json.loads(json_input)

    cleaned_json = clean_json_structure(parsed_data)
    print("Cleaned JSON:", json.dumps(cleaned_json, indent=2))

    data_types = extract_data_types(cleaned_json)
    print("Data Types:", data_types)


def clean_json_structure_str_list(json_data):
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


def process_json_rows(json_data, data_types):
    """ Parse JSON string, clean its structure, and track data types """
    if isinstance(json_data, str):
        try:
            json_data = json.loads(json_data)
        except json.JSONDecodeError:
            return None  # Ignore invalid JSON

    json_data = clean_json_structure_str_list(json_data)  # Clean and restructure JSON
    if isinstance(json_data, dict):
        for key, value in json_data.items():
            data_types[key].add(type(value).__name__)

    return json_data


def process_file_csv_xl(filepath, distinct_rows, data_types):
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
            json_data = process_json_rows(row[col], data_types)
            if json_data:
                processed_row[col] = json.dumps(json_data, sort_keys=True)
        if processed_row:
            distinct_rows.add(tuple(processed_row.items()))  # Keep distinct rows


def process_folders(folder_path):
    """ Process all files in the folder and clean JSON structures """
    distinct_rows = set()
    data_types = defaultdict(set)

    for filename in os.listdir(folder_path):
        filepath = os.path.join(folder_path, filename)
        if os.path.isfile(filepath):
            process_file_csv_xl(filepath, distinct_rows, data_types)

    # Convert distinct rows to DataFrame
    output_data = [dict(row) for row in distinct_rows]
    output_df = pd.DataFrame(output_data)

    # Save results
    output_df.to_csv(folder_path + "/Files Output/2025-05-30--07-40-00--processed_output.csv",
                     index=False)  # Save without index

    # Print tracked data types across processed JSON
    print("Tracked Data Types in Processed JSON:")
    for key, types in data_types.items():
        print(f"{key}: {', '.join(types)}")


def process_folders_example():
    # Example usage:
    folder_path = "../Files Input"  # Update this with the actual folder path
    process_folders(folder_path)


def clean_json_structure_recursively(json_data):
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
        return {k: clean_json_structure_recursively(v) for k, v in json_data.items() if
                v is not None}  # Handle nested dicts

    return json_data  # Return as-is for primitive types


def flatten_json_list_dict(obj, parent_key='', sep='.'):
    """Recursively flattens nested JSON into dotted keys."""
    items = {}
    if isinstance(obj, dict):
        for k, v in obj.items():
            new_key = f"{parent_key}{sep}{k}" if parent_key else k
            items.update(flatten_json_list_dict(v, new_key, sep=sep))
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            new_key = f"{parent_key}[]" if parent_key else "[]"
            items.update(flatten_json_list_dict(item, new_key, sep=sep))
    else:
        items[parent_key] = obj
    return items


def process_file_type(file_path, type_map):
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
                    cell = clean_json_structure_recursively(cell)
                    parsed = json.loads(cell)
                    flat = flatten_json_list_dict(parsed)
                    for key, val in flat.items():
                        type_str = type(val).__name__
                        type_map[(os.path.basename(file_path), col, key)].add(type_str)
                except Exception:
                    continue


def process_folder_with_type_tracking(folder_path, output_excel):
    type_map = defaultdict(set)

    for f_name in os.listdir(folder_path):
        if f_name.endswith('.xlsx') or f_name.endswith('.csv'):
            file_path = os.path.join(folder_path, f_name)
            process_file_type(file_path, type_map)

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
    output_df = process_folder_with_type_tracking(folder_path,
                                                  folder_path + "/Files Output/2025-05-30--07-40-00--json_nested_type_summary.xlsx")
    print(output_df)


def remove_none(obj):
    """
    Recursively remove None values from lists and dicts (including custom [{"key":..., "value":...}] format).
    """
    if isinstance(obj, list):
        cleaned = []
        for item in obj:
            cleaned_item = remove_none(item)
            if cleaned_item is not None:
                cleaned.append(cleaned_item)
        return cleaned
    elif isinstance(obj, dict):
        # Special case for {"key":..., "value":...} format
        if set(obj.keys()) == {"key", "value"}:
            if obj["value"] is None:
                return None
            cleaned_value = remove_none(obj["value"])
            if cleaned_value is None or cleaned_value == [] or cleaned_value == {}:
                return None
            return {"key": obj["key"], "value": cleaned_value}
        # General dict
        cleaned = {}
        for k, v in obj.items():
            cleaned_v = remove_none(v)
            if cleaned_v is not None:
                cleaned[k] = cleaned_v
        return cleaned if cleaned else None
    else:
        return obj


def custom_format(obj):
    """
    Recursively convert a list of {"key":..., "value":...} dicts into the custom {key,value} string format.
    """
    if obj is None:
        return ''
    if isinstance(obj, list):
        # Only include non-empty items
        items = [custom_format(item) for item in obj if item is not None and custom_format(item) != '']
        return '[' + ','.join(items) + ']' if any(items) else ''
    elif isinstance(obj, dict) and set(obj.keys()) == {"key", "value"}:
        key = obj["key"]
        value = obj["value"]
        formatted_value = custom_format(value)
        return f'{{{key},{formatted_value}}}' if formatted_value != '' else ''
    else:
        return str(obj)


def remove_none_example():
    # Example usage:
    input_json = '''[
        {"key": "a", "value": 1},
        {"key": "b", "value": [
            {"key": "c", "value": 2},
            {"key": "d", "value": [3,4,5]},
            {"key": "e", "value": null}
        ]},
        {"key": "f", "value": null}
    ]'''
    parsed = json.loads(input_json)
    cleaned = remove_none(parsed)
    output_str = custom_format(cleaned)
    print(output_str)


def custom_nested_format(obj):
    """
    Recursively format [{"key":..., "value":...}] as {key:value}, with nested lists/dicts.
    """
    if isinstance(obj, list):
        if all(isinstance(item, dict) and set(item.keys()) == {"key", "value"} for item in obj):
            return ','.join(custom_nested_format(item) for item in obj)
        else:
            return '[' + ','.join(custom_nested_format(item) for item in obj) + ']'
    elif isinstance(obj, dict) and set(obj.keys()) == {"key", "value"}:
        key = obj["key"]
        value = obj["value"]
        formatted_value = custom_nested_format(value)
        return f'{{{key}:{formatted_value}}}'
    else:
        return str(obj)


def flatten_json_parsed(obj, parent_key=''):
    """
    Recursively flatten [{"key":..., "value":...}] into dot notation.
    Returns a list of (key, value) tuples.
    """
    items = []
    if isinstance(obj, list):
        for item in obj:
            if isinstance(item, dict) and set(item.keys()) == {"key", "value"}:
                k = item["key"]
                v = item["value"]
                new_key = f"{parent_key}.{k}" if parent_key else k
                if isinstance(v, list) and all(isinstance(i, dict) and set(i.keys()) == {"key", "value"} for i in v):
                    items.extend(flatten_json_parsed(v, new_key))
                else:
                    items.append((new_key, v))
    return items


def format_flattened(items):
    """
    Format list of (key, value) tuples as {key:value}
    """
    return ','.join(f'{{{k}:{v}}}' if not isinstance(v, list) else f'{{{k}:{v}}}' for k, v in items)


def custom_nested_format_example():
    input_json = '''[
        {"key": "a", "value": 1},
        {"key": "b", "value": [
            {"key": "c", "value": 2},
            {"key": "d", "value": [3,4,5]}
        ]}
    ]'''
    parsed = json.loads(input_json)
    # 1. Custom Nested Format
    nested_str = custom_nested_format(parsed)
    print(nested_str)  # Output: {a:1},{b:[{c:2},{d:[3,4,5]}]}


def format_flattened_example():
    input_json = '''[
        {"key": "a", "value": 1},
        {"key": "b", "value": [
            {"key": "c", "value": 2},
            {"key": "d", "value": [3,4,5]}
        ]}
    ]'''
    parsed = json.loads(input_json)
    # 2. Flattened Recursive Format
    flat_items = flatten_json_parsed(parsed)
    flat_str = format_flattened(flat_items)
    print(flat_str)  # Output: {a:1},{b.c:2},{b.d:[3,4,5]}


def flatten_json_dict_lst(y, prefix=''):
    out = {}
    if isinstance(y, dict):
        for k, v in y.items():
            full_key = f"{prefix}.{k}" if prefix else k
            if isinstance(v, dict):
                out.update(flatten_json_dict_lst(v, full_key))
            elif isinstance(v, list):
                out[full_key] = 'list'
                for idx, item in enumerate(v):
                    out.update(flatten_json_dict_lst(item, f"{full_key}[{idx}]"))
            else:
                out[full_key] = v
    elif isinstance(y, list):
        for idx, item in enumerate(y):
            out.update(flatten_json_dict_lst(item, f"{prefix}[{idx}]"))
    return out


def infer_types(flat_dict):
    return {k: type(v).__name__ for k, v in flat_dict.items()}


def json_data_types_example():
    # --- USER INPUTS ---
    excel_file = r'../Files Output/json_data.xlsx'
    json_column = 'json_data'  # The column name containing your nested JSON

    # --- READ EXCEL ---
    df = pd.read_excel(excel_file)

    # --- PROCESS EACH ROW ---
    all_types = []
    for idx, row in df.iterrows():
        json_str = row[json_column]
        try:
            data = json.loads(json_str)
            flat = flatten_json_dict_lst(data)
            types = infer_types(flat)
            for key, dtype in types.items():
                all_types.append({'Row': idx + 1, 'Key': key, 'Type': dtype})
        except Exception as e:
            all_types.append({'Row': idx + 1, 'Key': 'ERROR', 'Type': str(e)})

    # --- CREATE SUMMARY TABLE ---
    summary_df = pd.DataFrame(all_types)
    print(summary_df)

    # Optionally, write to Excel
    summary_df.to_excel('../Files Output/2025-05-31--12-00-00--json_key_types_per_row.xlsx', index=False)


def custom_format_recursive(obj):
    """
    Recursively convert a list of {"key":..., "value":...} dicts into the custom string format.
    """
    if isinstance(obj, list):
        # Check if this is a list of {"key":..., "value":...} dicts
        if all(isinstance(item, dict) and set(item.keys()) == {"key", "value"} for item in obj):
            return ','.join(custom_format_recursive(item) for item in obj)
        else:
            # It's a list of primitives or other lists
            return '[' + ','.join(custom_format_recursive(item) for item in obj) + ']'
    elif isinstance(obj, dict) and set(obj.keys()) == {"key", "value"}:
        key = obj["key"]
        value = obj["value"]
        # Recursively format the value
        formatted_value = custom_format_recursive(value)
        return f'{{{key},{formatted_value}}}'
    else:
        return str(obj)


def custom_format_recursive_example():
    # Example usage:
    input_json = '[{"key": "a", "value": "asd"}, {"key": "b", "value": [{"c": 2}, {"d": [3,4,5]}]}]'
    parsed = json.loads(input_json)
    output_str = custom_format_recursive(parsed)
    print(output_str)


def is_json(val):
    """ Function to check if a value is a JSON object or array"""
    if not isinstance(val, str):
        return False
    try:
        obj = json.loads(val)
        return isinstance(obj, (dict, list))
    except (ValueError, TypeError):
        return False


def is_json_example():
    # Read the Excel file
    df = pd.read_excel(f'../Files Input/nested_json_as_string_1000.xlsx')
    json_field_count = 0
    # Iterate over all cells in the DataFrame
    for col in df.columns:
        json_field_count += df[col].apply(is_json).sum()

    print(f"Number of JSON fields in the Excel file: {json_field_count}")
    '''----------------------------------------------------------------------------------'''


def generate_sample_json(index):
    """ Helper to create a nested JSON-like structure"""
    return {
        "id": index,
        "name": f"Item {index}",
        "details": {
            "manufacturer": f"Company {random.randint(1, 10)}",
            "warranty_years": random.choice([1, 2, 3]),
            "specs": {
                "weight": f"{random.uniform(1.0, 5.0):.2f} kg",
                "dimensions": {
                    "length": f"{random.uniform(10.0, 50.0):.2f} cm",
                    "width": f"{random.uniform(10.0, 50.0):.2f} cm",
                    "height": f"{random.uniform(10.0, 50.0):.2f} cm"
                }
            }
        },
        "tags": [random.choice(["electronics", "home", "garden", "sports", "fashion"]) for _ in
                 range(random.randint(2, 5))],
        "available": random.choice([True, False])
    }


def generate_sample_json_example():
    # Create 100 samples
    sample_data = [json.dumps(generate_sample_json(i)) for i in range(1, 101)]

    # Create a DataFrame and save to Excel
    df = pd.DataFrame({"json_data": sample_data})
    df.to_excel("../Files Output/100_sample_json_strings.xlsx", index=False)


def flatten_key_value_json_dict_list(obj, parent_key=''):
    flat_dict = {}
    if isinstance(obj, dict):
        k = obj.get('key')
        v = obj.get('value')
        if k is not None:
            if isinstance(v, dict) or isinstance(v, list):
                nested = flatten_key_value_json_dict_list(v, parent_key=k)
                for nk, nv in nested.items():
                    # If parent_key exists, combine keys
                    combined_key = f"{k}.{nk}" if nk else k
                    flat_dict[combined_key] = nv
            else:
                flat_dict[k] = v
        else:
            # If not a key-value dict, process all items
            for sub_k, sub_v in obj.items():
                flat_dict.update(flatten_key_value_json_dict_list(sub_v, parent_key=sub_k))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json_dict_list(item, parent_key=parent_key))
    return flat_dict


def flatten_key_value_json_dict_list_example():
    # Example usage:
    nested_json = {
        "key": "user",
        "value": [
            {
                "key": "profile",
                "value": {
                    "key": "name",
                    "value": "Jordan"
                }
            },
            {
                "key": "contact",
                "value": {
                    "key": "phone",
                    "value": "555-1234"
                }
            }
        ]
    }

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)

    nested_json = {
        "key": "user",
        "value": {
            "key": "profile",
            "value": {
                "key": "name",
                "value": "Jordan"
            }
        }
    }

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)

    nested_json = {
        "key": "user",
        "value": [
            {
                "key": "profile",
                "value": {
                    "key": "name",
                    "value": "Jordan"
                }
            },
            {
                "key": "contact",
                "value": {
                    "key": "phone",
                    "value": "555-1234"
                }
            }
        ]
    }

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)


def flatten_json_list(data, parent_key=''):
    """
    Recursively flattens input JSON array of {"key":..., "value":...} objects,
    prefixing nested keys with their parent key (dot notation).
    """
    result = {}
    if isinstance(data, list):
        for item in data:
            key = item.get('key')
            value = item.get('value')
            # Build the new key with dot notation if parent_key exists
            new_key = f"{parent_key}.{key}" if parent_key else key
            # If value is a list, flatten recursively and prefix keys
            if isinstance(value, list):
                nested = flatten_json_list(value, new_key)
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
                    nested = flatten_json_list([{'key': k, 'value': v} for k, v in value.items()], new_key)
                    result.update(nested)
            else:
                # If value is a primitive
                result[new_key] = value
    return result


def flatten_json_safe(json_string):
    """
    Attempts to parse and flatten a JSON string using flatten_json.
    Returns the input as-is if input is empty, invalid, or flattening yields empty.
    """
    if not json_string or not isinstance(json_string, str) or not json_string.strip():
        return json_string
    try:
        data = json.loads(json_string)
        flat = flatten_json_list(data)
        if not flat:
            return json_string
        return flat
    except Exception as e:
        print(e)
        return json_string


def smart_cast(val):
    """Cast value to its actual Python type if possible, else return as string."""
    # Handle bool
    if isinstance(val, str):
        if val.lower() == 'true':
            return True, 'bool'
        if val.lower() == 'false':
            return False, 'bool'
    # Handle int
    try:
        if isinstance(val, str) and val.isdigit():
            return int(val), 'int'
    except Exception:
        pass
    # Handle float
    try:
        if isinstance(val, str) and '.' in val:
            float_val = float(val)
            return float_val, 'float'
    except Exception:
        pass
    # Fallback: use original value and its type
    return val, type(val).__name__


def flatten_top_level(data):
    rows = []
    if isinstance(data, list):
        for item in data:
            key = item.get('key')
            value = item.get('value')
            if key is None or value is None:
                continue
            # If value is a dict, add all non-null values as separate rows
            if isinstance(value, dict):
                for k, v in value.items():
                    if v is not None:
                        v2, dtype = smart_cast(v)
                        rows.append((key, v2, dtype))
            # If value is a list, flatten each element
            elif isinstance(value, list):
                for v in value:
                    if v is not None:
                        v2, dtype = smart_cast(v)
                        rows.append((key, v2, dtype))
            # If value is a primitive and not None
            elif value is not None:
                v2, dtype = smart_cast(value)
                rows.append((key, v2, dtype))
    return rows


def flatten_top_level_example():
    # Example JSON string
    """
    [
        {"key":"code","value":{"str_value":"XYZ123","int_value":null, "float_value":"12.5", "bool_value":"true"}},
        {"key":"code","value":{"str_value":null,"int_value":"123", "float_value":null, "bool_value":"false"}},
        {"key":"desc","value":{"en":"Test","fr":null}},
        {"key":"active","value":true},
        {"key":"empty","value":null}
    ]
    """
    json_str = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"code","value":{"str_value":null,"int_value":"123"}}]'

    # Parse and flatten
    data = json.loads(json_str)
    flat_rows = flatten_top_level(data)

    # Combine rows at key level
    combined = {}
    for key, value, dtype in flat_rows:
        if key not in combined:
            combined[key] = {'value': [], 'value data type': []}
        combined[key]['value'].append(str(value))
        combined[key]['value data type'].append(dtype)

    # Prepare final rows
    final_rows = []
    for key, vals in combined.items():
        final_rows.append((
            key,
            ', '.join(vals['value']),
            ', '.join(vals['value data type'])
        ))

    # Build DataFrame
    df = pd.DataFrame(final_rows, columns=['key', 'value', 'value data type'])

    # Save to Excel
    excel_filename = '../Files Output/key_value_type_combined_output.xlsx'
    df.to_excel(excel_filename, index=False)

    print(f"Data saved to {excel_filename}")
    print(df)

    # Valid nested JSON array
    # json_str = '[{"key":"a","value":[{"key":"b","value":{"str_value":"hello"}},{"key":"c","value":{"int_value":42}}]}]'
    json_str = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"code","value":{"str_value":null,"int_value":"123"}}]'
    print(flatten_top_level(json_str))  # {'a.b': 'hello', 'a.c': 42}

    # Empty input
    print(flatten_top_level(""))  # Output: ""

    # Invalid JSON
    print(flatten_top_level("not json"))  # Output: "not json"

    # JSON that flattens to empty
    print(flatten_top_level("[]"))  # Output: "[]"

    # Example with nested input
    input_json = '''[
        {"key":"code","value":{"str_value":"XYZ123","int_value":null}},
        {"key":"code1","value":{"str_value":null,"int_value":"123"}},
        {"key":"details","value":[
            {"key":"sub code","value":{"str_value":"A1","int_value":null}},
            {"key":"sub value","value":{"str_value":null,"int_value":"456"}}
        ]}
    ]'''

    output = flatten_top_level(input_json)
    output_result = flatten_top_level(output)
    print(f"Flatten_json function output_result\n{output_result}")
    print(f"Flatten_json function output\n{output}\n{json.dumps(output, indent=2)}")
