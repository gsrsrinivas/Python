# Copilot windows
# this script will move images similar to a reference image from a search folder (including subfolders) to an output folder based on a similarity threshold. It uses OpenCV for image processing and the Structural Similarity Index (SSIM) to determine how similar two images are.

import os
import shutil
import cv2
import numpy as np

# --- CONFIGURATION ---
reference_image_path = r"D:\FZ Bike - RegistrationCard - FrontSide.jpg"   # The photo/card you want to match
search_root_folder = r"D:\TeraBoxDownload"     # Folder to scan (includes subfolders)
output_folder = r"D:\Documents-Images"          # Folder where similar images will be moved
similarity_threshold = 0.7                           # Adjust: 0.0–1.0 (higher = stricter match)

# --- FUNCTION TO CALCULATE SIMILARITY ---
def calculate_similarity(img1, img2):
    # Convert to grayscale
    img1_gray = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
    img2_gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

    # Resize to same size
    img2_gray = cv2.resize(img2_gray, (img1_gray.shape[1], img1_gray.shape[0]))

    # Compute Structural Similarity Index (SSIM)
    from skimage.metrics import structural_similarity as ssim
    score, _ = ssim(img1_gray, img2_gray, full=True)
    return score

# --- MAIN SCRIPT ---
def find_and_move_similar_images():
    # Load reference image
    ref_img = cv2.imread(reference_image_path)
    if ref_img is None:
        print("Error: Reference image not found.")
        return

    # Ensure output folder exists
    os.makedirs(output_folder, exist_ok=True)

    # Walk through all files in folder and subfolders
    for root, _, files in os.walk(search_root_folder):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                img = cv2.imread(file_path)
                if img is None:
                    continue  # Skip non-image files

                similarity = calculate_similarity(ref_img, img)
                if similarity >= similarity_threshold:
                    print(f"Match found: {file_path} (Similarity: {similarity:.2f})")
                    shutil.move(file_path, os.path.join(output_folder, file))
            except Exception as e:
                print(f"Error processing {file_path}: {e}")

if __name__ == "__main__":
    find_and_move_similar_images()

