# Grok
# pip install pillow imagehash opencv-python numpy tqdm
# this script will move images similar to a reference image from a search folder (including subfolders) to an output folder based on a similarity threshold. It uses perceptual hashing and optional OpenCV feature matching for better accuracy with rotated or resized images.
# not working and matching is not accurate, so I will rewrite the script to improve accuracy and performance.

import os
import shutil
from pathlib import Path
from PIL import Image
import imagehash
import cv2
import numpy as np
from tqdm import tqdm

# ====================== CONFIG ======================
REFERENCE_IMAGE = r"D:\FZ Bike - RegistrationCard - FrontSide.jpg"   # <-- change this
SEARCH_FOLDER   = r"D:\TeraBoxDownload"                  # <-- change this
OUTPUT_FOLDER   = r"D:\Documents-Images"                    # <-- change this

# How similar should images be? (lower = stricter)
# For perceptual hash: 0 = identical, 5-10 = very similar, 15+ = somewhat similar
HASH_THRESHOLD = 8

# Also use OpenCV feature matching? (slower but better for rotated/resized cards)
USE_FEATURE_MATCHING = True
FEATURE_MATCH_THRESHOLD = 25   # minimum good matches to consider similar

# Supported image extensions
EXTENSIONS = {'.jpg', '.jpeg', '.png', '.bmp', '.webp', '.tiff', '.tif'}
# ====================================================


def get_image_hash(image_path):
    """Compute perceptual hash (average hash + difference hash for robustness)."""
    try:
        img = Image.open(image_path)
        # Convert to RGB to avoid issues with RGBA / palette images
        if img.mode != 'RGB':
            img = img.convert('RGB')
        ahash = imagehash.average_hash(img)
        dhash = imagehash.dhash(img)
        phash = imagehash.phash(img)
        return ahash, dhash, phash
    except Exception as e:
        print(f"  [!] Could not hash {image_path}: {e}")
        return None


def is_similar_by_hash(ref_hashes, candidate_path, threshold=HASH_THRESHOLD):
    """Compare perceptual hashes. Returns True if similar."""
    cand_hashes = get_image_hash(candidate_path)
    if cand_hashes is None:
        return False

    # Take the minimum distance across the three hashes (more robust)
    distances = [
        ref_hashes[0] - cand_hashes[0],
        ref_hashes[1] - cand_hashes[1],
        ref_hashes[2] - cand_hashes[2]
    ]
    min_distance = min(distances)
    return min_distance <= threshold


def is_similar_by_features(ref_img, candidate_path, min_matches=FEATURE_MATCH_THRESHOLD):
    """
    OpenCV ORB feature matching.
    Good for cards that may be rotated, cropped, or have different lighting.
    """
    try:
        cand_img = cv2.imread(str(candidate_path), cv2.IMREAD_GRAYSCALE)
        if cand_img is None:
            return False

        # Create ORB detector
        orb = cv2.ORB_create(nfeatures=1000)

        kp1, des1 = orb.detectAndCompute(ref_img, None)
        kp2, des2 = orb.detectAndCompute(cand_img, None)

        if des1 is None or des2 is None:
            return False

        # Brute-force matcher with Hamming distance
        bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
        matches = bf.match(des1, des2)

        # Keep only good matches
        good_matches = [m for m in matches if m.distance < 50]

        return len(good_matches) >= min_matches
    except Exception:
        return False


def find_and_move_similar():
    ref_path = Path(REFERENCE_IMAGE)
    search_root = Path(SEARCH_FOLDER)
    output_dir = Path(OUTPUT_FOLDER)

    if not ref_path.exists():
        raise FileNotFoundError(f"Reference image not found: {ref_path}")

    if not search_root.exists():
        raise FileNotFoundError(f"Search folder not found: {search_root}")

    # Create output folder
    output_dir.mkdir(parents=True, exist_ok=True)

    # Compute reference hashes
    print("Computing reference image hashes...")
    ref_hashes = get_image_hash(ref_path)
    if ref_hashes is None:
        raise ValueError("Could not process reference image")

    # Load reference for feature matching (grayscale)
    ref_cv = None
    if USE_FEATURE_MATCHING:
        ref_cv = cv2.imread(str(ref_path), cv2.IMREAD_GRAYSCALE)
        if ref_cv is None:
            print("[!] Warning: Could not load reference for feature matching. Falling back to hash only.")
            USE_FEATURE_MATCHING = False

    # Collect all image files recursively
    print(f"Scanning {search_root} for images...")
    all_images = []
    for root, _, files in os.walk(search_root):
        for f in files:
            if Path(f).suffix.lower() in EXTENSIONS:
                all_images.append(Path(root) / f)

    print(f"Found {len(all_images)} images. Comparing...\n")

    moved = 0
    skipped = 0

    for img_path in tqdm(all_images, desc="Checking similarity"):
        # Skip the reference itself
        if img_path.resolve() == ref_path.resolve():
            continue

        # Skip files already inside the output folder
        try:
            if output_dir.resolve() in img_path.resolve().parents:
                continue
        except Exception:
            pass

        similar = False

        # 1. Perceptual hash check (fast)
        if is_similar_by_hash(ref_hashes, img_path, HASH_THRESHOLD):
            similar = True

        # 2. Optional feature matching (more accurate for cards)
        elif USE_FEATURE_MATCHING and ref_cv is not None:
            if is_similar_by_features(ref_cv, img_path):
                similar = True

        if similar:
            # Create a unique name in case of collisions
            dest = output_dir / img_path.name
            counter = 1
            while dest.exists():
                dest = output_dir / f"{img_path.stem}_{counter}{img_path.suffix}"
                counter += 1

            try:
                shutil.move(str(img_path), str(dest))
                moved += 1
                tqdm.write(f"  → Moved: {img_path.name}")
            except Exception as e:
                tqdm.write(f"  [!] Failed to move {img_path}: {e}")
                skipped += 1
        else:
            skipped += 1

    print("\n" + "="*50)
    print(f"Done!")
    print(f"  Similar images moved : {moved}")
    print(f"  Images left alone    : {skipped}")
    print(f"  Output folder        : {output_dir}")
    print("="*50)


if __name__ == "__main__":
    find_and_move_similar()

