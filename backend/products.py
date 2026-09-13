from fastapi import APIRouter
from database import get_connection

router = APIRouter()


@router.get("/shops/{shop_id}/products")
def get_shop_products(shop_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, product_name, price, availability
        FROM products
        WHERE shop_id = %s
        ORDER BY product_name
    """, (shop_id,))

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "product_name": row[1],
            "price": row[2],
            "availability": row[3],
        }
        for row in rows
    ]