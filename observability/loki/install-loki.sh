#!/usr/bin/env bash
# install-loki.sh — Install Loki + Promtail for log aggregation
set -e

echo "===> Adding Grafana Helm repo for Loki & Promtail..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "===> Installing Loki log engine in monitoring namespace..."
helm upgrade --install loki grafana/loki-stack \
  --namespace monitoring \
  --set promtail.enabled=true \
  --set loki.persistence.enabled=false

echo "✅ Loki + Promtail log aggregation stack successfully installed!"
