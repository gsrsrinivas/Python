import yfinance as yf
import pandas as pd
import numpy as np
from scipy.signal import argrelextrema
import matplotlib
matplotlib.rcParams['figure.max_open_warning'] = 100  # or any number you prefer
matplotlib.use('Agg')  # Use a non-GUI backend # Ensure matplotlib uses a non-GUI backend to avoid display issues in headless environments
import matplotlib.pyplot as plt

def find_double_top(df, order=8, tolerance=0.03):
    # Find local maxima and minima
    maxima_idx = argrelextrema(df['Close'].values, np.greater_equal, order=order)[0]
    minima_idx = argrelextrema(df['Close'].values, np.less_equal, order=order)[0]

    patterns = []
    for i in range(len(maxima_idx) - 1):
        first_top = maxima_idx[i]
        second_top = maxima_idx[i + 1]
        if second_top - first_top < order:  # Avoid overlapping peaks
            continue
        trough_range = minima_idx[(minima_idx > first_top) & (minima_idx < second_top)]
        if len(trough_range) == 0:
            continue  # Need a trough between two tops
        trough = trough_range[0]
        price1 = float(df['Close'].iloc[first_top].iloc[0]) if isinstance(df['Close'].iloc[first_top],pd.Series) else float(df['Close'].iloc[first_top])
        price2 = float(df['Close'].iloc[second_top].iloc[0]) if isinstance(df['Close'].iloc[second_top],pd.Series) else float(df['Close'].iloc[second_top])
        trough_price = float(df['Close'].iloc[trough].iloc[0]) if isinstance(df['Close'].iloc[trough],pd.Series) else float(df['Close'].iloc[trough])

        # Check price proximity of peaks
        if abs(price1 - price2) / max(price1, price2) <= tolerance:
            patterns.append({
                "first_top_idx": first_top,
                "trough_idx": trough,
                "second_top_idx": second_top,
                "price1": price1,
                "trough_price": trough_price,
                "price2": price2,
                "first_top_date": df.index[first_top],
                "trough_date": df.index[trough],
                "second_top_date": df.index[second_top],
            })
    return patterns


# Parameters
ticker = 'TCS.NS'  # e.g., 'RELIANCE.NS' for NSE India
start_date = '2024-01-01'
end_date = '2025-08-08'

# Download historical stock data
df = yf.download(ticker, start=start_date, end=end_date, auto_adjust=True, progress=False)
if df.empty:
    print("No data downloaded. Please check the ticker and dates.")
else:
    # Find double tops
    patterns = find_double_top(df)

    # Print detected double tops
    if not patterns:
        print("No double top patterns found.")
    else:
        # print(f"Found {len(patterns)} double top patterns:\n")
        # for idx, p in enumerate(patterns, 1):
        #     print(f"Pattern {idx}:")
        #     print(f"  First Top : {p['first_top_date']} @ {p['price1']:.2f}")
        #     print(f"  Trough    : {p['trough_date']} @ {p['trough_price']:.2f}")
        #     print(f"  Second Top: {p['second_top_date']} @ {p['price2']:.2f}")
        #     print("-" * 40)

        # # Example: Plotting last detected double top pattern
        # last_pattern = patterns[-1]
        # fig = plt.figure(figsize=(12, 6))  # Small thumbnail size
        # plt.plot(df['Close'], linewidth=1)
        # # plt.title(f"{symbol_name.replace(".NS", "")}-{interval_value}-{period_value}", fontsize=8)
        # plt.xticks([], [])
        # plt.yticks([], [])
        # plt.tight_layout()
        # plt.savefig(f'Reliance.ns.png', dpi=100, format='png')
        # plt.close(fig)  # Close the figure to free memory

        last_pattern = patterns[-1]
        # plt.figure(figsize=(14, 7))
        # df.index = pd.to_datetime(df.index)
        # plt.plot(df.index, df['Close'], label='Close Price', linewidth=2)
        # # plt.plot(df['Close'], label='Close Price')
        # plt.xticks(rotation=45)
        # # plt.xticks([], [])
        # # plt.yticks([], [])
        # plt.scatter([df.index[last_pattern["first_top_idx"]],
        #              df.index[last_pattern["trough_idx"]],
        #              df.index[last_pattern["second_top_idx"]]],
        #             [last_pattern["price1"], last_pattern["trough_price"], last_pattern["price2"]],
        #             color='red', s=120, label='Double Top Points', zorder=5)
        # plt.title('Double Top Pattern Detected')
        # plt.title('Double Top Pattern Detected', fontsize=16)
        # plt.xlabel('Date', fontsize=14)
        # plt.ylabel('Close Price', fontsize=14)
        # plt.legend(fontsize=12)
        # plt.grid(True)
        # plt.xlabel('Date')
        # plt.ylabel('Close Price')
        # plt.legend()
        # plt.tight_layout()
        # plt.savefig('Reliance.ns.png')  # <-- save the file
        # plt.close()
        # print('Saved plot as Reliance.ns.png')

        plt.figure(figsize=(14, 7))
        plt.plot(df.index, df['Close'], label='Close Price', linewidth=2)
        plt.scatter(
            [df.index[last_pattern["first_top_idx"]],
             df.index[last_pattern["trough_idx"]],
             df.index[last_pattern["second_top_idx"]]],
            [last_pattern["price1"], last_pattern["trough_price"], last_pattern["price2"]],
            color='red', s=120, label='Double Top Points', zorder=5
        )
        plt.title('Double Top Pattern Detected', fontsize=16)
        plt.xlabel('Date', fontsize=14)
        plt.ylabel('Close Price', fontsize=14)
        plt.legend(fontsize=12)
        plt.grid(True)
        plt.xticks(rotation=45)
        for idx in [last_pattern["first_top_idx"], last_pattern["trough_idx"], last_pattern["second_top_idx"]]:
            plt.axvline(df.index[idx], color='gray', linestyle='--', alpha=0.6)
        plt.tight_layout()
        plt.savefig(ticker + '.png')
        plt.close()
