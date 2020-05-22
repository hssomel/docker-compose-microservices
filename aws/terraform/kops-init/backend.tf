terraform {
  backend "s3" {
    bucket         = "gurkamal-singh-toptal-demo-terraform-state"
    key            = "terraform/kops-init.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gurkamal-singh-toptal-demo-terraform-locks"
    encrypt        = true
  }
}