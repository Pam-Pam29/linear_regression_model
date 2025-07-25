# Cora - Your Health Insurance Predictor


## Mission & Problem (4 lines)
Cora helps users estimate their annual health insurance charges quickly and easily. Many people struggle to predict these costs, making it hard to plan and compare policies. Cora provides instant, personalized estimates using machine learning. This empowers users to make informed financial decisions about their health coverage.

## Dataset Source & Description
- **Source:** [Medical Cost Personal Datasets on Kaggle](https://www.kaggle.com/datasets/mirichoi0218/insurance)
- **Background:** This dataset contains real health insurance data, commonly used for regression modeling. It includes demographic and health-related features for individuals, along with their actual insurance charges. The dataset is not Africanized, and the 'region' feature was removed for contextual relevance.

  ## Feature Engineering
- **Removed 'region' column:** The original dataset included a 'region' feature representing US regions. Since this is not relevant for an African context and could introduce bias, it was removed from both the training data and the deployed model.
- **Categorical encoding:** The 'sex' and 'smoker' columns were converted to numeric values using one-hot encoding.
- **Feature scaling:** All numeric features (age, bmi, children) were standardized using StandardScaler to ensure equal contribution to the model.
- **Final feature vector:** Each prediction uses the following features: age, bmi, children, sex_female, sex_male, smoker_no, smoker_yes.


**Columns Used:**
| Column    | Description                                 |
|-----------|---------------------------------------------|
| age       | Age of the primary beneficiary              |
| sex       | Gender: 'male' or 'female'                   |
| bmi       | Body Mass Index                              |
| children  | Number of children covered by insurance      |
| smoker    | Smoking status: 'yes' or 'no'               |
| charges   | Annual medical insurance charges             |


## Public API Endpoint
A publicly available API endpoint returns predictions given input values. You can test it using Swagger UI:
- **API URL:** [https://linear-regression-model-4ns8.onrender.com/predict](https://linear-regression-model-4ns8.onrender.com/predict)
- **Swagger UI:** [https://linear-regression-model-4ns8.onrender.com/docs](https://linear-regression-model-4ns8.onrender.com/docs)

## YouTube Video Demo
Watch a short demo of Cora in action:
- [YouTube Demo ](https://youtu.be/YRHmIkGouDg)

## How to Run the Mobile App
1. Make sure the FastAPI backend is running and accessible at the public API URL.
2. In the `my cora-flutter_app` directory, run:
   ```
   flutter pub get
   flutter run
   ```
3. Enter your details in the app to get your insurance estimate.

---
**Author:** Pam-Pam29
