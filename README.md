# CAW-terraform-module

This repository contains aws terraform modules . we only include the particular module terraform code in their folder. you can set the naming and tagging convention according to your needs.

## Usage

```hcl
resource "aws_ec2_client_vpn_endpoint" "this-vpn-client-endpoint" {
  
  description            = "terraform-vpn-client-endpoint"
  server_certificate_arn = var.vpn_server_certificate_arn
  client_cidr_block      = "1.0.0.0/16"
  vpn_port = 443

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.vpn_server_certificate_arn
  }
  
  split_tunnel = true
  vpc_id = module.vpc.vpc_id
  session_timeout_hours = 8 # 
  security_group_ids = [module.db-vpn-sg.security_group_id]#put the vpn security group id#
  connection_log_options {
    enabled               = false
    # cloudwatch_log_group  = aws_cloudwatch_log_group.lg.name
    # cloudwatch_log_stream = aws_cloudwatch_log_stream.ls.name
  }
  depends_on = [
    module.db-vpn-sg
  ]
}
```

## Resources

| Name | Type |
|------|------|
| [aws_ec2_client_vpn_authorization_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_ec2_client_vpn_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
