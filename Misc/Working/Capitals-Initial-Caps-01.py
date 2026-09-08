# not working properly for the initial cap in of english words
import re
import string


def initial_caps_with_spaces(text):
    """Capitalizes the first letter of each word and inserts spaces."""

    if not text:
        return ""

    # Split using regex to find word boundaries (uppercase letters or start of string)
    words = re.findall(r'[A-Z]?[a-z0-9]*', text)
    words = [word for word in words if word]  # remove empty strings.

    capitalized_words = []

    for word in words:

        prefix_punctuation = ""
        suffix_punctuation = ""

        # Check for leading punctuation
        while word and word[0] in string.punctuation:
            prefix_punctuation += word[0]
            word = word[1:]

        # Check for trailing punctuation
        while word and word[-1] in string.punctuation:
            suffix_punctuation += word[-1]
            word = word[:-1]

        if word:
            capitalized_word = word[0].upper() + word[1:].lower()
        else:
            capitalized_word = ""

        capitalized_words.append(prefix_punctuation + capitalized_word + suffix_punctuation)

    return " ".join(capitalized_words)


def initial_caps_with_spaces_examples():
    # Example Usage
    print(initial_caps_with_spaces("niftymidcap"))
    print(initial_caps_with_spaces("nsebank"))
    print(initial_caps_with_spaces("aBCdEFg"))
    print(initial_caps_with_spaces("test123example"))
    print(initial_caps_with_spaces("123testExample"))
    print(initial_caps_with_spaces("testexample"))
    print(initial_caps_with_spaces("...testEXAMPLE..."))
    print(initial_caps_with_spaces("niftyMIDcap"))


if __name__ == "__main__":
    initial_caps_with_spaces_examples()
