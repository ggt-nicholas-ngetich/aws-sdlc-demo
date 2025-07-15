#!/bin/bash
set -e

# Update system packages and install Python3/pip3 if not present
yum update -y
yum install -y python3 python3-pip

# Install Python dependencies
cd /home/ec2-user/app
pip3 install -r requirements.txt