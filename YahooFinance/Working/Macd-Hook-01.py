# code is not working
import matplotlib.pyplot as plt
import pandas as pd
import ta
import yfinance as yf

# Download historical stock data
symbol = "HAL"
df = yf.download(symbol, start="2023-01-01", end="2025-12-31")

# Compute MACD using the ta library
macd = ta.trend.MACD(close=df['Close'])
df['macd_line'] = macd.macd()
df['macd_signal'] = macd.macd_signal()


# Function to find MACD hooks (upturn after N declines)
def find_macd_hooks(df, window=3):
    hooks = []
    # macd_values = df['macd_line'].dropna().to_numpy().reshape(-1)
    macd_values = df['macd_line'] = pd.Series(macd.macd().values.flatten(), index=df.index)

    for i in range(window, len(macd_values) - 1):
        is_declining = all(macd_values[i - j - 1] > macd_values[i - j] for j in range(window))
        is_hook = macd_values[i] < macd_values[i + 1]
        if is_declining and is_hook:
            hooks.append(i + 1)
    return df.iloc[hooks]


# Find and display hooks
hook_df = find_macd_hooks(df)
print(hook_df[['Close', 'macd_line', 'macd_signal']])

# Optional: Plot MACD and hooks
plt.figure(figsize=(14, 6))
plt.plot(df.index, df['macd_line'], label='MACD Line', color='blue')
plt.plot(df.index, df['macd_signal'], label='Signal Line', color='red')
plt.scatter(hook_df.index, hook_df['macd_line'], color='green', marker='o', label='Hook Points')
plt.title(f"{symbol} MACD Hooks")
plt.xlabel("Date")
plt.ylabel("MACD")
plt.legend()
plt.grid(True)
plt.show()
