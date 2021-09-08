# certs have to be made in us-east-1 for CloudFront to use them
provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}

variable "domain_name" {
  type = string
}

resource "aws_acm_certificate" "main" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = { Name = var.domain_name }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = aws_route53_zone.main.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

output "certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}

output "validation_certificate_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
