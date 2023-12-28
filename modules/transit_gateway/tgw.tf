resource "aws_ec2_transit_gateway" "transit_gateway" {
  description       = "TGW services"

  # Configurações de rota
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  # Tags para o Transit Gateway
  tags = {
    Name = "TransitGatewayServices"
  }
}

# Criação da Tabela de Rotas Personalizada
resource "aws_ec2_transit_gateway_route_table" "custom_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name = "CustomRouteTable"
  }
}


output "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.transit_gateway.id
}
output "tgw_routetable_id" {
  description = "ID of the Transit Gateway RT"
  value       = aws_ec2_transit_gateway_route_table.custom_route_table.id
}