#security group nlb
resource "aws_security_group" "allow_inbound_rules_nlb" {
  name        = "allow_inbound_rules_aws_nlb"
  description = "Allow inbound traffic nlb"
  vpc_id      = aws_vpc.task_vpc.id

  dynamic "ingress" {
    for_each = var.ports
    content {
      description = "allow inbound"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_grp_name_nlb" {
  value = aws_security_group.allow_inbound_rules_nlb.id
}

#   ingress {
#    description = "TLS from vpc"
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#   ingress {
#    description = "python api ingress"
#    from_port   = 5000
#    to_port     = 5000
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }