resource "aws_vpc_endpoint" "endpoint_sqs" {
  vpc_id             = aws_vpc.vpc_services.id
  service_name       = var.sqs-service-name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.sg-endpoints.id]
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  tags = {
    Owner     = "shared-services"
    Terraform = "true"
    Name      = "sqs-endpoint-services"
  }
  # Restante da configuração...
}

output "endpoints-dns" {
  value = aws_vpc_endpoint.endpoint_sqs.dns_entry
}

# Recurso para o endpoint SSM
resource "aws_vpc_endpoint" "endpoint_ssm" {
  vpc_id             = aws_vpc.vpc_services.id
  service_name       = var.ssm_service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.sg-endpoints.id]
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  tags = {
    Owner     = "shared-services"
    Terraform = "true"
    Name      = "ssm-endpoint-services"
  }
  # Restante da configuração...
}

resource "aws_vpc_endpoint" "endpoint_ssm_messages" {
  vpc_id             = aws_vpc.vpc_services.id
  service_name       = var.ssm_service_name_messages
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.sg-endpoints.id]
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  tags = {
    Owner     = "shared-services"
    Terraform = "true"
    Name      = "ssm-endpoint-services"
  }
  # Restante da configuração...
}

# Recurso para o endpoint EC2
resource "aws_vpc_endpoint" "endpoint_ec2" {
  vpc_id             = aws_vpc.vpc_services.id
  service_name       = var.ec2_service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.sg-endpoints.id]
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  tags = {
    Owner     = "shared-services"
    Terraform = "true"
    Name      = "ec2-endpoint-services"
  }
  # Restante da configuração...
}

# Output para os DNS dos endpoints
output "ssm_endpoint_dns" {
  value = aws_vpc_endpoint.endpoint_ssm.dns_entry
}

output "ec2_endpoint_dns" {
  value = aws_vpc_endpoint.endpoint_ec2.dns_entry
}

