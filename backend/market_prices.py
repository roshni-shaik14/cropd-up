from fastapi import APIRouter
from database import get_connection

router = APIRouter()


# ==========================================
# GET ALL MARKET PRICES
# ==========================================
@router.get("/market-prices")
def get_market_prices():
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
        ORDER BY id
    """)

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "crop_name": row[1],
            "market_name": row[2],
            "location": row[3],
            "price": row[4],
            "updated_at": row[5]
        }
        for row in rows
    ]


# ==========================================
# GET MARKET PRICES FOR ONE CROP
# ==========================================
@router.get("/market-prices/{crop_name}")
def get_crop_market_prices(crop_name: str):
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

    return [
        {
            "id": row[0],
            "crop_name": row[1],
            "market_name": row[2],
            "location": row[3],
            "price": row[4],
            "updated_at": row[5]
        }
        for row in rows
    ]