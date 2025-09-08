from pathlib import Path

import pandas as pd


def get_input_folder_path():
    input_file = r'C:\Users\gsrsr\Downloads\Zerodha\Zerodha\TradeBook\Input'  # Replace with your file path
    return input_file


def get_output_file_path():
    output_file = r'C:\Users\gsrsr\Downloads\Zerodha\Zerodha\TradeBook\processed_file.xlsx'  # Replace with your file path
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
            # For Excel files, skip the first 14 rows to get to the data
            df = pd.read_excel(input_file, engine='openpyxl', skiprows=14)
        else:
            print(f"Unsupported file type: {input_file.suffix}")
        df_all = pd.concat([df_all, df], ignore_index=True)
    return df_all


def process_dataframe(df):
    df['Trade Date'] = pd.to_datetime(df['Trade Date'], format='%Y-%m-%d')
    buys = df[df['Trade Type'] == 'buy'].copy().reset_index(drop=True)
    sells = df[df['Trade Type'] == 'sell'].copy()
    output_df = []
    # Group sells by symbol and reset index for positional access
    sells_grouped = sells.groupby('Symbol')
    for symbol, buys_sub in buys.groupby('Symbol'):
        sells_sub = sells_grouped.get_group(symbol).copy().reset_index(drop=True) if symbol in sells_grouped.groups else pd.DataFrame(columns=sells.columns)
        sell_pointer = 0
        for _, buy_row in buys_sub.iterrows():
            remain_buy = buy_row['Quantity']

            while remain_buy > 0 and sell_pointer < len(sells_sub):
                sell_row = sells_sub.iloc[sell_pointer]
                remain_sell = sell_row['Quantity']
                if remain_sell == 0 or sell_row['Trade Date'] < buy_row['Trade Date']:
                    sell_pointer += 1
                    continue
                matched = min(remain_buy, remain_sell)
                buy_value = matched * buy_row['Price']
                sell_value = matched * sell_row['Price']
                profit_loss_perc = ((sell_value - buy_value) / buy_value) * 100 if buy_value != 0 else 0
                output_df.append({
                    'Symbol': symbol,
                    'Buy Price': buy_row['Price'],
                    'Buy Qty': matched,
                    'Sell Price': sell_row['Price'],
                    'Sell Qty': matched,
                    'Buy Date': buy_row['Trade Date'].strftime('%d-%b-%y'),
                    'Sell Date': sell_row['Trade Date'].strftime('%d-%b-%y'),
                    'Account': buy_row.get('Account', ''),
                    'Buy Exch': buy_row.get('Exchange', ''),
                    'Sell Exch': sell_row['Exchange'],
                    'Sgmt': sell_row['Segment'],
                })

                # output_df.append({
                #     'Buy Symbol': symbol,
                #     'Buy ISIN': buy_row.get('ISIN', ''),
                #     'Buy Exch': buy_row.get('Exchange', ''),
                #     'Buy Sgmt': buy_row.get('Segment', ''),
                #     'Buy Series': buy_row.get('Series', ''),
                #     'Buy Trade ID': buy_row.get('Trade ID', ''),
                #     'Buy Order ID': buy_row.get('Order ID', ''),
                #     'Buy Order Execution Time': buy_row.get('Order Execution Time', ''),
                #
                #     'Buy Date': buy_row['Trade Date'].strftime('%d-%b-%y'),
                #     'Buy Qty': matched,
                #     'Buy Price': buy_row['Price'],
                #     'Buy Value': buy_value,
                #
                #     'Sell Symbol': symbol,
                #     'Sell Date': sell_row['Trade Date'].strftime('%d-%b-%y'),
                #     'Sell Qty': matched,
                #     'Sell Price': sell_row['Price'],
                #     'Sell Value': sell_value,
                #
                #     'Sell ISIN': sell_row['ISIN'],
                #     'Sell Exch': sell_row['Exch'],
                #     'Sell Sgmt': sell_row['Segment'],
                #     'Sell Series': sell_row['Series'],
                #     'Sell Trade ID': sell_row['Trade ID'],
                #     'Sell Order ID': sell_row['Order ID'],
                #     'Sell Order Execution Time': sell_row['Order Execution Time'],
                #
                #     'Profit/Loss %': profit_loss_perc
                # })
                remain_buy -= matched
                sells_sub.at[sell_pointer, 'Quantity'] -= matched
                if sells_sub.at[sell_pointer, 'Quantity'] == 0:
                    sell_pointer += 1

            if remain_buy > 0:
                buy_value = remain_buy * buy_row['Price']
                output_df.append({
                    'Symbol': symbol,
                    'Buy Price': buy_row['Price'],
                    'Buy Qty': remain_buy,
                    'Sell Price': '',
                    'Sell Qty': '',
                    'Buy Date': buy_row['Trade Date'].strftime('%d-%b-%y'),
                    'Sell Date': '',
                    'Account': buy_row.get('Account', ''),
                    'Buy Exch': buy_row.get('Exchange', ''),
                    'Sell Exch': '',
                    'Sgmt': '',
                })
                # output_df.append({
                #     'Buy Symbol': symbol,
                #     'Buy ISIN': buy_row.get('ISIN', ''),
                #     'Buy Exch': buy_row.get('Exchange', ''),
                #     'Buy Sgmt': buy_row.get('Segment', ''),
                #     'Buy Series': buy_row.get('Series', ''),
                #     'Buy Trade ID': buy_row.get('Trade ID', ''),
                #     'Buy Order ID': buy_row.get('Order ID', ''),
                #     'Buy Order Execution Time': buy_row.get('Order Execution Time', ''),
                #
                #     'Buy Date': buy_row['Trade Date'].strftime('%d-%b-%y'),
                #     'Buy Qty': remain_buy,
                #     'Buy Price': buy_row['Price'],
                #     'Buy Value': buy_value,
                #
                #     'Sell Symbol': '',
                #     'Sell Date': '',
                #     'Sell Qty': '',
                #     'Sell Price': '',
                #     'Sell Value': '',
                #
                #     'Sell ISIN': '',
                #     'Sell Exch': '',
                #     'Sell Sgmt': '',
                #     'Sell Series': '',
                #     'Sell Trade ID': '',
                #     'Sell Order ID': '',
                #     'Sell Order Execution Time': '',
                #
                #     'Profit/Loss %': ''
                # })
    return output_df


def format_trade_book():
    df = read_all_files_into_dataframe()
    output_df = process_dataframe(df)
    out_df = pd.DataFrame(output_df)
    out_df.loc[(out_df['Account'] == ''), ['Account', ]] = ['LD3666', ]
    out_df.loc[(out_df['Sell Exch'] == 'MCX') & (out_df['Symbol'].str.contains('PE')), ['Sgmt', ]] = ['ComOpt',]
    out_df.loc[(out_df['Buy Exch'] == 'MCX') & (out_df['Symbol'].str.contains('CE')), ['Sgmt', ]] = ['ComOpt', ]
    out_df.loc[(out_df['Buy Exch'] == 'MCX') & (out_df['Symbol'].str.contains('FUT')), ['Sgmt', ]] = ['ComFut', ]
    out_df.loc[(out_df['Buy Exch'].str.contains('SE')) & (out_df['Symbol'].str.contains('FUT')) & (out_df['Sgmt']=='FO'), ['Sgmt', ]] = ['Fut', ]
    out_df.loc[(out_df['Buy Exch'].str.contains('SE')) & (out_df['Symbol'].str.contains('PE')) & (out_df['Sgmt']=='FO'), ['Sgmt', ]] = ['Opt', ]
    out_df.loc[(out_df['Buy Exch'].str.contains('SE')) & (out_df['Symbol'].str.contains('CE')) & (out_df['Sgmt']=='FO'), ['Sgmt', ]] = ['Opt', ]
    # total_buy_val = out_df['Buy Value'].sum()
    # total_sell_val = pd.to_numeric(out_df['Sell Value'], errors='coerce').fillna(0).sum()
    # overall_profit_loss_perc = ((total_sell_val - total_buy_val) / total_buy_val) * 100 if total_buy_val != 0 else 0
    out_df = out_df[['Symbol','Buy Price','Buy Qty','Sell Price','Sell Qty','Buy Date','Sell Date','Account','Buy Exch','Sell Exch','Sgmt',]]
    # out_df = out_df[['Buy Symbol', 'Buy Date', 'Buy Qty', 'Buy Price', 'Buy Value'
    #     ,'Buy ISIN','Buy Exch','Buy Sgmt', 'Buy Series','Buy Trade ID','Buy Order ID','Buy Order Execution Time'
    #     ,'Sell Symbol', 'Sell Date', 'Sell Qty', 'Sell Price', 'Sell Value'
    #     ,'Sell ISIN','Sell Exch','Sell Sgmt', 'Sell Series','Sell Trade ID','Sell Order ID','Sell Order Execution Time'
    #     ,'Profit/Loss %']]

    output_file = get_output_file_path()
    out_df.to_excel(output_file, index=False)
    # print(f"\nOverall Profit/Loss Percentage: {overall_profit_loss_perc:.2f}%")


if __name__ == "__main__":
    format_trade_book()
