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
  tags = {
  terraform = true 
  }
}
```

## VPN NETWORK ASSOCIATION

A VPN (Virtual Private Network) is a network technology that allows users to create a secure and encrypted connection to another network over the internet. When you connect to a VPN, your device creates a virtual tunnel between your device and the VPN server, encrypting all data that travels between them. so once you done with creating vpn client endpoint you have to associate the subnet where you want to allow a user to connect through vpn .

```hcl
resource "aws_ec2_client_vpn_network_association" "this-vpn-subnet-1a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this-vpn-client-endpoint.id
  subnet_id              = data.aws_subnets.public-subnets.ids[0]#Put the subnet id of aws resource which you want to secure from vpn#
}
```

```hcl
data "aws_subnets" "public-subnets" {
  filter {
    name   = "tag:Name"
    values = [var.database_subnet_names[0], var.database_subnet_names[1]]
  }
  depends_on = [
    module.vpc
  ]
}
```

## VPN AUTHORIZATION RULE

A VPN (Virtual Private Network) authorization rule is a set of policies and rules that define who can access the VPN network and what they can do once they are connected. Authorization rules are typically configured by the network administrator and are used to ensure that only authorized users can access the VPN network and its resources.

Authorization rules can be based on a variety of criteria, including user credentials, device type, network location, and time of day. For example, an authorization rule may specify that only users with a specific role or group membership can connect to the VPN network, or that only devices with specific security settings are allowed to connect.

Once a user or device is authorized to connect to the VPN network, the authorization rule can also specify what resources they are allowed to access. This can include specific network segments, servers, or applications, as well as specific actions that are allowed, such as file sharing or printing.

```hcl

resource "aws_ec2_client_vpn_authorization_rule" "this-vpn-authorization" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this-vpn-client-endpoint.id
  target_network_cidr    = var.vpc_cidr_block#Put the vpc cidr block which we will establish vpn connection to that particular cidr#
  authorize_all_groups   = true
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
