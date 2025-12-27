# import pandas as pd
# import yfinance as yf
# from requests.exceptions import HTTPError
# import time
# from concurrent.futures import ThreadPoolExecutor, as_completed

import sys
import threading
from concurrent.futures import as_completed
from pathlib import Path
from typing import List, Dict

sys.path.append(str(Path(__file__).resolve().parents[1])) # Get parent directory of current file # Add it to sys.path

from _Common_Functions.base_functions import *


def fetch_ticker_info_indefinite_429(symbol: str, position: int = None, total: int = None, base_delay: float = 5.0, max_attempts: int = 100) -> Dict[str, Dict]:
    """
    Fetch single ticker info with INDEFINITE 429 retry.
    Retries FOREVER until success or max_attempts reached.
    """
    attempt = 0

    while attempt < max_attempts:
        pos_text = f"{position}/{total}" if position is not None and total is not None else ""
        try:
            ticker = yf.Ticker(symbol)
            info = ticker.info

            # Check if response is valid
            if info and len(info) > 0:
                print(f"✅ {pos_text:<4}:{symbol:<20} SUCCESS (attempt {attempt + 1})")
                return {symbol: info}

        except Exception as e:
            if "Too Many Requests. Rate limited." in str(e):
                # Simulate HTTPError for 429
                # e = HTTPError(response=type('obj', (object,), {'status_code': 429})())
                attempt += 1
                wait_time = base_delay * (1.5 ** min(attempt, 10))  # Progressive backoff, caps at ~2min
                print(f"⏳ 429 {pos_text:<4}:{symbol:<20} #{attempt}/{max_attempts}. Waiting {wait_time:.0f}s... (total wait: {attempt * base_delay:.0f}s)")
                time.sleep(wait_time)
                continue
            else:
                print(f"❌ Error {symbol}: {str(e)[:40]}")
                break


    print(f"💥 {symbol} FAILED after {max_attempts} attempts (~{max_attempts * base_delay / 60:.1f}min)")
    return {symbol: {}}


def parallel_tickers_info_indefinite_retry(tickers: List[str], max_workers: int = 6, batch_size: int = 25) -> Dict[str, Dict]:
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
            for j, sym in enumerate(batch):
                global_idx = i + j + 1
                future_to_symbol = {executor.submit(fetch_ticker_info_indefinite_429, sym, global_idx, len(tickers))}

            for future in as_completed(future_to_symbol):
                result = future.result()
                with lock:
                    all_info.update(result)

        print(f"✅ Batch {i // batch_size + 1} complete")
        if i + batch_size < len(tickers):
            time.sleep(3.0)  # Inter-batch cooldown

    return all_info


def save_to_file_and_insert_into_db(df: pd.DataFrame):
    df = df.where(pd.notna(df), None)
    for col in df.columns:
        if df[col].dtype == 'object':
            try:
                df[col] = df[col].str.replace(',', ' ', regex=False)
            except Exception as e:
                print(f"Could not replace commas in column {col}: {e}")
                continue

    selected_columns = ['symbol_db', 'sector', 'sectorKey', 'sectorDisp', 'industry', 'industryKey', 'industryDisp',
                        'marketCap', 'regularMarketPrice', 'regularMarketChange', 'regularMarketDayRange',
                        'fiftyTwoWeekLowChange', 'fiftyTwoWeekLowChangePercent', 'fiftyTwoWeekRange',
                        'fiftyTwoWeekHighChange', 'fiftyTwoWeekHighChangePercent', 'fiftyTwoWeekChangePercent',
                        'dividendYield', 'trailingPE', 'forwardPE', 'totalRevenue', 'grossProfits', 'profitMargins',
                        'priceToBook', 'recommendationKey', 'averageAnalystRating', 'website', 'shortName',
                        'longName',
                        'quoteType', 'quoteSourceName', 'typeDisp', 'tradeable', 'exchange', 'fullExchangeName',
                        'market', 'dividendRate', 'priceHint', 'previousClose', 'dayLow', 'dayHigh',
                        'regularMarketPreviousClose', 'regularMarketOpen', 'regularMarketDayLow',
                        'regularMarketDayHigh', 'earningsTimestamp', 'epsTrailingTwelveMonths', 'epsForward',
                        'epsCurrentYear', 'priceEpsCurrentYear', 'cryptoTradeable', 'marketState',
                        'corporateActions',
                        'trailingPegRatio', 'city', 'country', 'region', 'currency',
                        'lastSplitFactor', 'lastSplitDate', 'exDividendDate', 'maxAge', 'payoutRatio', 'beta',
                        'volume',
                        'fiftyTwoWeekLow', 'fiftyTwoWeekHigh', 'allTimeHigh', 'allTimeLow', 'fiftyDayAverage',
                        'twoHundredDayAverage', 'trailingAnnualDividendRate', 'trailingAnnualDividendYield',
                        'enterpriseValue', 'heldPercentInsiders', 'heldPercentInstitutions', 'bookValue',
                        'lastFiscalYearEnd', 'nextFiscalYearEnd', 'mostRecentQuarter', 'earningsQuarterlyGrowth',
                        'netIncomeToCommon', 'trailingEps', 'forwardEps', 'enterpriseToRevenue',
                        'enterpriseToEbitda',
                        'SandP52WeekChange', 'lastDividendValue', 'lastDividendDate', 'currentPrice',
                        'targetHighPrice',
                        'targetLowPrice', 'targetMeanPrice', 'targetMedianPrice', 'recommendationMean',
                        'numberOfAnalystOpinions', 'ebitda', 'quickRatio', 'currentRatio', 'debtToEquity',
                        'revenuePerShare', 'returnOnAssets', 'returnOnEquity', 'earningsGrowth', 'revenueGrowth',
                        'grossMargins', 'ebitdaMargins', 'operatingMargins', 'messageBoardId', 'financialCurrency',
                        'triggerable', 'customPriceAlertConfidence', 'exchangeTimezoneName',
                        'exchangeTimezoneShortName', 'hasPrePostMarketData', 'batch_no', 'symbol_yf',
                        'created_datetime']
    df_selected = pd.DataFrame(columns=selected_columns)
    df_selected = df.reindex(columns=df_selected.columns)
    common_cols = [col for col in df_selected.columns if col in df.columns]  # Get common columns only
    df_selected[common_cols] = df[common_cols].values

    file_path = chart_ink_to_csv(df_selected, "stock_detail_tickers_1", False)
    table_script_names = ["", "", "Master_Stock_Details"]
    insert_into_database_tables(table_script_names, bulk_file_path=file_path)


def stock_detail_tickers_1():
    # setup_logger(__file__, f"daily_{Path(__file__).stem}.log")
    print_start_timestamp()
    print("Fetching stock data from Yahoo Finance...")
    with get_database_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(""" 
            select distinct ms.Symbol, ms.Symbol_YF + isnull(ms.extension,'')  
            from Stocks_Analysis.dbo.Master_Segments ms
            where ms.extension is not null
            order by 1 ASC;
        """)
        database_symbols = cursor.fetchall()
    nse_symbol = []
    for db_sym in database_symbols:
        nse_symbol.extend([db_sym[0] + '.NS'])
        if db_sym[1] and db_sym[1] != db_sym[0] and db_sym[1].strip() != '' and db_sym[1].upper() != 'N/A' and db_sym[1] is not None:
            nse_symbol.extend([db_sym[1]])
    print(f"after consolidating all values from database: {len(nse_symbol)}")
    nse_symbols = list(set(nse_symbol))  # Optional: Remove duplicates if any
    print(f"after removing duplicates: {len(nse_symbols)}")
    # Example usage - WILL NOT STOP UNTIL ALL SUCCEED
    nse_symbols.sort()
    print("🚀 Starting INDEFINITE 429 retry fetch...")
    print("⚠️  This will run FOREVER until all symbols succeed or Ctrl+C")

    try:
        info_data = parallel_tickers_info_indefinite_retry(nse_symbols, max_workers=4, batch_size=20) # changed from 4 workers to 8 and 20 batch size to 50
        # Save results
        valid_info = {k: v for k, v in info_data.items() if v and len(v) > 0}
        df = pd.DataFrame(list(valid_info.values()))
        save_to_file_and_insert_into_db(df)
        print(f"\n🎉 ALL DONE! Saved {len(valid_info)}/{len(nse_symbols)} tickers")
    except KeyboardInterrupt:
        print("\n⏹️  Stopped by user (Ctrl+C)")
    finally:
        # allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    stock_detail_tickers_1()
