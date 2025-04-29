import enchant
import re

def prepare_statement_property(text):
    """
    Prepares a statement property by removing spaces, capitalizing words,
    and correcting spelling using pyenchant.

    Args:
        text (str): The input text.

    Returns:
        str: The prepared statement property.
    """
    if not text:
        return ""

    d = enchant.Dict("en_US")  # Or "en_GB", etc.

    # Remove all spaces
    text_no_spaces = text.replace(" ", "")

    # Split the string based on uppercase letters (word boundaries)
    words = re.findall(r'[A-Z]?[a-z0-9]*', text_no_spaces)
    words = [word for word in words if word] #remove empty strings

    corrected_words = []
    for word in words:
        if d.check(word):
            corrected_words.append(word)
        else:
            suggestions = d.suggest(word)
            if suggestions:
                corrected_words.append(suggestions[0])  # Use the first suggestion
            else:
                 corrected_words.append(word) #if no suggestions, keep original

    # Capitalize the first letter of each corrected word and join them
    capitalized_words = [word[0].upper() + word[1:].lower() for word in corrected_words]

    return "".join(capitalized_words)

# Example Usage
text1 = "this is a test property with misspeled words"
text2 = "multiple spaces andCapitalization"
text3 = "no spaces at all"
text4 = "a verylongwordthatisbadlyspelled"
text5 = ""

print(f"'{text1}' -> '{prepare_statement_property(text1)}'")
print(f"'{text2}' -> '{prepare_statement_property(text2)}'")
print(f"'{text3}' -> '{prepare_statement_property(text3)}'")
print(f"'{text4}' -> '{prepare_statement_property(text4)}'")
print(f"'{text5}' -> '{prepare_statement_property(text5)}'")