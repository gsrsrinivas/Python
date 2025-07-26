import os
from pathlib import Path

# pictures_path = os.path.join(os.environ["USERPROFILE"], "Pictures").replace("gsrsr", r"gsrsr\OneDrive")
# print("Pictures folder :", str(pictures_path))
# Get the path to the Pictures folder
# pictures_path = os.path.join(os.environ["USERPROFILE"], "Pictures").replace("gsrsr", r"gsrsr\OneDrive")
pictures_path = os.path.dirname(os.path.dirname(Path(r'C:\Users\gsrsr\OneDrive\Documents\PythonProject')))
# Folder to save thumbnails
thumb_dir = pictures_path + r'\Pictures\Thumbnails'
# Create thumbnails directory if it doesn't exist
print("Pictures folder after appended thumbnails folder is: ", thumb_dir)

documents_path = os.path.join(os.environ["USERPROFILE"], "Documents").replace("gsrsr", r"gsrsr\OneDrive")
input_folder_path = documents_path + r"\SQL Server Management Studio\Analysis of Stocks\Analysis of Stocks"
print("Documents folder after appended thumbnails folder is:", documents_path)

folder_path = os.path.dirname(Path(r'C:\Users\gsrsr\OneDrive\Documents\PythonProject'))
print("Folder path is:", folder_path)
