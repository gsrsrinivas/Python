import os
import shutil

import cv2
import numpy as np
import pillow_heif
from PIL import Image

# ---------------- CONFIG ---------------- #

SOURCE_ROOT = r"C:\Users\gsrsr\Downloads\Google.Photos - GsrSrinivas08@gmail.com"        # Folder to scan (with subfolders)
NON_HUMAN_FOLDER = r"C:\Users\gsrsr\Downloads\Google.Photos--GsrSrinivas08@gmail.com--non_human_images"     # Destination folder

SUPPORTED_EXTENSIONS = (
    ".jpg", ".jpeg", ".png", ".bmp",
    ".tiff", ".tif", ".webp",
    ".heic", ".heif"
)

os.makedirs(NON_HUMAN_FOLDER, exist_ok=True)

face_cascade = cv2.CascadeClassifier(
    cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
)

# ---------------- IMAGE LOADER ---------------- #

def load_image_any_format(image_path):
    ext = os.path.splitext(image_path)[1].lower()

    if ext in (".heic", ".heif"):
        heif_file = pillow_heif.read_heif(image_path)
        image = Image.frombytes(
            heif_file.mode,
            heif_file.size,
            heif_file.data
        ).convert("RGB")
        return cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)

    image = cv2.imread(image_path)
    if image is None:
        raise ValueError("Unreadable image")
    return image

# ---------------- HUMAN DETECTION ---------------- #

def is_human_image(image_bgr):
    gray = cv2.cvtColor(image_bgr, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(60, 60)
    )
    return len(faces) > 0

# ---------------- FILE MOVE (SAFE) ---------------- #

def move_to_non_human(src_path):
    filename = os.path.basename(src_path)
    dest_path = os.path.join(NON_HUMAN_FOLDER, filename)

    base, ext = os.path.splitext(filename)
    counter = 1

    # Avoid overwriting files
    while os.path.exists(dest_path):
        dest_path = os.path.join(
            NON_HUMAN_FOLDER, f"{base}_{counter}{ext}"
        )
        counter += 1

    shutil.move(src_path, dest_path)

# ---------------- DIRECTORY PROCESS ---------------- #

def process_directory(root_folder):
    for root, _, files in os.walk(root_folder):
        for file in files:
            ext = os.path.splitext(file)[1].lower()
            if ext in SUPPORTED_EXTENSIONS:
                image_path = os.path.join(root, file)
                try:
                    image = load_image_any_format(image_path)

                    if not is_human_image(image):
                        move_to_non_human(image_path)
                        print(f"MOVED (Non-Human): {image_path}")
                    else:
                        print(f"KEPT (Human): {image_path}")

                except Exception as e:
                    print(f"FAILED: {image_path} ({e})")

# ---------------- RUN ---------------- #

if __name__ == "__main__":
    process_directory(SOURCE_ROOT)
