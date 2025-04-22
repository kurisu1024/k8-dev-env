variable "k8s_env" {
  description = "Which Kubernetes environment to target (kind or docker-desktop)"
  type        = string
  default     = "docker-desktop"
}

variable "enable_redis" {
  description = "Enable Redis"
  type        = bool
  default     = false
}

variable "enable_postgres" {
  description = "Enable Postgres"
  type        = bool
  default     = false
}

variable "enable_mongodb" {
  description = "Enable MongoDB"
  type        = bool
  default     = false
}

variable "enable_cassandra" {
  description = "Enable Cassandra"
  type        = bool
  default     = false
}

variable "enable_prom_stack" {
  description = "Enable Prometheus and Grafana"
  type        = bool
  default     = false
}

variable "enable_elastic_search" {
  description = "Enable elastic search"
  type        = bool
  default     = false
}

variable "enable_kibana" {
  description = "Enable kibana"
  type        = bool
  default     = false
}

variable "enable_fluent_bit" {
  description = "Enable fluent-bit"
  type        = bool
  default     = false
}

variable "enable_nginx" {
  description = "Enable nginx"
  type        = bool
  default     = false
}

locals {
  kube_context = var.k8s_env == "kind" ? "kind-dev" : "docker-desktop"
  redis_count = var.enable_redis ? 1 : 0
  postgres_count = var.enable_postgres ? 1 : 0
  mongodb_count = var.enable_mongodb ? 1 : 0
  cassandra_count = var.enable_cassandra ? 1 : 0
  prom_stack_count = var.enable_prom_stack ? 1 : 0
  elastic_search_count = var.enable_elastic_search ? 1 : 0
  kibana_count = var.enable_kibana ? 1 : 0
  fluent_bit_count = var.enable_fluent_bit ? 1 : 0
  nginx_count = var.enable_nginx ? 1 : 0

  # Prometheus stack dependencies
  # Individual dependencies
  mongodb_deps = var.enable_mongodb ? [helm_release.mongodb[0]] : []
  # redis_deps = var.enable_redis ? [helm_release.redis[0]] : []
  # postgres_deps = var.enable_postgres ? [helm_release.postgresql[0]] : []
  # cassandra_deps = var.enable_cassandra ? [helm_release.cassandra[0]] : []

  # Combined dependencies
  prom_stack_deps = concat(
    local.mongodb_deps,
    # local.redis_deps,
    # local.postgres_deps,
    # local.cassandra_deps
  )
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = local.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = local.kube_context
  }
}

