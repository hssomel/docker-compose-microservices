variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "kops_state_store_s3" {
  type = string
}

variable "route53_zone_name" {
  type = string
}

provider "aws" {
  region = var.aws_region
  version = "2.63"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "1.6.0"
  bucket = var.kops_state_store_s3
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

module "dev_cluster_domain" {
  source  = "cloudposse/route53-cluster-zone/aws"
  version = "0.4.0"
  
  name = "k8s"
  namespace = ""
  stage = ""
  parent_zone_name = var.route53_zone_name
}