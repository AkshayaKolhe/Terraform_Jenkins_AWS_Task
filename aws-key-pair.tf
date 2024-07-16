#creating ssh-key pair

resource "aws_key_pair" "terrafrom_key" {
  key_name   = "terrafrom_key"
  public_key = file("${path.module}/terrafrom-key-pair.pub") #file function reads the contents of a file
}

output "print_key_name" {
  value = aws_key_pair.terrafrom_key.key_name
}

