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
        print(f"Processing: {row[0]}")
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

    df['symbol'] = df['symbol'].str.replace('.NS', '', regex=False).replace('.BO', '', regex=False)
    df['longBusinessSummary'] = df['longBusinessSummary'].str.replace(',', ' ', regex=False)
    selected_columns = ['symbol','sector','sectorKey','sectorDisp','industry','industryKey','industryDisp','marketCap','regularMarketPrice','regularMarketChange','regularMarketDayRange','fiftyTwoWeekLowChange','fiftyTwoWeekLowChangePercent','fiftyTwoWeekRange','fiftyTwoWeekHighChange','fiftyTwoWeekHighChangePercent','fiftyTwoWeekChangePercent','dividendYield','trailingPE','forwardPE','totalRevenue','grossProfits','profitMargins','priceToBook','recommendationKey','averageAnalystRating','website','shortName','longName','quoteType','quoteSourceName','typeDisp','tradeable','exchange','fullExchangeName','market','dividendRate','priceHint','previousClose','dayLow','dayHigh','regularMarketPreviousClose','regularMarketOpen','regularMarketDayLow','regularMarketDayHigh','earningsTimestamp','epsTrailingTwelveMonths','epsForward','epsCurrentYear','priceEpsCurrentYear','cryptoTradeable','marketState','corporateActions','trailingPegRatio','city','country','region','longBusinessSummary','currency','lastSplitFactor','lastSplitDate','exDividendDate','maxAge','payoutRatio','beta','volume','fiftyTwoWeekLow','fiftyTwoWeekHigh','allTimeHigh','allTimeLow','fiftyDayAverage','twoHundredDayAverage','trailingAnnualDividendRate','trailingAnnualDividendYield','enterpriseValue','heldPercentInsiders','heldPercentInstitutions','bookValue','lastFiscalYearEnd','nextFiscalYearEnd','mostRecentQuarter','earningsQuarterlyGrowth','netIncomeToCommon','trailingEps','forwardEps','enterpriseToRevenue','enterpriseToEbitda','SandP52WeekChange','lastDividendValue','lastDividendDate','currentPrice','targetHighPrice','targetLowPrice','targetMeanPrice','targetMedianPrice','recommendationMean','numberOfAnalystOpinions','ebitda','quickRatio','currentRatio','debtToEquity','revenuePerShare','returnOnAssets','returnOnEquity','earningsGrowth','revenueGrowth','grossMargins','ebitdaMargins','operatingMargins','messageBoardId','financialCurrency','triggerable','customPriceAlertConfidence','exchangeTimezoneName','exchangeTimezoneShortName','hasPrePostMarketData']
    df_selected = df.loc[:, selected_columns]
    batch_no = datetime.now().strftime('%Y%m%d%H%M%S')
    print("batch_no:", batch_no)
    df_selected['Batch_No'] = batch_no  # Add batch number to the DataFrame

    file_path = chart_ink_to_csv(df_selected, "StockListFromYahoo")
    table_script_names = ["","","Master_Stock_Details"]
    insert_into_database_tables(table_script_names, bulk_file_path=file_path)

except Exception as e:
    print(f"An error occurred: {e}")
finally:
    # allow_sleep()
    print_end_timestamp()
