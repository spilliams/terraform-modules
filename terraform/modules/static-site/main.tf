locals {
  bucket_domain_name = join("-", split(".", var.domain_name))
  bucket_name        = "tf-${local.bucket_domain_name}"
}
