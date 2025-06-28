import json

import pandas as pd


def flatten_json_dict_lst(y, prefix=''):
    out = {}
    if isinstance(y, dict):
        for k, v in y.items():
            full_key = f"{prefix}.{k}" if prefix else k
            if isinstance(v, dict):
                out.update(flatten_json_dict_lst(v, full_key))
            elif isinstance(v, list):
                out[full_key] = 'list'
                for idx, item in enumerate(v):
                    out.update(flatten_json_dict_lst(item, f"{full_key}[{idx}]"))
            else:
                out[full_key] = v
    elif isinstance(y, list):
        for idx, item in enumerate(y):
            out.update(flatten_json_dict_lst(item, f"{prefix}[{idx}]"))
    return out


def infer_types(flat_dict):
    return {k: type(v).__name__ for k, v in flat_dict.items()}


def json_data_types_example():
    # --- USER INPUTS ---
    excel_file = r'../Json/Json_In_Out/Output/json_data.xlsx'
    json_column = 'json_data'  # The column name containing your nested JSON

    # --- READ EXCEL ---
    df = pd.read_excel(excel_file)

    # --- PROCESS EACH ROW ---
    all_types = []
    for idx, row in df.iterrows():
        json_str = row[json_column]
        try:
            data = json.loads(json_str)
            flat = flatten_json_dict_lst(data)
            types = infer_types(flat)
            for key, dtype in types.items():
                all_types.append({'Row': idx + 1, 'Key': key, 'Type': dtype})
        except Exception as e:
            all_types.append({'Row': idx + 1, 'Key': 'ERROR', 'Type': str(e)})

    # --- CREATE SUMMARY TABLE ---
    summary_df = pd.DataFrame(all_types)
    print(summary_df)

    # Optionally, write to Excel
    summary_df.to_excel('../Output/2025-05-31--12-00-00--json_key_types_per_row.xlsx', index=False)


if __name__ == '__main__':
    json_data_types_example()
