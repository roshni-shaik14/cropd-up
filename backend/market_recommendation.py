from fastapi import APIRouter
from database import get_connection

router = APIRouter()


# ==========================================
# BEST MARKET RECOMMENDATION
# ==========================================
@router.get("/recommend-market/{crop_name}")
def recommend_market(crop_name: str):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT
            id,
            crop_name,
            market_name,
            location,
            price,
            updated_at
        FROM market_prices
        WHERE LOWER(crop_name) = LOWER(%s)
        ORDER BY price DESC
    """, (crop_name,))

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    if not rows:
        return {
            "success": False,
            "message": "No market prices found for this crop"
        }

    best_market = rows[0]

    return {
        "success": True,
        "crop_name": best_market[1],
        "recommended_market": best_market[2],
        "location": best_market[3],
        "price": best_market[4],
        "reason": "This market has the highest available price for the selected crop"
    }