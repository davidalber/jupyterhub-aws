# JupyterHub AWS

This repository contains Terraform and Ansible code to set up AWS
resources and deploy a JupyterHub instance using [The Littlest
JupyterHub](https://tljh.jupyter.org/) (TLJH).

The infrastructure code here offers an alternative to the manual steps
in TLJH's [Installing on Amazon Web
Services](https://tljh.jupyter.org/en/latest/install/amazon.html)
guide. While you can set up TLJH using the manual steps in the guide,
you may enjoy the benefits of having your infrastructure setup in code
if you are running a production instance of JupyterHub. It will be
simple to create, replace, and destroy the infrastructure in a
reproducible manner.

The downside of this approach is that you will need to install
additional dependencies, whereas the manual approach from the guide is
done entirely from the AWS console.

The process is broken down into steps:
- [Set up infrastructure with Terraform](infra/README.md)
- [Configure the domain DNS record](dns-configuration.md)
- [Set up JupyterHub on the EC2 instance using
  Ansible](playbooks/README.md)
- [Deny all access to SSH](deny-ssh-access.md)
