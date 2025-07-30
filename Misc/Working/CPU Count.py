# import emoji
# print(emoji.EMOJI_DATA.keys())  # Lists all emoji codes
import os

print(os.cpu_count())
print(min(32, os.cpu_count()+4))  # Fallback to 32 if os.cpu_count() returns None
