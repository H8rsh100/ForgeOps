# ForgeOps — Self-Hosted Internal Developer Platform
*A vast, hands-on DevOps learning project — 3 days, 47 commits (21 / 9 / 17) [COMPLETED v1.0.0]*

## Why this project
ForgeOps is a mini **Internal Developer Platform (IDP)**: the same category of system that platform teams at real companies build (think: a scrappy version of what Backstage + ArgoCD + Prometheus gives you). Building it forces you through the *entire* DevOps lifecycle:

- **IaC** — Terraform provisioning a local Kubernetes cluster
- **Containerization** — Dockerized sample microservices
- **CI** — GitHub Actions: lint, test, build, scan, push
- **CD / GitOps** — ArgoCD watching a GitOps repo, auto-syncing to cluster
- **Secrets management** — Sealed Secrets (no plaintext secrets in git)
- **Observability** — Prometheus + Grafana + Loki, real dashboards and alerts
- **Policy & security** — OPA/Gatekeeper admission control + Trivy image scanning
- **Chaos engineering** — scripted pod-kill / network-latency fault injection
- **Platform UI** — a single dashboard tying deploy status, metrics, and alerts together

---

## Complete Project Timeline & Commit Checklist

- [x] **Day 1**: Infrastructure, Microservices, Helm Charts & CI Pipeline (21 Commits Completed)
- [x] **Day 2**: GitOps Engine, ArgoCD, Sealed Secrets & Automated Deployment (9 Commits Completed)
- [x] **Day 3**: Observability, OPA Policy Enforcement, Chaos Testing & IDP Dashboard (17 Commits Completed)

**Total Completed Commits: 47 / 47** 🎉

---
*Tagged Release: v1.0.0*
