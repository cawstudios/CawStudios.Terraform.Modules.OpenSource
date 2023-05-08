variable "vpc_cidr_block" {
  type= string
  default= "10.0.0.0/16"
}
variable "aws_region" {
  type= string
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "database_subnet_names" {}