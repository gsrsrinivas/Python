import pandas as pd
import pyodbc

def insert_data_into_database():
    # Read data from Excel file
    excel_file = f'C:/Users/gsrsr/Downloads/ChartInk-Stocks.xlsx'
    df = pd.read_excel(excel_file)
    df = df.fillna(0)
    # Define connection string to SQL Server with Windows Authentication
    conn_str = (
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-EP99LTB;'
        'DATABASE=Stocks_Analysis;'
        'Trusted_Connection=yes;'
    )

    # Establish connection to SQL Server
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    print(f'connection is established')
    # Define the insert statement
    insert_query = '''INSERT INTO dbo.Cash_Stocks(sr#,[stock name],symbol,Links,[% Chg],price,volume,Indicator,TimeLine,Direction,Segment,Batch_No)
    VALUES (?, ?, ?, ? ,? , ?, ?, ? ,? , ?, ?, ?)'''

    # Iterate over the DataFrame and insert data into the SQL Server table
    for index, row in df.iterrows():
        cursor.execute(insert_query, row['sr#'], row['stock name'], row['symbol'], row['Links'], row['% Chg'], row['price'], row['volume'],row['Indicator'], row['TimeLine'], row['Direction'], row['Segment'], row['Batch_No'])

    # Commit the transaction
    conn.commit()

    # Close the connection
    cursor.close()
    conn.close()

    print('Data inserted successfully!')

if __name__ == "__main__":
    insert_data_into_database()
