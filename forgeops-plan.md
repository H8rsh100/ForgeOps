# ForgeOps — Self-Hosted Internal Developer Platform
*A vast, hands-on DevOps learning project — 3 days, 47 commits (21 / 9 / 17)*

## Why this project
You said you're learning DevOps right now and want something vast enough to actually learn from — not a toy CI pipeline. ForgeOps is a mini **Internal Developer Platform (IDP)**: the same category of system that platform teams at real companies build (think: a scrappy version of what Backstage + ArgoCD + Prometheus gives you). Building it forces you through the *entire* DevOps lifecycle instead of one slice of it:

- **IaC** — Terraform provisioning a local Kubernetes cluster
- **Containerization** — Dockerized sample microservices
- **CI** — GitHub Actions: lint, test, build, scan, push
- **CD / GitOps** — ArgoCD watching a GitOps repo, auto-syncing to cluster
- **Secrets management** — Sealed Secrets (no plaintext secrets in git)
- **Observability** — Prometheus + Grafana + Loki, real dashboards and alerts
- **Policy & security** — OPA/Gatekeeper admission control + Trivy image scanning
- **Chaos engineering** — scripted pod-kill / network-latency fault injection
- **Platform UI** — a single dashboard tying deploy status, metrics, and alerts together

By the end you'll have touched Terraform, Kubernetes, Helm, GitHub Actions, ArgoCD, Prometheus/Grafana, OPA, and basic chaos testing — the exact stack DevOps/Platform job specs list.

---

## Repo scaffold

```
forgeops/
├── infra/
│   ├── terraform/
│   │   ├── main.tf              # kind cluster provisioning
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── kind-config.yaml
├── services/
│   ├── api-service/             # simple FastAPI service (the "app" being deployed)
│   │   ├── main.py
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   └── worker-service/          # simple background worker (2nd service, for realism)
│       ├── worker.py
│       └── Dockerfile
├── charts/
│   ├── api-service/             # Helm chart
│   └── worker-service/
├── gitops/
│   ├── dev/
│   ├── staging/
│   └── prod/                    # ArgoCD Application manifests per env
├── .github/
│   └── workflows/
│       ├── ci.yml               # lint/test/build/scan/push
│       └── cd-trigger.yml       # bumps image tag in gitops/ repo
├── observability/
│   ├── prometheus/
│   ├── grafana/
│   │   └── dashboards/
│   └── loki/
├── policies/
│   └── gatekeeper/               # OPA constraint templates + constraints
├── chaos/
│   └── pod-kill.sh
├── dashboard/                    # platform UI (React) — ties it all together
│   ├── src/
│   └── package.json
└── README.md
```

---

## Day 1 — Today — 21 commits
**Goal: cluster up, services containerized, CI green, Helm deploy working manually.**

1. `chore: init repo structure + README skeleton`
2. `feat(infra): add kind cluster config`
3. `feat(infra): terraform provider + kind cluster resource`
4. `feat(infra): terraform variables + outputs`
5. `feat(infra): terraform apply script + docs`
6. `feat(api-service): scaffold FastAPI app with health endpoint`
7. `feat(api-service): add core route + basic logic`
8. `feat(api-service): Dockerfile + .dockerignore`
9. `test(api-service): add pytest unit tests`
10. `feat(worker-service): scaffold background worker`
11. `feat(worker-service): Dockerfile`
12. `chore: docker-compose for local dev (pre-k8s sanity check)`
13. `feat(charts): api-service Helm chart skeleton`
14. `feat(charts): worker-service Helm chart skeleton`
15. `feat(charts): values.yaml per environment (dev/staging/prod)`
16. `feat(ci): GitHub Actions workflow — lint + test`
17. `feat(ci): add Docker build + push to registry step`
18. `feat(ci): add Trivy image scan step`
19. `docs: architecture diagram + service overview in README`
20. `fix: manual helm install to kind cluster, resolve issues`
21. `chore: day 1 wrap — verify full local deploy end-to-end`

## Day 2 — Tomorrow — 9 commits
**Goal: GitOps loop closed — CI updates image tag, ArgoCD auto-deploys, secrets are sealed.**

1. `feat(gitops): create gitops/ repo structure for dev/staging/prod`
2. `feat(argocd): install ArgoCD into cluster + Application manifests`
3. `feat(ci): cd-trigger workflow — bump image tag in gitops repo on merge`
4. `feat(secrets): install Sealed Secrets controller`
5. `feat(secrets): seal a real secret (e.g. DB creds) and reference in chart`
6. `feat(gitops): configure ArgoCD sync policy (auto-sync + self-heal)`
7. `test: end-to-end — push code change, watch it auto-deploy via ArgoCD`
8. `fix: resolve sync/drift issues from e2e test`
9. `docs: GitOps flow diagram + runbook`

## Day 3 — Day after — 17 commits
**Goal: observability, policy enforcement, chaos test, and the platform dashboard.**

1. `feat(observability): install Prometheus + kube-state-metrics`
2. `feat(observability): install Grafana + datasource config`
3. `feat(observability): build service health dashboard`
4. `feat(observability): install Loki + Promtail for log aggregation`
5. `feat(observability): add alerting rule (e.g. high error rate, pod crashloop)`
6. `feat(policies): install OPA Gatekeeper`
7. `feat(policies): constraint template — require resource limits`
8. `feat(policies): constraint template — block `:latest` image tags`
9. `test(policies): verify a bad manifest gets rejected`
10. `feat(chaos): pod-kill script targeting api-service`
11. `feat(chaos): network-latency injection script`
12. `test(chaos): run chaos test, confirm ArgoCD/k8s self-heals`
13. `feat(dashboard): scaffold React platform dashboard`
14. `feat(dashboard): deploy status panel (pulls from ArgoCD API)`
15. `feat(dashboard): metrics panel (pulls from Prometheus API)`
16. `docs: full README — architecture, setup, what-you-learn summary`
17. `chore: final polish, screenshots/gifs, tag v1.0`

---

## Agent prompt — Day 1 only
*(Hand this to your coding agent to execute today's 21 commits. I'll give you Day 2 and Day 3 prompts separately when you get there, per your usual setup.)*

```
You are building "ForgeOps", a self-hosted Internal Developer Platform for DevOps learning.
Execute ONLY Day 1 of the plan below as 21 separate git commits, one per listed item, in order.
Each commit must be a real, working, incremental change — no placeholder/empty commits.
After each commit, run relevant tests/builds before moving to the next.

Stack: Terraform (kind provider), Docker, FastAPI (api-service), a simple Python worker
(worker-service), Helm charts for both, GitHub Actions CI (lint, test, build, Trivy scan,
push to a registry).

Day 1 commit list (do exactly these, in this order):
1. chore: init repo structure + README skeleton
2. feat(infra): add kind cluster config
3. feat(infra): terraform provider + kind cluster resource
4. feat(infra): terraform variables + outputs
5. feat(infra): terraform apply script + docs
6. feat(api-service): scaffold FastAPI app with health endpoint
7. feat(api-service): add core route + basic logic
8. feat(api-service): Dockerfile + .dockerignore
9. test(api-service): add pytest unit tests
10. feat(worker-service): scaffold background worker
11. feat(worker-service): Dockerfile
12. chore: docker-compose for local dev (pre-k8s sanity check)
13. feat(charts): api-service Helm chart skeleton
14. feat(charts): worker-service Helm chart skeleton
15. feat(charts): values.yaml per environment (dev/staging/prod)
16. feat(ci): GitHub Actions workflow — lint + test
17. feat(ci): add Docker build + push to registry step
18. feat(ci): add Trivy image scan step
19. docs: architecture diagram + service overview in README
20. fix: manual helm install to kind cluster, resolve issues
21. chore: day 1 wrap — verify full local deploy end-to-end

End of day, the cluster should be running locally via kind, both services deployed via
helm install manually, and CI should be green on GitHub. Do not touch ArgoCD, GitOps repo
structure, observability, or policy enforcement — those are Day 2/3.
```
