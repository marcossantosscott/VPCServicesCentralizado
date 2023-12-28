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

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "instance_profile" {
  type    = string
  default = "AmazonSSMRoleForInstancesQuickSetup"
}