from openai import OpenAI
import os
import json
from dotenv import load_dotenv

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def gpt_estimate_nutrition(image_base64: str, nutrition_summary: str) -> dict:
    """Ask GPT to estimate ingredients and nutrition in strict JSON format."""
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[{
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": (
                        "Estimate the dish name, ingredients, and nutrition for this food image.\n"
                        "Respond ONLY in raw JSON. Do not include ```json or any markdown blocks.\n\n"
                        "{\n"
                        "  \"dish_name\": \"string\",\n"
                        "  \"ingredients\": [\n"
                        "    {\"name\": \"string\", \"quantity_grams\": number },\n"
                        "    ...\n"
                        "  ],\n"
                        "  \"nutrition\": {\n"
                        "    \"calories\": number,\n"
                        "    \"protein_g\": number,\n"
                        "    \"carbohydrates_g\": number,\n"
                        "    \"fats_g\": number\n"
                        "  }\n"
                        "}"
                    )


                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{image_base64}"
                    }
                }
            ]
        }]
    )

    raw = response.choices[0].message.content.strip()
    try:
        return json.loads(raw)
    except Exception:
        return {"error": "Invalid JSON", "raw": raw}
