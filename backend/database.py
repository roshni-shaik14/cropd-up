from fastapi import APIRouter
from database import psycopg2

router = APIRouter()


@router.get("/crops")
def get_crops():
    conn = psycopg2.connect(
        host="localhost",
        database="cropdup",
        user="postgres",
        password="navyacharya2523",
        port="5432"
    )

    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, crop_name, quantity, expected_price, location
        FROM crops
        ORDER BY id
    """)

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "crop_name": row[1],
            "quantity": row[2],
            "expected_price": row[3],
            "location": row[4]
        }
        for row in rows
    ]