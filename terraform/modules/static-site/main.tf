resource "random_string" "slug" {
  length  = 6
  upper   = false
  special = false
}

locals {
  bucket_domain_name = join("-", split(".", var.domain_name))
  bucket_name        = "tf-${local.bucket_domain_name}-${random_string.slug.result}"
}
