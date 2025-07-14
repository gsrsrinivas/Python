import pandas as pd
import requests
from bs4 import BeautifulSoup


def chart_ink_scan_results():
    # Define the scan URL and the scan clause
    scan_url = 'https://chartink.com/screener/bullish-15-minutes-of-triple-screen2'
    # scan_clause = '( {cash} ( latest close > 10 and latest tema(latest close,10) > latest tema( latest close,20) and latest volume > 50000 and market cap > 500) )'
    scan_clause = '( cash ( ( cash ( [0] 4 hour macd line( 26,12,9 ) >= [0] 4 hour macd signal( 26,12,9 ) and [0] 4 hour macd line( 26,12,9 ) >= [-1] 4 hour macd line( 26 , 12 , 9 ) and [0] 1 hour macd line( 26,12,9 ) >= [0] 1 hour macd signal( 26,12,9 ) and [0] 1 hour macd line( 26,12,9 ) >= [-1] 1 hour macd line( 26 , 12 , 9 ) and [0] 15 minute macd line( 26,12,9 ) >= [0] 15 minute macd signal( 26,12,9 ) and [0] 15 minute macd line( 26,12,9 ) >= [-1] 15 minute macd line( 26 , 12 , 9 ) ) ) and( cash ( ( cash ( [0] 15 minute slow stochastic %k( 14 , 3 ) >= [0] 15 minute slow stochastic %d( 14 , 3 ) and [0] 15 minute slow stochastic %k( 14 , 3 ) >= [-1] 15 minute slow stochastic %k( 14 , 3 ) ) ) or [0] 15 minute rsi( 14 ) >= [-1] 15 minute rsi( 14 ) ) ) and( cash ( [0] 15 minute adx di positive( 14 ) >= [0] 15 minute adx di negative( 14 ) and [0] 15 minute adx( 14 ) >= [-1] 15 minute adx( 14 ) ) ) and( cash ( [0] 15 minute volume >= [0] 15 minute "sum( close * volume, 20 ) / sum( volume ,20 )" and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 13 ) and [0] 15 minute ema( [0] 15 minute close , 5 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 13 ) >= [0] 15 minute ema( [0] 15 minute close , 26 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 100 ) and [0] 15 minute ema( [0] 15 minute close , 50 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) and [0] 15 minute ema( [0] 15 minute close , 100 ) >= [0] 15 minute ema( [0] 15 minute close , 200 ) ) ) and( cash ( [0] 15 minute upper bollinger band( 20 , 3 ) >= [-1] 15 minute upper bollinger band( 20 , 3 ) and [0] 15 minute lower bollinger band( 20 , 3 ) <= [-1] 15 minute lower bollinger band( 20 , 3 ) and [0] 15 minute upper bollinger band( 20 , 2 ) >= [-1] 15 minute upper bollinger band( 20 , 2 ) and [0] 15 minute lower bollinger band( 20 , 2 ) <= [-1] 15 minute lower bollinger band( 20 , 2 ) ) ) ) )'
    # Start a session
    with requests.Session() as s:
        # Get the initial page to retrieve the CSRF token
        r = s.get(scan_url)
        soup = BeautifulSoup(r.content)  # lxml , 'xlsx'
        csrf_token = soup.select_one('[name=csrf-token]')['content']

        # Set the headers and data for the POST request
        s.headers.update({'X-CSRF-TOKEN': csrf_token})
        data = {'scan_clause': scan_clause}

        # Make the POST request to get the scan results
        r = s.post('https://chartink.com/screener/process', data=data)
        results = r.json()['data']

        # Convert the results to a DataFrame
        df = pd.DataFrame(results)

        # Save the DataFrame to an Excel file
        df.to_excel('chart_ink_scan_results.xlsx', index=False)

    print("Scan results saved to 'chart_ink_scan_results.xlsx'")


if __name__ == "__main__":
    chart_ink_scan_results()
