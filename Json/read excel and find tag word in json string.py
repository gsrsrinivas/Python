import pandas as pd
import json
from collections import defaultdict

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

if __name__ == "__main__":
    find_tag_types_example()
