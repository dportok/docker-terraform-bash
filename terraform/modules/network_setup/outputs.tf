output "vpc_id_out" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.vpc_demo.id}"
}

output "public_subnet_id_out" {
  description = "The ID of the Public subnet"
  value       = "${aws_subnet.public-subnet.id}"
}
