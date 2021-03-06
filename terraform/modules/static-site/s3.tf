resource "aws_s3_bucket" "site" {
  bucket = local.bucket_name
  acl    = "public-read"
  policy = templatefile("${path.module}/bucket-policy.json.tpl", { bucket = local.bucket_name })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = concat(["https://${var.domain_name}"], var.extra_allowed_origins)
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
