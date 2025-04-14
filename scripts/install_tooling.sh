#!/bin/bash
set -e

echo "🛠 Installing Helm..."
if ! command -v helm &>/dev/null; then
  brew install helm || { echo "❌ Failed to install Helm"; exit 1; }
else
  echo "✅ Helm already installed"
fi

echo "📦 Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami || { echo "❌ Failed to add Bitnami repo"; exit 1; }
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts || exit 1
helm repo add elastic https://helm.elastic.co || exit 1
helm repo add fluent https://fluent.github.io/helm-charts || exit 1
helm repo update || { echo "❌ Helm repo update failed"; exit 1; }

echo "✅ Helm repos ready"
