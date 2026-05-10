from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.database import create_db_and_tables
from app.routes.task import router

@asynccontextmanager
async def lifespan(app: FastAPI):
    create_db_and_tables()
    yield

app = FastAPI(
    title="DevOps Challenge - Task API",
    description="A production-ready Task management API",
    version="1.0.0",
    lifespan=lifespan
)

app.include_router(router, prefix="/api/v1", tags=["tasks"])

@app.get("/")
def root():
    return {
        "message": "Task API is running",
        "version": "1.0.0",
        "docs": "/docs"
    }

@app.get("/health")
def health_check():
    return {
        "status": "healthy"
    }