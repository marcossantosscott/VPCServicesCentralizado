variable "vpc_cidr_services" {
  type        = string
  default     = "10.0.0.0/20"
  description = "cidr da VPC services"
}

variable "vpc_cidr_consumer1" {
  type        = string
  description = "cidr da VPC consumer1"
  default     = "172.18.0.0/16"
}

variable "vpc_cidr_consumer2" {
  type        = string
  description = "cidr da VPC consumer2"
  default     = "192.168.0.0/16"
}

variable "sqs-service-name" {
  type    = string
  default = "com.amazonaws.us-east-1.sqs"
}

variable "ssm_service_name" {
  description = "Nome do serviço SSM"
  type    = string
  default = "com.amazonaws.us-east-1.ssm"
}

variable "ssm_service_name_messages" {
  description = "Nome do serviço SSM messages"
  type    = string
  default = "com.amazonaws.us-east-1.ssmmessages"
}

variable "ec2_service_name" {
  description = "Nome do serviço EC2"
  type    = string
  default = "com.amazonaws.us-east-1.ec2"
}


variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "instance_profile" {
  type    = string
  default = "AmazonSSMRoleForInstancesQuickSetup"
}