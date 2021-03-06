module "s3" {
  source = "github.com/pbs/terraform-aws-s3-module?ref=0.0.1"

  name         = var.bucket_name
  use_prefix   = var.use_prefix
  is_versioned = var.is_versioned
  acl          = var.acl
  cors_rules   = var.cors_rules

  bucket_policy   = local.bucket_policy
  lifecycle_rules = var.lifecycle_rules

  force_destroy = var.force_destroy

  replication_configuration_set      = var.replication_configuration_set
  replication_configuration_shortcut = var.replication_configuration_shortcut

  allow_anonymous_vpce_access = var.allow_anonymous_vpce_access

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "cloudfront" {
  source = "github.com/pbs/terraform-aws-cloudfront-module?ref=0.1.1"

  name    = local.name
  comment = var.comment

  primary_hosted_zone = var.primary_hosted_zone

  origins = [
    merge(
      {
        domain_name      = local.s3_regional_domain_name
        s3_origin_config = local.s3_origin_config
      },
      var.additional_origin_configurations
    )
  ]

  default_origin_id = var.default_origin_id

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  default_root_object = var.default_root_object

  cloudfront_default_certificate = var.cloudfront_default_certificate

  minimum_protocol_version = var.minimum_protocol_version

  ssl_support_method = var.ssl_support_method

  default_cache_policy_name = var.default_cache_policy_name
  default_cache_policy_id   = var.default_cache_policy_id

  default_origin_request_policy_name = var.default_origin_request_policy_name
  default_origin_request_policy_id   = var.default_origin_request_policy_id

  default_behavior_allowed_methods = var.default_behavior_allowed_methods
  default_behavior_cached_methods  = var.default_behavior_cached_methods

  default_response_headers_policy_id   = var.default_response_headers_policy_id
  default_response_headers_policy_name = var.default_response_headers_policy_name

  ordered_cache_behavior = var.ordered_cache_behavior

  dns_evaluate_target_health = var.dns_evaluate_target_health
  web_acl_id                 = var.web_acl_id

  logging_config        = var.logging_config
  custom_error_response = var.custom_error_response

  create_cname = var.create_cname
  cnames       = var.cnames
  aliases      = var.aliases

  restriction_locations  = var.restriction_locations
  restriction_type       = var.restriction_type
  price_class            = var.price_class
  compress               = var.compress
  viewer_protocol_policy = var.viewer_protocol_policy

  acm_arn = var.acm_arn

  default_behavior_function_arn        = var.default_behavior_function_arn
  default_behavior_function_event_type = var.default_behavior_function_event_type

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
  tags         = var.tags
}

data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.oia_arns
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.s3.arn]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.oia_arns
    }
  }

  dynamic "statement" {
    for_each = var.allow_anonymous_vpce_access ? [1] : []
    content {
      actions = [
        "s3:GetObject",
      ]
      resources = ["arn:aws:s3:::${module.s3.name}/*"]
      condition {
        test     = "StringEquals"
        variable = "aws:sourceVpce"
        values   = [local.vpce]
      }
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }

  # These only need to be created if we're configuring replication

  dynamic "statement" {
    for_each = local.create_replication_target_policy ? toset(["create"]) : toset([])
    content {
      actions = [
        "s3:ReplicateDelete",
        "s3:ReplicateObject",
      ]
      resources = ["arn:aws:s3:::${module.s3.name}/*"]
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.replication_source.account_id}:role/${var.replication_source.role}"]
      }
    }
  }

  dynamic "statement" {
    for_each = local.create_replication_target_policy ? toset(["create"]) : toset([])
    content {
      actions = [
        "s3:List*",
        "s3:GetBucketVersioning",
        "s3:PutBucketVersioning",
      ]
      resources = ["arn:aws:s3:::${module.s3.name}"]
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.replication_source.account_id}:role/${var.replication_source.role}"]
      }
    }
  }

  dynamic "statement" {
    for_each = local.create_replication_target_policy ? toset(["create"]) : toset([])
    content {
      actions = [
        "s3:ObjectOwnerOverrideToBucketOwner",
      ]
      resources = ["arn:aws:s3:::${module.s3.name}/*"]
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.replication_source.account_id}:role/${var.replication_source.role}"]
      }
    }
  }

  source_policy_documents   = var.source_policy_documents
  override_policy_documents = var.override_policy_documents
}
