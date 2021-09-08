resource "random_string" "slug" {
  length  = 6
  upper   = false
  special = false
}

locals {
  default_tags = {
    Domain     = var.domain_name
    DeployedBy = "terraform"
  }
  tags               = merge(local.default_tags, var.tags)
  bucket_domain_name = join("-", split(".", var.domain_name))
  root_bucket_name   = "tf-${local.bucket_domain_name}-root-${random_string.slug.result}"
  www_bucket_name    = "tf-${local.bucket_domain_name}-www-${random_string.slug.result}"
}

module "tld" {
  source = "../tld"

  domain_name = var.domain_name
}
