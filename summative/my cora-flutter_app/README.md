# Cora - Your Health Insurance Predictor

## Problem Statement
Unpredictable health insurance costs make it difficult for individuals and families to plan and compare policies. Many people lack access to tools that provide quick, personalized estimates, leading to financial uncertainty and poor decision-making. Cora addresses this challenge by making insurance cost prediction accessible and user-friendly.

## Mission & Problem (4 lines)
Cora helps users estimate their annual health insurance charges quickly and easily. Many people struggle to predict these costs, making it hard to plan and compare policies. Cora provides instant, personalized estimates using machine learning. This empowers users to make informed financial decisions about their health coverage.

## Dataset Source & Description
- **Source:** [Medical Cost Personal Datasets on Kaggle](https://www.kaggle.com/datasets/mirichoi0218/insurance)
- **Background:** This dataset contains real health insurance data, commonly used for regression modeling. It includes demographic and health-related features for individuals, along with their actual insurance charges. The dataset is not Africanized, and the 'region' feature was removed for contextual relevance.

**Columns:**
| Column    | Description                                 |
|-----------|---------------------------------------------|
| age       | Age of the primary beneficiary (int)         |
| sex       | Gender: 'male' or 'female' (str)            |
| bmi       | Body Mass Index (float)                      |
| children  | Number of children covered by insurance (int)|
| smoker    | Smoking status: 'yes' or 'no' (str)         |
| charges   | Annual medical insurance charges (float)     |

## Feature Engineering
To make the model more relevant for the African context, the 'region' feature was removed from the dataset and model. This ensures predictions are not biased by irrelevant regional categories.

## Public API Endpoint
A publicly available API endpoint returns predictions given input values. You can test it using Swagger UI:
- **API URL:** [https://your-public-api-url/predict](https://your-public-api-url/predict) (replace with your deployed endpoint)
- **Swagger UI:** [https://your-public-api-url/docs](https://your-public-api-url/docs)

## YouTube Video Demo
Watch a short demo of Cora in action:
- [YouTube Demo (max 5 min)](https://your-youtube-demo-link)

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
