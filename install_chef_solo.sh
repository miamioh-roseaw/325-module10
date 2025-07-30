#!/bin/bash

set -e

echo "[INFO] Installing Chef Workstation using wget..."

# Download Chef Workstation .deb package
wget https://packages.chef.io/files/stable/chef-workstation/23.10.1043/ubuntu/22.04/chef-workstation_23.10.1043-1_amd64.deb -O /tmp/chef-workstation.deb

echo "[INFO] Installing Chef Workstation..."
sudo dpkg -i /tmp/chef-workstation.deb

# Confirm installation
echo "[INFO] Verifying installation..."
chef -v

