from fastapi import APIRouter
from database import get_connection

router = APIRouter()


@router.get("/shops")
def get_shops():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, location, contact, category
        FROM shops
        ORDER BY name
    """)

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "name": row[1],
            "location": row[2],
            "contact": row[3],
            "category": row[4] or "Agriculture"
        }
        for row in rows
    ]


@router.get("/shops/{shop_id}")
def get_shop(shop_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, location, contact, category
        FROM shops
        WHERE id = %s
    """, (shop_id,))

    row = cursor.fetchone()

    cursor.close()
    conn.close()

    if row is None:
        return {
            "message": "Shop not found"
        }

    return {
        "id": row[0],
        "name": row[1],
        "location": row[2],
        "contact": row[3],
        "category": row[4] or "Agriculture"
    }


@router.get("/shops/search/{location}")
def search_shops(location: str):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, location, contact, category
        FROM shops
        WHERE location ILIKE %s
        ORDER BY name
    """, (f"%{location}%",))

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "name": row[1],
            "location": row[2],
            "contact": row[3],
            "category": row[4] or "Agriculture"
        }
        for row in rows
    ]