import json

def remove_nulls(value):
    if isinstance(value, dict):
        return {k: remove_nulls(v) for k, v in value.items() if v is not None}
    elif isinstance(value, list):
        return [remove_nulls(item) for item in value if item is not None]
    else:
        return value

def remove_nulls_example():
    # Example usage:
    json_str = '''
    {
        "customer_id": 12345,
        "name": "Jordan",
        "email": null,
        "phone": "555-1234",
        "address": null,
        "contact_info": {
            "email": null,
            "phone": "555-1234",
            "social_media": {
                "facebook": null,
                "twitter": "@jordan123"
            }
        },
        "addresses": [null, {"street": "123 Elm St", "city": "Springfield"}]
    }
    '''

    data = json.loads(json_str)
    cleaned_data = remove_nulls(data)
    result_json_str = json.dumps(cleaned_data, indent=2)
    print(result_json_str)

if __name__== "__main__":
    remove_nulls_example()
