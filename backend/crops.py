from fastapi import APIRouter

router = APIRouter()

crops = [
    {
        "id": 1,
        "crop_name": "Tomato",
        "quantity": 500,
        "expected_price": 27,
        "location": "Bengaluru",
    },
    {
        "id": 2,
        "crop_name": "Onion",
        "quantity": 300,
        "expected_price": 32,
        "location": "Mysuru",
    },
    {
        "id": 3,
        "crop_name": "Potato",
        "quantity": 450,
        "expected_price": 29,
        "location": "Tumakuru",
    },
]


@router.get("/crops")
def get_crops():
    return crops