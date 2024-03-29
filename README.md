# PBS TF Static Website Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-static-website-module?ref=6.0.16
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an S3 bucket fronted by CloudFront to serve static content.

Integrate this module like so:

```hcl
module "static_website" {
  source = "github.com/pbs/terraform-aws-static-website-module?ref=6.0.16"

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`6.0.16`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.27.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | github.com/pbs/terraform-aws-cloudfront-module | 3.1.17 |
| <a name="module_s3"></a> [s3](#module\_s3) | github.com/pbs/terraform-aws-s3-module | 4.0.11 |
| <a name="module_s3_policy"></a> [s3\_policy](#module\_s3\_policy) | github.com/pbs/terraform-aws-s3-bucket-policy-module | 1.0.21 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (sharedtools, dev, staging, qa, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization using this module. Used to prefix tags so that they are easily identified as being from your organization | `string` | n/a | yes |
| <a name="input_primary_hosted_zone"></a> [primary\_hosted\_zone](#input\_primary\_hosted\_zone) | Name of the primary hosted zone for DNS. e.g. primary\_hosted\_zone = example.org --> service.example.org. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Tag used to group resources according to product | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | Tag used to point to the repo using this module | `string` | n/a | yes |
| <a name="input_acl"></a> [acl](#input\_acl) | ACL configuration for the bucket. If an ACL is not provided, the bucket will be created with ACLs disabled | <pre>object({<br>    canned_acl            = optional(string)<br>    expected_bucket_owner = optional(string)<br>    access_control_policy = optional(object({<br>      grants = set(object({<br>        grantee = object({<br>          type          = string<br>          email_address = optional(string)<br>          id            = optional(string)<br>          uri           = optional(string)<br>        })<br>        permission = string<br>      }))<br>      owner = object({<br>        id           = string<br>        display_name = optional(string)<br>      })<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | (optional) ARN for the ACM cert used for the CloudFront distribution | `string` | `null` | no |
| <a name="input_additional_origin_configurations"></a> [additional\_origin\_configurations](#input\_additional\_origin\_configurations) | Additional origin configurations to merge into default configuration. Useful for setting origin shield configurations | `any` | `{}` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | (optional) CNAME(s) that are allowed to be used for this cdn. Default is `product`.`primary_hosted_zone`. e.g. [service.example.com] --> [service.example.com] | `list(string)` | `null` | no |
| <a name="input_allow_anonymous_vpce_access"></a> [allow\_anonymous\_vpce\_access](#input\_allow\_anonymous\_vpce\_access) | Create bucket policy that allows anonymous VPCE access. | `bool` | `false` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name to use for the bucket. If null, will default to product. | `string` | `null` | no |
| <a name="input_cloudfront_default_certificate"></a> [cloudfront\_default\_certificate](#input\_cloudfront\_default\_certificate) | (optional) use cloudfront default ssl certificate | `bool` | `false` | no |
| <a name="input_cnames"></a> [cnames](#input\_cnames) | (optional) CNAME(s) that are going to be created for this cdn in the primary\_hosted\_zone. This can be set to [] to avoid creating a CNAME for the app. This can be useful for CDNs. Default is `product`. e.g. [service] --> [example.example.com] | `list(string)` | `null` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | (optional) comment for the CDN | `string` | `null` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | (optional) gzip compress response | `bool` | `true` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | CORS Rules | <pre>set(object({<br>    allowed_headers = list(string),<br>    allowed_methods = list(string),<br>    allowed_origins = list(string),<br>    expose_headers  = list(string),<br>    max_age_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_create_cname"></a> [create\_cname](#input\_create\_cname) | (optional) create CNAME(s) that point to CloudFront distribution | `bool` | `true` | no |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | (optional) set of one or more custom error response elements | `list(any)` | `[]` | no |
| <a name="input_default_behavior_allowed_methods"></a> [default\_behavior\_allowed\_methods](#input\_default\_behavior\_allowed\_methods) | (optional) default behavior allowed methods | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_default_behavior_cached_methods"></a> [default\_behavior\_cached\_methods](#input\_default\_behavior\_cached\_methods) | (optional) default behavior cached methods | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_default_behavior_function_association"></a> [default\_behavior\_function\_association](#input\_default\_behavior\_function\_association) | (optional) default behavior function association | <pre>object({<br>    event_type   = string<br>    function_arn = string<br>  })</pre> | `null` | no |
| <a name="input_default_behavior_lambda_function_association"></a> [default\_behavior\_lambda\_function\_association](#input\_default\_behavior\_lambda\_function\_association) | (optional) default behavior lambda function association | <pre>object({<br>    event_type   = string<br>    lambda_arn   = string<br>    include_body = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_default_cache_policy_id"></a> [default\_cache\_policy\_id](#input\_default\_cache\_policy\_id) | (optional) policy id for the cache policy of the default cache behavior. If null, a lookup on default\_cache\_policy\_name will be attempted. | `string` | `null` | no |
| <a name="input_default_cache_policy_name"></a> [default\_cache\_policy\_name](#input\_default\_cache\_policy\_name) | (optional) policy name for the cache policy of the default cache behavior | `string` | `"Managed-CachingDisabled"` | no |
| <a name="input_default_origin_id"></a> [default\_origin\_id](#input\_default\_origin\_id) | (optional) default origin origin id | `string` | `null` | no |
| <a name="input_default_origin_request_policy_id"></a> [default\_origin\_request\_policy\_id](#input\_default\_origin\_request\_policy\_id) | (optional) policy id for the origin request policy of the default cache behavior. If null, a lookup on default\_origin\_request\_policy\_name will be attempted. | `string` | `null` | no |
| <a name="input_default_origin_request_policy_name"></a> [default\_origin\_request\_policy\_name](#input\_default\_origin\_request\_policy\_name) | (optional) policy name for the origin request policy of the default cache behavior | `string` | `null` | no |
| <a name="input_default_response_headers_policy_id"></a> [default\_response\_headers\_policy\_id](#input\_default\_response\_headers\_policy\_id) | (optional) policy id for the response headers policy of the default cache behavior. If null, a lookup on default\_response\_headers\_policy\_name will be attempted. | `string` | `null` | no |
| <a name="input_default_response_headers_policy_name"></a> [default\_response\_headers\_policy\_name](#input\_default\_response\_headers\_policy\_name) | (optional) policy name for the response headers policy of the default cache behavior | `string` | `null` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | (optional) default root object to be served from cdn. For your security, it is recommended to set this to a non-null value for static websites. This prevents listing the contents of the S3 bucket used as the default origin of the CloudFront distribution. | `string` | `"index.html"` | no |
| <a name="input_dns_evaluate_target_health"></a> [dns\_evaluate\_target\_health](#input\_dns\_evaluate\_target\_health) | (optional) evaluate health of endpoints by querying DNS records | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (optional) enable cloudfront | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow destruction of an S3 bucket without clearing out the contents first | `bool` | `false` | no |
| <a name="input_force_tls"></a> [force\_tls](#input\_force\_tls) | Deny HTTP requests that are made to the bucket without TLS. | `bool` | `true` | no |
| <a name="input_http_version"></a> [http\_version](#input\_http\_version) | (optional) The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. | `string` | `"http2and3"` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_inventory_config"></a> [inventory\_config](#input\_inventory\_config) | Inventory configuration | <pre>object({<br>    enabled = optional(bool, true)<br><br>    included_object_versions = optional(string, "All")<br>    destination = object({<br>      bucket = object({<br>        name       = string<br>        format     = optional(string, "Parquet")<br>        prefix     = optional(string)<br>        account_id = optional(string)<br>      })<br>    })<br>    filter = optional(object({<br>      prefix = string<br>    }))<br>    schedule = optional(object({<br>      frequency = string<br>      }), {<br>      frequency = "Daily"<br>    })<br>    optional_fields = optional(list(string), [<br>      "Size",<br>      "LastModifiedDate",<br>      "StorageClass",<br>      "IntelligentTieringAccessTier",<br>    ])<br>  })</pre> | `null` | no |
| <a name="input_is_ipv6_enabled"></a> [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | (optional) enable ipv6 | `bool` | `true` | no |
| <a name="input_is_versioned"></a> [is\_versioned](#input\_is\_versioned) | Is versioning enabled? | `bool` | `true` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of maps containing configuration of object lifecycle management. | <pre>list(object({<br>    id      = string<br>    enabled = optional(bool, true)<br>    filter = optional(object({<br>      and = optional(list(object({<br>        object_size_greater_than = optional(number)<br>        object_size_less_than    = optional(number)<br>        prefix                   = optional(string)<br>        tags                     = optional(map(string))<br>      })))<br>      object_size_greater_than = optional(number)<br>      object_size_less_than    = optional(number)<br>      prefix                   = optional(string)<br>      tag = optional(object({<br>        key   = string<br>        value = string<br>      }))<br>    }))<br>    abort_incomplete_multipart_upload_days = optional(number)<br>    expiration = optional(object({<br>      date                         = optional(string)<br>      days                         = optional(number)<br>      expired_object_delete_marker = optional(bool)<br>    }))<br>    noncurrent_version_expiration = optional(object({<br>      days = optional(number)<br>    }))<br>    noncurrent_version_transition = optional(list(object({<br>      days          = optional(number)<br>      storage_class = optional(string)<br>    })), [])<br>    transition = optional(list(object({<br>      date          = optional(string)<br>      days          = optional(number)<br>      storage_class = string<br>    })), [])<br>  }))</pre> | <pre>[<br>  {<br>    "abort_incomplete_multipart_upload_days": 7,<br>    "enabled": true,<br>    "id": "default-lifecycle-rule",<br>    "noncurrent_version_transition": [<br>      {<br>        "days": 30,<br>        "storage_class": "GLACIER"<br>      }<br>    ],<br>    "transition": [<br>      {<br>        "days": 7,<br>        "storage_class": "INTELLIGENT_TIERING"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | (optional) logging configuration that controls how logs are written to your distribution (maximum one) | `list(any)` | `[]` | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | (optional) tls minimum protocol version | `string` | `"TLSv1"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for the static site. If null, will default to product. | `string` | `null` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | (optional) an ordered list of cache behaviors resource for this distribution | <pre>list(object({<br>    path_pattern     = string<br>    target_origin_id = string<br><br>    cache_policy_id            = string<br>    origin_request_policy_id   = optional(string)<br>    response_headers_policy_id = optional(string)<br><br>    allowed_methods           = optional(list(string), ["GET", "HEAD"])<br>    cached_methods            = optional(list(string), ["GET", "HEAD"])<br>    compress                  = optional(bool, true)<br>    field_level_encryption_id = optional(string)<br>    viewer_protocol_policy    = optional(string, "redirect-to-https")<br>    smooth_streaming          = optional(bool)<br>    trusted_key_groups        = optional(list(string))<br>    trusted_signers           = optional(list(string))<br><br>    lambda_function_associations = optional(list(object({<br>      event_type   = optional(string, "viewer-request")<br>      lambda_arn   = string<br>      include_body = optional(bool, false)<br>    })))<br>    function_associations = optional(list(object({<br>      event_type   = optional(string, "viewer-request")<br>      function_arn = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid from earlier documents in the list. Statements with non-blank sids will also override statements with the same sid from documents provided in the source\_json and source\_policy\_documents arguments. Non-overriding statements will be added to the exported document. | `list(string)` | `null` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | (optional) price class for the distribution | `string` | `"PriceClass_100"` | no |
| <a name="input_replication_configuration_set"></a> [replication\_configuration\_set](#input\_replication\_configuration\_set) | Set of (single) replication that needs to be managed by this bucket. If empty, no replication takes place. | <pre>set(object({<br>    role = string,<br>    rules = set(object({<br>      id                                           = string<br>      priority                                     = number<br>      status                                       = string<br>      destination_account_id                       = string<br>      destination_bucket                           = string<br>      destination_access_control_translation_owner = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_replication_configuration_shortcut"></a> [replication\_configuration\_shortcut](#input\_replication\_configuration\_shortcut) | Shorthand version of the configuration used in replication\_configuration\_set. Is overridden by replication\_configuration\_set if defined. | <pre>object({<br>    destination_account_id = string<br>    destination_bucket     = string<br>  })</pre> | `null` | no |
| <a name="input_replication_source"></a> [replication\_source](#input\_replication\_source) | The account number and role for the source bucket in a replication configuration. | <pre>object({<br>    account_id = string<br>    role       = string<br>  })</pre> | `null` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_restriction_locations"></a> [restriction\_locations](#input\_restriction\_locations) | (optional) locations to use in access restriction (whitelist or blacklist based on restriction\_type) | `list(string)` | `[]` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | (optional) type of restriction for CDN | `string` | `"none"` | no |
| <a name="input_s3_regional_domain_name"></a> [s3\_regional\_domain\_name](#input\_s3\_regional\_domain\_name) | (optional) s3 regional domain name. | `string` | `null` | no |
| <a name="input_source_policy_documents"></a> [source\_policy\_documents](#input\_source\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements defined in source\_policy\_documents or source\_json must have unique sids. Statements with the same sid from documents assigned to the override\_json and override\_policy\_documents arguments will override source statements. | `list(string)` | `null` | no |
| <a name="input_ssl_support_method"></a> [ssl\_support\_method](#input\_ssl\_support\_method) | (optional) ssl support method (one of vip or sni-only) | `string` | `"sni-only"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra tags | `map(string)` | `{}` | no |
| <a name="input_use_prefix"></a> [use\_prefix](#input\_use\_prefix) | Create bucket with prefix instead of explicit name | `bool` | `true` | no |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | (optional) viewer protocol policy | `string` | `"redirect-to-https"` | no |
| <a name="input_vpce"></a> [vpce](#input\_vpce) | Name of the VPC endpoint that should have access to this bucket. Only used when `allow_anonymous_vpce_access` is true. | `string` | `null` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | (optional) unique identifier that specifies the AWS WAF web ACL | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the CloudFront distribution |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the bucket backing this CDN |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Bucket backing this CDN. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | One domain name that will resolve to this cdn. Might not be a valid alias. |
| <a name="output_id"></a> [id](#output\_id) | ID of the CloudFront distribution |
| <a name="output_oac_id"></a> [oac\_id](#output\_oac\_id) | ID of the origin access identity |
