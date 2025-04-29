import requests
from bs4 import BeautifulSoup

url = "https://www.nseindia.com/option-chain"
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate, br'
}

session = requests.Session()
session.get("https://www.nseindia.com", headers=headers)
response = session.get(url, headers=headers)
soup = BeautifulSoup(response.content, 'html.parser')
# print(response.text)
# Extract stock symbols
# symbols = [option.text for option in soup.find_all('option') if option.get('value')]
symbols = [option.get('value') for option in soup.find_all('option') if option.get('value')]
print(symbols)
