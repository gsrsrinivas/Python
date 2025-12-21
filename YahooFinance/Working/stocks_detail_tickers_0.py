import warnings
from concurrent.futures import as_completed

from yfinance.exceptions import YFRateLimitError  # available in recent versions

from _Common_Functions.base_functions import *

warnings.simplefilter(action='ignore', category=FutureWarning)


def fetch_symbol_with_retry(symbol, max_retries=5, base_delay=60):
    delay = base_delay
    for attempt in range(1, max_retries + 1):
        try:
            print(f"Fetching {symbol}, attempt {attempt}")
            # data = yf.download(symbol, period="1y", interval="1d")
            data = yf.Ticker(symbol)
            # optional: validate data here
            return data
        except YFRateLimitError as e:
            print(f"Rate limited for {symbol}: {e}. Sleeping {delay}s.")
            time.sleep(delay)
            delay *= 2  # exponential backoff
        except Exception as e:
            # other errors: decide if you want to retry or not
            print(f"Error for {symbol}: {e}")
            raise
    raise RuntimeError(f"Failed to fetch {symbol} after {max_retries} retries")


def fetch_ticker_data(symbol_row):
    """Fetch data for single symbol - thread-safe"""
    try:
        symbol_db, symbol_yf = symbol_row
        batch_no = datetime.now().strftime('%Y%m%d%H%M%S')

        # Try symbols in order
        symbols = [f"{symbol_db}.NS", f"{symbol_db}.BO", symbol_db, f"{symbol_yf}.NS", f"{symbol_yf}.BO", symbol_yf]
        ticker_data = None

        for sym in symbols:
            # ticker = yf.Ticker(sym)
            ticker = fetch_symbol_with_retry(sym)
            info = ticker.info
            if info and 'regularMarketPrice' in info:
                ticker_data = info.copy()
                ticker_data.update({
                    'symbol_db': symbol_db,
                    'symbol_yf': symbol_yf,
                    'batch_no': batch_no
                })
                break

        return ticker_data
    except:
        return None


def stock_details_yahoofinance():
    try:
        print_start_timestamp()
        print("Fetching stock data from Yahoo Finance...")

        with get_database_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("""select distinct ms.Symbol, ms.Symbol_YF from Stocks_Analysis.dbo.Master_Segments ms
            where ms.Symbol_YF is not null and ms.Symbol_YF <> ''
            order by 2 ASC;""")
            column_values = cursor.fetchall()
            total_stock = len(column_values)

        print(f"Total symbols to process: {total_stock}")

        # 1. PARALLEL PROCESSING - 5x speedup
        max_workers = min(100, total_stock)  # Adjust based on your system
        results = []

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            # Submit all tasks
            future_to_symbol = {
                executor.submit(fetch_ticker_data, row): row[1]
                for row in column_values
            }
            time.sleep(120)  # Initial sleep to avoid immediate rate limiting

            # Collect results as they complete
            for i, future in enumerate(as_completed(future_to_symbol), 1):
                symbol = future_to_symbol[future]
                try:
                    result = future.result()
                    if result:
                        results.append(result)
                        print(f"{i}/{total_stock}: ✅ {symbol}")
                    else:
                        print(f"{i}/{total_stock}: ❌ No data - {symbol}")
                except Exception as e:
                    print(f"{i}/{total_stock}: ⚠️ Error - {symbol}: {e}")

        # 2. SINGLE DataFrame creation - 3x speedup
        df = pd.DataFrame(results)

        # 3. Clean ONCE - before column selection
        if 'longBusinessSummary' in df.columns:
            df['longBusinessSummary'] = df['longBusinessSummary'].str.replace(',', ' ', regex=False)

        # Convert NaN to None ONCE
        df = df.where(pd.notna(df), None)
        # # Only clean object columns
        # obj_cols = df.select_dtypes(include=['object']).columns
        # df[obj_cols] = df[obj_cols].astype(str).str.replace(',', '', regex=False)
        # df[obj_cols] = df[obj_cols].apply(pd.to_numeric, errors='coerce')
        for col in df.columns:
            if df[col].dtype == 'object':
                try:
                    df[col] = df[col].str.replace(',', ' ', regex=False)
                except Exception as e:
                    print(f"Could not replace commas in column {col}: {e}")
                    continue

        # 4. Select columns FIRST (reduces memory)
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
        # df_selected = df.reindex(columns=df_selected.columns)
        common_cols = [col for col in df_selected.columns if col in df.columns]  # Get common columns only
        df_selected[common_cols] = df[common_cols].values
        # # 5. Clean numeric columns for SQL bulk load
        # numeric_cols = ['marketCap', 'regularMarketPrice', 'regularMarketChange', 'fiftyTwoWeekLowChange',
        #                 'fiftyTwoWeekLowChangePercent', 'fiftyTwoWeekHighChange', 'fiftyTwoWeekHighChangePercent',
        #                 'fiftyTwoWeekChangePercent', 'dividendRate', 'priceHint', 'previousClose', 'dayLow', 'dayHigh',
        #                 'regularMarketPreviousClose', 'regularMarketOpen', 'regularMarketDayLow',
        #                 'regularMarketDayHigh', 'earningsTimestamp', 'epsTrailingTwelveMonths', 'epsForward',
        #                 'epsCurrentYear', 'priceEpsCurrentYear', 'trailingPegRatio', 'maxAge', 'payoutRatio', 'beta',
        #                 'volume', 'fiftyTwoWeekLow', 'fiftyTwoWeekHigh', 'allTimeHigh', 'allTimeLow', 'fiftyDayAverage',
        #                 'twoHundredDayAverage', 'trailingAnnualDividendRate', 'trailingAnnualDividendYield',
        #                 'enterpriseValue', 'heldPercentInsiders', 'heldPercentInstitutions', 'bookValue',
        #                 'lastFiscalYearEnd', 'nextFiscalYearEnd', 'mostRecentQuarter', 'earningsQuarterlyGrowth',
        #                 'netIncomeToCommon', 'trailingEps', 'forwardEps', 'enterpriseToRevenue', 'enterpriseToEbitda',
        #                 'SandP52WeekChange', 'lastDividendValue', 'lastDividendDate', 'currentPrice', 'targetHighPrice',
        #                 'targetLowPrice', 'targetMeanPrice', 'targetMedianPrice', 'recommendationMean',
        #                 'numberOfAnalystOpinions', 'ebitda', 'quickRatio', 'currentRatio', 'debtToEquity',
        #                 'revenuePerShare', 'returnOnAssets', 'returnOnEquity', 'earningsGrowth', 'revenueGrowth',
        #                 'grossMargins', 'ebitdaMargins', 'operatingMargins', 'batch_no']
        # for col in numeric_cols:
        #     if col in df_selected.columns:
        #         df_selected[col] = (df_selected[col].astype(str)
        #                             .str.replace(',', '', regex=False)
        #                             .replace('None', 'NaN')
        #                             .pipe(pd.to_numeric, errors='coerce')
        #                             .fillna(0))
        file_path = chart_ink_to_csv(df_selected, "StockListFromYahoo", False)
        table_script_names = ["", "", "Master_Stock_Details"]
        insert_into_database_tables(table_script_names, bulk_file_path=file_path)
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # allow_sleep()
        print_end_timestamp()


if __name__ == "__main__":
    stock_details_yahoofinance()
