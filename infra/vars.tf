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
