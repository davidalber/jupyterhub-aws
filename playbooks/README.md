# JupyterHub AWS Ansible Playbooks

This directory contains Ansible playbooks that are run after Terraform
creates the infrastructure. If the infrastructure has not yet been
created, go back and complete the Terraform steps before running
Ansible.

The playbooks in this directory do the following:
- Install JupyterHub on the EC2 instance
- Set up SSL for the JupyterHub instance so that users communicate
  securely over HTTPS

## Prerequisites

You need to have Ansible installed on your local machine. Ansible
requires Python. See [Installing
Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
for full coverage of options.

A quick and self-contained option for installing is to create a
virtual environment and install Ansible into it. For instance:

```bash
# Assuming `python` is Python 3.
$ python -m venv ansible_env  # Create a virtual environment named ansible_env
$ . ansible_env/bin/activate  # Activate the virtual environment
(ansible_env) $ pip install ansible  # Install Ansible in the virtual environment
.
.
.

(ansible_env) $ ansible --version
ansible [core 2.16.4]
.
.
.
```

## Configuration

You need to do some configuration before running Ansible. Follow these
steps:
1. Copy the inventory.template file to inventory. Update the domain
   name in the new file.

   If you are not deploying JupyterHub with a custom domain, use the
   EC2 instance's IP address. Note: this is not a good production
   option because SSL cannot be set up without a domain name. All
   requests in this situation will be sent as plaintext and subject to
   easy snooping. This includes your users' JupyterHub passwords, so
   if you are following this route, be absolutely certain to not reuse
   a password.
1. Copy the vars.yaml.template file to vars.yaml. Update the values in
   the new file. You can leave `jupyterhub_admin` unchanged, if
   desired.

   It is preferred to leave `enable_ssl` as `yes` if you are using a
   custom domain. If you are not using a custom domain, put `no`. If
   SSL is enabled, you must provide values for `letsencrypt_email` and
   `letsencrypt_domain`. If it is not enabled, the `letsencrypt_*`
   values may be left unchanged.

   The `letsencrypt_email` value is provided to Let's Encrypt, the SSL
   certificate provider. Let's Encrypt sends notifications to this
   email address if a certificate registered with it is at risk of
   expiring.

   The `letsencrypt_domain` value is the domain that you have
   configured to point to the JupyterHub instance (i.e., the same
   domain you put in the inventory file).

   The `letsencrypt_test_cert` value specifies if a test SSL
   certificate (`yes`) or a production SSL certificate (`no`) should
   be created. If you are testing the deployment, you may want the
   test certificate because production certificate creation is rate
   limited. That is, if you create the infrastructure too many times
   (which causes SSL certificate creation), then you may be eventually
   unable to create a new production certificate for a while. The
   downside of the test certificate is that web browsers will
   determine it is invalid and you will need to instruct the browser
   to accept the certificate. Once you are satisfied with the setup,
   definitely change `letsencrypt_test_cert` to `no`.

## Executing the Set Up

With configuration complete, you can use Ansible to set up JupyterHub
by doing:

```bash
$ ansible-playbook -i inventory setup.yaml
```

Once this is complete, head to the configured domain (or IP address)
in a browser and create a password for your admin user.
