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

The code in this repository also sets up HTTPS, which is covered in a
different TLJH guide: [Enable
HTTPS](https://tljh.jupyter.org/en/latest/howto/admin/https.html).

The process is broken down into steps:
- [Set up infrastructure with Terraform](infra/README.md)
- [Configure the domain DNS record](dns-configuration.md)
- [Set up JupyterHub on the EC2 instance using
  Ansible](playbooks/README.md)
- [Deny all access to SSH](deny-ssh-access.md)

## Feedback

I set this up because I was curious what operationalizing JupyterHub
could look like, but I also put in effort to make it general enough
for others to customize it easily to their situation. If you find this
useful, please consider letting me know (star or email); that would
mean a lot to me. Feel free to send feedback or other thoughts.

If I were using this in a shared environment with real users, there's
more that I would do. If something can be added to help you, let me
know. I might find time to add it. Some potential features that are on
my mind follow.

### Backups

There needs to be backup and restoration in the event that something
goes wrong. The most obvious option is snapshotting the EBS volume,
but I would also investigate how JupyterHub can be backed up without a
complete snapshot.

### Installing System Packages with Ansible

Users on JupyterHub can install packages into their own environments,
but some packages are likely to be used by many users. In that
situation, it makes sense to just have it installed once for
everyone. TLJH has the guide [Install conda / pip packages for all
users](https://tljh.jupyter.org/en/latest/install/amazon.html#step-3-install-conda-pip-packages-for-all-users),
but I would investigate doing this in an Ansible playbook so that the
environment is more reproducible.

### DNS Configuration with Route53

For a fully-coded setup, I would manage DNS with Route53. To avoid
extra complication for potential users, I didn't do that
here. However, it might be nice to have optional configuration for
Route53 users.
