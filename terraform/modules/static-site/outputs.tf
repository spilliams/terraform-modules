output "bucket_name" {
  description = "The name of the bucket to upload site files to"
  value = local.bucket_name
}

output "bucket_endpoint" {
  description = "The URL that goes directly to the bucket, does not pass go"
  value = aws_s3_bucket.site.website_endpoint
}

output "cloudfront_id" {
  description = "The cloudfront to invalidate after putting enw files in the bucket"
  value = aws_cloudfront_distribution.site.id
}

output "hosted_zone_id" {
  description = "The zone ID of the site's hosted zone"
  value = aws_route53_zone.site.zone_id
}

output "name_servers" {
  description = "The name servers of the site's hosted zone"
  value = aws_route53_zone.site.name_servers
}
