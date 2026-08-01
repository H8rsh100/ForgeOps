#!/usr/bin/env bash
# install-prometheus.sh — Provision Prometheus Telemetry Engine & kube-state-metrics
set -e

echo "===> Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "===> Adding prometheus-community Helm repository..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "===> Installing kube-state-metrics exporter..."
helm upgrade --install kube-state-metrics prometheus-community/kube-state-metrics \
  --namespace monitoring

echo "===> Installing Prometheus server..."
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --set server.persistentVolume.enabled=false \
  --set server.service.type=NodePort

echo "✅ Prometheus & kube-state-metrics successfully deployed!"
