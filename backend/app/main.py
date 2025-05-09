from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
from app.nutrition_data import load_nutrition_data
from app.openai_service import gpt_estimate_nutrition_from_usda
import base64
import traceback

app = FastAPI()

# Load USDA nutrition data
nutrition_df = load_nutrition_data(
    'app/data/food.csv',
    'app/data/food_nutrient.csv',
    'app/data/food_portion.csv'
)


def build_nutrition_summary(df) -> str:
    """Create readable USDA food nutrition entries for GPT."""
    summaries = []
    for _, row in df.iterrows():
        try:
            summaries.append(
                f"{row['description']}: {int(row['Calories'])} kcal, {round(row['Protein'], 1)}g protein, {round(row['Carbohydrates'], 1)}g carbs, {round(row['Fats'], 1)}g fat per 100g"
            )
        except:
            continue
    return "\n".join(summaries[:200])  # Keep it concise to avoid token limits


nutrition_summary = build_nutrition_summary(nutrition_df)


@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        image = await file.read()
        image_base64 = base64.b64encode(image).decode("utf-8")
        gpt_response = gpt_estimate_nutrition_from_usda(
            image_base64, nutrition_summary)
        return JSONResponse(content={"gpt_analysis": gpt_response})
    except Exception as e:
        traceback.print_exc()
        return JSONResponse(status_code=500, content={"error": str(e)})
