import os
import shutil
from datetime import datetime
from pathlib import Path

# Suppress Hugging Face symlink warning before importing transformers
os.environ["HF_HUB_DISABLE_SYMLINKS_WARNING"] = "1"

from PIL import Image
import torch
from transformers import pipeline

# 1. Configuration
SOURCE_FOLDER = r"D:\TeraBoxDownload\Media"
OUTPUT_FOLDER = r"D:\Documents-Images"
CONFIDENCE_THRESHOLD = 0.5  # Adjust sensitivity (0.0 - 1.0)

MOVE_FILES = True  # True to MOVE, False to COPY
PRESERVE_SUBFOLDERS = True  # True = maintain original subfolder tree in output

CANDIDATE_LABELS = [
    "a photo or scan of a document, bill, receipt, ID card, passport, or certificate",
    "a photo of a person or human face",
    "a photo of an animal or pet",
    "a photo of nature, trees, plants, or landscapes",
    "a drawing, illustration, or digital artwork",
    "a random everyday object or scenery"
]

POSITIVE_LABEL = "a photo or scan of a document, bill, receipt, ID card, passport, or certificate"
SUPPORTED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".bmp", ".webp", ".tiff"}


def filter_documents():
    # Start Timer
    start_time = datetime.now()

    print("=" * 60)
    print(f"Script Execution Started At : {start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)

    os.makedirs(OUTPUT_FOLDER, exist_ok=True)

    device = 0 if torch.cuda.is_available() else -1
    print(f"\nLoading CLIP model on {'GPU' if device == 0 else 'CPU'}...")
    classifier = pipeline(
        "zero-shot-image-classification",
        model="openai/clip-vit-base-patch32",
        device=device
    )

    source_path = Path(SOURCE_FOLDER)

    # Recursive search: Finds files in SOURCE_FOLDER and all subfolders
    image_files = [
        f for f in source_path.rglob("*")
        if f.is_file() and f.suffix.lower() in SUPPORTED_EXTENSIONS
    ]

    total_files = len(image_files)
    print(f"\nFound {total_files} images across all subfolders in '{SOURCE_FOLDER}'\n" + "=" * 60)

    matched_count = 0

    for idx, img_path in enumerate(image_files, 1):
        # Display the relative path (e.g., subfolder/image.jpg)
        rel_path = img_path.relative_to(source_path)
        print(f"\n[{idx}/{total_files}] Processing: {rel_path}")

        try:
            with Image.open(img_path) as img:
                img_rgb = img.convert("RGB")
                results = classifier(img_rgb, candidate_labels=CANDIDATE_LABELS)

                top_label = results[0]["label"]
                top_score = results[0]["score"]

                if top_label == POSITIVE_LABEL and top_score >= CONFIDENCE_THRESHOLD:
                    # Target path destination
                    if PRESERVE_SUBFOLDERS:
                        dest_path = Path(OUTPUT_FOLDER) / rel_path
                        dest_path.parent.mkdir(parents=True, exist_ok=True)
                    else:
                        dest_path = Path(OUTPUT_FOLDER) / img_path.name

                    if MOVE_FILES:
                        shutil.move(img_path, dest_path)
                        action_str = "MOVED"
                    else:
                        shutil.copy2(img_path, dest_path)
                        action_str = "COPIED"

                    matched_count += 1
                    print(f"  └── [MATCH] {action_str} -> {dest_path} (Confidence: {top_score:.2%})")
                else:
                    print(f"  └── [SKIP] Excluded (Identified as '{top_label}' at {top_score:.2%})")

        except Exception as e:
            print(f"  └── [ERROR] Could not process {rel_path}: {e}")
    # Stop Timer & Calculate Elapsed Time
    end_time = datetime.now()
    duration = end_time - start_time

    total_seconds = int(duration.total_seconds())
    hours, remainder = divmod(total_seconds, 3600)
    minutes, seconds = divmod(remainder, 60)

    print("\n" + "=" * 60)
    print("EXECUTION SUMMARY")
    print("=" * 60)
    print(f"Start Time   : {start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"End Time     : {end_time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Total Time   : {hours:02d}h {minutes:02d}m {seconds:02d}s")
    print(f"Files Scanned: {total_files}")
    print(f"Files Moved  : {matched_count}")
    print("=" * 60)


if __name__ == "__main__":
    filter_documents()
