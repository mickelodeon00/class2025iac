terraform {
  backend  "local" {
    path = "/tmp/terraform.tfstate"
  }
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_instance" "nginx-node-by-terraform" {
  ami                    = "ami-02b6701d21b6c2fec"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0c3eeaffb052fc77e"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node-by-terraform" {
  ami                    = "ami-0b05581ab39fe9730"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0c3eeaffb052fc77e"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-java-node"
  }
}

resource "aws_instance" "python-node-by-terraform" {
  ami                    = "ami-0b05581ab39fe9730"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0c3eeaffb052fc77e"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-python-node"
  }
}