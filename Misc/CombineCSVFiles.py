import pandas as pd
import os

# Directory containing the CSV files
directory = 'C:/Users/gsrsr/Downloads/'

# List to store dataframes
dfs = []

# Loop through the CSV files and read each into a dataframe
for filename in os.listdir(directory):
    if filename.endswith('.csv'):
        filepath = os.path.join(directory, filename)
        df = pd.read_csv(filepath)
        df['filename'] = filename  # Add filename as a new column
        dfs.append(df)

# Concatenate all dataframes into a single dataframe
combined_df = pd.concat(dfs, ignore_index=True)

# Save the combined dataframe to a new CSV file
combined_df.to_csv(f'{directory}__combined_file.csv', index=False)

