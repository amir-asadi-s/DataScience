![Project Image](https://storage.googleapis.com/kaggle-media/competitions/Titanic/titanic_5407_media_banner.png)

# Titanic - Machine Learning from Disaster

This project aims to predict the survival of passengers aboard the Titanic using various classification models. The dataset used for this analysis is sourced from the [Kaggle Titanic competition](https://www.kaggle.com/c/titanic).

## Motivation

The sinking of the Titanic was one of the most infamous disasters in history. While there was some element of luck in surviving, some groups of people were more likely to survive than others. The goal of this project is to build machine learning models to predict the likelihood of survival for passengers using data such as age, gender, passenger class, and more.

## Data Insights

Before diving into model training, several insights were uncovered from the dataset:
- **Gender**: Female passengers had a higher likelihood of survival than males.
- **Class**: Passengers in first class were more likely to survive compared to those in third class.
- **Age**: Children were more likely to survive compared to adults.
  
These insights guided the feature engineering and model training process.

### Key Visualizations:
- **Survival Rate by Gender**:
  ![Survival Rate by Gender](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_1.png)

- **Feature Importance** (Random Forest):
  ![Feature Importance](https://github.com/amir-asadi-s/DataScience/blob/main/Kaggle/Titanic%20-%20Machine%20Learning%20from%20Disaster/__results___19_6.png)

## Results

The project compares multiple classification models based on various metrics, including accuracy and F1-score. After evaluating several models, **Random Forest** and **XGBoost** were found to be the best-performing models.

### Model Comparison

| Model               | Accuracy | F1-Score | Precision | Recall  |
|---------------------|----------|----------|-----------|---------|
| Logistic Regression  | 0.771    | 0.754    | 0.79      | 0.73    |
| Random Forest        | 0.805    | 0.792    | 0.81      | 0.78    |
| XGBoost              | 0.793    | 0.785    | 0.80      | 0.77    |

### Best Model: **Random Forest**

Random Forest outperformed other models based on the following criteria:
- Highest accuracy on the validation set.
- Good balance between precision and recall.
- Efficient performance after hyperparameter tuning.

## Key Findings

- **Random Forest** and **XGBoost** delivered the best overall performance for predicting survival.
- Feature engineering (handling missing values, encoding categorical variables, and interaction features) significantly improved model performance.
- **Gender** and **Passenger Class** were among the most influential features in predicting survival.

## Technologies Used

- **Python**: For scripting and data analysis.
- **scikit-learn**: For building and tuning machine learning models.
- **XGBoost**: For gradient boosting.
- **pandas**: For data manipulation.
- **matplotlib/seaborn**: For visualization.

## Deployment

To deploy this model for real-world use, consider the following:

- **Accuracy**: The model has been fine-tuned for general Titanic datasets but could benefit from additional data or further tuning for new scenarios.
- **Completeness**: Ensure the test dataset is preprocessed in the same way as the training set to avoid inconsistencies.
- **Model Updating**: The model could be improved further by testing new techniques or refining feature engineering methods.

## Challenges

The most significant challenge during this project was handling missing values and engineering new features. The dataset contains several missing entries (especially for age and cabin), which required careful imputation and thoughtful feature creation to ensure model robustness.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Kaggle for providing the dataset.
- The Titanic competition community for shared insights and resources.
- The Python and scikit-learn community for their fantastic documentation and support.

