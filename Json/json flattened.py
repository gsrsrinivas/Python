import json

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

def flatten_json(obj, parent_key=''):
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
                    items.extend(flatten_json(v, new_key))
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
    flat_items = flatten_json(parsed)
    flat_str = format_flattened(flat_items)
    print(flat_str)  # Output: {a:1},{b.c:2},{b.d:[3,4,5]}

if __name__ == "__main__":
    custom_nested_format_example()
    format_flattened_example()
