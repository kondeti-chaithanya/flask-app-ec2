terraform {
  backend "s3" {
    bucket = "chaitanya-terraform-state-bucket"
    key    = "ec2-docker/terraform.tfstate"
    region = "ap-south-1"
  }
}