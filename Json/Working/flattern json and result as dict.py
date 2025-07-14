def flatten_key_value_json_dict_list(obj, parent_key=''):
    flat_dict = {}
    if isinstance(obj, dict):
        k = obj.get('key')
        v = obj.get('value')
        if k is not None:
            if isinstance(v, dict) or isinstance(v, list):
                nested = flatten_key_value_json_dict_list(v, parent_key=k)
                for nk, nv in nested.items():
                    # If parent_key exists, combine keys
                    combined_key = f"{k}.{nk}" if nk else k
                    flat_dict[combined_key] = nv
            else:
                flat_dict[k] = v
        else:
            # If not a key-value dict, process all items
            for subk, subv in obj.items():
                flat_dict.update(flatten_key_value_json_dict_list(subv, parent_key=subk))
    elif isinstance(obj, list):
        for item in obj:
            flat_dict.update(flatten_key_value_json_dict_list(item, parent_key=parent_key))
    return flat_dict


def flatten_key_value_json_dict_list_example():
    # Example usage:
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

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)

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

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)

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

    flat = flatten_key_value_json_dict_list(nested_json)
    print(flat)


if __name__ == "__main__":
    flatten_key_value_json_dict_list_example()
