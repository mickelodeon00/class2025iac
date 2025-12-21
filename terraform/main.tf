terraform {
  backend "s3" {
    bucket  = "techbleat-terraform-cicd-state-bucket"
    key     = "envs/dev/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
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

# -------------------------
# Web Node Security Group
# -------------------------

resource "aws_security_group" "web_sg" {

  name        = "web-sg"
  description = "Allow SSH and Port 80  inbound, all outbound"
  vpc_id      = "vpc-0d78f18513624c2a9"


  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 80 (web)
  ingress {
    description = "Web port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security_group"
  }

}

#-------------------------
# Web EC2 Instance
# ------------------------

resource "aws_instance" "web-node" {
  ami                    = "ami-0116d7349f019d56f"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "mickey"

  tags = {
    Name = "web-node"
  }
}


# -------------------------
# Python Node Security Group
# -------------------------

resource "aws_security_group" "python_sg" {

  name        = "python-sg"
  description = "Allow SSH and Port 8080  inbound, all outbound"
  vpc_id      = "vpc-0d78f18513624c2a9"


  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 8080 (app)
  ingress {
    description = "Python App port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "python-app-security_group"
  }

}


#-------------------------
# Python App EC2 Instance
# ------------------------

resource "aws_instance" "python-node" {
  ami                    = "ami-07c7c1f4c6cf133c2"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = [aws_security_group.python_sg.id]
  key_name               = "mickey"

  tags = {
    Name = "python-node"
  }
}


# -------------------------
# Java Node Security Group
# -------------------------

resource "aws_security_group" "java_sg" {

  name        = "java-sg"
  description = "Allow SSH and Port 9090  inbound, all outbound"
  vpc_id      = "vpc-0d78f18513624c2a9"


  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 9090 (app)
  ingress {
    description = "Java App port 9090"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "java-app-security_group"
  }

}


#-------------------------
# Java App EC2 Instance
# ------------------------

resource "aws_instance" "java-node" {
  ami                    = "ami-07c7c1f4c6cf133c2"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05355ecc913c17c32"
  vpc_security_group_ids = [aws_security_group.java_sg.id]
  key_name               = "mickey"

  tags = {
    Name = "java-node"
  }
}

