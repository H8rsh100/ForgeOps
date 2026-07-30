import pytest
from fastapi.testclient import TestClient
from main import app, JOBS_DB

client = TestClient(app)

@pytest.fixture(autouse=True)
def clear_jobs():
    """Clear in-memory jobs before each test."""
    JOBS_DB.clear()

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["service"] == "api-service"
    assert "uptime_seconds" in data

def test_readiness_check():
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.json()["status"] == "ready"

def test_get_platform_info():
    response = client.get("/api/v1/info")
    assert response.status_code == 200
    data = response.json()
    assert data["platform"] == "ForgeOps IDP"
    assert data["environment"] == "dev"
    assert data["active_jobs"] == 0

def test_create_job():
    payload = {
        "name": "deploy-api",
        "target_env": "dev",
        "payload": {"image": "api-service:v1.0.0"}
    }
    response = client.post("/api/v1/jobs", json=payload)
    assert response.status_code == 201
    data = response.json()
    assert data["id"] == 1
    assert data["name"] == "deploy-api"
    assert data["status"] == "queued"

def test_list_jobs():
    payload = {
        "name": "deploy-worker",
        "target_env": "staging",
        "payload": {}
    }
    client.post("/api/v1/jobs", json=payload)
    
    response = client.get("/api/v1/jobs")
    assert response.status_code == 200
    assert len(response.json()) == 1

    # Filter by environment
    resp_staging = client.get("/api/v1/jobs?env=staging")
    assert len(resp_staging.json()) == 1
    resp_prod = client.get("/api/v1/jobs?env=prod")
    assert len(resp_prod.json()) == 0

def test_metrics_endpoint():
    response = client.get("/metrics")
    assert response.status_code == 200
    assert "forgeops_uptime_seconds" in response.text
    assert "forgeops_jobs_total" in response.text
