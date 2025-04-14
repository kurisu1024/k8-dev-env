# 🟢 GRAFANA ADMIN PASSWORD
locals {
  grafana_admin_raw = try(tostring(data.kubernetes_secret.grafana.data["admin-password"]), "")
  grafana_admin_decoded = try(base64decode(local.grafana_admin_raw), null)
}

output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = local.grafana_admin_decoded
  sensitive   = true
}

# 🌐 GRAFANA URL (local forwarding)
output "grafana_url" {
  description = "Grafana local URL (port-forward required)"
  value       = "http://localhost:3000"
}

# 🌐 KIBANA URL (local forwarding)
output "kibana_url" {
  description = "Kibana local URL (port-forward required)"
  value       = "http://localhost:5601"
}