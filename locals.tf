locals {
  name                    = var.name != null ? var.name : var.product
  s3_origin_config        = module.s3.name
  s3_regional_domain_name = var.s3_regional_domain_name != null ? var.s3_regional_domain_name : module.s3.regional_domain_name
}
