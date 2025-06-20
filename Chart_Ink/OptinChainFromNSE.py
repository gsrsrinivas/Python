import json

import pandas as pd
import requests


def option_chain_from_nse():
    # URL for fetching option chain data
    symbol = 'NIFTY'
    if symbol != 'NIFTY':
        url = f'https://www.nseindia.com/api/option-chain-equities?symbol={symbol}'
    else:
        url = f'https://www.nseindia.com/api/option-chain-indices?symbol={symbol}'

    # Headers to mimic a browser request
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br'
    }

    session = requests.Session()
    # First, get the cookies from the main page
    session.get("https://www.nseindia.com", headers=headers)
    # Then, use those cookies to access the API
    response = session.get(url, headers=headers)

    # # Fetching the data
    # response = requests.get(url, headers=headers)
    print(response.status_code)
    data = json.loads(response.text)

    # Extracting the option chain data
    option_chain = data['records']['data']

    # Converting to a DataFrame for easier manipulation
    df = pd.json_normalize(option_chain)

    # Saving to a CSV file
    df.to_csv(f'C:/Users/gsrsr/Downloads/{symbol}_option_chain.csv', index=False)

    print(f"Option chain data for {symbol} is saved to {symbol}_option_chain.csv")


if __name__ == "__main__":
    option_chain_from_nse()
