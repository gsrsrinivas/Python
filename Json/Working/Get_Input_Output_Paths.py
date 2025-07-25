import os
from datetime import datetime
from pathlib import Path


def get_file_paths():
    # get the timestamp
    file_timestamp = datetime.now().strftime("%Y-%m-%d--%H-%M-%S--")
    # Gets the parent directory of the current working directory
    parent_folder = Path.cwd().parent
    # get the source file folder
    folder_path = parent_folder / "Input"
    # get the output folder
    output_folder = parent_folder / "Output"
    # get the output file name along with timestamp
    output_filename = f"{file_timestamp}json_types_summary_all_files.xlsx"

    # get the input folder path to be processed
    input_path = folder_path
    # get the output folder path to be processed
    output_path = os.path.join(output_folder, output_filename)
    return input_path, output_path
    ## --------------------------------------------------------------------------------------------- ##


if __name__ == "__main__":
    in_path, out_path = get_file_paths()
    print(f"input folder path and output folder path are\n{in_path}\n{out_path}")
