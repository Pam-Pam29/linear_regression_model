from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

# 1. Define the input data model
class InsuranceInput(BaseModel):
    age: int = Field(..., ge=18, le=100, description="Age in years (18-100)")
    sex: str = Field(..., description="Sex: 'male' or 'female'")
    bmi: float = Field(..., ge=10, le=60, description="BMI (10-60)")
    children: int = Field(..., ge=0, le=10, description="Number of children (0-10)")
    smoker: str = Field(..., description="Smoker: 'yes' or 'no'")
    region: str = Field(..., description="Region: 'northeast', 'northwest', 'southeast', or 'southwest'")

# 2. Create the FastAPI app
app = FastAPI()

# 3. Add CORS middleware (so your Flutter/web app can call the API)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins (for demo; restrict in production)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 4. Helper function to convert categorical input to numbers/one-hot
def preprocess_input(data: InsuranceInput):
    # Sex: 'female'->0, 'male'->1
    sex = 1 if data.sex.lower() == 'male' else 0
    # Smoker: 'yes'->1, 'no'->0
    smoker = 1 if data.smoker.lower() == 'yes' else 0
    # Region one-hot encoding
    region_northwest = 1 if data.region.lower() == 'northwest' else 0
    region_southeast = 1 if data.region.lower() == 'southeast' else 0
    region_southwest = 1 if data.region.lower() == 'southwest' else 0
    # Northeast is all zeros
    return np.array([[data.age, sex, data.bmi, data.children, smoker,
                      region_northwest, region_southeast, region_southwest]])

# 5. Prediction endpoint
@app.post("/predict")
def predict(input: InsuranceInput):
    # Load scaler and model
    scaler = joblib.load("insurance_scaler.joblib")
    model = joblib.load("insurance_best_model.joblib")
    # Preprocess input
    X = preprocess_input(input)
    X_scaled = scaler.transform(X)
    prediction = model.predict(X_scaled)[0]
    return {"predicted_charges": float(prediction)}