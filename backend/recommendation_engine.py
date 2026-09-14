from fastapi import APIRouter
from pydantic import BaseModel, Field
from database import get_connection

router = APIRouter()


class RecommendationRequest(BaseModel):
    crop_name: str = Field(
        ...,
        min_length=1,
        max_length=100
    )

    location: str = Field(
        default="",
        max_length=100
    )

    quantity: float = Field(
        default=0,
        gt=0,
        le=100000
    )


@router.post("/recommendation-engine")
def recommendation_engine(request: RecommendationRequest):
    crop_name = request.crop_name.strip()
    location = request.location.strip()

    if not crop_name:
        return {
            "success": False,
            "message": "Crop name cannot be empty"
        }

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("""
            SELECT
                market_name,
                location,
                price
            FROM market_prices
            WHERE LOWER(crop_name) = LOWER(%s)
            ORDER BY price DESC
        """, (crop_name,))

        rows = cursor.fetchall()

    finally:
        cursor.close()
        conn.close()

    if not rows:
        return {
            "success": False,
            "message": "No market data found for this crop"
        }

    # Highest-paying market
    best_market = rows[0]

    prices = [float(row[2]) for row in rows]

    highest_price = max(prices)
    average_price = sum(prices) / len(prices)

    # Demo AI-style prediction
    predicted_price = (
        average_price * 0.4
        + highest_price * 0.6
    )

    recommended_price = predicted_price * 1.05

    predicted_price = round(predicted_price, 2)
    recommended_price = round(recommended_price, 2)

    # Estimate total expected revenue
    estimated_revenue = round(
        recommended_price * request.quantity,
        2
    )

    return {
        "success": True,
        "crop_name": crop_name,
        "farmer_location": location,
        "quantity": request.quantity,

        "recommended_market": best_market[0],
        "market_location": best_market[1],
        "market_price": float(best_market[2]),

        "average_market_price": round(
            average_price,
            2
        ),

        "highest_market_price": round(
            highest_price,
            2
        ),

        "ai_predicted_price": predicted_price,

        "recommended_selling_price":
            recommended_price,

        "estimated_revenue":
            estimated_revenue,

        "markets_analyzed": len(rows),

        "recommendation": (
            f"Sell {crop_name} at "
            f"{best_market[0]} because it currently "
            f"offers the highest available market price."
        )
    }