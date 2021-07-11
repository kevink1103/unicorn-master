locals {
  user_data = <<EOF
#!/bin/bash

wget https://s3.amazonaws.com/ee-assets-prod-us-east-1/modules/gd2015-loadgen/v0.1/server
chmod +x server
./server

# Reboot if the server crashes
shutdown -h now
EOF
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "unicorn-instance"
  instance_count         = 1

  ami                    = "ami-0b827f3319f7447c6"
  instance_type          = "t2.micro"
  key_name               = "unicorn-master-key" // TODO
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
