#!/bin/bash
set -e

# First, install required packages
yum update -y
yum install -y python3 python3-pip

# Create the directory (in case CodeDeploy hasn't done it yet)
mkdir -p /home/ec2-user/app

# Now safe to change directory
cd /home/ec2-user/app

# Install Python dependencies
pip3 install -r requirements.txt