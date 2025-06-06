import pandas as pd
from Get_Input_Output_Paths import get_file_paths
from Get_Folder_FilePaths import list_files_by_extensions
import os

def read_file(file_path, file_types):
    """ read the file and output the data as Data Frame."""
    if file_types == '.csv':
        df = pd.read_csv(file_path)
    elif file_types == '.txt':
        df = pd.read_csv(file_path, delimiter='\t')
    elif file_types == '.xlsx':
        df = pd.read_excel(file_path, dtype=str)  # Read everything as string
    elif file_types == '.xls':
        df = pd.read_excel(file_path)
    elif file_types == '.parquet':
        df = pd.read_parquet(file_path)
    else:
        raise ValueError("Unsupported file type")
    return df

def read_file_example():
    in_path, out_path = get_file_paths()
    file_list = list_files_by_extensions(in_path)
    for each_file in file_list:
        _, ext = os.path.splitext(each_file)
        df1 = read_file(each_file, ext)
        print(f"file details are as follows:\n{df1}")

if __name__ == "__main__":
    read_file_example()
