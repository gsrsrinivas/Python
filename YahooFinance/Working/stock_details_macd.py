import yfinance as yf
from ta.momentum import RSIIndicator, StochasticOscillator
from ta.trend import MACD

# Download historical data for a stock, e.g., Apple [finance:Apple Inc.]
data = yf.download("AAPL", start="2023-01-01", end="2025-11-21")

# Calculate RSI (default 14 periods)
rsi = RSIIndicator(close=data['Adj Close']).rsi()
data['RSI'] = rsi

# Calculate MACD
macd = MACD(close=data['Adj Close'])
data['MACD'] = macd.macd()
data['MACD_signal'] = macd.macd_signal()
data['MACD_diff'] = macd.macd_diff()

# Calculate Stochastic Oscillator
stoch = StochasticOscillator(high=data['High'], low=data['Low'], close=data['Adj Close'])
data['Stoch_K'] = stoch.stoch()
data['Stoch_D'] = stoch.stoch_signal()

print(data[['RSI', 'MACD', 'MACD_signal', 'MACD_diff', 'Stoch_K', 'Stoch_D']].tail())
