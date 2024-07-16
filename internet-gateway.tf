resource "aws_internet_gateway" "task-internet-gateway" {
  vpc_id = aws_vpc.task_vpc.id
}