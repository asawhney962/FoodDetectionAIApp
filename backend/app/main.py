from openai import OpenAI
import base64

client = OpenAI(
    # enter api key
    api_key=""
)
# input the path to image
with open("", "rb") as f:
    image_base64 = base64.b64encode(f.read()).decode("utf-8")

completion = client.chat.completions.create(
    model="gpt-4o",
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": (
                        "What's in this image? Identify the food, estimate the serving size, "
                        "and list the macronutrients in the following format:\n\n"
                        "Food: <food name>\n"
                        "Serving Size: <amount in grams or cups>\n"
                        "Calories: <kcal>\n"
                        "Protein: <grams>\n"
                        "Carbohydrates: <grams>\n"
                        "Fats: <grams>"
                    )
                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{image_base64}"
                    },
                },
            ],
        },
    ],
)

print(completion.choices[0].message.content)
