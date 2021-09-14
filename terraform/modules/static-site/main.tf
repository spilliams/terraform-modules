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
  bucket_name        = "tf-${local.bucket_domain_name}-${random_string.slug.result}"
}
