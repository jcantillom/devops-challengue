# Usar una VPC existente en AWS
data "aws_vpc" "selected_vpc" {
  id = var.existing_vpc_id
}

# Usar una Subnet Pública existente en la VPC
data "aws_subnet" "selected_subnet" {
  id = var.existing_subnet_id
}

# Usar un Internet Gateway existente en la VPC
data "aws_internet_gateway" "selected_igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.existing_vpc_id]
  }
}

data "aws_route_table" "existing_route_table" {
  filter {
    name   = "vpc-id"
    values = [var.existing_vpc_id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

