import yfinance as yf
import pandas as pd
import numpy as np
from scipy.signal import argrelextrema
import matplotlib.pyplot as plt
from ta.trend import MACD

# --- 1. Download Stock Data ---
ticker = 'RELIANCE.NS'
data = yf.download(ticker, start='2022-01-01', end='2025-01-01')

if data.empty or 'Close' not in data.columns:
    print("Data not available.")
    exit()

df = pd.DataFrame(data['Close'])
df.columns = ['Close']

# --- 2. Detect Swing Points ---
order = 5
min_idx = argrelextrema(df['Close'].values, np.less_equal, order=order)[0]
max_idx = argrelextrema(df['Close'].values, np.greater_equal, order=order)[0]

df['min'] = np.nan
df['max'] = np.nan
df.loc[df.index[min_idx], 'min'] = df['Close'].iloc[min_idx]
df.loc[df.index[max_idx], 'max'] = df['Close'].iloc[max_idx]

# Combine and sort swing points
swings = pd.concat([
    df[['Close']].iloc[min_idx].rename(columns={'Close': 'Price'}).assign(Type='Low'),
    df[['Close']].iloc[max_idx].rename(columns={'Close': 'Price'}).assign(Type='High')
])
swings = swings.sort_index()

# --- 3. Heuristic Wave Labeling (1–5) ---
# Pick first 5 alternating swings
wave_points = []
last_type = None
for idx, row in swings.iterrows():
    if last_type != row['Type']:
        wave_points.append((idx, row['Price']))
        last_type = row['Type']
    if len(wave_points) == 5:
        break

# --- 4. MACD (Optional for confirmation) ---
macd = MACD(close=df['Close'])
df['MACD'] = macd.macd()
df['MACD_signal'] = macd.macd_signal()
df['MACD_diff'] = macd.macd_diff()

# --- 5. Plot Close + Wave Labels ---
plt.figure(figsize=(15, 6))
plt.plot(df['Close'], label='Close Price', alpha=0.8)
plt.scatter(df.index[min_idx], df['Close'].iloc[min_idx], color='green', label='Swing Lows', s=60)
plt.scatter(df.index[max_idx], df['Close'].iloc[max_idx], color='red', label='Swing Highs', s=60)

# Plot wave numbers
for i, (idx, price) in enumerate(wave_points):
    plt.text(idx, price * 1.01, f'Wave {i+1}', fontsize=10, fontweight='bold', color='blue')

plt.title(f"{ticker} - Elliott Wave Labeling (Heuristic 1–5)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
