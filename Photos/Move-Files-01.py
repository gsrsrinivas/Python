import os
import shutil

import pandas as pd

# ==== CONFIG ====
csv_path = r"D:\.TeraBoxDownload\image_classification_log.csv"   # your Excel file
source_col = "Final_Path_Error"                            # column name for source path
dest_col = "Original_Path"                         # column name for destination path
# ===============

def move_files_from_csv(csv_file, src_col, dst_col):
    # Read CSV into DataFrame
    df = pd.read_csv(csv_file)  # uses comma as default delimiter.[web:20][web:25]

    for idx, row in df.iterrows():
        src = str(row[src_col]).strip()
        dst = str(row[dst_col]).strip()

        # Skip empty or NaN sources
        if not src or src.lower() == "nan":
            print(f"Row {idx}: empty source, skipping.")
            continue

        # Check if source file exists
        if not os.path.exists(src):
            print(f"Row {idx}: source does not exist -> {src}")
            continue

        # Ensure destination directory exists
        dst_dir = os.path.dirname(dst)
        if dst_dir and not os.path.exists(dst_dir):
            os.makedirs(dst_dir, exist_ok=True)

        try:
            shutil.move(src, dst)   # move file from src to dst.[web:4][web:21][web:27]
            print(f"Row {idx}: moved\n  {src}\n  -> {dst}")
        except Exception as e:
            print(f"Row {idx}: failed to move {src} -> {dst}. Error: {e}")

if __name__ == "__main__":
    move_files_from_csv(csv_path, source_col, dest_col)
