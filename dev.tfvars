# Env var to set the k8 context.  Available options are
# 'kind' and 'docker-desktop'. Defaults to 'docker-desktop'
k8s_env = "docker-desktop"

# Enable/Disable resources. Default behavior is disabled.

# Databases
# enable_redis = true
# enable_postgres = true
enable_mongodb = true
# enable_cassandra = true

# Logging
# enable_elastic_search = true
# enable_kibana = true
# enable_fluent_bit = true
#
# # Monitoring
enable_prom_stack = true
#
# # API Gateways
# enable_nginx = false
# # TODO: Add traefik option for API Gateway.
# # enable_traefik = true
