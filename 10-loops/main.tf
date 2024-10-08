provider "aws" {
  region     = "us-east-1"
}

#resource "aws_instance" "web" {
#  ami           = data.aws_ami.example.id
#  # count=3  # we will have 3 instances created
#  count = length(var.instances)
#  instance_type = "t3.micro"
#
#  tags = {
#    Name = "HelloWorld"
#  }
#}

resource "aws_instance" "web" {
  for_each = var.instances
  ami           = data.aws_ami.example.id
  instance_type = lookup(each.value, "instance_type", "t3.small" ) # Here lookup will check for instance type and if it is not mentioned it will pick or else it will use t3.small

  tags = {
    #name = var.instances[count.index]
    name = each.key # Here key is frontend, catalogue, cart
  }
}
data "aws_ami" "example" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"

}

#variable "instances" {
#  default = ["frontend", "catalogue", "cart"]
#}

variable "instances" {
   default = {
    frontend = {
      name          = "frontend"
    }
    catalogue  = {
      name          = "catalogue"
      instance_type = "t3.nano"
    }
    cart = {
      name          = "cart"
      instance_type = "t3.nano"
    }
  }
}