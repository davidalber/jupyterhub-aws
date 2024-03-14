import argparse
import subprocess
import sys
import yaml


def load_config():
    """Load current configuration."""
    result = subprocess.run(["tljh-config", "show"], capture_output=True)
    return yaml.safe_load(result.stdout).get("https", {})


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Check if TLJH HTTPS configuration matches the provided values"
    )

    parser.add_argument(
        "enabled",
        metavar="ENABLED",
        type=str,
        choices=("False", "True"),
        help="string ('False' or 'True') indicating whether HTTPS is to be enabled",
    )
    parser.add_argument(
        "email", metavar="EMAIL", type=str, help="the email provided to Let's Encrypt"
    )
    parser.add_argument(
        "domain", metavar="DOMAIN", type=str, help="domain target for SSL certificate"
    )
    parser.add_argument(
        "testcert",
        metavar="TEST_CERT",
        type=str,
        choices=("False", "True"),
        help="string ('False' or 'True') indicating whether to request a test certificate",
    )

    args = parser.parse_args()
    config = load_config()

    ssl_enabled = args.enabled == "True"
    test_cert_enabled = args.testcert == "True"
    letsencrypt = config.get("letsencrypt", {})
    letsencrypt_email = letsencrypt.get("email")
    letsencrypt_domains = letsencrypt.get("domains")
    letsencrypt_testcert = letsencrypt.get("staging", False)

    if ssl_enabled != config.get("enabled", False):
        sys.exit(1)  # configuration mismatch

    if ssl_enabled:
        # If SSL is enabled, email, domain, and testcert must match.
        if (
            args.email == letsencrypt_email
            and [args.domain] == letsencrypt_domains
            and test_cert_enabled == letsencrypt_testcert
        ):
            sys.exit(0)  # configuration matches
    else:
        # If it SSL is not enabled, email, domain, and testcert must be `None`.
        if (
            letsencrypt_email is None
            and letsencrypt_domains is None
            and letsencrypt_testcert is None
        ):
            sys.exit(0)  # configuration matches

    sys.exit(1)  # configuration mismatch
