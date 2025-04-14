#!/bin/bash

echo "🔌 Port-forwarding commonly used services..."

# Add more as needed
kubectl port-forward svc/kube-prom-stack-grafana 3000:80 -n monitoring &
kubectl port-forward svc/elasticsearch-master 9200:9200 -n logging &
kubectl port-forward svc/kibana-kibana 5601:5601 -n logging &
kubectl port-forward svc/mongodb 27017:27017 -n data &
kubectl port-forward svc/redis-master 6379:6379 -n data &
kubectl port-forward svc/postgresql 5432:5432 -n data &

echo "🚀 Port forwarding active (Ctrl+C to stop)"
wait

