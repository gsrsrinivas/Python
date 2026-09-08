from _Common_Functions.base_functions import *

df_all = pd.DataFrame()
df = pd.DataFrame()

data_list = [
    # {'double top fake break out__daily__setup'    : {'scan_clause': ''}},
    # {'double top fake break down__daily__setup'   : {'scan_clause': ''}},
    {'price__4_hourly__below_50_Ema': {
        'scan_clause': '( {segments_filter} ( [0] 4 hour close < [0] 4 hour ema( [0] 4 hour close , 50 ) ) )'}},
    {'price__1_hourly__below_50_Ema': {
        'scan_clause': '( {segments_filter} ( [0] 1 hour close < [0] 1 hour ema( [0] 1 hour close , 50 ) ) )'}},
    {'price__15_minutes__below_50_Ema': {
        'scan_clause': '( {segments_filter} ( [0] 15 minute close < [0] 15 minute ema( [0] 15 minute close , 50 ) ) )'}},

]

for data_each_list in data_list:
    data_each_list = {key: {k: val.replace('segments_filter', 'cash')} for key, value in data_each_list.items() for
                      k, val in value.items()}
    key, data = next(iter(data_each_list.items()))
    df = download_chart_ink_technical_analysis_scanner(key, data, 'Cash')
    df_all = pd.concat([df_all, df], ignore_index=True)

print(f"\n🔄 downloading data from the website is complete.")
batch_no = datetime.now().strftime('%Y%m%d%H%M%S')
df_all['Batch_No'] = batch_no  # Add batch number to the DataFrame
chart_ink_to_csv(df_all, 'chart_ink_sample')
print(f"✅ Data saved to chart_in_sample.csv")
