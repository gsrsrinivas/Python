# Microsoft 365 Copilot
# This script moves image files from one folder to another. It uses the `os` and `shutil` libraries to handle file operations.
# pip install pillow imagehash tqdm
# pip install torch torchvision pillow transformers

import os
import shutil
from PIL import Image
import imagehash
from tqdm import tqdm

# -----------------------------
# CONFIGURATION
# -----------------------------
REFERENCE_IMAGE = r"D:\FZ Bike - RegistrationCard - FrontSide.jpg"
SEARCH_FOLDER = r"D:\TeraBoxDownload"
OUTPUT_FOLDER = r"D:\Documents-Images"

# Lower = stricter matching
# Typical values: 5-15
HASH_THRESHOLD = 15

# Supported image formats
IMAGE_EXTENSIONS = ('.jpg', '.jpeg', '.png', '.bmp', '.webp')

# -----------------------------
# CREATE OUTPUT FOLDER
# -----------------------------
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

# -----------------------------
# REFERENCE HASH
# -----------------------------
reference_hash = imagehash.phash(Image.open(REFERENCE_IMAGE))

matched_count = 0

# -----------------------------
# SEARCH ALL SUBFOLDERS
# -----------------------------
i=0
for root, dirs, files in os.walk(SEARCH_FOLDER):
    print (f"Scanning folder: {root}\({len(files)} files)")
    for file in files:
        print(f"{i} Checking file: {root} {file}")
        i+=1
        if not file.lower().endswith(IMAGE_EXTENSIONS):
            continue

        full_path = os.path.join(root, file)

        # Skip the reference image itself
        if os.path.abspath(full_path) == os.path.abspath(REFERENCE_IMAGE):
            continue

        try:
            current_hash = imagehash.phash(Image.open(full_path))

            distance = reference_hash - current_hash

            if distance <= HASH_THRESHOLD:

                destination = os.path.join(
                    OUTPUT_FOLDER,
                    os.path.basename(full_path)
                )

                # Prevent overwrite
                if os.path.exists(destination):
                    base, ext = os.path.splitext(destination)
                    i = 1

                    while os.path.exists(
                        f"{base}_{i}{ext}"
                    ):
                        i += 1

                    destination = f"{base}_{i}{ext}"

                shutil.move(full_path, destination)

                matched_count += 1
                print(
                    f"MATCH ({distance}) -> {full_path}"
                )

        except Exception as e:
            print(f"Error processing {full_path}: {e}")

print(f"\nFinished.")
print(f"Moved {matched_count} matching images.")
