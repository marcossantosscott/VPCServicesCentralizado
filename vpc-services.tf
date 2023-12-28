data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

resource "aws_vpc" "vpc_services" {
  cidr_block           = var.vpc_cidr_services
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "VPC Services"
    Terraform = "true"
  }
}

resource "aws_subnet" "private_subnets_services" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_services.id
  cidr_block        = cidrsubnet(aws_vpc.vpc_services.cidr_block, 3, count.index * 2)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "private_subnet_services${count.index + 1}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets_services" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_services.id
  cidr_block        = cidrsubnet(aws_vpc.vpc_services.cidr_block, 3, count.index * 2 + 1)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "public_subnet_services${count.index + 1}"
    Terraform = "true"
  }
}

resource "aws_route_table" "private-services" {
  vpc_id = aws_vpc.vpc_services.id
  depends_on = [aws_ec2_transit_gateway.transit_gateway]

  route {
    cidr_block = var.vpc_cidr_services
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-services.id
  }
  route {
    cidr_block = var.vpc_cidr_consumer1
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block = var.vpc_cidr_consumer2
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  tags = {
    Name = "private-routetable-services"
  }
}

resource "aws_route_table" "public-services" {
  vpc_id = aws_vpc.vpc_services.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public-routetable-services"
  }
}

#Create route table associations
resource "aws_route_table_association" "public-services" {
  depends_on     = [aws_subnet.public_subnets_services]
  route_table_id = aws_route_table.public-services.id
  for_each       = { for idx, subnet in aws_subnet.public_subnets_services : idx => subnet.id }
  subnet_id      = each.value
}

resource "aws_route_table_association" "private-services" {
  depends_on     = [aws_subnet.private_subnets_services]
  route_table_id = aws_route_table.private-services.id
  for_each       = { for idx, subnet in aws_subnet.private_subnets_services : idx => subnet.id }
  subnet_id      = each.value
}

#Create Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_services.id
  tags = {
    Name = "igw_sharedServices"
  }
}

resource "aws_nat_gateway" "nat-services" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets_services[0].id

  tags = {
    Name = "Service NAT Centralizado"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = {
    Name = "EIPNatServices"
  }
}