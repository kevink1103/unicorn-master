module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "unicorn-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["${local.region}a", "${local.region}c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = local.common_tags
}
