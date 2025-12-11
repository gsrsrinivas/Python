# stock data details from yahoo finance
import warnings

from _Common_Functions.base_functions import *

# Suppress only the specific FutureWarning related to concatenation
warnings.simplefilter(action='ignore', category=FutureWarning)


def stock_details_yahoofinance():
    try:
        print_start_timestamp()
        print("Fetching stock data from Yahoo Finance...")

        df = pd.DataFrame()
        with get_database_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(""" select distinct ms.Symbol ,ms.Symbol_YF from Stocks_Analysis.dbo.Master_Segments ms
            -- where ms.Symbol_YF is not null and ms.Symbol_YF <> '' 
            order by 2 ASC; """)
            column_values  = cursor.fetchall()

        total_stock = len(column_values)
        batch_no = datetime.now().strftime('%Y%m%d%H%M%S')
        print(f"Total symbols to process: {total_stock}")
        for i,symbol in enumerate(column_values, start=1):
            if i % 500 == 0:
                print("Sleeping for 2 minutes...")
                time.sleep(120)  # 120 seconds = 2 minutes
            for sym in symbol:
                try:
                    if sym is None or sym.strip() == '':
                        continue
                    print(f"{i} out of {total_stock}: Processing: {sym}")
                    sym  = sym + '.NS'
                    ticker = safe_ticker(sym)
                    if not ticker.info or 'regularMarketPrice' not in ticker.info:
                        sym = sym.replace('.NS', '.BO')
                        ticker = safe_ticker(sym)
                        if not ticker.info or 'regularMarketPrice' not in ticker.info:
                            sym = sym.replace('.BO', '')
                            ticker = safe_ticker(sym)
                            if not ticker.info or 'regularMarketPrice' not in ticker.info:
                                print(f"No data found for symbol: {sym}")
                                continue
                            else:
                                break_for_loop = 1
                        else:
                            break_for_loop = 1
                    else:
                        break_for_loop = 1
                    df1 = pd.DataFrame([ticker.info])
                    df2 = pd.DataFrame([{'symbol_db': symbol[0], 'symbol_yf': symbol[1], 'batch_no': batch_no}])
                    df = pd.concat([df, pd.concat([df1, df2], axis=1)], axis=0, ignore_index=True)
                    if break_for_loop == 1:
                        break
                except Exception as e:
                    print(f"Error processing symbol: {sym} - {e}")
                    continue

            # below code is giving message for each symbol which is not required
            # for sym in symbol:
            #     try:
            #         if sym is None or sym.strip() == '':
            #             continue
            #         print(f"{i} out of {total_stock}: Processing: {sym}")
            #         ticker = safe_ticker(sym)
            #         if not ticker.info or 'regularMarketPrice' not in ticker.info:
            #             print(f"No data found for symbol: {sym}")
            #             continue
            #         df1 = pd.DataFrame([ticker.info])
            #         df2 = pd.DataFrame([{'symbol_db': symbol[2], 'symbol_yf': symbol[5], 'batch_no': batch_no}])
            #         df = pd.concat([df, pd.concat([df1, df2], axis=1)], axis=0, ignore_index=True)
            #     except Exception as e:
            #         print(f"Error processing symbol: {sym} - {e}")
            #         continue

            # below code is checking only 1 column fetched from db which is not sufficient
            # symbol_ns = symbol[1] + ".NS"
            # symbol_bo = symbol[1] + ".BO"
            # print(f"{i} out of {total_stock}: Processing: {symbol[1]}")
            # try:
            #     ticker = safe_ticker(symbol_ns)
            #     if not ticker.info or 'regularMarketPrice' not in ticker.info:
            #         ticker = safe_ticker(symbol_bo)
            #         if not ticker.info or 'regularMarketPrice' not in ticker.info:
            #             ticker = safe_ticker(symbol[1])
            #             if not ticker.info or 'regularMarketPrice' not in ticker.info:
            #                 print(f"No data found for symbol: {symbol[1]}")
            #                 continue
            #     df1 = pd.DataFrame([ticker.info])
            #     df2 = pd.DataFrame([{'symbol_db': symbol[0], 'symbol_yf': symbol[1], 'batch_no': batch_no}])
            #     df = pd.concat([df, pd.concat([df1, df2], axis=1)], axis=0, ignore_index=True)
            # except:
            #     print(f"Error processing symbol: {symbol[1]} - {e}")
            #     continue
        df = df.where(pd.notna(df), None)
        for col in df.columns:
            if df[col].dtype == 'object':
                try:
                    df[col] = df[col].str.replace(',', ' ', regex=False)
                except Exception as e:
                    print(f"Could not replace commas in column {col}: {e}")
                    continue
        # df['longBusinessSummary'] = df['longBusinessSummary'].str.replace(',', ' ', regex=False)

        selected_columns = ['symbol_db', 'sector', 'sectorKey', 'sectorDisp', 'industry', 'industryKey', 'industryDisp',
                            'marketCap', 'regularMarketPrice', 'regularMarketChange', 'regularMarketDayRange',
                            'fiftyTwoWeekLowChange', 'fiftyTwoWeekLowChangePercent', 'fiftyTwoWeekRange',
                            'fiftyTwoWeekHighChange', 'fiftyTwoWeekHighChangePercent', 'fiftyTwoWeekChangePercent',
                            'dividendYield', 'trailingPE', 'forwardPE', 'totalRevenue', 'grossProfits', 'profitMargins',
                            'priceToBook', 'recommendationKey', 'averageAnalystRating', 'website', 'shortName', 'longName',
                            'quoteType', 'quoteSourceName', 'typeDisp', 'tradeable', 'exchange', 'fullExchangeName',
                            'market', 'dividendRate', 'priceHint', 'previousClose', 'dayLow', 'dayHigh',
                            'regularMarketPreviousClose', 'regularMarketOpen', 'regularMarketDayLow',
                            'regularMarketDayHigh', 'earningsTimestamp', 'epsTrailingTwelveMonths', 'epsForward',
                            'epsCurrentYear', 'priceEpsCurrentYear', 'cryptoTradeable', 'marketState', 'corporateActions',
                            'trailingPegRatio', 'city', 'country', 'region', 'currency',
                            'lastSplitFactor', 'lastSplitDate', 'exDividendDate', 'maxAge', 'payoutRatio', 'beta', 'volume',
                            'fiftyTwoWeekLow', 'fiftyTwoWeekHigh', 'allTimeHigh', 'allTimeLow', 'fiftyDayAverage',
                            'twoHundredDayAverage', 'trailingAnnualDividendRate', 'trailingAnnualDividendYield',
                            'enterpriseValue', 'heldPercentInsiders', 'heldPercentInstitutions', 'bookValue',
                            'lastFiscalYearEnd', 'nextFiscalYearEnd', 'mostRecentQuarter', 'earningsQuarterlyGrowth',
                            'netIncomeToCommon', 'trailingEps', 'forwardEps', 'enterpriseToRevenue', 'enterpriseToEbitda',
                            'SandP52WeekChange', 'lastDividendValue', 'lastDividendDate', 'currentPrice', 'targetHighPrice',
                            'targetLowPrice', 'targetMeanPrice', 'targetMedianPrice', 'recommendationMean',
                            'numberOfAnalystOpinions', 'ebitda', 'quickRatio', 'currentRatio', 'debtToEquity',
                            'revenuePerShare', 'returnOnAssets', 'returnOnEquity', 'earningsGrowth', 'revenueGrowth',
                            'grossMargins', 'ebitdaMargins', 'operatingMargins', 'messageBoardId', 'financialCurrency',
                            'triggerable', 'customPriceAlertConfidence', 'exchangeTimezoneName',
                            'exchangeTimezoneShortName', 'hasPrePostMarketData', 'batch_no', 'symbol_yf']
        df_selected = pd.DataFrame(columns=selected_columns)
        # df_selected = df.reindex(columns=df_selected.columns)
        # Get common columns only
        common_cols = [col for col in df_selected.columns if col in df.columns]
        df_selected[common_cols] = df[common_cols].values
        # df_selected = df.loc[:, selected_columns]
        file_path = chart_ink_to_csv(df_selected, "StockListFromYahoo",False)
        table_script_names = ["","","Master_Stock_Details"]
        insert_into_database_tables(table_script_names, bulk_file_path=file_path)
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # allow_sleep()
        print_end_timestamp()

if __name__ == "__main__":
    stock_details_yahoofinance()

