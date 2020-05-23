provider "aws" {
  region = "us-east-1"
  version = "2.63"
}

resource "aws_kms_key" "terraform_state_s3_bucket_kms_key" {
  description = "KMS key is used to encrypt s3 bucket for terraform state store"
  deletion_window_in_days = 7
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "1.6.0"
  bucket = s3_bucket_name_terraform_state
  acl = "private"
  force_destroy = true
  versioning = {
    enabled = true
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.terraform_state_s3_bucket_kms_key.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

module "dynamodb" {
  source = "cloudposse/dynamodb/aws"
  version = "0.15.0"
  name = var.dynamodb_name_terraform_state_locks
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  dynamodb_attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}