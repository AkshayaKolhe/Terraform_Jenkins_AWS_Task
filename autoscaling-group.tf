# Create Auto Scaling Group using the Launch Template
resource "aws_autoscaling_group" "autoscaling_grp_task" {
  launch_template {
    id      = aws_launch_template.task_terraform_template.id
    version = aws_launch_template.task_terraform_template.latest_version
  }
  target_group_arns = [aws_lb_target_group.target_group.arn]


  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 1
  health_check_grace_period = 200
  health_check_type         = "EC2"
  vpc_zone_identifier       = [aws_subnet.subnet_south_a.id, aws_subnet.subnet_south_b.id]

  enabled_metrics = [
    "GroupInServiceInstances"
  ]
}

# Target Tracking Scaling Policy
resource "aws_autoscaling_policy" "target_tracking_policy" {
  name                      = "target-tracking-policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 200 #200 sec
  autoscaling_group_name    = aws_autoscaling_group.autoscaling_grp_task.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 2.0 #cpu utilization till 2
  }
}
