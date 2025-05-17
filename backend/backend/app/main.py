from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
from app.nutrition_data import load_nutrition_data
from app.openai_service import gpt_estimate_nutrition
import base64
import traceback

app = FastAPI()

nutrition_df = load_nutrition_data(
    'app/data/food.csv',
    'app/data/food_nutrient.csv',
    'app/data/food_portion.csv'
)


def build_summary(df):
    rows = []
    for _, row in df.iterrows():
        try:
            rows.append(
                f"{row['description']}: {int(row['Calories'])} kcal, "
                f"{round(row['Protein'], 1)}g protein, "
                f"{round(row['Carbohydrates'], 1)}g carbs, "
                f"{round(row['Fats'], 1)}g fat per 100g"
            )
        except:
            continue
    return "\n".join(rows[:150])


summary = build_summary(nutrition_df)


@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        image = await file.read()
        image_base64 = base64.b64encode(image).decode("utf-8")
        gpt_output = gpt_estimate_nutrition(image_base64, summary)

        return JSONResponse(content=gpt_output)
    except Exception as e:
        traceback.print_exc()
        return JSONResponse(status_code=500, content={"error": str(e)})
