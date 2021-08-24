locals {
  profile = "kevin"
  region = "ap-northeast-2"

  ami = "ami-0b827f3319f7447c6"
  instance_type = "t2.micro"
  key_name = "unicorn-master-key"

  user_data = <<EOF
#!/bin/bash

wget https://s3.amazonaws.com/ee-assets-prod-us-east-1/modules/gd2015-loadgen/v0.1/server
chmod +x server
./server

# Reboot if the server crashes
shutdown -h now
EOF

  common_tags = {
    Terraform = "true"
    Project = "unicorn"
  }
}
