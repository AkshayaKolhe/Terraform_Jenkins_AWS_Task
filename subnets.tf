#tfsec:ignore:aws-ec2-no-public-ip-subnet
resource "aws_subnet" "subnet_south_a" {
  vpc_id                  = aws_vpc.task_vpc.id
  cidr_block              = var.subnet_south_a1
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "subnet_south_a"
  }
}

#tfsec:ignore:aws-ec2-no-public-ip-subnet
resource "aws_subnet" "subnet_south_b" {
  vpc_id                  = aws_vpc.task_vpc.id
  cidr_block              = var.subnet_south_b1
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "subnet_south_b"
  }
}


