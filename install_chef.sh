#!/bin/bash

set -e

echo "[INFO] Installing Chef Solo with wget..."

# Make sure wget and required tools are installed
sudo apt-get update
sudo apt-get install -y wget curl gnupg

# Download and install the Chef installer script
wget https://omnitruck.chef.io/install.sh -O install.sh
sudo bash install.sh -v 16.18.14

# Verify installation
if ! command -v chef-solo &>/dev/null; then
  echo "[ERROR] Chef Solo installation failed."
  exit 1
fi

echo "[INFO] Chef Solo installed successfully."
