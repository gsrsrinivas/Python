# Install if required:
# pip install yfinance matplotlib pandas taew

import yfinance as yf
import pandas as pd
import matplotlib.pyplot as plt
import taew
import numpy as np
import sys
import os

# Add your custom module path if needed
sys.path.append(os.path.dirname(os.path.dirname(__file__)))  # Adjust according to your filepath
from YahooFinance.stock_thumb_nails import *

# Connect to database or get symbols list
len_symbols, symbols = connect_to_db()
tickers = symbols[:1]  # Use symbols retrieved

result_stocks = []

for ticker in tickers:
    # Download 1 year daily data, auto adjusted
    df = yf.download(ticker, period="1y", interval="1d", auto_adjust=True)
    df.dropna(inplace=True)
    if len(df) < 50:
        continue

    close_prices = df['Close'].values
    close_np = np.array(close_prices, dtype=np.double)

    # Perform Elliott Wave labeling using taew
    label = taew.Alternative_ElliottWave_label_upward(close_np)

    # Append data for plotting later
    result_stocks.append({'ticker': ticker, 'df': df, 'label': label})

# Now plot and save the charts with wave counts labeled
for stock in result_stocks:
    fig, ax = plt.subplots(figsize=(6, 4))

    # Plot closing prices
    stock['df']['Close'].plot(ax=ax, title=stock['ticker'])

    # Overlay wave numbers: extract last 200 detected wave segments if available
    window_labels = stock['label'][-200:]

    for wave in window_labels:
        # Each wave is a dict with keys 'x' (prices) and 'z' (indices)
        if isinstance(wave, dict):
            x_vals = wave.get('x', [])
            z_vals = wave.get('z', [])
            # Label maximum 5 waves per detected pattern
            for i in range(min(len(x_vals), 5)):
                price = float(x_vals[i][0])  # unwrap numpy array
                index_pos = z_vals[i]
                # Check index_pos validity and plot label
                if index_pos < len(stock['df']):
                    date = stock['df'].index[index_pos]
                    ax.text(date, price, str(i + 1), color='red', fontsize=10, fontweight='bold')

    ax.set_xticks([])
    ax.set_yticks([])
    plt.tight_layout()

    # Save file named after the ticker symbol (e.g. "TITAN.NS.png")
    filename = f"{stock['ticker']}.png"
    fig.savefig(filename)
    plt.close(fig)
    print(f"Saved Elliott Wave plot for {stock['ticker']} to {filename}")
