#!/bin/bash
set -e

cd /home/ec2-user/app

# Install dependencies
pip3 install -r requirements.txt