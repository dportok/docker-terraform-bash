resource "aws_security_group_rule" "ingress_cidrs" {
  count             = "${var.ingress_rules_cidrs == "" ? 0 : length(split("\n", chomp(var.ingress_rules_cidrs)))}"
  security_group_id = "${var.security_group_id}"
  type              = "ingress"
  protocol          = "${trimspace(element(split("|", element(split("\n", var.ingress_rules_cidrs), count.index)), 0))}"
  from_port         = "${trimspace(element(split("|", element(split("\n", var.ingress_rules_cidrs), count.index)), 1))}"
  to_port           = "${trimspace(element(split("|", element(split("\n", var.ingress_rules_cidrs), count.index)), 2))}"
  cidr_blocks       = "${split(",", trimspace(element(split("|", element(split("\n", var.ingress_rules_cidrs), count.index)), 3)))}"
}

resource "aws_security_group_rule" "egress_cidrs" {
  count             = "${var.egress_rules_cidrs == "" ? 0 : length(split("\n", chomp(var.egress_rules_cidrs)))}"
  security_group_id = "${var.security_group_id}"
  type              = "egress"
  protocol          = "${trimspace(element(split("|", element(split("\n", var.egress_rules_cidrs), count.index)), 0))}"
  from_port         = "${trimspace(element(split("|", element(split("\n", var.egress_rules_cidrs), count.index)), 1))}"
  to_port           = "${trimspace(element(split("|", element(split("\n", var.egress_rules_cidrs), count.index)), 2))}"
  cidr_blocks       = "${split(",", trimspace(element(split("|", element(split("\n", var.egress_rules_cidrs), count.index)), 3)))}"
}

