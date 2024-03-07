# JupyterHub AWS

This repository contains Terraform and Ansible code to set up AWS
resources and deploy a JupyterHub instance. After running two
commands, your JupyterHub instance is ready to go.

As written in this repository, Terraform will:
- Deploy all resources to the AWS us-west-2 region
- Create a VPC named "jupyterhub"

## Customizing

If you want to use the configurations in this repository you will need
to change some values, and you may also want to change other values.

## Required Changes
### Backend Configuration

As configured, Terraform will store its state file in S3. Backend
configurations cannot have variables, so these values must be changed
in the backend block in terraform.tf. The attributes you must change
are:
- `bucket`: The name of an S3 bucket you have permission to write
  to. Note that this bucket must already exist; this Terraform module
  does not create the S3 bucket for you.

## Optional Changes
### Backend Configuration

In addition to the required changes to the backend configuration
described above, you may change the following values:
- `key`: The key in the S3 bucket into which state will be written.
- `region`: The AWS region of the S3 bucket.

### VPC

You may change the name of the VPC in vars.tf by changing the
`vpc_name` variable declaration.
