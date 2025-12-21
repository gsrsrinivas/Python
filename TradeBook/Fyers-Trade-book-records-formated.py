from pathlib import Path

import pandas as pd


def get_input_folder_path():
    input_file = r'C:\Users\gsrsr\Downloads\Fyers'  # Replace with your file path
    return input_file


def get_output_file_path():
    output_file = r'C:\Users\gsrsr\Downloads\Fyers\processed_file.xlsx'  # Replace with your file path
    return output_file


def read_all_files_into_dataframe():
    input_folder = get_input_folder_path()
    df_all = df = pd.DataFrame()
    dir_path = Path(input_folder)
    file_type = f"*.*"  # You can change this to "*.csv" if needed
    for file_name in dir_path.glob(file_type):
        input_file = file_name
        print(f"Processing file: {input_file}")
        if input_file.suffix == '.csv':
            df = pd.read_csv(input_file)
        elif input_file.suffix in ['.xls', '.xlsx']:
            df = pd.read_excel(input_file, engine='openpyxl')
        else:
            print(f"Unsupported file type: {input_file.suffix}")
        df_all = pd.concat([df_all, df], ignore_index=True)
    return df_all


def process_dataframe(df):
    df['date'] = pd.to_datetime(df['date'], format='%d-%m-%Y')
    buys = df[df['type'] == 'BUY'].copy().reset_index(drop=True)
    sells = df[df['type'] == 'SELL'].copy()
    output_df = []
    # Group sells by symbol and reset index for positional access
    sells_grouped = sells.groupby('symbol')
    for symbol, buys_sub in buys.groupby('symbol'):
        sells_sub = sells_grouped.get_group(symbol).copy().reset_index(
            drop=True) if symbol in sells_grouped.groups else pd.DataFrame(columns=sells.columns)
        sell_pointer = 0
        for _, buy_row in buys_sub.iterrows():
            remain_buy = buy_row['qty']

            while remain_buy > 0 and sell_pointer < len(sells_sub):
                sell_row = sells_sub.iloc[sell_pointer]
                remain_sell = sell_row['qty']
                if remain_sell == 0 or sell_row['date'] < buy_row['date']:
                    sell_pointer += 1
                    continue
                matched = min(remain_buy, remain_sell)
                output_df.append({
                    'symbol': symbol,
                    'Buy trade_price': buy_row['trade_price'],
                    'Buy qty': matched,
                    'Sell trade_price': sell_row['trade_price'],
                    'Sell qty': matched,
                    'Buy date': buy_row['date'].strftime('%d-%b-%y'),
                    'Sell date': sell_row['date'].strftime('%d-%b-%y'),
                    'Account': buy_row.get('Account', ''),
                    'Buy Exch': buy_row.get('segment', ''),
                    'Sell Exch': sell_row['segment'],
                    'Sgmt': '',
                })

                remain_buy -= matched
                sells_sub.at[sell_pointer, 'qty'] -= matched
                if sells_sub.at[sell_pointer, 'qty'] == 0:
                    sell_pointer += 1

            if remain_buy > 0:
                output_df.append({
                    'symbol': symbol,
                    'Buy trade_price': buy_row['trade_price'],
                    'Buy qty': remain_buy,
                    'Sell trade_price': '',
                    'Sell qty': '',
                    'Buy date': buy_row['date'].strftime('%d-%b-%y'),
                    'Sell date': '',
                    'Account': buy_row.get('Account', ''),
                    'Buy Exch': buy_row.get('segment', ''),
                    'Sell Exch': '',
                    'Sgmt': '',
                })
    return output_df


def format_trade_book():
    df = read_all_files_into_dataframe()
    output_df = process_dataframe(df)
    out_df = pd.DataFrame(output_df)
    out_df.loc[(out_df['Account'] == ''), ['Account', ]] = ['Fyers', ]
    out_df.loc[(out_df['Buy Exch'] == 'NSE_CASH'), ['Buy Exch', ]] = ['NSE', ]
    out_df.loc[(out_df['Sell Exch'] == 'NSE_CASH'), ['Sell Exch', ]] = ['NSE', ]

    out_df.loc[(out_df['Buy Exch'] == 'MCX') & (out_df['symbol'].str.contains('CF')), ['Sgmt', ]] = ['ComOpt', ]

    out_df.loc[(out_df['Sell Exch'] == 'MCX') & (out_df['symbol'].str.contains('PE')), ['Sgmt', ]] = ['ComOpt', ]
    out_df.loc[(out_df['Buy Exch'] == 'MCX') & (out_df['symbol'].str.contains('CE')), ['Sgmt', ]] = ['ComOpt', ]
    out_df.loc[(out_df['Buy Exch'] == 'MCX') & (out_df['symbol'].str.contains('FUT')), ['Sgmt', ]] = ['ComFut', ]

    out_df.loc[
        (out_df['Buy Exch'].str.contains('SE')) & (out_df['symbol'].str.contains('FUT')) & (out_df['Sgmt'] == 'FO'), [
            'Sgmt', ]] = ['Fut', ]
    out_df.loc[
        (out_df['Buy Exch'].str.contains('SE')) & (out_df['symbol'].str.contains('PE')) & (out_df['Sgmt'] == 'FO'), [
            'Sgmt', ]] = ['Opt', ]
    out_df.loc[
        (out_df['Buy Exch'].str.contains('SE')) & (out_df['symbol'].str.contains('CE')) & (out_df['Sgmt'] == 'FO'), [
            'Sgmt', ]] = ['Opt', ]
    out_df = out_df[
        ['symbol', 'Buy trade_price', 'Buy qty', 'Sell trade_price', 'Sell qty', 'Buy date', 'Sell date', 'Account',
         'Buy Exch', 'Sell Exch', 'Sgmt', ]]

    output_file = get_output_file_path()
    out_df.to_excel(output_file, index=False)


if __name__ == "__main__":
    format_trade_book()
