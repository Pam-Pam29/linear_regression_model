# Cora - Your Health Insurance Predictor

Cora is a friendly Flutter app that gives you a quick, personalized estimate of your annual health insurance charges.

## Features
- Clean, modern, and accessible UI
- Easy-to-use prediction form
- Personalized results page with rotating health tips
- Error handling and loading feedback
- Works with a FastAPI backend for real-time predictions

## How to Run
1. Make sure the FastAPI backend is running (see `summative/API` for details).
2. In this directory, run:
   ```
   flutter pub get
   flutter run
   ```
3. Use the app to enter your details and get your insurance estimate!

## Note
- The app requires the backend API to be running and accessible at the configured address (default: `http://10.0.2.2:8000/predict` for Android emulator).

---
**Author:** Pam-Pam29
