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
    # region field removed

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
# Remove region one-hot encoding

def preprocess_input(data: InsuranceInput):
    # Sex one-hot encoding
    sex_female = 1 if data.sex.lower() == 'female' else 0
    sex_male = 1 if data.sex.lower() == 'male' else 0

    # Smoker one-hot encoding
    smoker_no = 1 if data.smoker.lower() == 'no' else 0
    smoker_yes = 1 if data.smoker.lower() == 'yes' else 0

    # Return features in the exact order your model expects (without region)
    return np.array([[
        data.age,
        data.bmi,
        data.children,
        sex_female,
        sex_male,
        smoker_no,
        smoker_yes
    ]])
# 5. Prediction endpoint
@app.post("/predict")
def predict(input: InsuranceInput):
    # Load scaler and model
    scaler = joblib.load("cora_scaler.joblib")
    model = joblib.load("cora_best_model.joblib")
    # Preprocess input
    X = preprocess_input(input)
    X_scaled = scaler.transform(X)
    prediction = model.predict(X_scaled)[0]
    return {"predicted_charges": float(prediction)}