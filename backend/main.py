from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from crops import router as crops_router
from communication import router as communication_router
from market_prices import router as market_prices_router
from market_recommendation import router as market_recommendation_router
from shops import router as shops_router
from products import router as products_router
from ai_price_prediction import router as ai_price_prediction_router
from recommendation_engine import router as recommendation_engine_router


app = FastAPI(
    title="CropD-Up API",
    description="Farmer-First Marketplace Backend",
    version="1.2.0"
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
app.include_router(shops_router)
app.include_router(products_router)
app.include_router(ai_price_prediction_router)
app.include_router(recommendation_engine_router)


# ==========================================
# HOME
# ==========================================
@app.get("/")
def home():
    return {
        "message": "CropD-Up Backend is running",
        "version": "1.2.0",
        "phase": "Phase 15 - AI Price Prediction"
    }