import os
import json
from Get_Input_Output_Paths import get_file_paths

def list_files_by_extensions(folder_path, extensions=('.csv', '.xlsx', '.xls', '.parquet')):
    """
    Returns a list of file paths in the folder (and subfolders) matching the given extensions.
    :param folder_path: str, path to the folder
    :param extensions: tuple or list, e.g. ('.csv', '.xlsx', '.parquet')
    :return: list of file paths
    """
    matched_files = []
    for root, dirs, files_nm in os.walk(folder_path):
        for file in files_nm:
            if file.lower().endswith(extensions):
                matched_files.append(os.path.join(root, file))
    return matched_files

def list_files_by_extensions_example():
    # Example usage:
    folder, _ = get_file_paths()
    # folder = 'your_folder_path_here'
    ext = ('.csv', '.xlsx','.xls', '.parquet')
    files = list_files_by_extensions(folder, ext)
    files_format = json.dumps(files, indent=2)
    print(files_format)

if __name__ == "__main__":
    list_files_by_extensions_example()


