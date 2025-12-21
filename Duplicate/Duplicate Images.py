import os

import imagehash
from PIL import Image


def find_duplicates(folder_path):
    hashes = {}
    duplicates = []
    for dirpath, _, filenames in os.walk(folder_path):
        print("Scanning folder:", dirpath)
        for filename in filenames:
            # print("Processing file:", filename)
            # for filename in os.listdir(folder_path):
            if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
                # image_path = os.path.join(folder_path, filename)
                image_path = os.path.join(dirpath, filename)
                try:
                    hash = imagehash.dhash(Image.open(image_path))
                    if hash in hashes:
                        duplicates.append((filename, hashes[hash]))
                    else:
                        hashes[hash] = filename
                except Exception as e:
                    print(f"Error processing {filename}: {e}")
    return duplicates


# Usage
folder_path = r"D:\External Hard Drive\Photos"
duplicates = find_duplicates(folder_path)
for dup in duplicates:
    print(f"Duplicate found: {dup[0]} and {dup[1]}")
