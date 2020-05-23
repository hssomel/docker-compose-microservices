provider "aws" {
  region = "us-east-1"
  version = "2.63"
}

terraform {
  backend "s3" {
    bucket         = "gurkamal-terraform-state"
    key            = "kops-state-store.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gurkamal-terraform-locks"
    encrypt        = true
  }
}

resource "aws_kms_key" "kops_state_s3_bucket_kms_key" {
  description = "KMS key is used to encrypt bucket for kops state store"
  deletion_window_in_days = 7
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "1.6.0"
  bucket = "gurkamal-kops-state"
  acl = "private"
  force_destroy = true
  versioning = {
    enabled = true
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.kops_state_s3_bucket_kms_key.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}