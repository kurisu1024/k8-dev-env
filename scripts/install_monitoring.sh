#!/bin/bash
set -e

NAMESPACE="monitoring"

echo "📁 Creating $NAMESPACE namespace..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "📈 Installing Prometheus & Grafana stack..."
helm upgrade --install kube-prom-stack prometheus-community/kube-prometheus-stack --namespace $NAMESPACE || {
  echo "❌ Failed to install monitoring stack"
  exit 1
}

echo "⏳ Waiting for Grafana to be ready..."
kubectl rollout status deployment/kube-prom-stack-grafana -n $NAMESPACE --timeout=120s || {
  echo "❌ Grafana failed to become ready"
  exit 1
}

echo "🔐 Grafana credentials:"
kubectl get secret kube-prom-stack-grafana -n $NAMESPACE -o jsonpath="{.data.admin-password}" | base64 --decode && echo

echo "✅ Monitoring stack ready"

