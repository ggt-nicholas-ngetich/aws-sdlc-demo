#!/bin/bash
set -e

# Install system packages only
yum update -y
yum install -y python3 python3-pip