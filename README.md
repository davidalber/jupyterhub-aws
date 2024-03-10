# JupyterHub AWS

This repository contains Terraform and Ansible code to set up AWS
resources and deploy a JupyterHub instance. After running two
commands, your JupyterHub instance is ready to go.

The process is broken down into steps, each of which is documented
separately.
- [Set up infrastructure with Terraform](infra/README.md).
- [Configure the domain DNS record](dns-configuration.md).
- [Set up JupyterHub on the EC2 instance using
  Ansible](playbooks/README.md).
- [Deny all access to SSH](deny-ssh-access.md).
