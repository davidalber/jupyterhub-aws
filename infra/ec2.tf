///////////////////////////////////////////////////////////////////////////////
// Security group
///////////////////////////////////////////////////////////////////////////////
resource "aws_security_group" "jupyterhub" {
  name        = var.security_group_name
  description = "Allow ports necessary for JupyterHub"
  vpc_id      = aws_vpc.jupyterhub.id

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "jupyterhub_http" {
  security_group_id = aws_security_group.jupyterhub.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "jupyterhub_https" {
  security_group_id = aws_security_group.jupyterhub.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "jupyterhub_ssh" {
  for_each          = var.ssh_cidrs
  security_group_id = aws_security_group.jupyterhub.id

  cidr_ipv4   = each.value
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "jupyterhub_mosh" {
  for_each          = var.ssh_cidrs
  security_group_id = aws_security_group.jupyterhub.id

  cidr_ipv4   = each.value
  from_port   = 60000
  to_port     = 61000
  ip_protocol = "udp"
}

resource "aws_vpc_security_group_egress_rule" "jupyterhub_out" {
  security_group_id = aws_security_group.jupyterhub.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
