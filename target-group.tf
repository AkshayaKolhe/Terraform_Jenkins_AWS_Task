# Create a Target Group for your NLB
resource "aws_lb_target_group" "target_group" {
  name        = "target-group"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.task_vpc.id
  target_type = "instance"
}

# Attach Target Group to NLB Listener
resource "aws_lb_listener" "task_listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}