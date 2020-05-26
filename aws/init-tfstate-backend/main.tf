variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "tfstate_s3" {
  type = string
  default = "tfstate-company"
}

variable "tfstate_locks_dynamodb" {
  type = string
  default = "tfstate-locks-company"
}

provider "aws" {
  region = var.aws_region
  version = "2.63"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "1.6.0"
  bucket = var.tfstate_s3
  acl = "private"
  force_destroy = true
  versioning = {
    enabled = true
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

module "dynamodb" {
  source = "cloudposse/dynamodb/aws"
  version = "0.15.0"
  name = var.tfstate_locks_dynamodb
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  dynamodb_attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}