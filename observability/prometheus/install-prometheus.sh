#!/usr/bin/env bash
# install-prometheus.sh — Install Prometheus & kube-state-metrics in monitoring namespace
set -e

echo "===> Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "===> Adding prometheus-community Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "===> Installing kube-state-metrics..."
helm upgrade --install kube-state-metrics prometheus-community/kube-state-metrics \
  --namespace monitoring

echo "===> Installing Prometheus stack..."
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --set server.persistentVolume.enabled=false

echo "✅ Prometheus & kube-state-metrics installed successfully!"
