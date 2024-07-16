resource "aws_vpc" "task_vpc" {
  cidr_block = var.vpc_cidr
}