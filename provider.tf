terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}
provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}