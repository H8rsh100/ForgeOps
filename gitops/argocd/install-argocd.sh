#!/usr/bin/env bash
# install-argocd.sh — Provisions ArgoCD controller into cluster
set -e

echo "===> Creating argocd namespace..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "===> Applying ArgoCD official manifests..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "===> Waiting for ArgoCD server deployment..."
kubectl rollout status deployment/argocd-server -n argocd --timeout=120s

echo "===> Applying ArgoCD Application manifests..."
kubectl apply -f gitops/argocd/app-of-apps.yaml

echo "✅ ArgoCD successfully installed!"
