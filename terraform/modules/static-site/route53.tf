# Route 53
resource "aws_route53_zone" "site" {
  count = length(var.hosted_zone_id) > 0 ? 0 : 1
  name  = var.domain_name
}

data "aws_route53_zone" "site" {
  count   = length(var.hosted_zone_id) > 0 ? 1 : 0
  zone_id = var.hosted_zone_id
}

locals {
  hosted_zone = length(var.hosted_zone_id) > 0 ? data.aws_route53_zone.site[0] : aws_route53_zone.site[0]
}

resource "aws_route53_record" "site" {
  zone_id = local.hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}
