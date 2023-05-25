terraform {
  backend "s3" {
    bucket     = "caw-aws-aps1-demo-s3-tfstate"
    key        = "s3-backend-demo-infra-module.tfstate"
    region     = "ap-south-1"
  }
}


