resource "aws_flow_log" "aws_flow_log_vpc" {
  iam_role_arn    = aws_iam_role.vpc_flow_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_log_action.arn
  traffic_type    = "ALL"
  vpc_id = aws_vpc.task_vpc.id
  max_aggregation_interval  = 60
}

resource "aws_cloudwatch_log_group" "vpc_log_action" {
  name = "vpc_log_action_task"
}

data "aws_iam_policy_document" "assume_role_vpc_action_flow" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow_role" {
  name               = "vpc_flow_role_task"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "CloudWatch_vpc_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "CloudWatch_vpc_policy_task" {
  name   = "CloudWatch_vpc_policy_task"
  role   = aws_iam_role.vpc_flow_role.id
  policy = data.aws_iam_policy_document.CloudWatch_vpc_policy.json
}