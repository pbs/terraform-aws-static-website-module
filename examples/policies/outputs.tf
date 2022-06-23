output "arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.static_website.arn
}

output "domain_name" {
  description = "One domain name that will resolve to this cdn. Might not be a valid alias."
  value       = module.static_website.domain_name
}

output "oia_arns" {
  description = "Origin Access Identity ARNs"
  value       = module.static_website.oia_arns
}
