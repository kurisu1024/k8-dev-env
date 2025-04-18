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

locals {
  kube_context = var.k8s_env == "kind" ? "kind-dev" : "docker-desktop"
  redis_count = var.enable_redis ? 1 : 0
  postgres_count = var.enable_postgres ? 1 : 0
  mongodb_count = var.enable_mongodb ? 1 : 0
  cassandra_count = var.enable_cassandra ? 1 : 0
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

