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

resource "aws_subnet" "jupyterhub" {
  vpc_id                  = aws_vpc.jupyterhub.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "jupyterhub_public" {
  vpc_id = aws_vpc.jupyterhub.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jupyterhub.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "jupyterhub_public" {
  subnet_id      = aws_subnet.jupyterhub.id
  route_table_id = aws_route_table.jupyterhub_public.id
}
