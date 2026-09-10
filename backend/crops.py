from fastapi import APIRouter
from database import get_connection

router = APIRouter()


@router.get("/crops")
def get_crops():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT
            id,
            farmer_id,
            crop_name,
            quantity,
            expected_price,
            location,
            created_at
        FROM crops
        ORDER BY id
    """)

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "farmer_id": row[1],
            "crop_name": row[2],
            "quantity": row[3],
            "expected_price": row[4],
            "location": row[5],
            "created_at": row[6]
        }
        for row in rows
    ]