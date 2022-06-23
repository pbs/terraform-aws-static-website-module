locals {
  name                             = var.name != null ? var.name : var.product
  s3_origin_config                 = module.s3.name
  s3_regional_domain_name          = var.s3_regional_domain_name != null ? var.s3_regional_domain_name : module.s3.regional_domain_name
  create_replication_target_policy = var.replication_source != null
  bucket_policy                    = var.bucket_policy != null ? var.bucket_policy : data.aws_iam_policy_document.policy_doc.json
}
