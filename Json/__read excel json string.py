from All_Json_Functions_Draft import *


def iterate_through_excel_col():
    """ iterate all the rows and column in an Excel file"""
    df = get_data_frame()
    # (excel_col, key) -> set of types
    col_key_types = defaultdict(set)

    for col in df.columns:
        # json_obj = ""
        for cell in df[col].dropna():
            try:
                print(f"excel column value: {cell} \nand data type {type(cell).__name__}")
                json_obj = str(cell)
                print(f"json object converted to string: {json_obj}")
                json_obj = json.loads(json_obj)
                print(f"json object converted to json\nwhich is list or dict: {json_obj}")
                json_obj = remove_nulls(json_obj)
                print(f"removed null from json\nwhich is list or dict and returns the same data type: {json_obj}")
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


if __name__ == "__main__":
    print(f"program started")
    # input_folder_path, output_path = get_input_output_paths()
    # file_path_list = list_files_by_extensions(input_folder_path)
    # df = get_data_frame()
    # json_col_count_example(df)
    iterate_through_excel_col()
    print(f"program complete")