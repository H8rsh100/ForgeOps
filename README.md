# ForgeOps — Self-Hosted Internal Developer Platform

[![ForgeOps CI](https://github.com/H8rsh100/ForgeOps/actions/workflows/ci.yml/badge.svg)](https://github.com/H8rsh100/ForgeOps/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

ForgeOps is a production-grade, self-hosted **Internal Developer Platform (IDP)** architecture designed to demonstrate full-lifecycle DevOps, GitOps, Infrastructure-as-Code (IaC), Observability, Policy Enforcement, and Chaos Engineering.

---

## 🏗️ Architecture Overview

ForgeOps unifies modern DevOps tooling into an end-to-end local platform:

- **Infrastructure as Code (IaC)**: Terraform provisioning a Kubernetes (`kind`) cluster with customized node roles and port mappings.
- **Microservices**: Python FastAPI (`api-service`) and a asynchronous background processing worker (`worker-service`).
- **Containerization**: Multi-stage Docker builds with security hardening and non-root execution.
- **Helm Package Management**: Modular Helm charts with environment-specific overrides (`dev`, `staging`, `prod`).
- **Continuous Integration (CI)**: GitHub Actions workflow for linting, testing, Docker image builds, and Trivy security scanning.
- **GitOps Continuous Deployment (CD)**: ArgoCD watching GitOps manifests and enforcing automated synchronization.
- **Secrets Management**: Sealed Secrets controller for encrypted in-git secret management.
- **Observability Stack**: Prometheus, Grafana dashboards, and Loki log aggregation.
- **Policy & Security**: OPA Gatekeeper for Kubernetes policy enforcement and resource constraints.
- **Chaos Engineering**: Automated pod chaos and network fault injection scripts.
- **Platform UI**: React-based unified Developer Dashboard.

---

## 📂 Repository Structure

```text
forgeops/
├── infra/                 # Infrastructure as Code (Terraform & Kind configs)
│   ├── terraform/         # Cluster Terraform modules
│   └── kind-config.yaml   # Kind cluster topology configuration
├── services/              # Microservices source code
│   ├── api-service/       # FastAPI REST API service
│   └── worker-service/    # Background asynchronous worker
├── charts/                # Helm deployment charts
│   ├── api-service/       # API service Helm chart
│   └── worker-service/    # Worker service Helm chart
├── gitops/                # GitOps environment manifests (dev, staging, prod)
├── .github/               # GitHub Actions CI/CD workflows
│   └── workflows/
├── observability/         # Monitoring & Logging (Prometheus, Grafana, Loki)
├── policies/              # Policy as Code (OPA / Gatekeeper)
├── chaos/                 # Chaos engineering scripts
├── dashboard/             # Internal Developer Platform Dashboard
└── README.md
```

---

## 🚀 Quick Start & Prerequisites

### Prerequisites
- [Docker Desktop / Docker Engine](https://www.docker.com/) (v24.0+)
- [Kind (Kubernetes in Docker)](https://kind.sigs.k8s.io/) (v0.20+)
- [Terraform](https://www.terraform.io/) (v1.5+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (v1.27+)
- [Helm](https://helm.sh/) (v3.12+)

---

## 📜 Roadmap

- [x] **Day 1**: Infrastructure, Microservices, Helm Charts & CI Pipeline
- [ ] **Day 2**: GitOps Engine, ArgoCD, Sealed Secrets & Automated Deployment
- [ ] **Day 3**: Observability, OPA Policy Enforcement, Chaos Testing & IDP Dashboard

---

## 📄 License
MIT © 2026 Harsh
