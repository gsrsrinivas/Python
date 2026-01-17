import os
import shutil

import cv2

# Load face detection model
face_cascade = cv2.CascadeClassifier(
    cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
)

# Folder paths
source_folder = "photos"
no_face_folder = "no_faces"

# Create destination folder if not exists
os.makedirs(no_face_folder, exist_ok=True)

# Supported image formats
image_extensions = (".jpg", ".jpeg", ".png", ".bmp", ".webp")

for filename in os.listdir(source_folder):
    if not filename.lower().endswith(image_extensions):
        continue

    file_path = os.path.join(source_folder, filename)
    image = cv2.imread(file_path)

    if image is None:
        continue

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)

    # 👉 Move ONLY photos with NO faces
    if len(faces) == 0:
        shutil.move(file_path, os.path.join(no_face_folder, filename))
        print(f"Moved (no face): {filename}")
    else:
        print(f"Face detected: {filename}")
