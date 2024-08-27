module "ec2" {
  source = "./ec2"
  name = "sample1"
}

module "ec2" {
  source = "./ec2"
  name = "sample2"
}

#
output "public_ip_sample1" {
  value = module.sample1.publeic_ip
}

output "public_ip_sample2" {
  value = module.sample2.publeic_ip
}