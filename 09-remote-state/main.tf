terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "sample/terraform.tfstate"
    region = "us-east-1"
  }
}