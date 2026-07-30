import os
import time
from typing import List, Optional
from fastapi import FastAPI, Response, HTTPException, status
from pydantic import BaseModel, Field

app = FastAPI(
    title="ForgeOps API Service",
    description="Core backend REST API service for ForgeOps Internal Developer Platform",
    version="1.0.0"
)

START_TIME = time.time()

# In-memory data store for demonstration
JOBS_DB = []

class JobCreate(BaseModel):
    name: str = Field(..., example="deploy-service")
    target_env: str = Field("dev", example="dev")
    payload: dict = Field(default_factory=dict)

class JobResponse(BaseModel):
    id: int
    name: str
    target_env: str
    status: str
    created_at: float
    payload: dict

class PlatformInfo(BaseModel):
    platform: str
    version: str
    environment: str
    active_jobs: int

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
def readiness_check():
    """Readiness probe endpoint."""
    return {"status": "ready", "timestamp": time.time()}

@app.get("/api/v1/info", response_model=PlatformInfo, tags=["Platform"])
def get_info():
    """Retrieve internal platform status metadata."""
    env = os.getenv("ENVIRONMENT", "dev")
    return PlatformInfo(
        platform="ForgeOps IDP",
        version="1.0.0",
        environment=env,
        active_jobs=len(JOBS_DB)
    )

@app.post("/api/v1/jobs", response_model=JobResponse, status_code=status.HTTP_201_CREATED, tags=["Jobs"])
def create_job(job: JobCreate):
    """Enqueue a new platform deployment job."""
    job_id = len(JOBS_DB) + 1
    job_entry = {
        "id": job_id,
        "name": job.name,
        "target_env": job.target_env,
        "status": "queued",
        "created_at": time.time(),
        "payload": job.payload
    }
    JOBS_DB.append(job_entry)
    return job_entry

@app.get("/api/v1/jobs", response_model=List[JobResponse], tags=["Jobs"])
def list_jobs(env: Optional[str] = None):
    """List all enqueued deployment jobs."""
    if env:
        return [j for j in JOBS_DB if j["target_env"] == env]
    return JOBS_DB

@app.get("/metrics", tags=["Observability"])
def get_metrics():
    """Basic Prometheus metrics endpoint."""
    uptime = time.time() - START_TIME
    metrics_text = (
        f"# HELP forgeops_uptime_seconds Total uptime in seconds\n"
        f"# TYPE forgeops_uptime_seconds gauge\n"
        f"forgeops_uptime_seconds {uptime:.2f}\n"
        f"# HELP forgeops_jobs_total Total enqueued jobs\n"
        f"# TYPE forgeops_jobs_total counter\n"
        f"forgeops_jobs_total {len(JOBS_DB)}\n"
    )
    return Response(content=metrics_text, media_type="text/plain")
