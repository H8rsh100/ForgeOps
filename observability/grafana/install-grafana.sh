#!/usr/bin/env bash
# install-grafana.sh — Provision Grafana Visualization Engine with Automated Datasource Config
set -e

echo "===> Adding Grafana Helm repository..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "===> Installing Grafana into monitoring namespace..."
helm upgrade --install grafana grafana/grafana \
  --namespace monitoring \
  --set adminPassword="admin" \
  --set service.type=NodePort \
  --set service.nodePort=30080 \
  --set sidecar.dashboards.enabled=true \
  --set sidecar.datasources.enabled=true

echo "✅ Grafana visualization stack active at http://localhost:30080 (admin/admin)"
