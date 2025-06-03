import json

import pandas as pd


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
    json_str = '''
    [
        {"key":"code","value":{"str_value":"XYZ123","int_value":null, "float_value":"12.5", "bool_value":"true"}},
        {"key":"code","value":{"str_value":null,"int_value":"123", "float_value":null, "bool_value":"false"}},
        {"key":"desc","value":{"en":"Test","fr":null}},
        {"key":"active","value":true},
        {"key":"empty","value":null}
    ]
    '''
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
            {"key":"subcode","value":{"str_value":"A1","int_value":null}},
            {"key":"subvalue","value":{"str_value":null,"int_value":"456"}}
        ]}
    ]'''

    output = flatten_top_level(input_json)
    output_result = flatten_top_level(output)
    # print(f"Flatten_json function output_result\n{output_result}")
    # print(f"Flatten_json function output\n{output}\n{json.dumps(output, indent=2)}")


if __name__ == "__main__":
    flatten_top_level_example()
