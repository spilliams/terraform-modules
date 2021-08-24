output "root_bucket_name" {
  value = local.root_bucket_name
}

output "root_bucket_endpoint" {
  value = aws_s3_bucket.root.website_endpoint
}

output "root_cloudfront_id" {
  value = aws_cloudfront_distribution.root.id
}
