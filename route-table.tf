#Creating Route Table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.task_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task-internet-gateway.id
  }
}
resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.subnet_south_a.id
  route_table_id = aws_route_table.route-table.id
}
resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.subnet_south_b.id
  route_table_id = aws_route_table.route-table.id
}

