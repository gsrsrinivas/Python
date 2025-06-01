import json

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
            for subk, subv in obj.items():
                flat_dict.update(flatten_key_value_json(subv, parent_key=subk))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json(item, parent_key=parent_key))
    return flat_dict

def flatten_key_value_json_example():
    json_obj = '[{"key": "code", "value": {"str_value": "XYZ123"}}, {"key": "code", "value": {"int_value": "123"}}]'
    data = json.loads(json_obj)
    json_dict = flatten_key_value_json(data)
    print(json_dict)
