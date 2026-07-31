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
        CI -->|Trigger| CD[CD Trigger Workflow]
        CD -->|Bump Image Tag| GITOPS_REPO[gitops/ directory]
    end

    subgraph GitOps Continuous Deployment (ArgoCD)
        GITOPS_REPO -.->|Automated Watch & Self-Heal| ARGOCD[ArgoCD Controller]
        ARGOCD -->|Auto-Sync Manifests| KIND[Kind Kubernetes Cluster]
    end

    subgraph Kubernetes Cluster Workloads
        KIND --> NS_DEV[Namespace: forgeops-dev]
        KIND --> NS_PROD[Namespace: forgeops-prod]
        NS_DEV --> API[api-service Deployment]
        NS_DEV --> WORKER[worker-service Deployment]
        NS_DEV --> SECRETS[Bitnami Sealed Secrets]
    end
```

---

## 📦 Microservices & GitOps Engine Overview

### 1. `api-service` (FastAPI REST API)
- **Role**: Primary API gateway and business logic controller for the platform.
- **Endpoints**:
  - `GET /health` & `GET /ready`: Kubernetes liveness and readiness probe targets.
  - `GET /api/v1/info`: Platform state and environment telemetry.
  - `POST /api/v1/jobs` & `GET /api/v1/jobs`: Enqueue and query deployment pipeline jobs.
  - `GET /metrics`: Prometheus formatted gauge and counter metrics.
- **Tech Stack**: Python 3.11, FastAPI, Uvicorn, Pydantic v2.

### 2. `worker-service` (Async Background Processing Worker)
- **Role**: Consumes enqueued platform tasks, performs background sync and health verification.
- **Health Server**: Exposes lightweight health server on port `8080` for cluster probes.
- **Tech Stack**: Python 3.11, Requests, Pydantic v2.

### 3. GitOps & Secrets Management Engine
- **ArgoCD App-of-Apps**: Automatically watches `gitops/argocd/applications/` to manage multi-environment deployment definitions.
- **Sealed Secrets Controller**: Decrypts committed `SealedSecret` manifests into Kubernetes `v1/Secret` objects safely without plaintext exposure in Git.

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
├── gitops/                # GitOps repository single-source-of-truth
│   ├── dev/               # Development environment values & SealedSecrets
│   ├── staging/           # Staging environment values
│   ├── prod/              # Production environment values & SealedSecrets
│   ├── argocd/            # ArgoCD App-of-Apps and Application manifests
│   └── RUNBOOK.md         # Operational GitOps runbook & sequence diagrams
├── secrets/               # Sealed Secrets installation scripts & docs
├── scripts/               # Automation & verification scripts
│   ├── deploy-local.sh    # Kind load & Helm install automation script
│   ├── verify-day1.py     # Day 1 verification script
│   └── test-gitops-e2e.py # Day 2 GitOps E2E verification script
├── .github/               # GitHub Actions CI/CD workflows
│   └── workflows/
│       ├── ci.yml         # CI pipeline (lint, test, build, trivy scan, push)
│       └── cd-trigger.yml # CD trigger workflow (auto-bump image tags in GitOps repo)
├── README.md
└── forgeops-plan.md
```

---

## 🚀 Quick Start & Verification

### Run End-to-End GitOps Test
```bash
python scripts/test-gitops-e2e.py
```

### Read the GitOps Runbook
See [gitops/RUNBOOK.md](file:///c:/PROJECTS/ForgeOps/gitops/RUNBOOK.md) for detailed ArgoCD operation guidelines and manual sync commands.

---

## 📜 Roadmap

- [x] **Day 1**: Infrastructure, Microservices, Helm Charts & CI Pipeline (21 Commits Completed)
- [x] **Day 2**: GitOps Engine, ArgoCD, Sealed Secrets & Automated Deployment (9 Commits Completed)
- [ ] **Day 3**: Observability, OPA Policy Enforcement, Chaos Testing & IDP Dashboard (17 Commits Planned)

---

## 📄 License
MIT © 2026 Harsh
