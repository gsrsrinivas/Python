import pandas as pd
import requests
from bs4 import BeautifulSoup as bs


def chat_ink_excel_file_download():
    data = {
        'scan_clause': '( {cash} ( ( {cash} ( [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) and [0] 1 hour macd line( 26,12,9 ) >= [0] 1 hour macd signal( 26,12,9 ) and [0] 1 hour macd line( 26,12,9 ) >= [-1] 1 hour macd line( 26 , 12 , 9 ) and [0] 15 minute macd line( 26,12,9 ) >= [0] 15 minute macd signal( 26,12,9 ) and [0] 15 minute macd line( 26,12,9 ) >= [-1] 15 minute macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) and [0] 15 minute slow stochastic %k( 14 , 3 ) >= [-1] 15 minute slow stochastic %k( 14 , 3 ) ) ) or [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) ) and( {cash} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) and [0] 15 minute adx( 14 ) >= [-1] 15 minute adx( 14 ) ) ) and( {cash} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) and [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) ) and( {cash} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) and [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) and [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) and [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-15-minutes-of-triple-screen2')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish 15 Minutes of Triple Screen, Technical Analysis Scanner',
                  allow_duplicates=True)
        # print(df)
        df_15 = df
        # df.to_excel('C:/Users/gsrsr/Downloads/bullish-15-minutes-of-triple-screen.xlsx', index=False)

    print("complete bullish-15-minutes-of-triple-screen2")
    # ############################################################################################

    data = {
        'scan_clause': '( {cash} ( ( {cash} ( latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) and [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) and [0] 1 hour macd line( 26,12,9 ) >= [0] 1 hour macd signal( 26,12,9 ) and [0] 1 hour macd line( 26,12,9 ) >= [-1] 1 hour macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) and [0] 1 hour slow stochastic %k( 14 , 3 ) >= [-1] 1 hour slow stochastic %k( 14 , 3 ) ) ) or [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) ) and( {cash} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) and [0] 1 hour adx( 14 ) >= [-1] 1 hour adx( 14 ) ) ) and( {cash} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) and [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) and [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) and [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) and [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) and [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) ) and( {cash} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [-1] 1 hour upper bollinger band( 20 , 3 ) and [0] 1 hour lower bollinger band( 20 , 3 ) <= [-1] 1 hour lower bollinger band( 20 , 3 ) and [0] 1 hour upper bollinger band( 20 , 2 ) >= [-1] 1 hour upper bollinger band( 20 , 2 ) and [0] 1 hour lower bollinger band( 20 , 2 ) <= [-1] 1 hour lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-hourly-of-triple-screen1')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish Hourly of Triple Screen, Technical Analysis Scanner', allow_duplicates=True)
        # print(df)
        df_1 = df
        df_1 = pd.concat([df_1, df_15], ignore_index=True)
        # df_1.append(df_15, ignore_index=True)
        # df.to_excel('C:/Users/gsrsr/Downloads/bullish-hourly-of-triple-screen.xlsx', index=False)

    print("complete bullish-hourly-of-triple-screen1")
    # ############################################################################################

    data = {
        'scan_clause': '( {cash} ( ( {cash} ( weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) and latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) and [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) and [0] 4 hour slow stochastic %k( 14 , 3 ) >= [-1] 4 hour slow stochastic %k( 14 , 3 ) ) ) or [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) ) and( {cash} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) and [0] 4 hour adx( 14 ) >= [-1] 4 hour adx( 14 ) ) ) and( {cash} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) and [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) and [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) and [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) and [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) and [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) ) and( {cash} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [-1] 4 hour upper bollinger band( 20 , 3 ) and [0] 4 hour lower bollinger band( 20 , 3 ) <= [-1] 4 hour lower bollinger band( 20 , 3 ) and [0] 4 hour upper bollinger band( 20 , 2 ) >= [-1] 4 hour upper bollinger band( 20 , 2 ) and [0] 4 hour lower bollinger band( 20 , 2 ) <= [-1] 4 hour lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-4-hourly-of-triple-screen1')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish 4 Hourly of Triple Screen, Technical Analysis Scanner',
                  allow_duplicates=True)
        # print(df)
        df_4 = df
        df_4 = pd.concat([df_4, df_1], ignore_index=True)
        # df_4.append(df_1, ignore_index=True)
        # df.to_excel('C:/Users/gsrsr/Downloads/bullish-4-hourly-of-triple-screen.xlsx', index=False)

    print("complete bullish-4-hourly-of-triple-screen")
    # ############################################################################################

    data = {
        'scan_clause': '( {cash} ( ( {cash} ( monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) and weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) and latest macd line( 26,12,9 ) >= latest macd signal( 26,12,9 ) and latest macd line( 26,12,9 ) >= 1 day ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) and latest slow stochastic %k( 14 , 3 ) >= 1 day ago slow stochastic %k( 14 , 3 ) ) ) or latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) ) and( {cash} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) and latest adx( 14 ) >= 1 day ago adx( 14 ) ) ) and( {cash} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" and latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) and latest ema( latest close , 5 ) >= latest ema( latest close , 26 ) and latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) and latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) and latest ema( latest close , 50 ) >= latest ema( latest close , 200 ) and latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) ) and( {cash} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) and latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) and latest upper bollinger band( 20 , 2 ) > 1 day ago upper bollinger band( 20 , 2 ) and latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-daily-of-triple-screen-system1')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish Daily of Triple Screen System, Technical Analysis Scanner',
                  allow_duplicates=True)
        # print(df)
        df_d = df
        df_d = pd.concat([df_d, df_4], ignore_index=True)
        # df_d.append(df_4, ignore_index=True)
        # df.to_excel('C:/Users/gsrsr/Downloads/bullish-daily-of-triple-screen-system.xlsx', index=False)

    print("complete bullish-daily-of-triple-screen-system1")
    # ############################################################################################

    data = {
        'scan_clause': '( {cash} ( ( {cash} ( quarterly macd line( 26,12,9 ) >= quarterly macd signal( 26,12,9 ) and quarterly macd line( 26,12,9 ) >= 1 quarter ago macd line( 26 , 12 , 9 ) and monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) and weekly macd line( 26,12,9 ) >= weekly macd signal( 26,12,9 ) and weekly macd line( 26,12,9 ) >= 1 week ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) and weekly slow stochastic %k( 14 , 3 ) >= 1 week ago slow stochastic %k( 14 , 3 ) ) ) or weekly rsi( 14 ) >= 1 week ago rsi( 14 ) ) ) and( {cash} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) and weekly adx( 14 ) >= 1 week ago adx( 14 ) ) ) and( {cash} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" and weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) and weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 26 ) and weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) and weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) and weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 200 ) and weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) ) and( {cash} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) and weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) and weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) and weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-weekly-of-triple-screen1')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish Weekly of Triple Screen, Technical Analysis Scanner', allow_duplicates=True)
        # print(df)
        df_w = df
        df_w = pd.concat([df_w, df_d], ignore_index=True)
        # df_w.append(df_d, ignore_index=True)
        # df.to_excel('C:/Users/gsrsr/Downloads/bullish-weekly-of-triple-screen.xlsx', index=False)

    print("complete bullish-weekly-of-triple-screen1")
    # ############################################################################################

    data = {
        'scan_clause': '( {cash} ( ( {cash} ( yearly macd line( 26,12,9 ) >= yearly macd signal( 26,12,9 ) and yearly macd line( 26,12,9 ) >= 1 year ago macd line( 26 , 12 , 9 ) and quarterly macd line( 26,12,9 ) >= quarterly macd signal( 26,12,9 ) and quarterly macd line( 26,12,9 ) >= 1 quarter ago macd line( 26 , 12 , 9 ) and monthly macd line( 26,12,9 ) >= monthly macd signal( 26,12,9 ) and monthly macd line( 26,12,9 ) >= 1 month ago macd line( 26 , 12 , 9 ) ) ) and( {cash} ( ( {cash} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) and monthly slow stochastic %k( 14 , 3 ) >= 1 month ago slow stochastic %k( 14 , 3 ) ) ) or monthly rsi( 14 ) >= 1 month ago rsi( 14 ) ) ) and( {cash} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) and monthly adx( 14 ) >= 1 month ago adx( 14 ) ) ) and( {cash} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" and monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) and monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 26 ) and monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) and monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) and monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 200 ) and monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) ) and( {cash} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) and monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) and monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) and monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) ) ) )'
    }

    with requests.Session() as s:
        r = s.get('https://chartink.com/screener/bullish-monthly-of-triple-screen1')
        soup = bs(r.content, 'lxml')
        s.headers['X-CSRF-TOKEN'] = soup.select_one('[name=csrf-token]')['content']
        r = s.post('https://chartink.com/screener/process', data=data).json()
        df = pd.DataFrame(r['data'])
        # reorder columns
        df = df.iloc[:, [0, 2, 1, 3, 4, 5, 6]]
        # print(f"{df}")
        # Rename columns
        df.rename(
            columns={'sr': 'sno', 'name': 'stock_name', 'nsecode': 'symbol', 'per_chg': 'percent_change',
                     'close': 'price'}, inplace=True)
        # insert new column timeframe
        df.insert(7, 'TimeFrame', 'Bullish Monthly of Triple Screen, Technical Analysis Scanner', allow_duplicates=True)
        # print(df)
        df_m = df
        df_m = pd.concat([df_m, df_w], ignore_index=True)
        # df_m.append(df_w, ignore_index=True)
        # df_m.to_excel('C:/Users/gsrsr/Downloads/bullish-monthly-of-triple-screen.xlsx', index=False)
        df_m.to_excel('C:/Users/gsrsr/Downloads/bullish-triple-screen.xlsx', index=False)

    print("complete bullish-monthly-of-triple-screen")
    # ############################################################################################


if __name__ == "__main__":
    chat_ink_excel_file_download()
