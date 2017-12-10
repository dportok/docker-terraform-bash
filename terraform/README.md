# Fully automated deployment of an EC2 Instance running the Latest Ubuntu LTS

This Proof of Concept was created as part of a task, which requires the creation of an EC2 Instance, which should run the latest Ubuntu LTS AMI and allows HTTP, HTTPS and SSH traffic from a specific IP.

## Requirements
The whole project was built using AWS as the cloud provider and Terraform v0.10.8 as the provisioning tool.

## How to spin up the Environment
The structure of the directory which contains the code is shown below :

```
.
├── README.md
├── backend.tf
├── bootstrap.sh
├── destroy.sh
├── main.tf
├── modules
│   ├── network_setup
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── sg_rules
│       ├── main.tf
│       └── variables.tf
├── outputs.tf
├── terraform.tfvars
└── variables.tf
```
The environment is being built on ``` eu-west-2 ``` region, that is in the London region. This can be changed by modifying the region parameter inside the file ``` terraform.tfvars ```.

For storing the AWS credentials, a free tool called aws-vault was used :

[Aws-Vault](https://github.com/99designs/aws-vault)

In order to define S3 as the Backend for the state file, it is implied that the appropriate S3 bucket exists in order for the state file to be saved. In a fresh setup where no resource exists in advance, the initialization of terraform will throw an error similar to the following: 
```
terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Error loading state: NoSuchBucket: The specified bucket does not exist
	status code: 404, request id: FE5C34284092813D, host id: CSxM5O4YchTMpMHDkofhRbGmvrxbKopdYgnEc8l9LX8sJoIMtkhRcjMVA4TrXOHYWSafst+O8d8=
```
There is already an open issue on Github for this:
[Backend S3: NoSuchBucket](https://github.com/hashicorp/terraform/issues/16611)

In order to workaround this issue I have created two scripts, one for building the infrastructure and one for destroying it. The name of these scripts are : ```bootstrap.sh``` and ```destroy.sh``` accordingly.

After the user has setup his profile on the aws-vault tool, he can then run the ```bootstrap.sh``` script to spin up the infrastructure:

```./bootstrap.sh```

After the environment is built the user will have on his terminal as an output, the public IP of the EC2 Instance where he could ssh.

In order to destroy the infrastructure the user should run :
```./destroy.sh``` 

## AWS Infrastructure

The AWS Infrastructure which is used for this PoC contains the following components:
* 1 VPC
* 1 public subnet
* 1 IGW
* 1 EC2 Instance running the latest Ubuntu LTS AMI
* 1 S3 bucket to store the state file of Terraform
* The appropriate Security Group with the corresponding rules
* A DynamoDB table that provides the locking mechanism for the state file