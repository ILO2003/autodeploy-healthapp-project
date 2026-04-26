#!/bin/bash
set -e

echo "Script started.."

terraform -chdir=terraform apply -auto-approve
echo "Applied terraform"

./generate_inventory.sh
echo "Genereted Ansible inventory from Terraform Output"

echo "Waiting for SSH to be ready...."
IP=$(terraform -chdir=terraform output -raw ec2_public_ip)

MAX_RETRIES=10
COUNT=0

until ssh -o StrictHostKeyChecking=no -i ~/.ssh/healthapp.pem ec2-user@$IP "echo SSH ready" &>/dev/null; do
       	COUNT = $((COUNT+1))

	if [ $COUNT -ge $MAX_RETRIES ]; then
		echo "SSH DID NOT BECOME READY IN TIME. EXITING."
		exit 1 
	fi

	echo "Waiting... ($COUNT/$MAX_RETRIES)"
        sleep 5
done
echo "SSH is READY!"

sleep 2

echo "Running ansible playbook..."
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

echo
echo "Deployment complete:"
echo "http://$IP"
