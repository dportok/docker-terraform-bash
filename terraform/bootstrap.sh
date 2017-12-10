#!/bin/bash
rm -rf .terraform && rm -rf terraform.tfstate*

aws-vault exec personal -- terraform get
if [ $? -eq 0 ]; then
    echo "Terraform get was successful"
else
    echo "Terraform get failed"
    echo "Exiting script..."
    exit 1
fi
aws-vault exec personal -- terraform init
if [ $? -eq 0 ]; then
    echo "Terraform init was successful"
else
    echo "Terraform init failed"
    echo "Exiting script..."
    exit 1
fi

aws-vault exec personal -- terraform apply
if [ $? -eq 0 ]; then
    echo "Terraform build was successful"
else
    echo "Terraform build failed"
    echo "Exiting script..."
    exit 1
fi

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
