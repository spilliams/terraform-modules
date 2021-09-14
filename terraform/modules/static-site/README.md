# static-site module

I copied most of this module from
[alexhyett/terraform-s3-static-website](https://github.com/alexhyett/terraform-s3-static-website).
The differences with this module are:

- I flipped the redirect pattern: www redirects to root instead of the other way around.
- I also switched from email cert validation to DNS cert validation.
- and I removed the TLSv1 and TLSv1.1 policies. These sites require 1.2 or better.

Deploying this module gets you:

- certs and records to allow TLSv1.2 traffic to `domain_name` and `www.domain_name`
- s3 buckets and cloudfronts to serve content on these websites.
- Traffic to `www.domain_name` will be redirected to `domain_name`

After deploying this, sync files to the s3 bucket, then create an invalidation
on the cloudfront ID. I believe it's only necessary to deploy to the `root`
bucket and CDN, and you can leave the `www` bucket and CDN alone.

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
- v0.2.0:
  - removes the Route53 Hosted Zone and Certificate from provisioned resources
    (see `modules/tld`)
- v0.1.2: Adds an output for the Route53 Hosted Zone id
- v0.1.1: Adds an output for the S3 bucket's website endpoint (useful if you
  want to upload site contents and vet it before cutting the DNS over)
- v0.1.0: Initial release
