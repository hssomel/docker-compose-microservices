# Terraform uses s3 backend created by terraform-backend-init project
# this module assumes that an s3 backend is already setup

terraform {
  backend "s3" {
    bucket         = "tfstate.gurkamalsingh.com"
    dynamodb_table = "tfstate-locks.gurkamalsingh.com"
    key            = "kops-state-store.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}