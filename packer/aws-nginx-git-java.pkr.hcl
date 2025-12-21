packer {
  required_version = ">=1.9.0"

  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.0"
    }
  }
}


#-----------------------------
# source: AMI For Nginx and GIT 
#-----------------------------

source "amazon-ebs" "nginx-git" {
  region                  = "eu-west-1"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-08b6a2983df6e9e25"
  ami_name                = "nginx-git-ami"
  ami_virtualization_type = "hvm"
}


#-----------------------------
# source: AMI For Java , Python and GIT 
#-----------------------------

source "amazon-ebs" "java-python-git" {
  region                  = "eu-west-1"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-08b6a2983df6e9e25"
  ami_name                = "java-python-git-ami"
  ami_virtualization_type = "hvm"
}


#------------------------------------
# build: source + provisioning to do 
#------------------------------------

build {
  name = "nginx-git-ami-build"
  sources = [
    "source.amazon-ebs.nginx-git"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo  '<h1> Hello from Techbleat - Built by Micheal </h1>' | sudo tee /usr/share/nginx/html/index.html",
      "sudo yum install git -y"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'AMI build is finished For Nginx' "]
  }

}

build {
  name = "java-python-git-ami-build"
  sources = [
    "source.amazon-ebs.java-python-git"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install java-17-amazon-corretto -y",
      "sudo yum install python3 -y",
      "sudo yum install python3-pip -y",
      "sudo yum install git -y"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'AMI build is finished For Java and Python' "]
  }

}



