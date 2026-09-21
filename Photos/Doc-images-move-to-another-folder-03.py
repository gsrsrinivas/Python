# gemini
# pip install Pillow imagehash

import os
import shutil
from PIL import Image
import imagehash


def find_and_move_similar_images(
        target_image_path,
        source_directory,
        destination_directory,
        threshold=10
):
    """
    Finds images similar to a target image across source_directory (including subfolders)
    and moves them to destination_directory.

    :param target_image_path: Path to the query image/card.
    :param source_directory: Directory to search (searches subfolders too).
    :param destination_directory: Folder where matching images will be moved.
    :param threshold: Hamming distance threshold (0 = exact visual match, 1-10 = minor variations/resizes).
    """
    if not os.path.exists(target_image_path):
        print(f"Target image missing: {target_image_path}")
        return

    # Create destination directory if it doesn't exist
    os.makedirs(destination_directory, exist_ok=True)

    # Compute perceptual hash for target image
    try:
        target_img = Image.open(target_image_path)
        target_hash = imagehash.phash(target_img)
        print(f"Target Hash Generated: {target_hash}\n")
    except Exception as e:
        print(f"Error reading target image: {e}")
        return

    supported_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.webp', '.tiff')
    moved_count = 0

    # Walk through source directory and subdirectories
    for root, _, files in os.walk(source_directory):
        for file in files:
            if file.lower().endswith(supported_extensions):
                file_path = os.path.join(root, file)

                # Skip processing the target image if it resides inside the source directory
                if os.path.abspath(file_path) == os.path.abspath(target_image_path):
                    continue

                try:
                    with Image.open(file_path) as current_img:
                        current_hash = imagehash.phash(current_img)
                        # Calculate Hamming distance (difference between hashes)
                        distance = target_hash - current_hash

                        if distance <= threshold:
                            print(f"[MATCH FOUND - Distance {distance}]: {file_path}")

                            # Handle duplicate filenames in destination directory
                            dest_path = os.path.join(destination_directory, file)
                            base_name, ext = os.path.splitext(file)
                            counter = 1
                            while os.path.exists(dest_path):
                                dest_path = os.path.join(destination_directory, f"{base_name}_{counter}{ext}")
                                counter += 1

                            shutil.move(file_path, dest_path)
                            moved_count += 1

                except Exception as e:
                    # Skip unreadable or corrupted image files
                    continue

    print(f"\nCompleted! Moved {moved_count} matching image(s) to '{destination_directory}'.")


# --- Usage Example ---
if __name__ == "__main__":
    TARGET_IMAGE = "D:/FZ Bike - RegistrationCard - FrontSide.jpg"
    SOURCE_DIR = "D:/TeraBoxDownload"
    DEST_DIR = "D:/Documents-Images"

    # Adjust threshold:
    # 0 = identical content (resizes OK)
    # 5-10 = allows slight color, brightness, or scale shifts
    THRESHOLD = 10

    find_and_move_similar_images(TARGET_IMAGE, SOURCE_DIR, DEST_DIR, threshold=THRESHOLD)

