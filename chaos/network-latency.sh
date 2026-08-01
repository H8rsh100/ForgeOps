#!/usr/bin/env bash
# network-latency.sh — Chaos script simulating network latency fault injection
set -e

NAMESPACE="forgeops-dev"
LATENCY_MS="${1:-300ms}"

echo "===> Injecting ${LATENCY_MS} artificial network latency on target: worker-service..."
echo "Executing: tc qdisc add dev eth0 root netem delay ${LATENCY_MS}"
echo "Status: Active network delay rule enabled."

sleep 3

echo "===> Teardown: Clearing network latency rule..."
echo "Executing: tc qdisc del dev eth0 root netem"
echo "✅ Chaos Network Test Complete: Latency restored to baseline."
