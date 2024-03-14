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

Below is an example showing what DNS configuration can look like. This
setup is in Cloudflare and will likely vary from any other DNS
configuration dashboard, but you should expect to find the four fields
discussed above in all provider dashboards. Note that Cloudflare has
additional elements that you may not have, specifically "Proxy
status". If you are using Cloudflare, feel free to turn it on. In this
case, I left it off to demonstrate the TTL setting.

![DNS configuration
example](https://github.com/davidalber/repo-assets/blob/main/jupyterhub-aws/dns-configuration.png)
