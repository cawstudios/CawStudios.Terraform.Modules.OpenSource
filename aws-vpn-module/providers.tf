terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.44.0"
    }
  }
}
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {  
     tags = {
      org             = "CAW Studios"
      org-cost-center = "CAW Studios"
      org-team        = "devops"
      org-owner       = "xyz@gmail.com"# you can write your organization owner mail id here
      app-environment = "Dev"
      info-terraform  = "yes"
      info-created_by = "xyz" // username who created terraform script
      info-purpose    = "Development"
    }
  }
}