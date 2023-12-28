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