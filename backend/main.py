from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from crops import router as crops_router

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(crops_router)


@app.get("/")
def home():
    return {"message": "CropD-UP Backend is running"}