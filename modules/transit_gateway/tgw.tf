resource "aws_ec2_transit_gateway" "transit_gateway" {
  description       = "TGW services"

  # Configurações de rota
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  # Tags para o Transit Gateway
  tags = {
    Name = "TransitGatewayServices"
  }
}

output "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.transit_gateway.id
}