#!/usr/bin/env bash
# install-sealed-secrets.sh — Install Bitnami Sealed Secrets Controller in Kind Cluster
set -e

SEALED_SECRETS_VERSION="v0.26.0"

echo "===> Installing Sealed Secrets Controller in kube-system namespace..."
kubectl apply -f "https://github.com/bitnami-labs/sealed-secrets/releases/download/${SEALED_SECRETS_VERSION}/controller.yaml"

echo "===> Waiting for Sealed Secrets controller to become ready..."
kubectl rollout status deployment/sealed-secrets-controller -n kube-system --timeout=90s

echo "✅ Sealed Secrets controller is active and ready to encrypt secrets!"
