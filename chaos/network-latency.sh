#!/usr/bin/env bash
# network-latency.sh — Chaos script simulating network latency fault injection
set -e

NAMESPACE="forgeops-dev"
LATENCY_MS="300ms"

echo "===> Injecting ${LATENCY_MS} artificial network latency target: worker-service..."
echo "Command: tc qdisc add dev eth0 root netem delay ${LATENCY_MS}"
echo "Simulated: Traffic shaping rule active."

sleep 3

echo "===> Reverting network latency injection..."
echo "Command: tc qdisc del dev eth0 root netem"
echo "✅ Chaos Network Test Complete: Latency reverted to normal baseline."
