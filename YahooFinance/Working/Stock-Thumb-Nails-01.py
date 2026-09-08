import matplotlib

matplotlib.use('Agg')  # Use a non-GUI backend
import matplotlib.pyplot as plt
import yfinance as yf
import os

symbols = ['HAL.NS', ]
thumb_dir = 'thumbnails'  # Folder to save thumbnails
os.makedirs(thumb_dir, exist_ok=True)  # Create thumbnails directory if it doesn't exist

for symbol in symbols:
    # Download historical data for the last 30 days
    data = yf.download(symbol, period='30d', interval='15m', auto_adjust=True)
    # Skip if no data
    if data.empty:
        continue
    # Plot closing price
    plt.figure(figsize=(2, 1.5))  # Small thumbnail size
    plt.plot(data['Close'], linewidth=1)
    plt.title(symbol, fontsize=8)
    plt.xticks([], [])
    plt.yticks([], [])
    plt.tight_layout()
    # Save thumbnail
    plt.savefig(os.path.join(thumb_dir, f'{symbol}.jpeg'), dpi=100, format='jpeg')
    plt.close()
