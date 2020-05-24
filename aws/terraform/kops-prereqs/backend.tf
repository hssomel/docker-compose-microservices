# Terraform uses s3 backend created by init-tfstate-backend project in aws/init-tfstate-backend
# this module assumes that an s3 backend is already setup

terraform {
  backend "s3" {
    bucket = "tfstate-gurkamalsingh"
    dynamodb_table = "tfstate-locks-gurkamalsingh"
    key = "kops-prereqs.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}