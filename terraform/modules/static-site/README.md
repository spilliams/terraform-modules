# static-site module

Deploying this module gets you:

- an s3 bucket to host static site content from. **Note:** this bucket is set
  for **public-read access!**
- a cloudfront to host that content behind a domain. **Note:** this cloudfront
  requires TLSv1.2 traffic.
- a route53 hosted zone based on the `domain_name` input, and relevant records
  to forward traffic to CloudFront.

This module is designed to be used as a subdomain (e.g. "blog.example.com"). I
encourage users to provision their own "top-level domain" hosted zone and certs,
then provision this module, then create an NS record forwarding traffic from
their tld to the static site. An example of this is provided in
`terraform/examples/hugo`.

## Version History

- v0.3.0:
  - removes all trace of the `www` redirect stuff. This may come back in a
    future version.
  - adds a new input `acm_certificate_arn` for linking the cloudfront with an
    external certificate.
  - no longer provisions the "top-level domain" resources for redirecting
    traffic from www to root. Callers are expected to do this on their own terms
    for now.
  - adds new outputs `hosted_zone_id` and `name_servers` so that callers can
    route traffic to this site.
  - adds a new output `cloudfront_domain` so that users can troubleshoot new
    sites.
  - removes the `tags` input. I encourage users to use the `default_tags`
    feature in the aws provider.
  - adds new optional inputs `extra_aliases` and `extra_allowed_origins` for the
    cloudfront and s3 bucket CORS policy, respectively.
  - adds new input `hosted_zone_id` for users who want to provide their own
    hosted zone for the cloudfront.
- v0.2.0:
  - removes the Route53 Hosted Zone and Certificate from provisioned resources
    (see `modules/tld`)
- v0.1.2: Adds an output for the Route53 Hosted Zone id
- v0.1.1: Adds an output for the S3 bucket's website endpoint (useful if you
  want to upload site contents and vet it before cutting the DNS over)
- v0.1.0: Initial release
