terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

# -------------------------
# NAMESPACES
# -------------------------
resource "kubernetes_namespace" "apps" {
  metadata {
    name = "apps"
  }
}

resource "kubernetes_namespace" "data" {
  metadata {
    name = "data"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}

# -------------------------
# DATABASES
# -------------------------
resource "helm_release" "mongodb" {
  name       = "mongodb"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = "13.6.4"
  count = local.mongodb_count
  namespace  = kubernetes_namespace.data.metadata[0].name
  values     = [file("${path.module}/helm-values/${local.kube_context}/mongodb-values.yaml")]
}

resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = kubernetes_namespace.data.metadata[0].name
  version = "17.11.3"
  count = local.redis_count
  values = [file("${path.module}/helm-values/${local.kube_context}/redis-values.yaml")]
}

resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.data.metadata[0].name
  version = "12.5.6"
  count = local.postgres_count
  values = [file("${path.module}/helm-values/${local.kube_context}/postgresql-values.yaml")]
}

resource "helm_release" "cassandra" {
  name       = "cassandra"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "cassandra"
  namespace  = kubernetes_namespace.data.metadata[0].name
  version = "9.2.2"
  count = local.cassandra_count
  values = [file("${path.module}/helm-values/${local.kube_context}/cassandra-values.yaml")]
}

# -------------------------
# MONITORING
# -------------------------
resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prom-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  timeout    = 600
  version    = "45.6.0"
  values = [file("${path.module}/helm-values/${local.kube_context}/kube-prometheus-stack-values.yaml")]
}

data "kubernetes_secret" "grafana" {
  metadata {
    name      = "kube-prom-stack-grafana"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
}

# -------------------------
# LOGGING
# -------------------------
resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  namespace  = kubernetes_namespace.logging.metadata[0].name
  version    = "7.17.3"

  # Optional custom values file
  values = [file("${path.module}/helm-values/${local.kube_context}/elasticsearch-values.yaml")]
}

resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  namespace  = kubernetes_namespace.logging.metadata[0].name
  version = "7.17.3"
  values = [file("${path.module}/helm-values/${local.kube_context}/kibana-values.yaml")]

}

resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  namespace  = kubernetes_namespace.logging.metadata[0].name
  values = [file("${path.module}/helm-values/${local.kube_context}/fluent-bit-values.yaml")]
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "15.5.2"  # ✅ known valid version
  namespace  = kubernetes_namespace.apps.metadata[0].name

  values = [file("${path.module}/helm-values/${local.kube_context}/nginx-values.yaml")]
}


