data "aws_availability_zones" "available" {}

variable "region" {
  description = "The region where the environment is being built"
}

variable "name" {
  description = "The name of the VPC"
  default     = "Demo"
}

variable "environment" {
  description = "The environment: Support, Modelling or Scoring"
  default     = "Demonstration"
}

variable "managed" {
  description = "Managed by Terraform"
  default     = "Managed by Terraform"
}