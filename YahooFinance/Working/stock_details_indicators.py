from datetime import datetime

import yfinance as yf
from ta.momentum import RSIIndicator, StochasticOscillator, WilliamsRIndicator
# from ta.others import ROCIndicator, MomentumIndicator
from ta.trend import MACD, ADXIndicator
from ta.volatility import BollingerBands
from ta.volume import OnBalanceVolumeIndicator, ChaikinMoneyFlowIndicator, VolumeWeightedAveragePrice

# Download historical data
data = yf.download("TCS", start="2022-01-01", end=datetime.today().strftime('%Y-%m-%d'))

# Calculate technical indicators
data['RSI'] = RSIIndicator(data['Adj Close']).rsi()
macd = MACD(data['Adj Close'])
data['MACD'] = macd.macd()
data['MACD_signal'] = macd.macd_signal()
data['MACD_diff'] = macd.macd_diff()

sto = StochasticOscillator(data['High'], data['Low'], data['Adj Close'])
data['Stoch_K'] = sto.stoch()
data['Stoch_D'] = sto.stoch_signal()

data['BB_upper'] = BollingerBands(data['Adj Close']).bollinger_hband()
data['BB_lower'] = BollingerBands(data['Adj Close']).bollinger_lband()

data['ADX'] = ADXIndicator(data['High'], data['Low'], data['Adj Close']).adx()
data['OBV'] = OnBalanceVolumeIndicator(data['Adj Close'], data['Volume']).on_balance_volume()
data['Chaikin_MF'] = ChaikinMoneyFlowIndicator(data['High'], data['Low'], data['Adj Close'],
                                               data['Volume']).chaikin_money_flow()
data['VWAP'] = VolumeWeightedAveragePrice(data['High'], data['Low'], data['Adj Close'],
                                          data['Volume']).volume_weighted_average_price()

data['CCI'] = data['Adj Close'].rolling(window=20).apply(lambda x: (x[-1] - x.mean()) / (0.015 * x.std()), raw=False)
data['WPR'] = WilliamsRIndicator(data['High'], data['Low'], data['Adj Close']).williams_r()

# data['ROC'] = ROCIndicator(data['Adj Close']).roc()
# data['Momentum'] = MomentumIndicator(data['Adj Close']).momentum()

# View the last few rows with indicator values
# print(data[[
#     'RSI', 'MACD', 'MACD_signal', 'MACD_diff', 'Stoch_K', 'Stoch_D', 'BB_upper', 'BB_lower',
#     'ADX', 'OBV', 'Chaikin_MF', 'VWAP', 'CCI', 'WPR', 'ROC', 'Momentum'
# ]].tail())
print(data[[
    'RSI', 'MACD', 'MACD_signal', 'MACD_diff', 'Stoch_K', 'Stoch_D', 'BB_upper', 'BB_lower',
    'ADX', 'OBV', 'Chaikin_MF', 'VWAP', 'CCI', 'WPR'
]].tail())
