output "arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.cloudfront.arn
}

output "id" {
  description = "ID of the CloudFront distribution"
  value       = module.cloudfront.id
}

output "domain_name" {
  description = "One domain name that will resolve to this cdn. Might not be a valid alias."
  value       = module.cloudfront.domain_name
}

output "bucket_name" {
  description = "Bucket backing this CDN."
  value       = module.s3.name
}

output "bucket_arn" {
  description = "ARN of the bucket backing this CDN"
  value       = module.s3.arn
}

output "oac_id" {
  description = "ID of the origin access identity"
  value       = module.cloudfront.oac_id
}
