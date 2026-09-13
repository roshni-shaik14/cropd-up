from fastapi import APIRouter
from pydantic import BaseModel
from database import get_connection

router = APIRouter()


class PricePredictionRequest(BaseModel):
    crop_name: str
    location: str = ""
    quantity: float = 0


@router.post("/ai-price-prediction")
def ai_price_prediction(request: PricePredictionRequest):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT price, market_name, location
        FROM market_prices
        WHERE LOWER(crop_name) = LOWER(%s)
        ORDER BY price DESC
    """, (request.crop_name,))

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    if not rows:
        return {
            "success": False,
            "message": "No market price data found for this crop"
        }

    prices = [float(row[0]) for row in rows]

    highest_price = max(prices)
    average_price = sum(prices) / len(prices)

    # Demo AI-style prediction
    predicted_price = (average_price * 0.4) + (highest_price * 0.6)

    # Recommended selling price
    recommended_price = predicted_price * 1.05

    predicted_price = round(predicted_price, 2)
    recommended_price = round(recommended_price, 2)

    if recommended_price >= highest_price:
        recommendation = "Good opportunity to sell at a competitive price."
    else:
        recommendation = "Consider checking nearby markets before selling."

    return {
        "success": True,
        "crop_name": request.crop_name,
        "location": request.location,
        "quantity": request.quantity,
        "average_market_price": round(average_price, 2),
        "highest_market_price": round(highest_price, 2),
        "ai_predicted_price": predicted_price,
        "recommended_selling_price": recommended_price,
        "recommendation": recommendation,
        "markets_analyzed": len(rows)
    }