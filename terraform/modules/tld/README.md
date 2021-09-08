# TLD

"top level domain"

Provisions a Route53 Hosted Zone for the given domain name, a Certificate for
`*.domain_name`, and validates the cert on the domain. Note that for this module
to apply you must have DNS records from your registrar pointing at the
(newly-created) hosted zone. Either `-target` the apply, or repoint the DNS on
the fly and hope it propagates before terraform times out.

## Version History

- v0.2.0: Initial release
