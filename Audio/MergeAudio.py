import os
from pydub import AudioSegment

def merge_audio():
    folder_path = r"C:\Users\gsrsr\Downloads"
    merged_audio = AudioSegment.empty()
    merged_audio += AudioSegment.from_mp3(r"C:\Users\gsrsr\Downloads\Nana_GayatriMantram_1time - Copy (1).mp3")
    merged_audio += AudioSegment.from_mp3(r"C:\Users\gsrsr\Downloads\Nana_GayatriMantram_1time - Copy (2).mp3")
    merged_audio.export("merged_output.mp3", format="mp3")
    print("MP3 files merged successfully!")
    # Loop through all MP3 files in the folder
    for file in os.listdir(folder_path):
        print(f"Checking folder: {folder_path}")
        print(f"Files in folder: {os.listdir(folder_path)}")
        if file.endswith(".mp3"):
            audio = AudioSegment.from_mp3(os.path.join(folder_path, file))
            merged_audio += audio

    # Export the merged audio file
    merged_audio.export("merged_output.mp3", format="mp3")

    print("MP3 files merged successfully!")

if __name__ == "__main__":
    merge_audio()
