module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name = "unicorn-asg"

  vpc_zone_identifier = module.vpc.public_subnets

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  use_lc    = true
  create_lc = true

  image_id          = local.ami
  instance_type     = local.instance_type
  key_name          = local.key_name
  ebs_optimized     = true
  enable_monitoring = true

  associate_public_ip_address = true

  security_groups   = [module.unicorn_instance_sg.security_group_id]
  target_group_arns = module.alb.target_group_arns
  health_check_type = "EC2"

  user_data_base64 = base64encode(local.user_data)

  tags = [{
    Terraform = "true"
    Project = "unicorn"
  }]
}
