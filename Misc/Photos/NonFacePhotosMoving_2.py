# it cannot only move non-human images but also supports HEIC/HEIF formats
import csv
import os
import shutil

import cv2
import numpy as np
import pillow_heif
from PIL import Image
from ultralytics import YOLO

# ---------------- CONFIG ---------------- #

SOURCE_ROOT = r"D:\.TeraBoxDownload\Camera"          # Root folder with images
NON_HUMAN_FOLDER = r"D:\.TeraBoxDownload\User - Documents\MISC-1"       # Destination folder
CSV_LOG_FILE = r"D:\.TeraBoxDownload\User - Documents\MISC-1\image_classification_log.csv"

SUPPORTED_EXTENSIONS = (
    ".jpg", ".jpeg", ".png", ".bmp",
    ".tiff", ".tif", ".webp",
    ".heic", ".heif"
)

os.makedirs(NON_HUMAN_FOLDER, exist_ok=True)

# Load YOLOv8 (pretrained on COCO)
model = YOLO("yolov8n.pt")  # lightweight & fast

PERSON_CLASS_ID = 0  # COCO class ID for "person"

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

# ---------------- YOLO HUMAN DETECTION ---------------- #

def is_human_image(image_bgr):
    results = model(image_bgr, verbose=False)

    for r in results:
        if r.boxes is not None:
            for cls in r.boxes.cls:
                if int(cls) == PERSON_CLASS_ID:
                    return True
    return False

# ---------------- SAFE MOVE ---------------- #

def move_to_non_human(src_path):
    filename = os.path.basename(src_path)
    base, ext = os.path.splitext(filename)
    dest_path = os.path.join(NON_HUMAN_FOLDER, filename)
    counter = 1

    while os.path.exists(dest_path):
        dest_path = os.path.join(
            NON_HUMAN_FOLDER, f"{base}_{counter}{ext}"
        )
        counter += 1

    shutil.move(src_path, dest_path)
    return dest_path

# ---------------- MAIN PROCESS ---------------- #

def process_directory(root_folder):
    log_rows = []

    for root, _, files in os.walk(root_folder):
        for file in files:
            ext = os.path.splitext(file)[1].lower()
            if ext in SUPPORTED_EXTENSIONS:
                image_path = os.path.join(root, file)

                try:
                    image = load_image_any_format(image_path)
                    human = is_human_image(image)

                    if not human:
                        new_path = move_to_non_human(image_path)
                        status = "Non-Human (Moved)"
                        print(f"MOVED: {image_path}")
                    else:
                        new_path = image_path
                        status = "Human"
                        print(f"KEPT: {image_path}")

                    log_rows.append([
                        image_path,
                        status,
                        new_path
                    ])

                except Exception as e:
                    print(f"FAILED: {image_path} ({e})")
                    log_rows.append([
                        image_path,
                        "Error",
                        str(e)
                    ])

    write_csv(log_rows)

# ---------------- CSV LOGGER ---------------- #

def write_csv(rows):
    with open(CSV_LOG_FILE, mode="w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["Original Path", "Result", "Final Path / Error"])
        writer.writerows(rows)

# ---------------- RUN ---------------- #

if __name__ == "__main__":
    process_directory(SOURCE_ROOT)
    print(f"\nProcessing complete. Log saved to {CSV_LOG_FILE}")
