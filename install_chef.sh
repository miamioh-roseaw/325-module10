#!/bin/bash

echo "[INFO] Updating packages and installing wget..."
sudo apt-get update
sudo apt-get install -y wget

if ! command -v wget &>/dev/null; then
  echo "[ERROR] wget installation failed or wget not found in PATH."
  exit 1
fi

echo "[INFO] wget is installed. Proceeding to download Chef Workstation..."

WGET_URL="https://packages.chef.io/files/stable/chef-workstation/25.5.1084/ubuntu/22.04/chef-workstation_25.5.1084-1_amd64.deb"
WGET_OUTPUT="/tmp/chef-workstation.deb"

wget -O "$WGET_OUTPUT" "$WGET_URL"

if [ $? -ne 0 ]; then
  echo "[ERROR] wget failed to download Chef Workstation."
  exit 1
fi

echo "[INFO] Installing Chef Workstation..."
sudo dpkg -i "$WGET_OUTPUT"
