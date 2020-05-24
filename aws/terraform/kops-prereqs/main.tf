variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "kops_state_store_s3" {
  type = string
  default = "kops-state-store-company"
}


# variable "route53_zone_name" {
#   type = string
#   default = "company.com"
# }


# variable "dev_vpc" {
#   type = string
#   default = "kops-state-store-company"
# }

# variable "prod_vpc" {
#   type = string
#   default = "kops-state-store-company"
# }



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



# module "dev_cluster_domain" {
#   source  = "cloudposse/route53-cluster-zone/aws"
#   version = "0.4.0"
#   # insert the 3 required variables here
#   name = "k8s"
#   namespace = ""
#   stage = "dev"
#   parent_zone_name = var.route53_zone_name
# }

# module "prod_cluster_domain" {
#   source  = "cloudposse/route53-cluster-zone/aws"
#   version = "0.4.0"
#   # insert the 3 required variables here
#   name = "k8s"
#   namespace = ""
#   stage = "prod"
#   parent_zone_name = var.route53_zone_name
# }


# module "vpc_dev" {
#   source = "terraform-aws-modules/vpc/aws"
#   version = "2.33.0"

#   name = "kubernetes-dev"
#   cidr = "10.0.0.0/16"
#   # insert the 12 required variables here
# }

# module "vpc_prod" {
#   source = "terraform-aws-modules/vpc/aws"
#   version = "2.33.0"

#   name = "kubernetes-prod"
#   cidr = "10.0.0.0/16"
#   # insert the 12 required variables here
# }