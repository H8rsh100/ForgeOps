#!/usr/bin/env bash
# deploy-local.sh — Deploy ForgeOps services to local Kind cluster via Helm
set -e

CLUSTER_NAME="forgeops-cluster"
NAMESPACE="forgeops-dev"

echo "===> Checking Kind Cluster status..."
if ! kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "Creating Kind cluster using topology config..."
    kind create cluster --config infra/kind-config.yaml
else
    echo "Kind cluster '${CLUSTER_NAME}' already exists."
fi

echo "===> Building local Docker container images..."
docker build -t forgeops/api-service:dev-latest ./services/api-service
docker build -t forgeops/worker-service:dev-latest ./services/worker-service

echo "===> Loading Docker images into Kind cluster nodes..."
kind load docker-image forgeops/api-service:dev-latest --name "${CLUSTER_NAME}"
kind load docker-image forgeops/worker-service:dev-latest --name "${CLUSTER_NAME}"

echo "===> Ensuring Kubernetes namespace '${NAMESPACE}' exists..."
kubectl create namespace "${NAMESPACE}" --dry-run=client -o yaml | kubectl apply -f -

echo "===> Installing/Upgrading api-service Helm release..."
helm upgrade --install api-service ./charts/api-service \
  --namespace "${NAMESPACE}" \
  -f ./charts/api-service/values-dev.yaml \
  --set image.repository=forgeops/api-service \
  --set image.tag=dev-latest \
  --set image.pullPolicy=Never

echo "===> Installing/Upgrading worker-service Helm release..."
helm upgrade --install worker-service ./charts/worker-service \
  --namespace "${NAMESPACE}" \
  -f ./charts/worker-service/values-dev.yaml \
  --set image.repository=forgeops/worker-service \
  --set image.tag=dev-latest \
  --set image.pullPolicy=Never \
  --set env.apiServiceUrl="http://api-service:8000"

echo "===> Waiting for deployments to achieve Ready state..."
kubectl rollout status deployment/api-service -n "${NAMESPACE}" --timeout=60s
kubectl rollout status deployment/worker-service -n "${NAMESPACE}" --timeout=60s

echo "✅ All ForgeOps services successfully deployed to Kind cluster!"
kubectl get pods,svc -n "${NAMESPACE}"
