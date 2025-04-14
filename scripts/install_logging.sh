#!/bin/bash
set -e

NAMESPACE="logging"

echo "📁 Creating $NAMESPACE namespace..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

deploy_chart() {
  local name=$1
  local chart=$2

  echo "📦 Installing $name..."
  helm upgrade --install $name $chart --namespace $NAMESPACE || {
    echo "❌ Failed to install $name"
    exit 1
  }
}

deploy_chart elasticsearch elastic/elasticsearch
deploy_chart kibana elastic/kibana
deploy_chart fluent-bit fluent/fluent-bit

echo "✅ Logging stack deployed (Elasticsearch, Kibana, Fluent Bit)"

