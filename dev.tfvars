# Env var to set the k8 context.  Avaliable options are
# 'kind' and 'docker-desktop'. Defaults to 'docker-desktop'
k8s_env = "docker-desktop"

# Enable/Disable resources. Default behavior is disabled.
# Supports only the databases right now.
enable_redis = true
enable_postgres = true
enable_mongodb = true
enable_cassandra = false