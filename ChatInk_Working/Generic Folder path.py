import os
from pathlib import Path


def generic_folder_paths_examples():
    """
    This script demonstrates how to work with generic folder paths in Python using both the os module and pathlib.
    It includes examples of creating folder paths relative to the current working directory, the user's home directory,
    and the parent directory.
    """
    folder_path = os.path.join(os.getcwd(), "my_folder")  # Joins the current working directory with the folder name
    print(folder_path)
    '''----------------------------------------------------------------------------------'''
    folder_path = Path.cwd() / "my_folder"  # Creates a path object for a folder in the current directory
    print(folder_path)
    '''----------------------------------------------------------------------------------'''
    home_directory = Path.home()  # Gets the user's home directory
    folder_path = home_directory / "Documents" / "my_folder"
    print(folder_path)
    '''----------------------------------------------------------------------------------'''
    parent_folder = Path.cwd().parent  # Gets the parent directory of the current working directory
    print(parent_folder)
    '''----------------------------------------------------------------------------------'''
    parent_folder = os.path.abspath(os.path.join(os.getcwd(), ".."))  # Moves up one folder
    print(parent_folder)


if __name__ == "__main__":
    generic_folder_paths_examples()
