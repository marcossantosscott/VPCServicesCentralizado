resource "aws_vpc_endpoint" "endpoint_sqs" {
  vpc_id             = aws_vpc.vpc_services.id
  service_name       = var.sqs-service-name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.sg_sqs_ingress.id]
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