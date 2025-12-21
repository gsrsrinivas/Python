import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import List, Dict

import pandas as pd
import yfinance as yf
from requests.exceptions import HTTPError


def fetch_ticker_info_indefinite_429(symbol: str, base_delay: float = 2.0, max_attempts: int = 100) -> Dict[str, Dict]:
    """
    Fetch single ticker info with INDEFINITE 429 retry.
    Retries FOREVER until success or max_attempts reached.
    """
    attempt = 0

    while attempt < max_attempts:
        try:
            ticker = yf.Ticker(symbol)
            info = ticker.info

            # Check if response is valid
            if info and len(info) > 0:
                print(f"✅ {symbol} SUCCESS (attempt {attempt + 1})")
                return {symbol: info}

        except HTTPError as e:
            if e.response and e.response.status_code == 429:
                attempt += 1
                wait_time = base_delay * (1.5 ** min(attempt, 10))  # Progressive backoff, caps at ~2min
                print(
                    f"⏳ 429 {symbol} #{attempt}/{max_attempts}. Waiting {wait_time:.0f}s... (total wait: {attempt * base_delay:.0f}s)")
                time.sleep(wait_time)
                continue
            else:
                print(f"❌ HTTP {e.response.status_code if e.response else 'UNK'} for {symbol}")
                break

        except Exception as e:
            print(f"❌ Error {symbol}: {str(e)[:40]}")
            time.sleep(1.0)
            attempt += 1
            continue

    print(f"💥 {symbol} FAILED after {max_attempts} attempts (~{max_attempts * base_delay / 60:.1f}min)")
    return {symbol: {}}


def parallel_tickers_info_indefinite_retry(tickers: List[str], max_workers: int = 6, batch_size: int = 25) -> Dict[
    str, Dict]:
    """
    Parallel ticker info with INDEFINITE per-symbol 429 retry.
    Each symbol blocks its thread until 429 resolves or timeout.
    """
    all_info = {}
    lock = threading.Lock()

    for i in range(0, len(tickers), batch_size):
        batch = tickers[i:i + batch_size]
        print(f"\n🚀 Batch {i // batch_size + 1}: {len(batch)} symbols ({max_workers} workers)")

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            future_to_symbol = {executor.submit(fetch_ticker_info_indefinite_429, sym): sym for sym in batch}

            for future in as_completed(future_to_symbol):
                result = future.result()
                with lock:
                    all_info.update(result)

        print(f"✅ Batch {i // batch_size + 1} complete")
        if i + batch_size < len(tickers):
            time.sleep(3.0)  # Inter-batch cooldown

    return all_info


# Example usage - WILL NOT STOP UNTIL ALL SUCCEED
nse_symbols = [
    'IDFCFIRSTB.NS', 'CDSL.NS', 'ACC.NS', 'VEDL.NS',
    'RELIANCE.NS', 'TCS.NS', 'INFY.NS', 'HDFCBANK.NS'
]

print("🚀 Starting INDEFINITE 429 retry fetch...")
print("⚠️  This will run FOREVER until all symbols succeed or Ctrl+C")

try:
    info_data = parallel_tickers_info_indefinite_retry(nse_symbols, max_workers=4, batch_size=20)

    # Save results
    valid_info = {k: v for k, v in info_data.items() if v and len(v) > 0}
    df_info = pd.DataFrame(list(valid_info.values()))
    df_info.insert(0, 'symbol', list(valid_info.keys()))
    df_info.to_csv('ticker_info_indefinite_429.csv', index=False)
    print(f"\n🎉 ALL DONE! Saved {len(valid_info)}/{len(nse_symbols)} tickers")

except KeyboardInterrupt:
    print("\n⏹️  Stopped by user (Ctrl+C)")
