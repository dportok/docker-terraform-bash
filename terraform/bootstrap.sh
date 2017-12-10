#!/bin/bash
rm -rf .terraform && rm -rf terraform.tfstate*
aws-vault exec personal -- terraform get
aws-vault exec personal -- terraform init
aws-vault exec personal -- terraform apply
sleep 2m

cat << EOF >> backend.tf 
terraform {
  backend "s3" 
  {
    encrypt = true
    bucket = "dportok-terraform-backend-bucket"
    region = "eu-west-2"
    key = "demo.tfstate"
    dynamodb_table = "demo-state-lock"
  }
}
EOF

echo "yes" | aws-vault exec personal -- terraform init