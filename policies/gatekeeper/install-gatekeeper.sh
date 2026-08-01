#!/usr/bin/env bash
# install-gatekeeper.sh — Install OPA Gatekeeper Admission Controller
set -e

GATEKEEPER_VERSION="v3.14.0"

echo "===> Installing OPA Gatekeeper in gatekeeper-system namespace..."
kubectl apply -f "https://raw.githubusercontent.com/open-policy-agent/gatekeeper/${GATEKEEPER_VERSION}/deploy/gatekeeper.yaml"

echo "===> Waiting for OPA Gatekeeper controller deployment..."
kubectl rollout status deployment/gatekeeper-controller-manager -n gatekeeper-system --timeout=120s

echo "===> Verifying Gatekeeper CRDs..."
kubectl get crd | grep gatekeeper.sh

echo "✅ OPA Gatekeeper admission control engine successfully installed and verified!"
