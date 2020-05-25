variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "kops_state_store_s3" {
  type = string
}

variable "route53_domain_name" {
  type = string
}

variable "kubernetes_subdomain" {
  type = string
  default = "k8s"
}

variable "ssh_public_key" {
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

module "kubernetes_subdomain" {
  source  = "cloudposse/route53-cluster-zone/aws"
  version = "0.4.0"

  namespace            = "eg"
  stage                = "poc"
  name                 = var.kubernetes_subdomain
  parent_zone_name     = var.route53_domain_name
  zone_name            = "$${name}.$${parent_zone_name}"
}

module "key-pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "0.4.0"

  key_name = module.kubernetes_subdomain.zone_name
  public_key = var.ssh_public_key
  # insert the 2 required variables here
}
