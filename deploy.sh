#!/bin/bash
set -e

echo "Script started.."
terraform -chdir=terraform apply -auto-approve
echo "Applied terraform"
./generate_inventory.sh
echo "Genereted Ansible inventory from Terraform Output"
echo "Running ansible playbook..."
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
IP=$(terraform -chdir=terraform output -raw ec2_public_ip)

echo ""
echo "Deployment complete:"
echo "http://$IP"
