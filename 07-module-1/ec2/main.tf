provider "aws" {
  region     = "us-east-1"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# The below code will launch a new instance with a security group

resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg.id] # list of security groups

  tags = {
    Name = var.name  # Instance Name is called Sample
  }
}

data "aws_ami" "example" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"

}


resource "aws_security_group" "sg" {
  name        = var.name
  description = "Allow TLS inbound traffic"

}

 ingress {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = var.name
  }

variable "name" {}