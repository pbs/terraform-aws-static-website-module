output "arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.static_website.arn
}

output "domain_name" {
  description = "One domain name that will resolve to this cdn. Might not be a valid alias."
  value       = module.static_website.domain_name
}

output "oac_id" {
  description = "ID of the origin access identity"
  value       = module.static_website.oac_id
}
