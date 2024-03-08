///////////////////////////////////////////////////////////////////////////////
// Top-level AWS values
///////////////////////////////////////////////////////////////////////////////
variable "aws_region" {
  type        = string
  nullable    = false
  default     = "us-west-2"
  description = "AWS region in which resources are create."
}

///////////////////////////////////////////////////////////////////////////////
// Networking values
///////////////////////////////////////////////////////////////////////////////
variable "vpc_name" {
  type        = string
  nullable    = false
  default     = "jupyterhub"
  description = "Name of the VPC."
}

variable "internet_gateway_name" {
  type        = string
  nullable    = false
  default     = "jupyterhub"
  description = "Name of the internet gateway created in the VPC."
}

variable "subnet_name" {
  type        = string
  nullable    = false
  default     = "jupyterhub"
  description = "Name of the VPC subnet."
}

variable "route_table_name" {
  type        = string
  nullable    = false
  default     = "jupyterhub public"
  description = "Name of the subnet route table."
}

variable "security_group_name" {
  type        = string
  nullable    = false
  default     = "jupyterhub"
  description = "Name of the JupyterHub EC2 security group."
}

variable "ssh_cidrs" {
  type        = set(string)
  nullable    = false
  default     = []
  description = "List of CIDR ranges from which to allow SSH connections."
}
