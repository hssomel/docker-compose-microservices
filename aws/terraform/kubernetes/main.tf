terraform {
  backend "s3" {
    bucket         = "gurkamal-singh-toptal-demo-terraform-state"
    key            = "kops-init-resources.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gurkamal-singh-toptal-demo-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  version = "2.63"
}