#!/bin/bash

set -e

echo "[INFO] Installing Chef Workstation..."
curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-workstation
echo "[INFO] Chef Workstation installed successfully."

# Verify install
chef --version
