terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "healhapp_sg_ilo" {
  name        = "healthapp-sg-ilo"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["94.234.72.181/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "healthapp_ec2" {
  ami           = "ami-0a0823e4ea064404d"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.healhapp_sg_ilo.id]

  key_name = "healthapp"
}
output "ec2_public_ip" {
  value       = aws_instance.healthapp_ec2.public_ip
}
