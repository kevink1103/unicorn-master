module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "unicorn-app-bucket"

  versioning = {
    enabled = false
  }

  tags = local.common_tags
}
