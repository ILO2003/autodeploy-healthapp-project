## AutoDeploy HealthApp Project

## Purpose
This project demonstrates how to provision and configure a simple web server on AWS using Infrastructure as Code and automation.

## Scenario
A team needs a repeatable way to deploy a basic internal web application without manually creating cloud resources or configuring servers.

## Tools Used
- AWS EC2
- Terraform
- Ansible
- Bash
- Nginx
- Git/GitHub

## Architecture
Developer runs `deploy.sh`, which provisions AWS infrastructure with Terraform, generates an Ansible inventory from Terraform output, and configures the EC2 instance with Ansible.

## Deployment Flow
1. Terraform provisions EC2 and security group.
2. Terraform outputs the EC2 public IP.
3. Bash generates the Ansible inventory dynamically.
4. Script waits until SSH is available.
5. Ansible installs and configures Nginx.
6. Web app becomes available over HTTP.

## Commands

Deploy:

```bash
./deploy.sh

Destroy:

./destroy.sh
