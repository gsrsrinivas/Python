import json

def flatten_json(data, parent_key=''):
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
        flat = flatten_json(data)
        if not flat:
            return json_string
        return flat
    except Exception as e:
        print(e)
        return json_string


def flatten_json_str_safe(json_input):
    """
    Accepts a JSON string, dict, or list.
    Returns a flattened dict or the input as-is if not processable.
    """
    import json
    def flatten_json_string(data, parent_key=''):
        result = {}
        if isinstance(data, list):
            for item in data:
                if isinstance(item, dict) and 'key' in item and 'value' in item:
                    key = item.get('key')
                    value = item.get('value')
                    new_key = f"{parent_key}.{key}" if parent_key else key
                    if isinstance(value, (list, dict)):
                        nested = flatten_json_string(value, new_key)
                        result.update(nested)
                    else:
                        result[new_key] = value
                else:
                    # If it's just a list of values, not key-value pairs
                    new_key = parent_key if parent_key else ''
                    result[new_key] = item
        elif isinstance(data, dict):
            # If dict has 'key' and 'value', treat as special structure
            if 'key' in data and 'value' in data:
                key = data.get('key')
                value = data.get('value')
                new_key = f"{parent_key}.{key}" if parent_key else key
                if isinstance(value, (list, dict)):
                    nested = flatten_json_string(value, new_key)
                    result.update(nested)
                else:
                    result[new_key] = value
            else:
                # Flatten regular dict
                for k, v in data.items():
                    new_key = f"{parent_key}.{k}" if parent_key else k
                    if isinstance(v, (dict, list)):
                        nested = flatten_json_string(v, new_key)
                        result.update(nested)
                    else:
                        result[new_key] = v
        else:
            # Primitive value
            if parent_key:
                result[parent_key] = data
        return result

    # Parse string if needed
    if isinstance(json_input, str):
        json_input = json_input.strip()
        if not json_input:
            return {}
        try:
            data = json.loads(json_input)
        except Exception:
            return {}
    else:
        data = json_input

    return flatten_json_string(data)

# Examples:
if __name__ == "__main__":
    # Valid nested JSON array
    # json_str = '[{"key":"a","value":[{"key":"b","value":{"str_value":"hello"}},{"key":"c","value":{"int_value":42}}]}]'
    json_str = '''[{"key":"a","value":{"str_value":"hello","int_value":null},"key":"c","value":{"int_value":42}}]'''
    print(flatten_json_safe(json_str))  # {'a.b': 'hello', 'a.c': 42}

    # Empty input
    print(flatten_json_safe(""))  # Output: ""

    # Invalid JSON
    print(flatten_json_safe("not json"))  # Output: "not json"

    # JSON that flattens to empty
    print(flatten_json_safe("[]"))  # Output: "[]"

    # Example with nested input
    input_json = '''[
        {"key":"code","value":{"str_value":"XYZ123","int_value":null}},
        {"key":"code1","value":{"str_value":null,"int_value":"123"}},
        {"key":"details","value":[
            {"key":"subcode","value":{"str_value":"A1","int_value":null}},
            {"key":"subvalue","value":{"str_value":null,"int_value":"456"}}
        ]}
    ]'''

    output = flatten_json_safe(input_json)
    output_result = flatten_json_safe(output)
    print(f"Flatten_json function output_result\n{output_result}")
    print(f"Flatten_json function output\n{output}\n{json.dumps(output, indent=2)}")
