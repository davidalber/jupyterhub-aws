# Deny SSH Access

When it is not necessary to have SSH access to the EC2 instance (e.g.,
after the Ansible steps have been completed), it is good practice to
remove access. This can be accomplished by:

1. Editing the infra/vars.tf file. Change the `default` of the
   `ssh_cidrs` variable to `[]`.
1. Running `terraform apply` from within the infra/ directory.
