# Define the provider
provider "aws" {
  region = "${var.region}"
}

# Module that builds the Network Infrastructure
module "infra_setup" {
  source             = "./modules/network_setup"
  vpc_cidr_block     = "10.0.0.0/16"
  azones             = "${data.aws_availability_zones.available.names[0]}"
  public_cidr_block  = "10.0.1.0/24"
}

# Create a Security Group allowing traffic on ports 22,80,443 from a speciif
resource "aws_security_group" "incoming_traffic" {
  description = "Incoming Traffic"
  vpc_id      = "${module.infra_setup.vpc_id_out}"

  tags {
    Name        = "${var.name}-Incoming-Traffic"
    Environment = "${var.environment}"
    ManagedBy   = "${var.managed}-${var.name}"
  }
}

# Apply the requested rules to the Incoming Traffic SG
module "internal_traffic_sg_rules" {
  source            = "./modules/sg_rules"
  security_group_id = "${aws_security_group.incoming_traffic.id}"

  ingress_rules_cidrs = <<EOF
tcp | 80 | 80 | 5.148.131.186/32
tcp | 443 | 443 | 5.148.131.186/32
tcp | 22 | 22 | 5.148.131.186/32
EOF

  egress_rules_cidrs = <<EOF
-1 | 0 | 0 | 0.0.0.0/0
EOF
}

# Get the latest ami for Ubuntu LTS version
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

# Create an EC2 instance with latest LTS ami of Ubuntu
resource "aws_instance" "ubuntu-instance" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  subnet_id              = "${module.infra_setup.public_subnet_id_out}"
  instance_type          = "t2.nano"
  key_name               = "demo" # Assuming that our key pair is called demo
  vpc_security_group_ids = ["${aws_security_group.incoming_traffic.id}"]

  tags {
    Name        = "${var.name}-Instance"
    Environment = "${var.environment}"
    ManagedBy   = "${var.managed}-${var.name}"
  }
}

# Create an S3 bucket to store remotely the terraform.tfstate file
resource "aws_s3_bucket" "terraform-backend-bucket" {
    bucket = "dportok-terraform-backend-bucket"
    force_destroy = true
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "${var.name}-S3-terraform"
      Environment = "${var.environment}"
      ManagedBy   = "${var.managed}-${var.name}"
    }      
}

# Create a DynamoDB table to use for state locking and consistency
resource "aws_dynamodb_table" "dynamodb-state-lock" {
  name = "demo-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
     Name = "${var.name}-DynamoDB"
     Environment = "${var.environment}"
     ManagedBy   = "${var.managed}-${var.name}"
  }
}
