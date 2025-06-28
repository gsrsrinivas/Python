import json
from collections import defaultdict

import pandas as pd


def get_json_tag_data_type_example():
    # Read the Excel file
    df = pd.read_excel('../Input/json_data.xlsx')

    # Dictionary to store data types of 'tag' field per column
    column_tag_types = defaultdict(set)

    # Function to get the data type of the 'tag' field in a JSON object
    def get_tag_type(cell):
        if not isinstance(cell, str):
            return None
        try:
            obj = json.loads(cell)
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

    '''----------------------------------------------------------------------------------'''


if __name__ == "__main__":
    get_json_tag_data_type_example()
