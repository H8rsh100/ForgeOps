# ForgeOps — Self-Hosted Internal Developer Platform

[![ForgeOps CI](https://github.com/H8rsh100/ForgeOps/actions/workflows/ci.yml/badge.svg)](https://github.com/H8rsh100/ForgeOps/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

ForgeOps is a production-grade, self-hosted **Internal Developer Platform (IDP)** architecture designed to demonstrate full-lifecycle DevOps, GitOps, Infrastructure-as-Code (IaC), Observability, Policy Enforcement, and Chaos Engineering.

---

## 🏗️ Architecture Overview

```mermaid
flowchart TB
    subgraph Developer Workspace
        DEV[Developer Code] -->|git push| GITHUB[GitHub Repository]
    end

    subgraph CI/CD Pipeline (GitHub Actions)
        GITHUB --> CI[CI Workflow]
        CI -->|Lint & Pytest| TEST[Unit & Chart Validation]
        CI -->|Docker Build| DOCKER[Container Images]
        DOCKER -->|Security Gate| TRIVY[Trivy Vulnerability Scan]
        TRIVY -->|Publish| GHCR[GHCR Registry]
    end

    subgraph Infrastructure Provisioning (Terraform)
        TF[Terraform] -->|Provision| KIND[Kind Kubernetes Cluster]
    end

    subgraph Kubernetes Cluster Workloads
        KIND --> NS[Namespace: forgeops-dev]
        NS --> API[api-service Deployment]
        NS --> WORKER[worker-service Deployment]
        API <-->|REST API / Metrics| WORKER
    end

    GHCR -.->|Helm Deploy| KIND
```

---

## 📦 Microservices Overview

### 1. `api-service` (FastAPI REST API)
- **Role**: Primary API gateway and business logic controller for the platform.
- **Endpoints**:
  - `GET /health` & `GET /ready`: Kubernetes liveness and readiness probe targets.
  - `GET /api/v1/info`: Platform state and environment telemetry.
  - `POST /api/v1/jobs` & `GET /api/v1/jobs`: Enqueue and query deployment pipeline jobs.
  - `GET /metrics`: Prometheus formatted gauge and counter metrics (`forgeops_uptime_seconds`, `forgeops_jobs_total`).
- **Tech Stack**: Python 3.11, FastAPI, Uvicorn, Pydantic v2.

### 2. `worker-service` (Async Background Processing Worker)
- **Role**: Consumes enqueued platform tasks, performs background sync and health verification.
- **Health Server**: Exposes lightweight health server on port `8080` for cluster probes.
- **Lifecycle**: Handles graceful shutdowns (`SIGINT`, `SIGTERM`) to guarantee zero task loss.
- **Tech Stack**: Python 3.11, Requests, Pydantic v2.

---

## 📂 Repository Structure

```text
forgeops/
├── infra/                 # Infrastructure as Code (Terraform & Kind configs)
│   ├── terraform/         # Cluster Terraform modules (main.tf, variables.tf, outputs.tf)
│   └── kind-config.yaml   # Kind cluster topology configuration (1 Control plane, 2 Workers)
├── services/              # Microservices source code
│   ├── api-service/       # FastAPI REST API service + Pytest test suite
│   └── worker-service/    # Background asynchronous worker
├── charts/                # Helm deployment charts
│   ├── api-service/       # API service Helm chart + dev/staging/prod values
│   └── worker-service/    # Worker service Helm chart + dev/staging/prod values
├── scripts/               # Automation & verification scripts
│   ├── deploy-local.sh    # Kind load & Helm install automation script
│   └── verify-day1.py     # End-to-End local verification script
├── gitops/                # GitOps environment manifests (dev, staging, prod)
├── .github/               # GitHub Actions CI/CD workflows
│   └── workflows/
│       └── ci.yml         # CI pipeline (lint, test, build, trivy scan, push)
├── observability/         # Monitoring & Logging (Prometheus, Grafana, Loki)
├── policies/              # Policy as Code (OPA / Gatekeeper)
├── chaos/                 # Chaos engineering scripts
├── dashboard/             # Internal Developer Platform Dashboard
└── README.md
```

---

## 🚀 Quick Start & Verification

### Local End-to-End Verification
```bash
python scripts/verify-day1.py
```

### Local Cluster Deployment
```bash
chmod +x scripts/deploy-local.sh
./scripts/deploy-local.sh
```

---

## 📜 Roadmap

- [x] **Day 1**: Infrastructure, Microservices, Helm Charts & CI Pipeline (21 Commits Completed)
- [ ] **Day 2**: GitOps Engine, ArgoCD, Sealed Secrets & Automated Deployment (9 Commits Planned)
- [ ] **Day 3**: Observability, OPA Policy Enforcement, Chaos Testing & IDP Dashboard (17 Commits Planned)

---

## 📄 License
MIT © 2026 Harsh
