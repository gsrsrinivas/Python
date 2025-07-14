import os

def list_directory_contents(path='.'):
    """
    Lists all files and subdirectories in the given path.
    Defaults to the current working directory.
    """
    try:
        print(f"Contents of '{os.path.abspath(path)}':")
        for item in os.listdir(path):
            print(item)
    except FileNotFoundError:
        print(f"Error: Directory not found at '{path}'")
    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage:
# List contents of the current directory
list_directory_contents(r"/YahooFinance/thumbnails")

# List contents of a specific directory (replace 'your_directory_path' with the actual path)
# list_directory_contents('/path/to/your/directory')
# On Windows, it might look like: list_directory_contents('C:\\Users\\YourUser\\Documents')
