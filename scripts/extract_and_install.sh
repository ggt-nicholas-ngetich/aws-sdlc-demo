#!/bin/bash
set -e

cd /home/ec2-user/app

# Extract the application
unzip -o application.zip

# Install dependencies
pip3 install -r requirements.txt