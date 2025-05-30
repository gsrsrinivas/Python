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

# Example with nested input
input_json = [
    {"key":"code","value":{"str_value":"XYZ123","int_value":None}},
    {"key":"code1","value":{"str_value":None,"int_value":"123"}},
    {"key":"details","value":[
        {"key":"subcode","value":{"str_value":"A1","int_value":None}},
        {"key":"subvalue","value":{"str_value":None,"int_value":"456"}}
    ]}
]

output = flatten_json(input_json)
print(json.dumps(output, indent=2))
