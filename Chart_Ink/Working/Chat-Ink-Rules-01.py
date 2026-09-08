def chat_ink_rules():
    data_list = [
        # condition to download the stocks
        # {'all_stocks' : {'scan_clause': '( {segments_filter} ( latest close >= 0 ) )'}},
        {'macd_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) >= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) >= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly macd line( 26 , 12 , 9 ) <= yearly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) >= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly macd line( 26 , 12 , 9 ) <= quarterly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) >= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly macd line( 26 , 12 , 9 ) <= monthly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) >= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly macd line( 26 , 12 , 9 ) <= weekly macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) >= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest macd line( 26 , 12 , 9 ) <= latest macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) >= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour macd line( 26 , 12 , 9 ) <= [0] 4 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) >= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour macd line( 26 , 12 , 9 ) <= [0] 1 hour macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) >= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        {'macd_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute macd line( 26 , 12 , 9 ) <= [0] 15 minute macd signal( 26 , 12 , 9 ) ) )'}},
        # ##################################################################################################################
        {'stochastic_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) >= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly slow stochastic %k( 14 , 3 ) <= yearly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) >= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly slow stochastic %k( 14 , 3 ) <= quarterly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) >= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly slow stochastic %k( 14 , 3 ) <= monthly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) >= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly slow stochastic %k( 14 , 3 ) <= weekly slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) >= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest slow stochastic %k( 14 , 3 ) <= latest slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) >= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour slow stochastic %k( 14 , 3 ) <= [0] 4 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) >= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour slow stochastic %k( 14 , 3 ) <= [0] 1 hour slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        {'stochastic_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute slow stochastic %k( 14 , 3 ) <= [0] 15 minute slow stochastic %d( 14 , 3 ) ) )'}},
        # ##################################################################################################################
        {'ema_5_13_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) >= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 5 ) <= yearly ema( yearly close , 13 ) ) )'}},
        {'ema_5_13_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) >= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 5 ) <= quarterly ema( quarterly close , 13 ) ) )'}},
        {'ema_5_13_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) >= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 5 ) <= monthly ema( monthly close , 13 ) ) )'}},
        {'ema_5_13_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) >= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 5 ) <= weekly ema( weekly close , 13 ) ) )'}},
        {'ema_5_13_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) >= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 5 ) <= latest ema( latest close , 13 ) ) )'}},
        {'ema_5_13_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) >= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 5 ) <= [0] 4 hour ema( [0] 4 hour close , 13 ) ) )'}},
        {'ema_5_13_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) >= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 5 ) <= [0] 1 hour ema( [0] 1 hour close , 13 ) ) )'}},
        {'ema_5_13_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        {'ema_5_13_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 5 ) <= [0] 15 minute ema( [0] 15 minute close , 13 ) ) )'}},
        # ##################################################################################################################
        {'ema_13_26_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) >= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 13 ) <= yearly ema( yearly close , 26 ) ) )'}},
        {'ema_13_26_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) >= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 13 ) <= quarterly ema( quarterly close , 26 ) ) )'}},
        {'ema_13_26_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) >= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 13 ) <= monthly ema( monthly close , 26 ) ) )'}},
        {'ema_13_26_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) >= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 13 ) <= weekly ema( weekly close , 26 ) ) )'}},
        {'ema_13_26_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) >= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 13 ) <= latest ema( latest close , 26 ) ) )'}},
        {'ema_13_26_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) >= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 13 ) <= [0] 4 hour ema( [0] 4 hour close , 26 ) ) )'}},
        {'ema_13_26_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) >= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 13 ) <= [0] 1 hour ema( [0] 1 hour close , 26 ) ) )'}},
        {'ema_13_26_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        {'ema_13_26_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 13 ) <= [0] 15 minute ema( [0] 15 minute close , 26 ) ) )'}},
        # ##################################################################################################################
        {'ema_50_100_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) >= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 50 ) <= yearly ema( yearly close , 100 ) ) )'}},
        {'ema_50_100_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) >= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 50 ) <= quarterly ema( quarterly close , 100 ) ) )'}},
        {'ema_50_100_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) >= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 50 ) <= monthly ema( monthly close , 100 ) ) )'}},
        {'ema_50_100_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) >= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 50 ) <= weekly ema( weekly close , 100 ) ) )'}},
        {'ema_50_100_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) >= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 50 ) <= latest ema( latest close , 100 ) ) )'}},
        {'ema_50_100_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) >= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 50 ) <= [0] 4 hour ema( [0] 4 hour close , 100 ) ) )'}},
        {'ema_50_100_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) >= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 50 ) <= [0] 1 hour ema( [0] 1 hour close , 100 ) ) )'}},
        {'ema_50_100_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        {'ema_50_100_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 50 ) <= [0] 15 minute ema( [0] 15 minute close , 100 ) ) )'}},
        # ##################################################################################################################
        {'ema_100_200_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) >= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly ema( yearly close , 100 ) <= yearly ema( yearly close , 200 ) ) )'}},
        {'ema_100_200_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) >= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly ema( quarterly close , 100 ) <= quarterly ema( quarterly close , 200 ) ) )'}},
        {'ema_100_200_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) >= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly ema( monthly close , 100 ) <= monthly ema( monthly close , 200 ) ) )'}},
        {'ema_100_200_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) >= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly ema( weekly close , 100 ) <= weekly ema( weekly close , 200 ) ) )'}},
        {'ema_100_200_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) >= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest ema( latest close , 100 ) <= latest ema( latest close , 200 ) ) )'}},
        {'ema_100_200_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) >= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour ema( [0] 4 hour close , 100 ) <= [0] 4 hour ema( [0] 4 hour close , 200 ) ) )'}},
        {'ema_100_200_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) >= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour ema( [0] 1 hour close , 100 ) <= [0] 1 hour ema( [0] 1 hour close , 200 ) ) )'}},
        {'ema_100_200_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        {'ema_100_200_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute ema( [0] 15 minute close , 100 ) <= [0] 15 minute ema( [0] 15 minute close , 200 ) ) )'}},
        # ##################################################################################################################
        {'rsi_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest rsi( 14 ) >= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest rsi( 14 ) <= 1 day ago rsi( 14 ) ) )'}},
        {'rsi_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) >= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour rsi( 14 ) <= [-1] 4 hour rsi( 14 ) ) )'}},
        {'rsi_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) >= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour rsi( 14 ) <= [-1] 1 hour rsi( 14 ) ) )'}},
        {'rsi_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) )'}},
        {'rsi_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute rsi( 14 ) <= [-1] 15 minute rsi( 14 ) ) )'}},
        # ##################################################################################################################
        {'upper_bollinger_band3_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) >= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 3 ) <= 1 year ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) >= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 3 ) <= 1 quarter ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) >= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 3 ) <= 1 month ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) >= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 3 ) <= 1 week ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) >= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 3 ) <= 1 day ago upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 3 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        {'upper_bollinger_band3_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 3 ) <= [-1] 15 minute upper bollinger band( 20 , 3 ) ) )'}},
        # ##################################################################################################################
        {'lower_bollinger_band3_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) >= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 3 ) <= 1 year ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) >= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 3 ) <= 1 quarter ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) >= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 3 ) <= 1 month ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) >= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 3 ) <= 1 week ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) >= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 3 ) <= 1 day ago lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 3 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) >= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        {'lower_bollinger_band3_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) ) )'}},
        # ##################################################################################################################
        {'upper_bollinger_band2_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) >= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly upper bollinger band( 20 , 2 ) <= 1 year ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) >= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly upper bollinger band( 20 , 2 ) <= 1 quarter ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) >= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly upper bollinger band( 20 , 2 ) <= 1 month ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) >= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly upper bollinger band( 20 , 2 ) <= 1 week ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) >= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest upper bollinger band( 20 , 2 ) <= 1 day ago upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 4 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) >= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour upper bollinger band( 20 , 2 ) <= [ -1 ] 1 hour upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        {'upper_bollinger_band2_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute upper bollinger band( 20 , 2 ) <= [-1] 15 minute upper bollinger band( 20 , 2 ) ) )'}},
        # ##################################################################################################################
        {'lower_bollinger_band2_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) >= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly lower bollinger band( 20 , 2 ) <= 1 year ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) >= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly lower bollinger band( 20 , 2 ) <= 1 quarter ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) >= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly lower bollinger band( 20 , 2 ) <= 1 month ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) >= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly lower bollinger band( 20 , 2 ) <= 1 week ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) >= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest lower bollinger band( 20 , 2 ) <= 1 day ago lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 4 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) >= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour lower bollinger band( 20 , 2 ) <= [ -1 ] 1 hour lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) >= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        {'lower_bollinger_band2_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) )'}},
        # ##################################################################################################################
        {'volume_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly volume >= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly volume <= yearly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly volume >= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly volume <= quarterly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly volume >= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly volume <= monthly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly volume >= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly volume <= weekly "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest volume >= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest volume <= latest "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour volume >= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour volume <= [0] 4 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour volume >= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour volume <= [0] 1 hour "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        {'volume_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute volume <= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" ) )'}},
        # ##################################################################################################################
        {'adx_yearly_crosses_above': {
            'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) >= yearly adx di negative( 14 ) ) )'}},
        {'adx_yearly_crosses_below': {
            'scan_clause': '( {segments_filter} ( yearly adx di positive( 14 ) <= yearly adx di negative( 14 ) ) )'}},
        {'adx_quarterly_crosses_above': {
            'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) >= quarterly adx di negative( 14 ) ) )'}},
        {'adx_quarterly_crosses_below': {
            'scan_clause': '( {segments_filter} ( quarterly adx di positive( 14 ) <= quarterly adx di negative( 14 ) ) )'}},
        {'adx_monthly_crosses_above': {
            'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) >= monthly adx di negative( 14 ) ) )'}},
        {'adx_monthly_crosses_below': {
            'scan_clause': '( {segments_filter} ( monthly adx di positive( 14 ) <= monthly adx di negative( 14 ) ) )'}},
        {'adx_weekly_crosses_above': {
            'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) >= weekly adx di negative( 14 ) ) )'}},
        {'adx_weekly_crosses_below': {
            'scan_clause': '( {segments_filter} ( weekly adx di positive( 14 ) <= weekly adx di negative( 14 ) ) )'}},
        {'adx_daily_crosses_above': {
            'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) >= latest adx di negative( 14 ) ) )'}},
        {'adx_daily_crosses_below': {
            'scan_clause': '( {segments_filter} ( latest adx di positive( 14 ) <= latest adx di negative( 14 ) ) )'}},
        {'adx_4_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) >= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx_4_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx di positive( 14 ) <= [0] 4 hour adx di negative( 14 ) ) )'}},
        {'adx_1_hourly_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) >= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx_1_hourly_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx di positive( 14 ) <= [0] 1 hour adx di negative( 14 ) ) )'}},
        {'adx_15_minutes_crosses_above': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) ) )'}},
        {'adx_15_minutes_crosses_below': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx di positive( 14 ) <= [0] 15 minute adx di negative( 14 ) ) )'}},
        # ##################################################################################################################
        {'adx_up_tick_yearly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly adx( 14 ) >= 1 year ago adx( 14 ) ) )'}},
        {'adx_down_tick_yearly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( yearly adx( 14 ) <= 1 year ago adx( 14 ) ) )'}},
        {'adx_up_tick_quarterly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) >= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_down_tick_quarterly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( quarterly adx( 14 ) <= 1 quarter ago adx( 14 ) ) )'}},
        {'adx_up_tick_monthly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly adx( 14 ) >= 1 month ago adx( 14 ) ) )'}},
        {'adx_down_tick_monthly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( monthly adx( 14 ) <= 1 month ago adx( 14 ) ) )'}},
        {'adx_up_tick_weekly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly adx( 14 ) >= 1 week ago adx( 14 ) ) )'}},
        {'adx_down_tick_weekly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( weekly adx( 14 ) <= 1 week ago adx( 14 ) ) )'}},
        {'adx_up_tick_daily_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest adx( 14 ) >= 1 day ago adx( 14 ) ) )'}},
        {'adx_down_tick_daily_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( latest adx( 14 ) <= 1 day ago adx( 14 ) ) )'}},
        {'adx_up_tick_4_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) >= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_down_tick_4_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 4 hour adx( 14 ) <= [ -1 ] 4 hour adx( 14 ) ) )'}},
        {'adx_up_tick_1_hourly_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) >= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_down_tick_1_hourly_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 1 hour adx( 14 ) <= [ -1 ] 1 hour adx( 14 ) ) )'}},
        {'adx_up_tick_15_minutes_greater_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) >= [ -1 ] 15 minute adx( 14 ) ) )'}},
        {'adx_down_tick_15_minutes_less_than_equal_to': {
            'scan_clause': '( {segments_filter} ( [0] 15 minute adx( 14 ) <= [ -1 ] 15 minute adx( 14 ) ) )'}},
    ]
    for i, data_each_list in enumerate(data_list):
        for key, value in data_each_list.items():
            print(f"{key};{value}")


if __name__ == "__main__":
    chat_ink_rules()
