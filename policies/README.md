# Policy as Code — OPA Gatekeeper

ForgeOps enforces security policies and compliance constraints at admission time using **Open Policy Agent (OPA) Gatekeeper**.

## Enforced Policies
1. **Require Resource Limits**: All pod containers in `forgeops-*` namespaces must declare `cpu` and `memory` limits.
2. **Block `:latest` Image Tags**: Container images with unpinned `:latest` tags are rejected to guarantee deterministic deployments.
