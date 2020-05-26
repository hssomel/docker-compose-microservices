aws_region = "us-east-1"
kops_state_store_s3 = "kops-state-store-gurkamalsingh"

# cluster domain (route53_domain_name MUST ALREADY be purchased through AWS)
route53_domain_name = "gurkamalsingh.com"
kubernetes_subdomain = "k8s"

# Note - generate an SSH keypair for cluster SSH access and do 1 of the following: 
# 1) set environment variable TF_VAR_ssh_public_key=< pubkey >
# 2) enter the public key at prompt