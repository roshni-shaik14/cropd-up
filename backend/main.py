from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from crops import router as crops_router
from communication import router as communication_router
from market_prices import router as market_prices_router
from market_recommendation import router as market_recommendation_router

app = FastAPI(
    title="CropD-Up API",
    description="Farmer-First Marketplace Backend",
    version="1.0.0"
)


# ==========================================
# CORS
# ==========================================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ==========================================
# ROUTES
# ==========================================
app.include_router(crops_router)
app.include_router(communication_router)
app.include_router(market_prices_router)
app.include_router(market_recommendation_router)


# ==========================================
# HOME
# ==========================================
@app.get("/")
def home():
    return {
        "message": "CropD-Up Backend is running"
    }