import emoji
# print(emoji.EMOJI_DATA.keys())  # Lists all emoji codes
print(emoji.Emoji(':grinning_face_with_big_eyes:'))  # Prints the emoji for the code
print(emoji.emojize(':grinning_face with_big_eyes:', use_aliases=True))  # Prints the emoji using aliases
print(emoji.demojize('😀'))  # Converts emoji to its code
print(emoji.demojize('😀', delimiters=('', '')))  # Converts emoji

print(emoji.emojize(':grinning_face_with_big_eyes:', language='alias'))

