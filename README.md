# FoodDetectionAIApp
SeeFood: AI-Powered Food Recognition and Nutrition Estimator
github: https://github.com/asawhney962/FoodDetectionAIApp, the most updated backend is on adharsh_branch,
SeeFood is an iOS app that allows users to scan meals using their camera or photo library. It uses an AI backend to detect ingredients and estimate the nutritional values based on USDA data. Users can save meals, view meal history, and chat with a nutrition bot.

Features:

- Capture or upload food images
- Ingredient detection via GPT-4o and a CNN-assisted backend
- Nutrition estimates using USDA Foundation Foods data
- Meal history tracking
- Chat-based nutrition assistant
- Firebase authentication and user management

Backend Dependencies:
Create a venv and then
Install using: pip install fastapi uvicorn pandas openai python-multipart python-dotenv

Running backend:

1. Navigate to the backend directory:
2. Create and activate virtual environment:
   python3 -m venv venv
   source venv/bin/activate
3. Start the FastAPI server:
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   Visit http://127.0.0.1:8000/docs to access Swagger UI.

Frontend (SwiftUI)
Features

- Scan food using camera or gallery
- View AI-estimated nutrition data
- Save meals and view meal history
- Profile and logout functionality
- Chatbot for meal suggestions

Setup
Open FoodDetection.xcodeproj in Xcode
Ensure your API key is added to Info.plist:

<key>OpenAI_APIKey</key>
<string>your-openai-api-key-here</string>
Ensure Info.plist is added to Copy Bundle Resources

API Connection
The frontend sends a .jpeg image to the /predict endpoint.

The backend responds with structured JSON containing:

    dish_name

    ingredients: [ { name, quantity_grams }, ... ]

    nutrition: { calories, protein_g, carbohydrates_g, fats_g }

This response is parsed and displayed in NutritionResults.swift.
