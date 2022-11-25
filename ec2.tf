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
  region = "us-east-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_instance" "myec2" {
  ami         = "ami-0beaa649c482330f7"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instanceProfile.name}"
}

data "aws_iam_policy_document" "ec2_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "my_role" {
  name = "my_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_role-policy" {
  role       = aws_iam_role.my_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2_instanceProfile" {
    name = "ec2_instanceProfile"
    role = "${aws_iam_role.my_role.id}"
}