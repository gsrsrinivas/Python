import os

import ffmpeg


# from ffmpeg import run, input, output
def merge_files_ffmeg():
    folder_path = "C:/Users/gsrsr/Downloads"
    output_file = "merged_output.mp3"

    # Get all MP3 files
    mp3_files = [os.path.join(folder_path, f) for f in os.listdir(folder_path) if f.endswith(".mp3")]

    # Create input file list
    with open("input.txt", "w") as f:
        for file in mp3_files:
            # f.write(f"file '{file}'\n")
            f.write(f"{file}\n")

    # Run ffmpeg command to merge files
    ffmpeg.input("input.txt", format="concat", safe=0).output(output_file, codec="copy").run()

    print("MP3 files merged successfully!")


if __name__ == "__main__":
    merge_files_ffmeg()
