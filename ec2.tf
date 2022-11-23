terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  name = "ec2-instance"
  ami         = "ami-0beaa649c482330f7"
  instance_type = "t2.micro"
}