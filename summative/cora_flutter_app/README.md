# Cora - Your Health Insurance Predictor

## Mission & Problem (4 lines)
Cora helps users estimate their annual health insurance charges quickly and easily. Many people struggle to predict these costs, making it hard to plan and compare policies. Cora provides instant, personalized estimates using machine learning. This empowers users to make informed financial decisions about their health coverage.

## Data Description & Source
The model is trained on the [Medical Cost Personal Datasets](https://www.kaggle.com/datasets/mirichoi0218/insurance) from Kaggle, which contains real insurance data including age, sex, BMI, children, smoker status, region, and charges. Due to high demand, an Africanized dataset may not be used (see note below).

## Public API Endpoint
A publicly available API endpoint returns predictions given input values. You can test it using Swagger UI:
- **API URL:** [https://your-public-api-url/predict](https://your-public-api-url/predict) (replace with your deployed endpoint)
- **Swagger UI:** [https://your-public-api-url/docs](https://your-public-api-url/docs)

## YouTube Video Demo
Watch a short demo of Cora in action:
- [YouTube Demo (max 5 min)](https://your-youtube-demo-link)

## How to Run the Mobile App
1. Make sure the FastAPI backend is running and accessible at the public API URL.
2. In the `cora_flutter_app` directory, run:
   ```
   flutter pub get
   flutter run
   ```
3. Enter your details in the app to get your insurance estimate.

## Problem Statement & Solution
Health insurance costs can be unpredictable and stressful for individuals and families. According to the World Health Organization, out-of-pocket health expenses push millions into poverty each year. Many people struggle to estimate their annual health insurance charges, making it hard to plan and compare policies.

**Solution:** Cora is a user-friendly app that predicts your annual health insurance charges based on your personal details. It uses a Random Forest machine learning model trained on real insurance data to provide quick, personalized estimates. This helps users make informed decisions, budget effectively, and better understand their insurance options.

## Note on Dataset
Due to high demand, an Africanized dataset may not be used. As per the reviewer:

> "I will not penalize for having a non-Africanized dataset, but I will review the use case more thoroughly for non-African datasets without considering geographical setting. This is only fair since some have gone through a lot of stress to find Africanized data and they found it and thus scrutiny should be relative to Use case and Geographical setting."

Please proceed with the data that is available.

---
**Author:** Pam-Pam29 

## Real-World Context
Health insurance helps individuals and families manage the financial risk of medical expenses. In many regions, including Africa, access to affordable health insurance is a growing concern. Predicting insurance charges can help users plan ahead, compare policies, and make informed decisions—even if the dataset is not fully localized. The methodology and app design can be adapted to any region as more relevant data becomes available.

## Ethical Note
Fairness and bias are important in health insurance models. Cora does not use sensitive features (like race or ethnicity) and aims to provide estimates based only on relevant health and demographic factors. It is important that such models do not unfairly penalize or exclude any group. Ongoing review and transparency are key to ethical use.

## User Feedback & Future Work
User feedback is valuable for improving both the model and the app. In future versions, Cora could include a feedback form or rating system to collect user experiences and suggestions. As more localized or diverse datasets become available, the model can be retrained for greater accuracy and fairness. Additional features, such as policy recommendations or educational resources, could also be added. 