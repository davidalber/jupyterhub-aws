terraform {
  required_version = "~> 1.7.0"

  backend "local" {
    path = "terraform.tfstate"
  }

  # backend "s3" {
  #   bucket = "EXISTING-BUCKET-NAME"
  #   key    = "jupyterhub-aws/terraform.tfstate"  # or whatever you like
  #   region = "us-west-2"  # or a different region
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
  }
}
