![Project Image](https://storage.googleapis.com/kaggle-media/competitions/Titanic/titanic_5407_media_banner.png)

# Titanic - Machine Learning from Disaster

This project aims to predict the survival of passengers aboard the Titanic using various classification models. The dataset used for this analysis is sourced from the [Kaggle Titanic competition](https://www.kaggle.com/c/titanic).

## Motivation

The sinking of the Titanic was one of the most infamous disasters in history. While survival had an element of luck, certain groups of people were more likely to survive than others. This project leverages machine learning models to predict the likelihood of passenger survival using features like age, gender, and passenger class.

## Data Insights

Before model training, several key insights emerged from the dataset:
- **Gender**: Female passengers had a significantly higher survival rate than males.
- **Class**: Passengers in first class were more likely to survive compared to those in second or third class.
- **Age**: Younger passengers, particularly children, had a higher survival rate compared to adults.

These insights informed the feature engineering and model training process.

### Key Visualizations:
- **Survival Rate by Gender**:
  ![Survival Rate by Gender]([link_to_image_1](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_1.png))

- **Survival Rate by Passenger Class**:
  ![Survival Rate by Passenger Class]([link_to_image_2](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_2.png))

- **Age Distribution of Survivors and Non-Survivors**:
  ![Age Distribution of Survivors and Non-Survivors]([link_to_image_3](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_3.png))

- **Survival Rate by Embarkation Point**:
  ![Survival Rate by Embarkation Point](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_4.png)

- **Feature Importance (Random Forest)**:
  ![Feature Importance]([link_to_image_6](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_6.png))

## Results

The project compares multiple classification models based on metrics such as accuracy, F1-score, precision, and recall. After evaluating several models, **Random Forest** and **XGBoost** stood out as the best-performing models.

### Model Comparison

| Model               | Accuracy | F1-Score | Precision | Recall  |
|---------------------|----------|----------|-----------|---------|
| Logistic Regression  | 81.56%   | 76.92%   | 79.71%    | 74.32%  |
| Random Forest        | 82.68%   | 77.37%   | 84.13%    | 71.62%  |
| XGBoost              | 80.45%   | 75.18%   | 79.10%    | 71.62%  |

### Best Model: **Random Forest**

Random Forest outperformed the other models in terms of:
- Highest validation accuracy (82.68%).
- A good balance between precision and recall.
- Robust performance after hyperparameter tuning.

## Key Findings

- **Random Forest** and **XGBoost** delivered the best overall performance for predicting survival.
- **Feature Engineering**—including handling missing values and creating interaction features—significantly boosted model performance.
- **Gender** and **Passenger Class** were the most influential features in determining survival.

## Technologies Used

- **Python**: For scripting and data analysis.
- **scikit-learn**: For building and tuning machine learning models.
- **XGBoost**: For gradient boosting.
- **pandas**: For data manipulation.
- **matplotlib/seaborn**: For visualizations.

## Deployment

To deploy this model in a real-world scenario, consider:
- **Accuracy**: While the model is fine-tuned for the Titanic dataset, further tuning and additional data might be needed for other datasets or similar tasks.
- **Data Preprocessing**: Ensure that any new data follows the same preprocessing steps applied to the training data.
- **Model Updating**: The model can be further refined by experimenting with more advanced techniques or optimizing feature engineering.

## Challenges

Handling missing values and creating meaningful features were the most significant challenges. Missing values, particularly in the age and cabin features, required careful imputation strategies and feature creation to ensure that the model performed well on unseen data.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- Kaggle for providing the dataset.
- The Kaggle Titanic competition community for shared insights and resources.
- The Python and scikit-learn community for excellent documentation and support.
