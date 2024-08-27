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

provisioner "remote-exec" {

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }


  inline = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/gnavien/roboshop-ansible.git main.yml -e env=dev -e role_name=${var.name}"
  ]
}
# We need to have DNS records to be created for all the ec2 instances
resource "aws_route53_record" "www" {
  zone_id ="Z00238782DN7KNOSJPFLV"
  name    = "${var.name}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.web.private_ip]v # We are accessing all the ec2 instances using the private IP address
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
      from_port   = 0
      to_port     = 0
      protocol    = "-1"  # -1 opens all the ports
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