module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "unicorn-instance"
  instance_count         = 1

  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  monitoring             = true
  vpc_security_group_ids = [module.unicorn_instance_sg.security_group_id]
  subnet_ids             = [module.vpc.public_subnets[0]]

  associate_public_ip_address  = true

  user_data_base64 = base64encode(local.user_data)

  tags = {
    Terraform = "true"
    Project   = "unicorn"
  }
}
