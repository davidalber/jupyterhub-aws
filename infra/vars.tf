variable "aws_region" {
  type     = string
  nullable = false
  default  = "us-west-2"
}

variable "vpc_name" {
  type     = string
  nullable = false
  default  = "jupyterhub"
}
