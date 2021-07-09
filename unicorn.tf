terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "ap-northeast-2"
  profile = "default"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "unicorn-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = {
    Terraform = "true"
    Project = "unicorn"
  }
}
