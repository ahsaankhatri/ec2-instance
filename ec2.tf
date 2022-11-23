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
  access_key = "AKIA4WFX332QE65V4ZXU"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  ami         = "ami-0beaa649c482330f7"
  instance_type = "t2.micro"
}