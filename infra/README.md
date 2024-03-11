# JupyterHub Terraform Module

This directory contains a Terraform module that creates AWS
infrastructure to run your JupyterHub instance. This Terraform step
will:
- Deploy all resources to the AWS us-west-2 region
- Create a VPC
- Set up a security group with HTTP, HTTPS, SSH, and Mosh ingress
  rules
- Create an EC2 instance on which to run JupyterHub

Terraform will store state in a local file. I would typically store
Terraform state in an S3 backend for more robustness, but I wanted to
keep the setup in this repository as low friction as possible. If you
would prefer to store the state in an S3 bucket, remove the `backend
"local"` block from terraform.tf, uncomment the `backend "s3"` block,
and configure it as needed for your case.

## Prerequisites

- You must have Terraform installed. See [Install
Terraform](https://developer.hashicorp.com/terraform/install) for
instructions.
- You must have an AWS account and an access key [installed where
  Terraform will look for
  it](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)
  (e.g., in $HOME/.aws/credentials).

## Customizing

Before running Terraform you must customize some configuration values,
and you can optionally change other values.

### Required Changes
#### Security Group

You must set the following values in vars.tf:
- `ssh_cidrs`: CIDR ranges from which SSH and Mosh connections will be
  accepted. It is good practice to disallow SSH access, except when
  needed. This is accomplished by leaving the set empty. It is also
  good practice, when allowing SSH access, to limit authorizations to
  necessary IP addresses. This can be accomplished by providing the
  desired CIDR ranges in the set (e.g., `["54.166.129.219/32"]`).

  While not recommended, if you prefer to allow connection from all IP
  addresses, that is accomplished with `["0.0.0.0/0"]`.

  Until setup is complete, you must authorize at least your own IP
  address. After completing the Ansible steps later, it is a good idea
  to remove that authorization.

#### EC2 Instance

Set the following value in vars.tf:
- `authorized_ssh_key`: In order to connect to and complete setup of
  the instance, it is necessary to provide a public SSH key at launch.

### Optional Changes
#### Networking

You may change the following networking-related values in vars.tf:
- `vpc_name`: The name assigned to the VPC. Default: "jupyterhub".
- `internet_gateway_name`: The name assigned to the VPC's internet
  gateway. Default: "jupyterhub".
- `subnet_name`: The VPC subnet name. Default: "jupyterhub".
- `route_table_name`: Subnet route table name. default: "jupyterhub
  public".

#### Security Group

You may affect the security group by changing the following values in
vars.tf:
- `security_group_name`: The name of the security group attached to
  the EC2 instance. Default: "jupyterhub".

#### EC2 Instance

You can customize the EC2 instance by changing the following values in
vars.tf:
- `ec2_instance_name`: The name of the EC2 instance. Default:
  "jupyterhub".
- `ec2_instance_type`: The EC2 instance type. The instance must be an
  ARM-based architecture because the AMI is built for an ARM
  instance. The default is t4g.small, which has 2GB of RAM. JupyterHub
  documentation recommends 2GB of RAM, but it also states that 1GB is
  an option, although it will have reduced performance. If you want to
  reduce costs and run an instance with 1GB of RAM, use t4g.micro.
- `ebs_volume_size`: The amount of storage attached to the EC2
  instance, in GB. Default: 8.

## Executing the Set Up

### Initialization

The Terraform module must be initialized before you can use it. This
only needs to be done once, unless subsequent changes are made in
terraform.tf.

```bash
$ terraform init
```

### Creating the Infrastructure

To alter the infrastructure to match the Terraform module's configuration, do:

```bash
$ terraform apply
```

Once this completes successfully, the infrastructure is set up. Note
that the IP address of the EC2 instance is output. Make a note of it
because you will need it later.

## Tearing Down the JupyterHub Infrastructure

If you want to shut down and destroy the infrastructure set up by this
module, do:

```bash
$ terraform destroy
```
