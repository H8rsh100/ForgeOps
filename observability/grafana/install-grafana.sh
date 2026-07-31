#!/usr/bin/env bash
# install-grafana.sh — Install Grafana visualization dashboard engine
set -e

echo "===> Adding Grafana Helm repo..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "===> Installing Grafana into monitoring namespace..."
helm upgrade --install grafana grafana/grafana \
  --namespace monitoring \
  --set adminPassword="admin" \
  --set service.type=NodePort \
  --set service.nodePort=30080

echo "✅ Grafana installed! Available at http://localhost:30080 (Username: admin / Password: admin)"
