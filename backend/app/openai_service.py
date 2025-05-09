from openai import OpenAI
import os
from dotenv import load_dotenv

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def detect_ingredients_with_grams(image_base64: str) -> dict:
    """Use GPT to detect food ingredients and estimate serving size in grams."""
    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[{
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": (
                        "Analyze this food image carefully.\n\n"
                        "List each distinct food you see along with an estimated serving size in grams.\n"
                        "Format exactly like this: Chicken: 100g, Rice: 80g, Broccoli: 50g.\n"
                        "ONLY reply with this format, no other text or explanation."
                    )
                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{image_base64}"
                    },
                }
            ]
        }]
    )

    raw_text = completion.choices[0].message.content.strip()
    ingredients = {}
    for item in raw_text.split(","):
        if ":" in item:
            food, grams = item.split(":")
            try:
                ingredients[food.strip()] = int(
                    grams.strip().replace("g", "").strip())
            except ValueError:
                continue
    return ingredients


def gpt_estimate_nutrition_from_usda(image_base64: str, nutrition_summary: str) -> dict:
    """Ask GPT to estimate nutrition based on image and USDA summary, return parsed dict."""
    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[{
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": (
                        "Given the food image and the USDA nutrition reference below, estimate a meal's typical ingredients and their quantities (in grams), and compute total nutrition.\n\n"
                        "Respond ONLY in JSON format with:\n"
                        "{\n"
                        "  \"ingredients\": [\n"
                        "    {\"ingredient\": \"name\", \"quantity\": number },\n"
                        "    ...\n"
                        "  ],\n"
                        "  \"calories\": number,\n"
                        "  \"protein\": number,\n"
                        "  \"carbohydrates\": number,\n"
                        "  \"fats\": number\n"
                        "}\n\n"
                        "USDA Nutrition Summary:\n"
                        f"{nutrition_summary}"
                    )

                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{image_base64}"
                    },
                }
            ]
        }]
    )

    # Use eval only in trusted local context — safer option: use `json.loads` after validation
    import json
    response_text = completion.choices[0].message.content.strip()
    try:
        # Try parsing as JSON directly (if GPT behaved)
        return json.loads(response_text)
    except Exception:
        # fallback: try extracting JSON manually if needed
        json_start = response_text.find("{")
        json_end = response_text.rfind("}") + 1
        try:
            return json.loads(response_text[json_start:json_end])
        except Exception as e:
            return {"error": "Invalid JSON from GPT", "raw": response_text}
