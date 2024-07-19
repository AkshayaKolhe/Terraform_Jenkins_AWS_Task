# SNS Topic for Scaling Notifications
#tfsec:ignore:aws-sns-enable-topic-encryption
resource "aws_sns_topic" "scale_notification_topic" {
  name = "scale-notification-topic"
}

# SNS Subscription for Scaling Notifications
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.scale_notification_topic.arn
  protocol  = "email"
  endpoint  = "akshaya.kolhe@coditas.com"
}
