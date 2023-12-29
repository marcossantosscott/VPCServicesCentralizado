resource "aws_route53_zone" "sqs-zone" {
  name = "sqs.us-east-1.amazonaws.com"
  vpc {
    vpc_id = aws_vpc.vpc_services.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "associate-consumer1-vpc" {
  zone_id = aws_route53_zone.sqs-zone.id
  vpc_id  = aws_vpc.vpc_consumer1.id
}

resource "aws_route53_zone_association" "associate-consumer2-vpc" {
  zone_id = aws_route53_zone.sqs-zone.id
  vpc_id  = aws_vpc.vpc_consumer2.id
}

resource "aws_route53_record" "sqs" {
  zone_id = aws_route53_zone.sqs-zone.id
  name    = "sqs.us-east-1.amazonaws.com"
  type    = "A"
  #ttl     = 300
  alias {
    name                   = aws_vpc_endpoint.endpoint_sqs.dns_entry[0]["dns_name"]
    zone_id                = aws_vpc_endpoint.endpoint_sqs.dns_entry[0]["hosted_zone_id"]
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "ec2-zone" {
  name = "ec2.us-east-1.amazonaws.com"
  vpc {
    vpc_id = aws_vpc.vpc_services.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "associate-consumer1-vpc-ec2" {
  zone_id = aws_route53_zone.ec2-zone.id
  vpc_id  = aws_vpc.vpc_consumer1.id
}

resource "aws_route53_zone_association" "associate-consumer2-vpc-ec2" {
  zone_id = aws_route53_zone.ec2-zone.id
  vpc_id  = aws_vpc.vpc_consumer2.id
}

resource "aws_route53_record" "ec2" {
  zone_id = aws_route53_zone.ec2-zone.id
  name    = "ec2.us-east-1.amazonaws.com"
  type    = "A"
  #ttl     = 300
  alias {
    name                   = aws_vpc_endpoint.endpoint_ec2.dns_entry[0]["dns_name"]
    zone_id                = aws_vpc_endpoint.endpoint_ec2.dns_entry[0]["hosted_zone_id"]
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "ssm-zone" {
  name = "ssm.us-east-1.amazonaws.com"
  vpc {
    vpc_id = aws_vpc.vpc_services.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "associate-consumer1-vpc-ssm" {
  zone_id = aws_route53_zone.ssm-zone.id
  vpc_id  = aws_vpc.vpc_consumer1.id
}

resource "aws_route53_zone_association" "associate-consumer2-vpc-ssm" {
  zone_id = aws_route53_zone.ssm-zone.id
  vpc_id  = aws_vpc.vpc_consumer2.id
}

resource "aws_route53_record" "ssm" {
  zone_id = aws_route53_zone.ssm-zone.id
  name    = "ssm.us-east-1.amazonaws.com"
  type    = "A"
  #ttl     = 300
  alias {
    name                   = aws_vpc_endpoint.endpoint_ssm.dns_entry[0]["dns_name"]
    zone_id                = aws_vpc_endpoint.endpoint_ssm.dns_entry[0]["hosted_zone_id"]
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "ssm-messages-zone" {
  name = "ssmmessages.us-east-1.amazonaws.com"
  vpc {
    vpc_id = aws_vpc.vpc_services.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "associate-consumer1-vpc-ssm-messages" {
  zone_id = aws_route53_zone.ssm-messages-zone.id
  vpc_id  = aws_vpc.vpc_consumer1.id
}

resource "aws_route53_zone_association" "associate-consumer2-vpc-ssm-messages" {
  zone_id = aws_route53_zone.ssm-messages-zone.id
  vpc_id  = aws_vpc.vpc_consumer2.id
}

resource "aws_route53_record" "ssm-messages" {
  zone_id = aws_route53_zone.ssm-messages-zone.id
  name    = "ssmmessages.us-east-1.amazonaws.com"
  type    = "A"
  #ttl     = 300
  alias {
    name                   = aws_vpc_endpoint.endpoint_ssm_messages.dns_entry[0]["dns_name"]
    zone_id                = aws_vpc_endpoint.endpoint_ssm_messages.dns_entry[0]["hosted_zone_id"]
    evaluate_target_health = true
  }
}