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

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-consumer1" {
  subnet_ids         = tolist(aws_subnet.private_subnets_consumer1[*].id)
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc_consumer1.id
  tags = {
    Name = "TGA-Consumer1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-consumer2" {
  subnet_ids         = tolist(aws_subnet.private_subnets_consumer2[*].id)
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc_consumer2.id
  tags = {
    Name = "TGA-Consumer2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-services" {
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc_services.id
  tags = {
    Name = "TGA-Services"
  }
}