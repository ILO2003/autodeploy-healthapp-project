#!/bin/bash
set -e

Echo "Destroying infrastructure..."
terraform -chdir=terraform destory -auto-approve

echo "Destroyed!"
