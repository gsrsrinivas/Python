import pandas as pd
import numpy as np
import yfinance as yf
from scipy.signal import argrelextrema
import matplotlib.pyplot as plt

# Download Nifty or any stock
ticker = 'RELIANCE.NS'  # Change to your preferred stock
data = yf.download(ticker, start='2022-01-01', end='2025-01-01')

# Check if data is fetched
if data.empty:
    print("No data fetched. Check the ticker symbol or date range.")
    exit()

# print("Available columns:", data.columns)

# Ensure 'Close' column is present
if 'Close' not in data.columns:
    print("Close column not found in data.")
    exit()

# Prepare DataFrame
df = data[['Close']].copy()

# Detect local minima and maxima
order = 5
min_idx = argrelextrema(df['Close'].values, np.less_equal, order=order)[0]
max_idx = argrelextrema(df['Close'].values, np.greater_equal, order=order)[0]

# Create empty columns for wave points
df['min'] = np.nan
df['max'] = np.nan

# Assign values
df.loc[df.index[min_idx], 'min'] = df['Close'].iloc[min_idx]
df.loc[df.index[max_idx], 'max'] = df['Close'].iloc[max_idx]

# # Plotting
# plt.figure(figsize=(14, 7))
# plt.plot(df['Close'], label='Close Price', alpha=0.6)
# # Use matching indexes and values
# plt.scatter(df.index[min_idx], df['Close'].iloc[min_idx], color='green', label='Swing Lows', s=50)
# plt.scatter(df.index[max_idx], df['Close'].iloc[max_idx], color='red', label='Swing Highs', s=50)
#
# plt.title(f"Wave Theory Points - {ticker}")
# plt.legend()
# plt.show()

# (Example conceptually, not automated yet)
wave_labels = ['1', '2', '3', '4', '5', 'A', 'B', 'C']

from ta.trend import macd, ema_indicator

df['EMA50'] = ema_indicator(df['Close'].iloc[min_idx], window=50)

from ta.trend import MACD

macd_indicator = MACD(close=df['Close'])  # Pass the Series only
df['MACD'] = macd_indicator.macd()
df['MACD_signal'] = macd_indicator.macd_signal()
df['MACD_diff'] = macd_indicator.macd_diff()

import matplotlib.pyplot as plt

plt.figure(figsize=(14, 6))
plt.plot(df['MACD'], label='MACD', color='blue')
plt.plot(df['MACD_signal'], label='Signal Line', color='orange')
plt.bar(df.index, df['MACD_diff'], label='MACD Histogram', color='gray')
plt.legend()
plt.title("MACD Indicator")
plt.grid(True)
plt.show()
