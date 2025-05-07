from fastapi import APIRouter, UploadFile, File
from app.services.image_model import predict_image
from app.services.nutrition_lookup import get_nutrition_info
from app.utils.image_utils import preprocess_image

router = APIRouter()


@router.post("/predict")
async def predict(file: UploadFile = File(...)):
    image = await file.read()
    preprocessed = preprocess_image(image)
    label = predict_image(preprocessed)
    nutrition = get_nutrition_info(label)
    return {"food": label, "nutrition": nutrition}
