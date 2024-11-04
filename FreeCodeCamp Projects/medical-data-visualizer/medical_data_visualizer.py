import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# 1 - Read data
df = pd.read_csv('medical_examination.csv')

# 2 - which patient is overweight - BMI formula
df['overweight'] = (df['weight'] / ((df['height'] / 100) ** 2)) > 25
df['overweight'] = df['overweight'].astype(int)

# 3 - Normalize cholesterol and gluc to binary values
df['cholesterol'] = df['cholesterol'].apply(lambda x: 0 if x == 1 else 1)
df['gluc'] = df['gluc'].apply(lambda x: 0 if x == 1 else 1)

# 4 -  two visualizations
#         1- A categorical plot across patients with and without cardiovascular disease
#         2- A heatmap - correlations
def draw_cat_plot():
    # 5 Melt (unpivot) the DataFrame for categorical plotting
    df_cat = pd.melt(
        df,
        id_vars=['cardio'],
        value_vars=['cholesterol', 'gluc', 'smoke', 'alco', 'active', 'overweight']
    )

    # 6 Group and reformat data for counting
    df_cat = df_cat.groupby(['cardio', 'variable', 'value']).size().reset_index(name='total')

    # 7 distribution of each variable across patients with and without cardiovascular disease.
    fig = sns.catplot(
        x='variable', y='total', hue='value', col='cardio',
        data=df_cat, kind='bar'
    ).fig
    # 8
    
    # 9 save
    fig.savefig('catplot.png')
    return fig

# 10
def draw_heat_map():
    # 11 data cleaning according instruction - outliers
    df_heat = df[
        (df['ap_lo'] <= df['ap_hi']) & 
        (df['height'] >= df['height'].quantile(0.025)) & 
        (df['height'] <= df['height'].quantile(0.975)) &
        (df['weight'] >= df['weight'].quantile(0.025)) & 
        (df['weight'] <= df['weight'].quantile(0.975))
    ]

    # 12 corr matrix
    corr = df_heat.corr()

    # 13 hide upper triangle
    mask = np.triu(np.ones_like(corr, dtype=bool))

    # 14 plot size
    fig, ax = plt.subplots(figsize=(10, 8))

    # 15 heatmap
    sns.heatmap(
        corr, mask=mask, cmap='coolwarm', vmax=.4, center=0,
        square=True, linewidths=.4, annot=True, fmt=".1f"
    )

    # 16
    fig.savefig('heatmap.png')
    return fig
