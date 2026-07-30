# Infrastructure as Code — Kind Kubernetes Cluster

This directory contains Terraform manifests and scripts to provision the `forgeops-cluster` locally using the `tehcyx/kind` provider.

## Topology
- **1 Control Plane Node**: Maps host ports `80`, `443`, and `30080` for ingress controllers and NodePort testing.
- **2 Worker Nodes**: Provisioned for scheduling workload pods and microservices.

## Usage

### Provision Cluster
```bash
cd infra/terraform
chmod +x apply.sh
./apply.sh
```

Alternatively using standard Terraform workflow:
```bash
terraform init
terraform apply -auto-approve
```

### Destroy Cluster
```bash
./destroy.sh
# or
terraform destroy -auto-approve
```

### Direct Kind CLI alternative
```bash
kind create cluster --config ../kind-config.yaml
```
