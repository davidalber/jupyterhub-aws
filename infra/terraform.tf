terraform {
  required_version = "~> 1.7.0"

  backend "s3" {
    bucket = "dma-tf-state"
    key    = "jupyterhub-aws/terraform.tfstate"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
  }
}
