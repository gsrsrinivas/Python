# ChatGPT
# This script moves image files from one folder to another based on their file extensions.
# pip install pillow imagehash

from pathlib import Path
import shutil
from PIL import Image
import imagehash

# =========================
# SETTINGS
# =========================

REFERENCE_IMAGE = r"D:\FZ Bike - RegistrationCard - FrontSide.jpg"

SOURCE_FOLDER = Path(r"D:\TeraBoxDownload")
DESTINATION_FOLDER = Path(r"D:\Documents-Images")

# Smaller number = stricter match
# 0   = essentially identical
# 5   = very similar
# 10  = somewhat similar
MAX_DISTANCE = 10

IMAGE_EXTENSIONS = {
    ".jpg", ".jpeg", ".png", ".bmp",
    ".webp", ".tif", ".tiff"
}


# =========================
# CREATE HASH
# =========================

reference_hash = imagehash.phash(Image.open(REFERENCE_IMAGE))

print("Reference image:")
print(REFERENCE_IMAGE)
print("Reference hash:", reference_hash)
print()


# =========================
# SCAN ALL FOLDERS
# =========================

matches = []

for file in SOURCE_FOLDER.rglob("*"):

    if not file.is_file():
        continue

    if file.suffix.lower() not in IMAGE_EXTENSIONS:
        continue

    # Don't process the reference image itself
    if file.resolve() == Path(REFERENCE_IMAGE).resolve():
        continue

    try:
        print(f"Processing: {file}")
        img = Image.open(file)

        current_hash = imagehash.phash(img)

        distance = reference_hash - current_hash

        if distance <= MAX_DISTANCE:
            matches.append((file, distance))

    except Exception as e:
        print("Could not process:", file)
        print("Reason:", e)


# =========================
# SHOW MATCHES
# =========================

matches.sort(key=lambda x: x[1])

print("\nMATCHES FOUND:")
print("-" * 70)

for file, distance in matches:
    print(f"Distance: {distance:2}  {file}")

print("\nTotal matches:", len(matches))


# =========================
# MOVE MATCHES
# =========================

DESTINATION_FOLDER.mkdir(parents=True, exist_ok=True)

for file, distance in matches:

    # Keep the original folder structure
    relative_path = file.relative_to(SOURCE_FOLDER)

    destination = DESTINATION_FOLDER / relative_path

    destination.parent.mkdir(parents=True, exist_ok=True)

    # Avoid overwriting existing files
    if destination.exists():
        destination = destination.with_name(
            destination.stem + "_matched" + destination.suffix
        )

    shutil.move(str(file), str(destination))

    print("Moved:", file)
    print("     ->", destination)


print("\nFinished.")
