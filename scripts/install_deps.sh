#!/bin/bash
set -e

./install_tooling.sh || { echo "❌ Failed to install tooling."; exit 1; }
./install_databases.sh || { echo "❌ Failed to install dataabases."; exit 1; }
./install_monitoring.sh || { echo "❌ Failed to install monitoring debs."; exit 1; }
./install_logging.sh || { echo "❌ Failed to install logging deps."; exit 1; }
./port_forward.sh || { echo "❌ Failed to port forward ports."; exit 1; }

echo  "✅All dependencies up and running!"
