# certs have to be made in us-east-1 for CloudFront to use them
provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}

resource "aws_acm_certificate" "main" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = merge(local.tags, { Name = var.domain_name })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "main" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
