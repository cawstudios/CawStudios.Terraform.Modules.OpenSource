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

resource "aws_ec2_client_vpn_network_association" "this-vpn-subnet-1a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this-vpn-client-endpoint.id
  subnet_id              = data.aws_subnets.public-subnets.ids[0]#Put the subnet id of aws resource which you want to secure from vpn#
}

resource "aws_ec2_client_vpn_network_association" "this-vpn-subnet-1b" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this-vpn-client-endpoint.id
  subnet_id              = data.aws_subnets.public-subnets.ids[1]#Put the subnet id of aws resource which you want to secure from vpn#
}

resource "aws_ec2_client_vpn_authorization_rule" "this-vpn-authorization" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this-vpn-client-endpoint.id
  target_network_cidr    = var.vpc_cidr_block#Put the vpc cidr block which we will establish vpn connection to that particular cidr#
  authorize_all_groups   = true
}
