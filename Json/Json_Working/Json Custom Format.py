import json


def custom_format_recursive(obj):
    """
    Recursively convert a list of {"key":..., "value":...} dicts into the custom string format.
    """
    if isinstance(obj, list):
        # Check if this is a list of {"key":..., "value":...} dicts
        if all(isinstance(item, dict) and set(item.keys()) == {"key", "value"} for item in obj):
            return ','.join(custom_format_recursive(item) for item in obj)
        else:
            # It's a list of primitives or other lists
            return '[' + ','.join(custom_format_recursive(item) for item in obj) + ']'
    elif isinstance(obj, dict) and set(obj.keys()) == {"key", "value"}:
        key = obj["key"]
        value = obj["value"]
        # Recursively format the value
        formatted_value = custom_format_recursive(value)
        return f'{{{key},{formatted_value}}}'
    else:
        return str(obj)


def custom_format_example():
    # Example usage:
    input_json = '[{"key": "a", "value": "asd"}, {"key": "b", "value": [{"c": 2}, {"d": [3,4,5]}]}]'
    parsed = json.loads(input_json)
    output_str = custom_format_recursive(parsed)
    print(output_str)


if __name__ == "__main__":
    custom_format_example()
