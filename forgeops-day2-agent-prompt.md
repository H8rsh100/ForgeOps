You are continuing "ForgeOps", a self-hosted Internal Developer Platform for DevOps learning.
Day 1 is done: kind cluster running locally, api-service + worker-service deployed via
manual `helm install`, CI green on GitHub (lint, test, build, Trivy scan, push).

Execute ONLY Day 2 of the plan as 9 separate git commits, one per listed item, in order.
Each commit must be a real, working, incremental change — no placeholder/empty commits.
After each commit, verify it actually works (cluster state, ArgoCD UI/API, sync status)
before moving to the next.

Stack for today: ArgoCD (GitOps controller), a separate gitops/ repo structure per
environment (dev/staging/prod), Sealed Secrets controller, and a CI workflow update that
bumps the image tag in the gitops repo instead of deploying directly.

Day 2 commit list (do exactly these, in this order):
1. feat(gitops): create gitops/ repo structure for dev/staging/prod
2. feat(argocd): install ArgoCD into cluster + Application manifests
3. feat(ci): cd-trigger workflow — bump image tag in gitops repo on merge
4. feat(secrets): install Sealed Secrets controller
5. feat(secrets): seal a real secret (e.g. DB creds) and reference in chart
6. feat(gitops): configure ArgoCD sync policy (auto-sync + self-heal)
7. test: end-to-end — push code change, watch it auto-deploy via ArgoCD
8. fix: resolve sync/drift issues from e2e test
9. docs: GitOps flow diagram + runbook

End of day, pushing a code change to api-service or worker-service should flow: CI builds
+ scans + pushes image → cd-trigger bumps tag in gitops repo → ArgoCD detects drift →
auto-syncs → cluster updates itself, with no manual `helm install` or `kubectl apply`.
Secrets must be sealed in git, never plaintext. Do not touch observability, policy
enforcement (OPA), chaos testing, or the dashboard — those are Day 3.
