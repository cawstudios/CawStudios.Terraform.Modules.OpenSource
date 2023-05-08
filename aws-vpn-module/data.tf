data "aws_subnets" "public-subnets" {
  filter {
    name   = "tag:Name"
    values = [var.database_subnet_names[0], var.database_subnet_names[1]]
  }
  depends_on = [
    module.vpc
  ]
}