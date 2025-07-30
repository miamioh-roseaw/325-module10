#!/bin/bash

echo "[INFO] Installing Chef Workstation..."

# Use curl if available, otherwise fallback to wget
if command -v curl >/dev/null 2>&1; then
  curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-workstation
elif command -v wget >/dev/null 2>&1; then
  wget -O - https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-workstation
else
  echo "[ERROR] Neither curl nor wget is available. Cannot install Chef."
  exit 1
fi

echo "[INFO] Chef Workstation installed successfully."

# Validate
if ! command -v chef >/dev/null 2>&1; then
  echo "[ERROR] Chef binary not found in PATH after install."
  exit 1
fi
