#!/bin/bash
set -e

Echo "Destroying infrastructure..."
terraform -chdir=terraform destroy -auto-approve

echo "Destroyed!"
