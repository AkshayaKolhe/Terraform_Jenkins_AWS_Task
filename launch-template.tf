# Launch Template
#tfsec:ignore:aws-ec2-enforce-launch-config-http-token-imds
resource "aws_launch_template" "task_terraform_template" {
  name          = "task-terra-template"
  image_id      = var.image_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terrafrom_key.key_name
  user_data     = base64encode(file("${path.module}/user-script.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.subnet_south_a.id
    security_groups             = [aws_security_group.allow_inbound_rules.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "task-instance"
    }
  }
}
