#!/bin/bash

IP=$(terraform -chdir=terraform output -raw ec2_public_ip)
cat > ansible/inventory.ini <<E0F
[web]
$IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/healthapp.pem
E0F
