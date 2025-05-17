import pandas as pd


def load_nutrition_data(food_path: str, nutrient_path: str, portion_path: str) -> pd.DataFrame:
    """Load Foundation Foods dataset with avg serving size (grams)."""

    # Load base tables
    foods = pd.read_csv(food_path)
    nutrients = pd.read_csv(nutrient_path)
    portions = pd.read_csv(portion_path)

    # Nutrient IDs we care about
    nutrient_ids = {
        1008: "Calories",
        1003: "Protein",
        1005: "Carbohydrates",
        1004: "Fats"
    }

    # Filter only relevant nutrients
    nutrients = nutrients[nutrients["nutrient_id"].isin(nutrient_ids.keys())]
    nutrients["nutrient_name"] = nutrients["nutrient_id"].map(nutrient_ids)

    # Pivot to get nutrients as columns
    pivot = nutrients.pivot_table(
        index="fdc_id",
        columns="nutrient_name",
        values="amount"
    ).reset_index()

    # Compute average portion size per fdc_id
    avg_portions = portions.groupby(
        "fdc_id")["gram_weight"].mean().reset_index()
    avg_portions = avg_portions.rename(
        columns={"gram_weight": "avg_serving_size_g"})

    # Merge everything
    merged = foods[["fdc_id", "description"]].merge(
        pivot, on="fdc_id", how="left")
    merged = merged.merge(avg_portions, on="fdc_id", how="left")
    merged = merged.dropna(
        subset=["Calories", "Protein", "Carbohydrates", "Fats"])

    return merged


def get_food_names(df: pd.DataFrame) -> list:
    """Return all food descriptions."""
    return df["description"].dropna().tolist()
