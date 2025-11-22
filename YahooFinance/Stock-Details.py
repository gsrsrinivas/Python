# stock data details from yahoo finance
import warnings

import yfinance as yf

from _Common_Functions.base_functions import *

# Suppress only the specific FutureWarning related to concatenation
warnings.simplefilter(action='ignore', category=FutureWarning)

try:
    print_start_timestamp()
    print("Fetching stock data from Yahoo Finance...")

    df = pd.DataFrame()
    with get_database_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""select distinct cs.symbol from Stocks_analysis.dbo.Cash_Stocks cs 
        where batch_no = (select max(batch_no) from Stocks_analysis.dbo.Cash_Stocks)
        order by 1 ASC;""")
        column_values  = cursor.fetchall()

    for row in column_values:
        symbol_ns = row[0] + ".NS"
        symbol_bo = row[0] + ".BO"
        print(f"Processing symbol: {row[0]}")
        try:
            ticker = yf.Ticker(symbol_ns)
            if not ticker.info or 'regularMarketPrice' not in ticker.info:
                ticker = yf.Ticker(symbol_bo)
                if not ticker.info or 'regularMarketPrice' not in ticker.info:
                    print(f"No data found for symbol: {row[0]}")
                    continue
            df1 = pd.DataFrame([ticker.info])
            df = pd.concat([df, df1], ignore_index=True)
        except:
            print(f"Error processing symbol: {row[0]}")
            continue

    df.to_csv(r"C:\Users\gsrsr\Downloads\StockListFromYahoo.csv", index=False)
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    # allow_sleep()
    print_end_timestamp()
