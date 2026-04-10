terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-12345"
    key    = "ec2-docker/terraform.tfstate"
    region = "ap-south-1"
  }
}