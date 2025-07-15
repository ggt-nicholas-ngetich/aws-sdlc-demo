#!/bin/bash
set -e

# Enable error logging
exec 1> >(logger -s -t $(basename $0)) 2>&1

# Update system packages
echo "Updating system packages..."
yum update -y
yum install -y python3 python3-pip python3-venv

# Update pip to latest version
echo "Updating pip..."
python3 -m pip install --upgrade pip

# Define application directory
APP_DIR="/home/ec2-user/app"

# Create and activate virtual environment if it doesn't exist
echo "Setting up virtual environment..."
if [ ! -d "${APP_DIR}/venv" ]; then
    python3 -m venv "${APP_DIR}/venv"
fi

# Activate virtual environment and install dependencies
echo "Installing dependencies..."
source "${APP_DIR}/venv/bin/activate"
if [ -f "${APP_DIR}/requirements.txt" ]; then
    pip install -r "${APP_DIR}/requirements.txt"
else
    echo "Error: requirements.txt not found at ${APP_DIR}/requirements.txt"
    exit 1
fi
deactivate

echo "Dependencies installation completed successfully"