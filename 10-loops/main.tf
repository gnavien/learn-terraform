provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  # count=3  # we will have 3 instances created
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

data "aws_ami" "example" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"

}