#!/bin/bash
set -e

echo "[INFO] Installing Chef Workstation (supports chef-solo) using wget..."

# Ensure wget is available
if ! command -v wget >/dev/null; then
  echo "[INFO] Installing wget..."
  sudo apt-get update
  sudo apt-get install -y wget
fi

# Download the correct package for 22.04
wget https://packages.chef.io/files/stable/chef-workstation/25.5.1084/ubuntu/22.04/chef-workstation_25.5.1084-1_amd64.deb \
  -O /tmp/chef-workstation.deb

echo "[INFO] Installing Chef Workstation package..."
sudo dpkg -i /tmp/chef-workstation.deb
echo "[INFO] Chef installation complete."

# Confirm the install
chef -v
