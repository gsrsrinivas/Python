import hashlib
import os


def hash_file(file_path, block_size=65536):
    """Return SHA-256 hash of a file."""
    hasher = hashlib.sha256()
    try:
        with open(file_path, 'rb') as file:
            buf = file.read(block_size)
            while buf:
                hasher.update(buf)
                buf = file.read(block_size)
    except (OSError, PermissionError):
        return None
    return hasher.hexdigest()


def find_duplicate_images(root_folder, image_extensions=None):
    """Traverse subfolders and find duplicate images."""
    if image_extensions is None:
        image_extensions = {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.webp', '.heic'}

    hash_map = {}
    duplicates = []

    for dirpath, _, filenames in os.walk(root_folder):
        print(f"Scanning folder: {dirpath}")
        for filename in filenames:
            # print(f"Processing file: {filename}")
            ext = os.path.splitext(filename)[1].lower()
            if ext in image_extensions:
                full_path = os.path.join(dirpath, filename)
                file_hash = hash_file(full_path)
                if file_hash:
                    if file_hash in hash_map:
                        duplicates.append((full_path, hash_map[file_hash]))
                    else:
                        hash_map[file_hash] = full_path
    return duplicates


if __name__ == "__main__":
    print("Scanning for duplicate images in subfolders...")
    folder = r"D:\External Hard Drive\Photos"
    # folder = input("Enter the path to scan for duplicate images: ").strip('"')
    duplicates = find_duplicate_images(folder)

    if duplicates:
        print("\nFound duplicate images:")
        for dup in duplicates:
            print(f"- {dup[0]}\n  matches with:\n  {dup[1]}\n")
    else:
        print("No duplicate images found.")
