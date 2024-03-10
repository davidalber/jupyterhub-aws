# DNS Configuration

If you are planning to associate a domain name with your JupyterHub
instance, you will need to create an `A` record in your DNS
configuration. How you do this will depend on how you manage your DNS
configuration, so only general information is included below.

Add a record to your DNS configuration with values like this:
- Type: `A`.
- TTL: 1800 (seconds). Make this much shorter (like 60 seconds) if you
  expect the IP address to change soon (e.g., you are creating and
  destroying the infrastructure repeatedly).
- Name: "jupyterhub" or whatever you want the domain to be named.
- IPv4 Address: the address output after running `terraform
  apply`. You can run `terraform output` in the infra directory to see
  the IP address again.
