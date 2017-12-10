#!/bin/bash
echo "" > backend.tf
"yes" "yes" | aws-vault exec personal -- terraform init
sed -i -e 's/prevent_destroy = true/prevent_destroy = false/g' main.tf

echo "yes" | aws-vault exec personal -- terraform destroy
if [ $? -eq 0 ]; then
    echo "Terraform destroy was successful"
else
    echo "Terraform destroy failed"
    echo "Exiting script..."
    exit 1
fi

rm -rf .terraform && rm -rf terraform.tfstate*
sed -i -e 's/prevent_destroy = false/prevent_destroy = true/g' main.tf