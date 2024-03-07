variable "aws_region" {
  type        = string
  nullable    = false
  default     = "us-west-2"
  description = "AWS region in which resources are create."
}

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
