resource "aws_iam_role" "ec2_role" {
  name = "ec2_cloudwatch_role"
  assume_role_policy = jsonencode({ #jsonencode function converts terraform expression result to valid JSON syntax.
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name

}

resource "aws_iam_role_policy" "ec2_cloudwatch_policy" {
  name = "CloudWatchLogsAccessPolicy"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          #tfsec:ignore:aws-iam-no-policy-wildcards
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = "*"
      }
    ]
  })
}