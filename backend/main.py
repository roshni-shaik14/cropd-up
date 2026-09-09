from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "CropD-UP Backend is running"}
