# Criação do Security Group
resource "aws_security_group" "sg_sqs_ingress" {
  name        = "securitygroup-sqs-ingress"
  description = "Security Group para o endpoint de entrada do SQS"
  vpc_id      = aws_vpc.vpc_services.id

  ingress {
    from_port   = 80 # Porta de entrada desejada
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Libera o tráfego de qualquer endereço IP
  }
  ingress {
    from_port   = 443 # Porta de entrada desejada
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Libera o tráfego de qualquer endereço IP
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG-Endpoint-SQS"
  }
}

resource "aws_security_group" "sg-ec2-consumer1" {
  name        = "securitygroup-ec2-consumer1"
  vpc_id      = aws_vpc.vpc_consumer1.id

  ingress {
    from_port   = 80 # Porta de entrada desejada
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Libera o tráfego de qualquer endereço IP
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Permitindo de qualquer lugar, ajuste conforme necessário
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG-consumer1-ec2"
  }
}

resource "aws_security_group" "sg-ec2-consumer2" {
  name        = "securitygroup-ec2-consumer2"
  vpc_id      = aws_vpc.vpc_consumer2.id

  ingress {
    from_port   = 80 # Porta de entrada desejada
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Libera o tráfego de qualquer endereço IP
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Permitindo de qualquer lugar, ajuste conforme necessário
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG-consumer2-ec2"
  }
}

resource "aws_security_group" "sg-ec2-services" {
  name        = "securitygroup-ec2-services"
  vpc_id      = aws_vpc.vpc_services.id

  ingress {
    from_port   = 80 # Porta de entrada desejada
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Libera o tráfego de qualquer endereço IP
  }
  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Permitindo de qualquer lugar, ajuste conforme necessário
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG-services-ec2"
  }
}