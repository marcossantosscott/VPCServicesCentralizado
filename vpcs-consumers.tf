resource "aws_vpc" "vpc_consumer1" {
  cidr_block           = var.vpc_cidr_consumer1
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "VPC Consumer1"
    Terraform = "true"
  }
}


resource "aws_subnet" "private_subnets_consumer1" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_consumer1.id
  cidr_block        = cidrsubnet(var.vpc_cidr_consumer1, 4, count.index * 4)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "private_subnet_consumer1${count.index}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets_consumer1" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_consumer1.id
  cidr_block        = cidrsubnet(var.vpc_cidr_consumer1, 4, count.index * 4 + 1)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "public_subnet_consumer1${count.index}"
    Terraform = "true"
  }
}

resource "aws_route_table" "rt-private-consumer1" {
  vpc_id = aws_vpc.vpc_consumer1.id
  depends_on = [aws_ec2_transit_gateway.transit_gateway]
  route {
    cidr_block = var.vpc_cidr_consumer1
    gateway_id = "local"
  }
  route {
    cidr_block = var.vpc_cidr_consumer2
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block = var.vpc_cidr_services
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  tags = {
    Name = "private-routetable-consumer1"
  }
}

resource "aws_route_table" "rt-public-consumer1" {
  vpc_id = aws_vpc.vpc_consumer1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-consumer1.id
  }
  tags = {
    Name = "public-routetable-consumer1"
  }
}

#Create route table associations
resource "aws_route_table_association" "public-consumer1" {
  depends_on     = [aws_subnet.public_subnets_consumer1]
  route_table_id = aws_route_table.rt-public-consumer1.id
  for_each       = { for idx, subnet in aws_subnet.public_subnets_consumer1 : idx => subnet.id }
  subnet_id      = each.value
}

resource "aws_route_table_association" "private-consumer1" {
  depends_on     = [aws_subnet.private_subnets_consumer1]
  route_table_id = aws_route_table.rt-private-consumer1.id
  for_each       = { for idx, subnet in aws_subnet.private_subnets_consumer1 : idx => subnet.id }
  subnet_id      = each.value
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw-consumer1" {
  vpc_id = aws_vpc.vpc_consumer1.id
  tags = {
    Name = "igw_consumer1"
  }
}

resource "aws_vpc" "vpc_consumer2" {
  cidr_block           = var.vpc_cidr_consumer2
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "VPC Consumer2"
    Terraform = "true"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw-consumer2" {
  vpc_id = aws_vpc.vpc_consumer2.id
  tags = {
    Name = "igw_consumer2"
  }
}

resource "aws_subnet" "private_subnets_consumer2" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_consumer2.id
  cidr_block        = cidrsubnet(var.vpc_cidr_consumer2, 4, count.index * 2)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "private_subnet_consumer2${count.index}"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets_consumer2" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.vpc_consumer2.id
  cidr_block        = cidrsubnet(var.vpc_cidr_consumer2, 4, count.index * 2 + 1)
  availability_zone = local.azs[count.index]

  tags = {
    Name      = "public_subnet_consumer2${count.index}"
    Terraform = "true"
  }
}

resource "aws_route_table" "rt-private-consumer2" {
  vpc_id = aws_vpc.vpc_consumer2.id
  depends_on = [aws_ec2_transit_gateway.transit_gateway]

  route {
    cidr_block = var.vpc_cidr_consumer2
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block = var.vpc_cidr_consumer1
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block = var.vpc_cidr_services
    gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  tags = {
    Name = "private-routetable-consumer2"
  }
}

resource "aws_route_table" "rt-public-consumer2" {
  vpc_id = aws_vpc.vpc_consumer2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-consumer2.id
  }
  tags = {
    Name = "public-routetable-consumer2"
  }
}

#Create route table associations
resource "aws_route_table_association" "public-consumer2" {
  depends_on     = [aws_subnet.public_subnets_consumer2]
  route_table_id = aws_route_table.rt-public-consumer2.id
  for_each       = { for idx, subnet in aws_subnet.public_subnets_consumer2 : idx => subnet.id }
  subnet_id      = each.value
}

resource "aws_route_table_association" "private-consumer2" {
  depends_on     = [aws_subnet.private_subnets_consumer2]
  route_table_id = aws_route_table.rt-private-consumer2.id
  for_each       = { for idx, subnet in aws_subnet.private_subnets_consumer2 : idx => subnet.id }
  subnet_id      = each.value
}