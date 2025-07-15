#!/bin/bash
set -e

# Install system packages only
yum update -y
yum install -y python3 python3-pip

# Install dependencies
pip3 install -r requirements.txt