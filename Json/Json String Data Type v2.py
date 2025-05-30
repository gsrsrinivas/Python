import json
from collections import defaultdict

def clean_json_structure(json_data):
    """ Remove null values and map key to valid values """
    result = defaultdict(set)

    for entry in json_data:
        if isinstance(entry, dict) and "key" in entry and "value" in entry:
            value_data = entry["value"]

            if isinstance(value_data, dict):
                for k, v in value_data.items():
                    if v is not None:
                        result[entry["key"]].add(v)  # Store valid values

    # Convert defaultdict to standard dictionary with list values
    cleaned_output = {k: list(v) for k, v in result.items()}
    return cleaned_output

def extract_data_types(cleaned_json):
    """ Track data types for each key """
    data_types = {}
    for key, values in cleaned_json.items():
        data_types[key] = ", ".join(set(type(v).__name__ for v in values))
    return data_types

# Example usage:
json_input = '[{"key":"code","value":{"str_value":"XYZ123","int_value":null}},{"key":"city","value":{"str_value":{"addr":"asdf","pincode":500019},"int_value":null}}]'
parsed_data = json.loads(json_input)

cleaned_json = clean_json_structure(parsed_data)
print("Cleaned JSON:", json.dumps(cleaned_json, indent=2))

data_types = extract_data_types(cleaned_json)
print("Data Types:", data_types)