import json

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

if __name__ == "__main__":
    remove_none_example()
