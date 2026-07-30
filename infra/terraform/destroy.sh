#!/usr/bin/env bash
# destroy.sh — Teardown script for ForgeOps Kind Cluster
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "===> Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

echo "✅ Kind Cluster destroyed successfully."
