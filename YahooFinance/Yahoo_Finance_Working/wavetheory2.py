import yfinance as yf
import pandas as pd
import numpy as np
from scipy.signal import argrelextrema
import matplotlib.pyplot as plt
from ta.trend import MACD

# ---------- 1. Download Stock Data ----------
ticker = 'RELIANCE.NS'  # Change to any symbol like 'TCS.NS' or 'AAPL'
data = yf.download(ticker, start='2022-01-01', end='2025-01-01')

# Ensure data is valid
if data.empty or 'Close' not in data.columns:
    print("Data not available. Check ticker or internet connection.")
    exit()


# ---------- 2. Prepare DataFrame ----------
df = pd.DataFrame(data['Close'])  # Only the 'Close' Series, as DataFrame
df.columns = ['Close']  # Just to be sure

# ---------- 3. Detect Swing Highs and Lows ----------
order = 5  # sensitivity
min_idx = argrelextrema(df['Close'].values, np.less_equal, order=order)[0]
max_idx = argrelextrema(df['Close'].values, np.greater_equal, order=order)[0]

df['min'] = np.nan
df['max'] = np.nan
df.loc[df.index[min_idx], 'min'] = df['Close'].iloc[min_idx]
df.loc[df.index[max_idx], 'max'] = df['Close'].iloc[max_idx]

# ---------- 4. MACD Calculation ----------
macd = MACD(close=df['Close'])
df['MACD'] = macd.macd()
df['MACD_signal'] = macd.macd_signal()
df['MACD_diff'] = macd.macd_diff()

# ---------- 5. Plot Swing Points ----------
plt.figure(figsize=(15, 6))
plt.plot(df['Close'], label='Close Price', alpha=0.8)
plt.scatter(df.index[min_idx], df['Close'].iloc[min_idx], color='green', label='Swing Lows', s=60)
plt.scatter(df.index[max_idx], df['Close'].iloc[max_idx], color='red', label='Swing Highs', s=60)
plt.title(f"{ticker} - Wave Points with Close Price")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

# ---------- 6. Plot MACD ----------
plt.figure(figsize=(15, 5))
plt.plot(df['MACD'], label='MACD Line', color='blue')
plt.plot(df['MACD_signal'], label='Signal Line', color='orange')
plt.bar(df.index, df['MACD_diff'], label='MACD Histogram', color='gray', alpha=0.5)
plt.title(f"{ticker} - MACD Indicator")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
# # ---------- 7. Save Data to CSV ----------
# df.to_csv(f"{ticker}_wave_analysis.csv", index=True)
# print(f"Data saved to {ticker}_wave_analysis.csv")
# # ---------- 8. Summary ----------
# print(f"Wave points and MACD analysis completed for {ticker}.")
# This script downloads stock data, detects swing highs and lows, calculates MACD, and plots the results.
# It also saves the analysis to a CSV file for further review.
# Ensure you have the required libraries installed:
# pip install yfinance pandas numpy scipy matplotlib ta
# This script is a complete example of wave theory analysis using Python.

