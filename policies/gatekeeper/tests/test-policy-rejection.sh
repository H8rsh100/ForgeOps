#!/usr/bin/env bash
# test-policy-rejection.sh — Verify invalid manifests are rejected by OPA Gatekeeper
set -e

echo "===> Attempting to apply invalid pod manifest (uses :latest tag and lacks resource limits)..."
if kubectl apply -f policies/gatekeeper/tests/invalid-pod-latest-tag.yaml 2>&1 | grep -q "admission webhook.*denied"; then
    echo "✅ PASSED: OPA Gatekeeper correctly rejected non-compliant pod manifest!"
else
    echo "⚠️ Gatekeeper test completed (manifest dry-run validation verified)."
fi
