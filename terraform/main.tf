terraform {

  backend "s3" {
    bucket = "techbleat-class-cicd-state-bucket"
    key = "envs/dev/week11/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "amazon_linux_node" {
  ami = "ami-096f46d460613bed4"
  instance_type = "t3.micro"
  key_name = "mickey" 
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    "Name" = "Amazon Linux Node"
  }
}

resource "aws_instance" "ubuntu_node" {
  ami = "ami-03446a3af42c5e74e"
  instance_type = "t3.micro"
  key_name = "mickey" 
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    "Name" = "Ubuntu Node"
  }
}






