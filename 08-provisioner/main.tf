provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0ce2351083cb5150c"]

  tags = {
    Name = "Hello AWS"
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
    "ansible-pull -i localhost, -U https://github.com/gnavien/roboshop-ansible.git main.yml -e env=dev -e role_name=frontend",
  ]
}

data "aws_ami" "example" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"

}