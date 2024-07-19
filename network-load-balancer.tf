# Create a Network Load Balancer 
#tfsec:ignore:aws-elb-alb-not-public
resource "aws_lb" "network_load_balancer" {
  name               = "terrafrom-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.subnet_south_a.id, aws_subnet.subnet_south_b.id]
  security_groups    = [aws_security_group.allow_inbound_rules_nlb.id]
}