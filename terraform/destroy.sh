#!/bin/bash
echo "" > backend.tf
"yes" "yes" | aws-vault exec personal -- terraform init
sed -i -e 's/prevent_destroy = true/prevent_destroy = false/g' main.tf
echo "yes" | aws-vault exec personal -- terraform destroy
rm -rf .terraform && rm -rf terraform.tfstate*
sed -i -e 's/prevent_destroy = false/prevent_destroy = true/g' main.tf