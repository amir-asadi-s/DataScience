import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress

def draw_plot():
    # Read data from file
    df = pd.read_csv('epa-sea-level.csv')

    # Create scatter plot
    plt.figure(figsize=(10, 6)) # Plot Size
    plt.scatter(df['Year'], df['CSIRO Adjusted Sea Level'], color='blue', label='Original data')

    # Create first line of best fit - (1880-2050)
    slope_1, intercept_1, r_value, p_value, std_err = linregress(df['Year'], df['CSIRO Adjusted Sea Level'])
    years_1 = pd.Series(range(1880, 2051))
    line_1 = slope_1 * years_1 + intercept_1
    plt.plot(years_1, line_1, color='red', label='Best fit line (1880-2050)')
  
    # Create second line of best fit - (2000, 2051)
    df_2 = df[df['Year'] >= 2000]
    slope_2, intercept_2 ,r_value, p_value, std_err= linregress(df_2['Year'], df_2['CSIRO Adjusted Sea Level'])
    years_2 = pd.Series(range(2000, 2051))
    line_2 = slope_2 * years_2 + intercept_2
    plt.plot(years_2, line_2, color='green', label='Best fit line (2000-2050)')
  
    # Add labels and title
    plt.xlabel('Year')
    plt.ylabel('Sea Level (inches)')
    plt.title('Rise in Sea Level')
    plt.legend()
    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()