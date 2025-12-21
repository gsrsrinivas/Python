# Sample data - replace this with reading from CSV or Excel file:
import pandas as pd

# data = '''Symbol,Date,Qty,Rate,Value,Type
# IREDA,16-Feb-24,500,175,87500,buy
# IREDA,26-Feb-24,180,151.5,27270,buy
# IREDA,03-Jun-24,680,194.57,132307.6,sell
# IREDA,14-Jun-24,175,180.5,31587.5,buy
# IREDA,05-Aug-24,160,190,30400,buy
# IREDA,29-Jul-24,170,186.45,32628.75,sell
# IREDA,24-Sep-24,165,222,35520,sell
# IEX,05-Aug-24,160,190,30400,buy'''

input_file = r'C:\Users\gsrsr\Downloads\Zerodha\TradeBook\Tradebookcsv.csv'  # Replace with your file path
# df = pd.read_csv(StringIO(data))
df = pd.read_csv(input_file)
df['Trade_Date'] = pd.to_datetime(df['Trade_Date'], format='%d-%b-%y')

# Separate buys and sells
buys = df[df['Trade_Type'] == 'buy'].copy().reset_index(drop=True)
sells = df[df['Trade_Type'] == 'sell'].copy().reset_index(drop=True)

# Match sells to buys FIFO with sell date >= buy date
output = []
sell_pointer = 0

for _, buy_row in buys.iterrows():
    remain_buy = buy_row['Quantity']
    while remain_buy > 0 and sell_pointer < len(sells):
        sell_row = sells.loc[sell_pointer]
        remain_sell = sell_row['Quantity']
        # Check sell date condition and available sell quantity
        if sell_row['Trade_Date'] < buy_row['Trade_Date'] or remain_sell == 0:
            sell_pointer += 1
            continue
        matched = min(remain_buy, remain_sell)
        buy_value = matched * buy_row['Price']
        sell_value = matched * sell_row['Price']
        profit_loss_perc = ((sell_value - buy_value) / buy_value) * 100 if buy_value != 0 else 0
        output.append({
            'Symbol': buy_row['Symbol'],
            'Buy Date': buy_row['Trade_Date'].strftime('%d-%b-%y'),
            'Buy Qty': matched,
            'Buy Rate': buy_row['Price'],
            'Buy Value': buy_value,
            'Sell Date': sell_row['Trade_Date'].strftime('%d-%b-%y'),
            'Sell Qty': matched,
            'Sell Rate': sell_row['Price'],
            'Sell Value': sell_value,
            'ISIN': buy_row.get('ISIN', ''),
            'Exchange': buy_row.get('Exchange', ''),
            'Segment': buy_row.get('Segment', ''),
            'series': buy_row.get('series', ''),
            'trade id': buy_row.get('trade_id', ''),
            'Order id': buy_row.get('Order_id', ''),
            'Order_Execution_time': buy_row.get('Order_Execution_Time', ''),
            'Profit/Loss %': profit_loss_perc
        })
        remain_buy -= matched
        sells.at[sell_pointer, 'Quantity'] -= matched
        if sells.at[sell_pointer, 'Quantity'] == 0:
            sell_pointer += 1
    if remain_buy > 0:
        buy_value = remain_buy * buy_row['Price']
        output.append({
            'Symbol': buy_row['Symbol'],
            'Buy Date': buy_row['Trade_Date'].strftime('%d-%b-%y'),
            'Buy Qty': remain_buy,
            'Buy Rate': buy_row['Price'],
            'Buy Value': buy_value,
            'Sell Date': '',
            'Sell Qty': '',
            'Sell Rate': '',
            'Sell Value': '',
            'ISIN': buy_row.get('ISIN', ''),
            'Exchange': buy_row.get('Exchange', ''),
            'Segment': buy_row.get('Segment', ''),
            'series': buy_row.get('Series', ''),
            'trade id': buy_row.get('Trade_ID', ''),
            'Order id': buy_row.get('Order_ID', ''),
            'Order_Execution_time': buy_row.get('Order_Execution_Time', ''),
            'Profit/Loss %': ''
        })

outdf = pd.DataFrame(output)

total_buy_val = outdf['Buy Value'].sum()
total_sell_val = pd.to_numeric(outdf['Sell Value'], errors='coerce').fillna(0).sum()
overall_profit_loss_perc = ((total_sell_val - total_buy_val) / total_buy_val) * 100 if total_buy_val != 0 else 0

# Reorder columns
outdf = outdf[['Symbol',
               'Buy Date', 'Buy Qty', 'Buy Rate', 'Buy Value',
               'Sell Date', 'Sell Qty', 'Sell Rate', 'Sell Value',
               'ISIN', 'Exchange', 'Segment', 'Series', 'trade_id', 'Order_id', 'Order_Execution_Time',
               'Profit/Loss %']]

outdf.to_csv(outdf, 'Tradebookformated.csv', index=False)

print(outdf)
print(f"\nOverall Profit/Loss Percentage: {overall_profit_loss_perc:.2f}%")
