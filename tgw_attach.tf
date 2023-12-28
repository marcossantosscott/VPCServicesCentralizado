module "transit_gateway" {
  source = "./modules/transit_gateway"
  # outras variáveis de entrada, se houver
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-consumer1" {
  #depends_on = [ aws_subnet.private_subnets_consumer1 ]
  subnet_ids         = tolist(aws_subnet.private_subnets_consumer1[*].id)
  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = aws_vpc.vpc_consumer1.id
  tags = {
    Name = "TGA-Consumer1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-consumer2" {
  #depends_on = [ aws_subnet.private_subnets_consumer2 ]
  subnet_ids         = tolist(aws_subnet.private_subnets_consumer2[*].id)
  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = aws_vpc.vpc_consumer2.id
  tags = {
    Name = "TGA-Consumer2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attach-vpc-services" {
  subnet_ids         = tolist(aws_subnet.private_subnets_services[*].id)
  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = aws_vpc.vpc_services.id
  tags = {
    Name = "TGA-Services"
  }
}