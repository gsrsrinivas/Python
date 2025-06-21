import os

from pydub import AudioSegment


def merge_files():
    global merged_audio
    folder_path = r"C:\Users\gsrsr\Downloads"
    mp3_files = []
    # Get all .mp3 files in the folder
    # files = glob.glob(folder_path + "/*.mp3")
    # mp3_files = [os.path.basename(file) for file in files]
    files = os.listdir(folder_path)
    mp3_files.extend(files)
    # for file in files:
    #     print(file)
    # print(mp3_files)
    # List of MP3 files to merge
    # mp3_files = ["file1.mp3", "file2.mp3", "file3.mp3"]
    # Load the first file
    # merged_audio = AudioSegment.from_mp3(mp3_files[0])
    # merged_audio = []
    for i, file in enumerate(files):
        file_extension = os.path.splitext(file)[1]
        if file_extension == ".mp3":
            filepath = folder_path + "\\" + file
            print(filepath)
            audio = AudioSegment.from_mp3(folder_path + "\\" + file)
            merged_audio = audio if i == 1 else merged_audio + audio

    # Append remaining files
    # for mp3 in mp3_files[1:]:
    #     audio = AudioSegment.from_mp3(mp3)
    #     merged_audio += audio

    # Export the merged audio file
    merged_audio.export("merged_output.mp3", format="mp3")

    print("MP3 files merged successfully!")


if __name__ == "__main__":
    merge_files()
