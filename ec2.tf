data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "ec2_services" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnets_services[0].id
  iam_instance_profile = var.instance_profile
  security_groups = [aws_security_group.sg-ec2-services.id]
  tags = {
    Name = "services-ec2"
  }
}

resource "aws_instance" "ec2_consumer1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnets_consumer1[0].id
  iam_instance_profile = var.instance_profile
  security_groups = [aws_security_group.sg-ec2-consumer1.id]
  tags = {
    Name = "consumer1-ec2"
  }
}

resource "aws_instance" "ec2_consumer2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnets_consumer2[1].id
  iam_instance_profile = var.instance_profile
  security_groups = [aws_security_group.sg-ec2-consumer2.id]
  tags = {
    Name = "consumer2-ec2"
  }
}