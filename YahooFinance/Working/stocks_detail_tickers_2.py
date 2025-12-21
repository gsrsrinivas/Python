from typing import List, Dict

from _Common_Functions.base_functions import *


def batch_tickers_info(tickers: List[str], batch_size: int = 50, delay: float = 0.2) -> Dict[str, Dict]:
    """
    Batch download ticker info using yf.Tickers to avoid rate limits.
    Splits large lists into batches of batch_size symbols.

    Args:
        tickers: List of symbols (e.g., ['IDFCFIRSTB.NS', 'CDSL.NS'])
        batch_size: Symbols per request (50-100 safe)
        delay: Seconds between batches

    Returns:
        Dict of {symbol: ticker.info}
    """
    all_info = {}

    for i in range(0, len(tickers), batch_size):
        batch = tickers[i:i + batch_size]
        print(f"Fetching batch {i // batch_size + 1}: {len(batch)} symbols")

        try:
            tickers_obj = yf.Tickers(' '.join(batch))
            batch_info = tickers_obj.tickers

            for symbol in batch:
                if symbol in batch_info:
                    all_info[symbol] = batch_info[symbol].info
                else:
                    print(f"Failed to fetch {symbol}")

        except Exception as e:
            print(f"Batch error: {e}")

        if i + batch_size < len(tickers):
            time.sleep(delay)

    return all_info


def save_ticker_info_to_csv(ticker_info: Dict[str, Dict], filename: str):
    """
    Save ticker info dictionary to a CSV file.

    Args:
        ticker_info: Dict of {symbol: ticker.info}
        filename: Output CSV filename
    """
    df = pd.DataFrame([info for info in ticker_info.values() if info])
    df.to_csv(filename, index=False)
    print(f"Saved {len(df)} tickers to {filename}")


def stocks_detail_tickers():
    try:
        print_start_timestamp()
        print("Fetching stock data from Yahoo Finance...")

        with get_database_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("""select distinct ms.Symbol, ms.Symbol_YF from Stocks_Analysis.dbo.Master_Segments ms;""")
            database_symbols = cursor.fetchall()
            total_stock = len(database_symbols)

        print(f"Total symbols to process: {total_stock}")
        # Example usage for your NSE stocks
        nse_symbols = [
            sym[1] for sym in database_symbols
            if sym[1] and sym[1].endswith('.NS')
        ]
        info_data = batch_tickers_info(nse_symbols, batch_size=50, delay=0.2)
        save_ticker_info_to_csv(info_data, 'nse_ticker_info.csv')
        # # Save to DataFrame
        # df_info = pd.DataFrame([info_data[sym] for sym in info_data if info_data[sym]])
        # df_info.to_csv('ticker_info.csv', index=False)
        # print(f"Saved {len(df_info)} tickers to ticker_info.csv")
    except Exception as e:
        print(f"Database error: {e}")
        return


if __name__ == "__main__":
    stocks_detail_tickers()
