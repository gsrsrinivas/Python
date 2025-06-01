import json

def remove_nulls(value):
    """ this function removes all the null pairs from a json string recursively
    and the out is same as input
    :param value:
    :return:
    """
    if isinstance(value, dict):
        return {k: remove_nulls(v) for k, v in value.items() if v is not None}
    elif isinstance(value, list):
        return [remove_nulls(item) for item in value if item is not None]
    else:
        return value

def remove_nulls_example():
    # Example usage:
    json_str = """
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
    """

    data = json.loads(json_str)
    cleaned_data = remove_nulls(data)
    result_json_str = json.dumps(cleaned_data, indent=2)
    print(result_json_str)

def flatten_key_value_json(obj, parent_key=""):
    """ this function flattens the json string either it is a list or dict
        and returns as a dict
    :param obj:
    :param parent_key:
    :return: dict
    """
    flat_dict = {}
    if isinstance(obj, dict):
        k = obj.get("key")
        v = obj.get("value")
        if k is not None:
            if isinstance(v, dict) or isinstance(v, list):
                nested = flatten_key_value_json(v, parent_key=k)
                for nk, nv in nested.items():
                    # If parent_key exists, combine keys
                    combined_key = f"{k}.{nk}" if nk else k
                    flat_dict[combined_key] = nv
            else:
                flat_dict[k] = v
        else:
            # If not a key-value dict, process all items
            for subk, subv in obj.items():
                flat_dict.update(flatten_key_value_json(subv, parent_key=subk))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json(item, parent_key=parent_key))
    return flat_dict

def flatten_key_value_json_example():
    # Example usage: starts here for the flatten_key_value_json fn
    # eg 1
    nested_json = {
        "key": "user",
        "value": {
            "key": "profile",
            "value": {
                "key": "name",
                "value": "Jordan"
            }
        }
    }
    flat = flatten_key_value_json(nested_json)
    # print(flat)
    # eg 2
    nested_json = {
        "key": "user",
        "value": [
            {
                "key": "profile",
                "value": {
                    "key": "name",
                    "value": "Jordan"
                }
            },
            {
                "key": "contact",
                "value": {
                    "key": "phone",
                    "value": "555-1234"
                }
            }
        ]
    }
    flat = flatten_key_value_json(nested_json)
    # print(flat)
    # eg 3
    json_obj = '[{"key": "code", "value": {"str_value": "XYZ123"}}, {"key": "code", "value": {"int_value": "123"}}]'
    json_obj = json.loads(json_obj)
    json_dict = flatten_key_value_json(json_obj)
    print(json_dict)

    # Example usage: ends here for the flatten_key_value_json fn

if __name__ == "__main__":
    flatten_key_value_json_example()

