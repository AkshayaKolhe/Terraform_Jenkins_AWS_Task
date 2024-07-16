#security group

resource "aws_security_group" "allow_inbound_rules" {
  name        = "allow_inbound_rules_aws"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.task_vpc.id

  dynamic "ingress" {
    for_each = var.ports
    content {
      description = "allow inbound"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.allow_inbound_rules_nlb.id]    
      }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_grp_name_ec2" {
  value = aws_security_group.allow_inbound_rules.id
}

#   ingress {
#    description = "TLS from vpc"
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#   ingress {
#    description = "python api ingress"
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }