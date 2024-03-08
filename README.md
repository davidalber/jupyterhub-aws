# JupyterHub AWS

This repository contains Terraform and Ansible code to set up AWS
resources and deploy a JupyterHub instance. After running two
commands, your JupyterHub instance is ready to go.

As written in this repository, Terraform will:
- Deploy all resources to the AWS us-west-2 region.
- Create a VPC named "jupyterhub".
- Set up a security group with HTTP, HTTPS, SSH, and Mosh ingress
  rules.

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

### Networking

You may change the following networking-related values in vars.tf:
- `vpc_name`: The name assigned to the VPC.
- `internet_gateway_name`: The name assigned to the VPC's internet
  gateway.
- `subnet_name`: The VPC subnet name.
- `route_table_name`: Subnet route table name.

### Security Group

You may affect the security group by changing the following values in
vars.tf:
- `security_group_name`: The name of the security group attached to
  the EC2 instance.
- `ssh_cidrs`: CIDR ranges from which SSH and Mosh connections will be
  accepted. It is good practice to disallow SSH access, except when
  needed. This is accomplished by leaving the set empty. It is also
  good practice, when allowing SSH access, to limit authorizations to
  necessary IP addresses. This can be accomplished by providing the
  desired CIDR ranges in the set (e.g., `["54.166.129.219/32"]`).
