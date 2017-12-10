variable "security_group_id" {
  description = "The ID of the Security Group to apply the rules"
}

variable "ingress_rules_cidrs" {
  description = "List of CIDR blocks"
  default     = ""
}

variable "egress_rules_cidrs" {
  description = "List of CIDR blocks"
  default     = ""
}
