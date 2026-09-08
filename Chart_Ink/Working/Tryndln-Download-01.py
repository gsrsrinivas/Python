## direct download for a direct url
import requests


def download_file(url, local_filename):
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)


# Example usage:
file_url = 'https://trendlyne.com/path/to/your/file.csv'  # Replace with actual file URL
local_file = 'file.csv'
download_file(file_url, local_file)
