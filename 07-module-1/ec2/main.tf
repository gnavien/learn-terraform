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
    Name = var.name  # Instance Name is called Sample we have the variable in the main.tf file
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

# Now i wanted to print the public IP of the EC2 instance and below is the code.

output "public_ip" {
  value = aws_instance.web.public_ip
}