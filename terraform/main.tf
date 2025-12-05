terraform {
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
  ami                    = "ami-00dbc43f8400b68cd"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0ed19fc2ace3c4acf"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node-by-terraform" {
  ami                    = "ami-0fd41a7b07a519463"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0ed19fc2ace3c4acf"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-java-node"
  }
}

resource "aws_instance" "python-node-by-terraform" {
  ami                    = "ami-0fd41a7b07a519463"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = ["sg-0544e913fb38c0879"]
  key_name               = "mickey"

  tags = {
    Name = "terraform-python-node"
  }
}