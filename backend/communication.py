from fastapi import APIRouter
from database import get_connection

router = APIRouter()


# ==========================================
# GET ALL BUYERS
# ==========================================
@router.get("/buyers")
def get_buyers():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, contact
        FROM buyers
        ORDER BY id
    """)

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return [
        {
            "id": row[0],
            "name": row[1],
            "contact": row[2]
        }
        for row in rows
    ]


# ==========================================
# GET ONE BUYER
# ==========================================
@router.get("/buyers/{buyer_id}")
def get_buyer(buyer_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, contact
        FROM buyers
        WHERE id = %s
    """, (buyer_id,))

    row = cursor.fetchone()

    cursor.close()
    conn.close()

    if row is None:
        return {
            "message": "Buyer not found"
        }

    return {
        "id": row[0],
        "name": row[1],
        "contact": row[2]
    }


# ==========================================
# CONTACT BUYER
# ==========================================
@router.get("/contact/buyer/{buyer_id}")
def contact_buyer(buyer_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, name, contact
        FROM buyers
        WHERE id = %s
    """, (buyer_id,))

    row = cursor.fetchone()

    cursor.close()
    conn.close()

    if row is None:
        return {
            "success": False,
            "message": "Buyer not found"
        }

    return {
        "success": True,
        "message": "Buyer contact found",
        "buyer": {
            "id": row[0],
            "name": row[1],
            "contact": row[2]
        }
    }