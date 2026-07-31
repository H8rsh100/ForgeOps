# GitOps Repository Structure

This directory serves as the GitOps single-source-of-truth for environment configurations across `dev`, `staging`, and `prod`.

## Directory Layout
```text
gitops/
├── dev/
│   ├── api-service-values.yaml
│   └── worker-service-values.yaml
├── staging/
│   ├── api-service-values.yaml
│   └── worker-service-values.yaml
└── prod/
    ├── api-service-values.yaml
    └── worker-service-values.yaml
```

## How it works
1. Continuous Integration (CI) builds and tests container images.
2. Upon merging to `main`, the `cd-trigger` workflow automatically updates the image tags in `gitops/<env>/`.
3. ArgoCD monitors this directory and reconciles the target Kubernetes cluster to match the declared state.
