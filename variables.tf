variable "ports" {
  type = list(number)
}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_south_a1" {
  type = string
}
variable "subnet_south_b1" {
  type = string
}
