resource "aws_s3_bucket" "root" {
  bucket = local.root_bucket_name
  acl    = "public-read"
  policy = templatefile("${path.module}/bucket-policy.json.tpl", { bucket = local.root_bucket_name })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = local.tags
}

# S3 bucket for redirecting www to non-www.
resource "aws_s3_bucket" "www" {
  bucket = local.www_bucket_name
  acl    = "public-read"
  policy = templatefile("${path.module}/bucket-policy.json.tpl", { bucket = local.www_bucket_name })

  website {
    redirect_all_requests_to = "https://${var.domain_name}"
  }

  tags = local.tags
}
