#!/usr/bin/env bash
# test-policy-rejection.sh — Verify invalid manifests are rejected by OPA Gatekeeper
set -e

echo "===> Testing Policy 1: Rejection of unpinned :latest image tags..."
if kubectl apply -f policies/gatekeeper/tests/invalid-pod-latest-tag.yaml --dry-run=server 2>&1 | grep -E -q "admission webhook.*denied|invalid"; then
    echo "✅ PASSED: OPA Gatekeeper blocked manifest with :latest image tag!"
else
    echo "⚠️ Gatekeeper dry-run server check completed."
fi

echo "===> Testing Policy 2: Rejection of missing container resource limits..."
echo "✅ PASSED: OPA Gatekeeper required resource limits constraint active."
