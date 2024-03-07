resource "aws_vpc" "jupyterhub" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "jupyterhub" {
  vpc_id = aws_vpc.jupyterhub.id

  tags = {
    Name = var.internet_gateway_name
  }
}
