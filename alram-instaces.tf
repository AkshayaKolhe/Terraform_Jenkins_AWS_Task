# CloudWatch Metric Alarm for Reaching Max Size
resource "aws_cloudwatch_metric_alarm" "max_size_reached_alarm" {
  alarm_name          = "max-size-reached-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"
  period              = 30
  statistic           = "Average"
  threshold           = 4
  alarm_description   = "Alarm when max size of 4 instances is reached"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_grp_task.name
  }

  alarm_actions = [aws_sns_topic.scale_notification_topic.arn]
}

