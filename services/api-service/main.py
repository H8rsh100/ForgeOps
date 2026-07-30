import time
from fastapi import FastAPI, Response, status
from pydantic import BaseModel

app = FastAPI(
    title="ForgeOps API Service",
    description="Core backend REST API service for ForgeOps Internal Developer Platform",
    version="1.0.0"
)

START_TIME = time.time()

class HealthResponse(BaseModel):
    status: str
    service: str
    version: str
    uptime_seconds: float

@app.get("/health", response_model=HealthResponse, tags=["Health"])
def health_check():
    """Liveness probe endpoint."""
    return HealthResponse(
        status="healthy",
        service="api-service",
        version="1.0.0",
        uptime_seconds=round(time.time() - START_TIME, 2)
    )

@app.get("/ready", tags=["Health"])
def readiness_check(response: Response):
    """Readiness probe endpoint."""
    return {"status": "ready", "timestamp": time.time()}
