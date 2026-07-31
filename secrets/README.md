# Sealed Secrets Management in ForgeOps

ForgeOps utilizes [Bitnami Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets) to safely store encrypted credentials directly inside public/private Git repositories without exposing plaintext secrets.

## How it Works
1. **Asymmetric Encryption**: The Sealed Secrets controller running in `kube-system` generates a public/private keypair.
2. **Offline Encryption (`kubeseal`)**: Developers encrypt standard Kubernetes Secret YAML files using the public key with `kubeseal`.
3. **Decryption on Cluster**: The resulting `SealedSecret` CRD manifest is committed to Git. When ArgoCD deploys the manifest to Kubernetes, the controller decrypts it into a standard `v1/Secret`.

## Command Workflow

```bash
# 1. Create a standard local secret manifest (DO NOT COMMIT THIS FILE)
kubectl create secret generic api-db-credentials \
  --from-literal=DB_PASSWORD="SuperSecretPassword123!" \
  --dry-run=client -o yaml > raw-secret.yaml

# 2. Encrypt using kubeseal
kubeseal --controller-name=sealed-secrets-controller \
  --controller-namespace=kube-system \
  < raw-secret.yaml > gitops/dev/api-db-sealedsecret.yaml

# 3. Safely commit gitops/dev/api-db-sealedsecret.yaml to Git
git add gitops/dev/api-db-sealedsecret.yaml
git commit -m "feat(secrets): add sealed secret for DB creds"
```
