#!/bin/bash
set -e

NAMESPACE="data"

echo "📁 Creating $NAMESPACE namespace..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

deploy_chart() {
  local name=$1
  local chart=$2

  echo "🚀 Installing $name..."
  helm upgrade --install $name $chart --namespace $NAMESPACE || {
    echo "❌ Failed to install $name"
    exit 1
  }
}

deploy_chart mongodb bitnami/mongodb
deploy_chart redis bitnami/redis
deploy_chart cassandra bitnami/cassandra
deploy_chart postgresql bitnami/postgresql

echo "✅ All databases deployed"

