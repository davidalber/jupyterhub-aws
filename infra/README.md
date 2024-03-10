This directory contains a Terraform module that creates AWS
infrastructure to run your JupyterHub instance. This Terraform step
will:
- Deploy all resources to the AWS us-west-2 region.
- Create a VPC named "jupyterhub".
- Set up a security group with HTTP, HTTPS, SSH, and Mosh ingress
  rules.
- Create an EC2 instance on which to run JupyterHub.

## Prerequisites

You must have Terraform installed. See [Install
Terraform](https://developer.hashicorp.com/terraform/install) for
instructions.

## Customizing

Before running Terraform you must change some configuration values,
and you can optionally change other values.

## Required Changes
### Backend Configuration

As configured, Terraform will store its state file in S3. Backend
configurations cannot have variables, so these values must be changed
in the backend block in terraform.tf. The attributes you must change
are:
- `bucket`: The name of an S3 bucket you have permission to write
  to. Note that this bucket must already exist; this Terraform module
  does not create the S3 bucket for you.

### Security Group

You must set the following values in vars.tf:
- `ssh_cidrs`: CIDR ranges from which SSH and Mosh connections will be
  accepted. It is good practice to disallow SSH access, except when
  needed. This is accomplished by leaving the set empty. It is also
  good practice, when allowing SSH access, to limit authorizations to
  necessary IP addresses. This can be accomplished by providing the
  desired CIDR ranges in the set (e.g., `["54.166.129.219/32"]`).

  While not recommended, if you prefer to allow connection from all IP
  addresses, that is accomplished with `[0.0.0.0/0]`.

  Until setup is complete, you must authorize at least your own IP
  address. After configuration when SSH connectivity is not needed, it
  is a good idea to remove that authorization.

### EC2 Instance

Set the following value in vars.tf:
- `authorized_ssh_key`: In order to connect to and complete setup of
  the instance, it is necessary to provide a public SSH key at launch.

## Optional Changes
### Backend Configuration

In addition to the required changes to the backend configuration
described above, you may change the following values:
- `key`: The key in the S3 bucket into which state will be
  written. Default "jupyterhub-aws/terraform.tfstate".
- `region`: The AWS region of the S3 bucket. Default: "us-west-2".

### Networking

You may change the following networking-related values in vars.tf:
- `vpc_name`: The name assigned to the VPC. Default: "jupyterhub".
- `internet_gateway_name`: The name assigned to the VPC's internet
  gateway. Default: "jupyterhub".
- `subnet_name`: The VPC subnet name. Default: "jupyterhub".
- `route_table_name`: Subnet route table name. default: "jupyterhub
  public".

### Security Group

You may affect the security group by changing the following values in
vars.tf:
- `security_group_name`: The name of the security group attached to
  the EC2 instance. Default: "jupyterhub".

### EC2 Instance

You can customize the EC2 instance by changing the following values in
vars.tf:
- `ec2_instance_name`: The name of the EC2 instance. Default:
  "jupyterhub".
- `ec2_instance_type`: The EC2 instance type. The instance must be an
  ARM-based architecture because the AMI is built for an ARM
  instance. The default is t4g.small, which has 2GB of RAM. JupyterHub
  documentation recommends 2GB of RAM, it says that 1GB is an option,
  although it will have reduced performance. If you want to reduce
  costs and run an instance with 1GB of RAM, select t4g.micro.
- `ebs_volume_size`: The amount of storage attached to the EC2
  instance, in GB. Default: 8.
