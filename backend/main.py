from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from crops import router as crops_router

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
# CROP ROUTES
# ==========================================
app.include_router(crops_router)


# ==========================================
# HOME ROUTE
# ==========================================
@app.get("/")
def home():
    return {
        "message": "CropD-Up Backend is running"
    }