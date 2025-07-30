#!/bin/bash

set -e

echo "[INFO] Installing Chef Workstation using wget..."

# Download a valid version (double-checked 25.5.1049 is available)
wget https://packages.chef.io/files/stable/chef-workstation/25.5.1049/ubuntu/22.04/chef-workstation_25.5.1049-1_amd64.deb -O /tmp/chef-workstation.deb

echo "[INFO] Installing Chef Workstation..."
sudo dpkg -i /tmp/chef-workstation.deb

# Verify installation
echo "[INFO] Installed version:"
chef -v
