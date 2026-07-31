# ForgeOps — Self-Hosted Internal Developer Platform (IDP)

[![ForgeOps CI](https://github.com/H8rsh100/ForgeOps/actions/workflows/ci.yml/badge.svg)](https://github.com/H8rsh100/ForgeOps/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

ForgeOps is a production-grade, self-hosted **Internal Developer Platform (IDP)** architecture built to demonstrate full-lifecycle DevOps, GitOps, Infrastructure-as-Code (IaC), Observability, Policy Enforcement, Chaos Engineering, and Platform Tooling.

---

## 🏗️ Platform Architecture

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

    subgraph GitOps Engine (ArgoCD & Security)
        GITOPS_REPO -.->|Automated Watch & Self-Heal| ARGOCD[ArgoCD Controller]
        ARGOCD -->|Auto-Sync Manifests| KIND[Kind Kubernetes Cluster]
        SECRETS[Bitnami Sealed Secrets] -->|Decrypt Secrets| KIND
    end

    subgraph Governance & Reliability
        OPA[OPA Gatekeeper] -->|Policy Enforcement| KIND
        CHAOS[Chaos Testing Scripts] -->|Fault Injection| KIND
    end

    subgraph Observability & Control Plane
        KIND --> PROM[Prometheus Telemetry]
        KIND --> LOKI[Loki & Promtail Logs]
        PROM --> GRAF[Grafana Dashboards]
        ARGOCD & PROM --> DASH[ForgeOps IDP React Dashboard]
    end
```

---

## 🛠️ Technology Stack & Learning Objectives

| Domain | Technology | Learning Objective & Implementation |
|---|---|---|
| **IaC** | Terraform & Kind | Multi-node Kubernetes cluster topology with port mapping (`main.tf`, `kind-config.yaml`). |
| **Microservices** | Python FastAPI & Worker | REST API gateway (`api-service`) and background processing daemon (`worker-service`). |
| **Containerization** | Docker | Multi-stage hardened builds with non-root security execution. |
| **Packaging** | Helm 3 | Templated deployment charts with tier overrides (`dev`, `staging`, `prod`). |
| **CI Pipeline** | GitHub Actions | Automated linting, pytest, Helm verification, Docker build, and Trivy CVE scanning. |
| **GitOps CD** | ArgoCD | Declarative App-of-Apps continuous deployment with automated self-healing. |
| **Secrets** | Sealed Secrets | Asymmetric in-git credential encryption without plaintext exposure. |
| **Observability** | Prometheus, Grafana, Loki | Full-stack metrics scraping, log aggregation, and custom alerting rules. |
| **Policy as Code** | OPA Gatekeeper | Rego admission constraints blocking `:latest` tags and requiring resource limits. |
| **Chaos Eng.** | Bash / Traffic Control | Automated pod-kill and network latency fault injection testing. |
| **Platform UI** | React | Single-pane-of-glass IDP dashboard pulling deployment status and telemetry metrics. |

---

## 📂 Repository Structure

```text
forgeops/
├── infra/                 # Infrastructure as Code (Terraform & Kind configs)
├── services/              # Microservices (api-service & worker-service)
├── charts/                # Helm deployment charts (api-service & worker-service)
├── gitops/                # GitOps environment manifests & ArgoCD App-of-Apps
├── secrets/               # Sealed Secrets controller setup & docs
├── observability/         # Prometheus, Grafana, Loki & alerting rules
├── policies/              # OPA Gatekeeper policy templates & constraints
├── chaos/                 # Pod-kill & network latency chaos test scripts
├── dashboard/             # React Platform IDP UI dashboard
├── scripts/               # Automated local deploy & E2E verification tools
└── README.md
```

---

## 🚀 Quick Start Guide

### 1. Provision Infrastructure
```bash
cd infra/terraform
./apply.sh
```

### 2. Install ArgoCD & Sealed Secrets
```bash
./gitops/argocd/install-argocd.sh
./secrets/install-sealed-secrets.sh
```

### 3. Deploy Observability & Policies
```bash
./observability/prometheus/install-prometheus.sh
./observability/grafana/install-grafana.sh
./policies/gatekeeper/install-gatekeeper.sh
```

### 4. Run End-to-End Verification
```bash
python scripts/test-gitops-e2e.py
bash chaos/run-chaos-suite.sh
```

---

## 📜 Complete 3-Day Roadmap

- [x] **Day 1**: Infrastructure, Microservices, Helm Charts & CI Pipeline (21 Commits Completed)
- [x] **Day 2**: GitOps Engine, ArgoCD, Sealed Secrets & Automated Deployment (9 Commits Completed)
- [x] **Day 3**: Observability, OPA Policy Enforcement, Chaos Testing & IDP Dashboard (17 Commits Completed)

---

## 📄 License
MIT © 2026 Harsh
