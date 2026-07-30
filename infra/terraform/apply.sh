#!/usr/bin/env bash
# apply.sh — Terraform provisioning script for ForgeOps Kind Cluster
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "===> Initializing Terraform..."
terraform init

echo "===> Planning Terraform deployment..."
terraform plan -out=tfplan

echo "===> Applying Terraform plan..."
terraform apply -auto-approve tfplan
rm -f tfplan

echo "===> Verifying cluster status..."
kubectl cluster-info --context kind-forgeops-cluster
kubectl get nodes -o wide

echo "✅ Kind Cluster 'forgeops-cluster' is ready!"
