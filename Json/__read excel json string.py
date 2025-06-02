from Get_Input_Output_Paths import get_file_paths
from Get_Folder_FilePaths import list_files_by_extensions
from read_file_to_dataframe import read_file
from collections import defaultdict
import pandas as pd
import json
import os

def get_data_frame():
    """ get the folder path and file path for processing"""
    in_path, out_path = get_file_paths()
    # print(f"input folder path and output folder path are\n{in_path}\n{out_path}")
    # get the file path extension
    file_list = list_files_by_extensions(in_path,extensions="json_data.xlsx")
    # get each file path from folder
    df = pd.DataFrame()
    for each_file in file_list:
        _, ext = os.path.splitext(each_file)
        df = read_file(each_file, ext)
        # print(f"file details are as follows:\n{df}")
    return df

def remove_nulls(val):
    """ this is working fine"""
    if isinstance(val, dict):
        return {k: remove_nulls(v) for k, v in val.items() if v is not None}
    elif isinstance(val, list):
        return [remove_nulls(item) for item in val if item is not None]
    else:
        return val

def flatten_key_value_json(obj, parent_key=''):
    """ this function is returning empty dict for non list values"""
    flat_dict = {}
    if isinstance(obj, dict):
        k = obj.get('key')
        v = obj.get('value')
        if k is not None:
            if isinstance(v, dict) or isinstance(v, list):
                nested = flatten_key_value_json(v, parent_key=k)
                for nk, nv in nested.items():
                    # If parent_key exists, combine keys
                    combined_key = f"{k}.{nk}" if nk else k
                    flat_dict[combined_key] = nv
            else:
                flat_dict[k] = v
        else:
            # If not a key-value dict, process all items
            for subk, subv in obj.items():
                flat_dict.update(flatten_key_value_json(subv, parent_key=subk))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json(item, parent_key=parent_key))
    return flat_dict

def get_types(value):
    """Recursively get all data types in a JSON value."""
    types = set()
    if isinstance(value, dict):
        types.add('dict')
        for v in value.values():
            types.update(get_types(v))
    elif isinstance(value, list):
        types.add('list')
        for item in value:
            types.update(get_types(item))
    elif value is None:
        types.add('NoneType')
    else:
        types.add(type(value).__name__)
    return types

def iterate_through_excel_column():
    """ iterate all the rows and column in a excel file"""
    df = get_data_frame()
    # (excel_col, key) -> set of types
    col_key_types = defaultdict(set)

    for col in df.columns:
        json_obj = ""
        for cell in df[col].dropna():
            try:
                print(f"excel column value: {cell} \nand data type {type(cell).__name__}")
                json_obj = str(cell)
                print(f"json object converted to string: {json_obj}")
                json_obj = json.loads(json_obj)
                print(f"json object converted to json: {json_obj}")
                json_obj = remove_nulls(json_obj)
                print(f"removed null from json: {json_obj}")
                json_obj = flatten_key_value_json(json_obj)
                print(f"flattened json is: {json_obj}")

            except Exception as e:
                print(f"error message is: {e}")
                continue  # Skip invalid JSON
            print(f"json variable has value: {json_obj}")
            if isinstance(json_obj, dict):
                for k, v in json_obj.items():
                    types = get_types(v)
                    col_key_types[(col, k)].update(types)

    # Prepare output
    output = []
    for (col, k), types in col_key_types.items():
        output.append({
            'col name': col,
            'key': k,
            'data type': ','.join(sorted(types))
        })

    # Create DataFrame and display without index
    out_df = pd.DataFrame(output)
    print(out_df.to_string(index=False))

