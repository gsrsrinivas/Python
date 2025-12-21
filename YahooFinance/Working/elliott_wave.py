import yfinance as yf
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from datetime import datetime

# Define symbol and date range
symbol = 'HAL.NS'
start_date = '2018-04-01'
end_date = datetime.today().strftime('%Y-%m-%d')

# Download data
data = yf.download(symbol, start=start_date, end=end_date, interval='1mo')
data.dropna(inplace=True)

# Calculate swings
data['returns'] = data['Close'].pct_change()
data['direction'] = np.where(data['returns'] > 0, 1, -1)
data['swing'] = data['direction'].diff().ne(0).astype(int)

# Identify swing points
swings = data[data['swing'] == 1].copy()
swings['wave'] = range(1, len(swings) + 1)

# Plot chart
fig, ax = plt.subplots(figsize=(18, 10))
ax.plot(data.index, data['Close'], label='Price', color='blue', linewidth=1.5)
ax.scatter(swings.index, swings['Close'], color='red', label='Swing Points', zorder=5)

# Annotate wave numbers
for i, row in swings.iterrows():
    ax.text(i, row['Close'], str(row['wave']), fontsize=8, color='darkgreen', ha='center')

ax.set_title(f"{symbol} Daily Price Chart with Wave Labels")
ax.set_xlabel("Date")
ax.set_ylabel("Adjusted Close")
ax.legend()
ax.grid(True)
plt.tight_layout()
plt.show()

# 15_minutes_stocks_daily.log
# if __name__ == "__main__":
#     printlog = setup_logger(__file__, '15_minutes_stocks_daily.log')
#     try:
#         print_start_timestamp()
#         # prevent_sleep()
#         # sys.exit() if trading_hours_check() == "exit" else None
#         with concurrent.futures.ThreadPoolExecutor() as executor:
#             chart_ink = executor.submit(chart_ink_download_15minutes)
#             thumb_nails = executor.submit(stock_thumb_nails_15min)
#             concurrent.futures.wait([chart_ink, thumb_nails])
#     except Exception as e:
#         print(f"An error occurred: {e}")
#         sys.exit(1)
#     finally:
#         # allow_sleep()
#         print_end_timestamp()
