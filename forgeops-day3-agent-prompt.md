You are finishing "ForgeOps", a self-hosted Internal Developer Platform for DevOps learning.
Day 1 done: kind cluster, api-service + worker-service deployed via Helm, CI green.
Day 2 done: ArgoCD GitOps loop closed — push → CI builds/scans/pushes → cd-trigger bumps
gitops repo → ArgoCD auto-syncs cluster. Secrets sealed via Sealed Secrets.

Execute ONLY Day 3 of the plan as 17 separate git commits, one per listed item, in order.
Each commit must be a real, working, incremental change — no placeholder/empty commits.
After each commit, verify it actually works (dashboard renders, alert fires, policy
actually rejects a bad manifest, chaos test actually recovers) before moving on.

Stack for today: Prometheus + kube-state-metrics, Grafana, Loki + Promtail, OPA Gatekeeper,
a couple of chaos scripts, and a React dashboard that pulls from ArgoCD + Prometheus APIs.

Day 3 commit list (do exactly these, in this order):
1. feat(observability): install Prometheus + kube-state-metrics
2. feat(observability): install Grafana + datasource config
3. feat(observability): build service health dashboard
4. feat(observability): install Loki + Promtail for log aggregation
5. feat(observability): add alerting rule (e.g. high error rate, pod crashloop)
6. feat(policies): install OPA Gatekeeper
7. feat(policies): constraint template — require resource limits
8. feat(policies): constraint template — block `:latest` image tags
9. test(policies): verify a bad manifest gets rejected
10. feat(chaos): pod-kill script targeting api-service
11. feat(chaos): network-latency injection script
12. test(chaos): run chaos test, confirm ArgoCD/k8s self-heals
13. feat(dashboard): scaffold React platform dashboard
14. feat(dashboard): deploy status panel (pulls from ArgoCD API)
15. feat(dashboard): metrics panel (pulls from Prometheus API)
16. docs: full README — architecture, setup, what-you-learn summary
17. chore: final polish, screenshots/gifs, tag v1.0

End state: Grafana shows live service health + logs, an alert actually fires under a
simulated fault, Gatekeeper actually blocks a bad manifest (don't just install it —
prove it rejects), a chaos script kills a pod and you can show ArgoCD/k8s bringing it
back, and the React dashboard gives a single-pane view of deploy status + metrics.
Tag v1.0 at the end — this is the full ForgeOps v1 platform.
