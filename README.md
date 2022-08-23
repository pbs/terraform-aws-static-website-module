# PBS TF static website module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-static-website-module?ref=1.1.0
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an S3 bucket fronted by CloudFront to serve static content.

Integrate this module like so:

```hcl
module "static-website" {
  source = "github.com/pbs/terraform-aws-static-website-module?ref=1.1.0"

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

### :warning: Warning

This module requires a targeted apply to start using it.

The following command will apply the resources that need to be created in order to finish applying (assuming you name the module `static_website`):

```bash
terraform apply \
-target='module.static_website.module.s3.aws_s3_bucket.bucket' \
-target='module.static_website.data.aws_iam_policy_document.policy_doc'
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`1.1.0`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.27.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | github.com/pbs/terraform-aws-cloudfront-module | 1.0.0 |
| <a name="module_s3"></a> [s3](#module\_s3) | github.com/pbs/terraform-aws-s3-module | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (sharedtools, dev, staging, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization using this module. Used to prefix tags so that they are easily identified as being from your organization | `string` | n/a | yes |
| <a name="input_primary_hosted_zone"></a> [primary\_hosted\_zone](#input\_primary\_hosted\_zone) | Name of the primary hosted zone for DNS. e.g. primary\_hosted\_zone = example.org --> service.example.org. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Tag used to group resources according to product | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | Tag used to point to the repo using this module | `string` | n/a | yes |
| <a name="input_acl"></a> [acl](#input\_acl) | Canned ACL for the bucket. If an ACL is not provided, the bucket will be created with ACLs disabled | `string` | `null` | no |
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | (optional) ARN for the ACM cert used for the CloudFront distribution | `string` | `null` | no |
| <a name="input_additional_origin_configurations"></a> [additional\_origin\_configurations](#input\_additional\_origin\_configurations) | Additional origin configurations to merge into default configuration. Useful for setting origin shield configurations | `any` | `{}` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | (optional) CNAME(s) that are allowed to be used for this cdn. Default is `product`.`primary_hosted_zone`. e.g. [service.example.com] --> [service.example.com] | `list(string)` | `null` | no |
| <a name="input_allow_anonymous_vpce_access"></a> [allow\_anonymous\_vpce\_access](#input\_allow\_anonymous\_vpce\_access) | Create bucket policy that allows anonymous VPCE access. If bucket\_policy is defined, this will be ignored. | `bool` | `false` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name to use for the bucket. If null, will default to product. | `string` | `null` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | Policy to apply to the bucket. If null, one will be guessed based on surrounding functionality | `string` | `null` | no |
| <a name="input_cloudfront_default_certificate"></a> [cloudfront\_default\_certificate](#input\_cloudfront\_default\_certificate) | (optional) use cloudfront default ssl certificate | `bool` | `false` | no |
| <a name="input_cnames"></a> [cnames](#input\_cnames) | (optional) CNAME(s) that are going to be created for this cdn in the primary\_hosted\_zone. This can be set to [] to avoid creating a CNAME for the app. This can be useful for CDNs. Default is `product`. e.g. [service] --> [example.example.com] | `list(string)` | `null` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | (optional) comment for the CDN | `string` | `null` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | (optional) gzip compress response | `bool` | `true` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | CORS Rules | <pre>set(object({<br>    allowed_headers = list(string),<br>    allowed_methods = list(string),<br>    allowed_origins = list(string),<br>    expose_headers  = list(string),<br>    max_age_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_create_cname"></a> [create\_cname](#input\_create\_cname) | (optional) create CNAME(s) that point to CloudFront distribution | `bool` | `true` | no |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | (optional) set of one or more custom error response elements | `list(any)` | `[]` | no |
| <a name="input_default_behavior_allowed_methods"></a> [default\_behavior\_allowed\_methods](#input\_default\_behavior\_allowed\_methods) | (optional) default behavior allowed methods | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_default_behavior_cached_methods"></a> [default\_behavior\_cached\_methods](#input\_default\_behavior\_cached\_methods) | (optional) default behavior cached methods | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_default_behavior_function_arn"></a> [default\_behavior\_function\_arn](#input\_default\_behavior\_function\_arn) | (optional) default behavior function arn. If null, no function is associated with default behavior. | `string` | `null` | no |
| <a name="input_default_behavior_function_event_type"></a> [default\_behavior\_function\_event\_type](#input\_default\_behavior\_function\_event\_type) | (optional) default behavior function event type. If default\_behavior\_function\_arn is null, this is ignored. | `string` | `"viewer-request"` | no |
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
| <a name="input_inventory_bucket"></a> [inventory\_bucket](#input\_inventory\_bucket) | Name of the bucket to use for inventory. If null, will not configure inventory configurations. | `string` | `null` | no |
| <a name="input_inventory_frequency"></a> [inventory\_frequency](#input\_inventory\_frequency) | Frequency of inventory collection. | `string` | `"Daily"` | no |
| <a name="input_inventory_included_object_versions"></a> [inventory\_included\_object\_versions](#input\_inventory\_included\_object\_versions) | Included object versions for inventory collection. | `string` | `"All"` | no |
| <a name="input_is_ipv6_enabled"></a> [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | (optional) enable ipv6 | `bool` | `true` | no |
| <a name="input_is_versioned"></a> [is\_versioned](#input\_is\_versioned) | Is versioning enabled? | `bool` | `true` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of maps containing configuration of object lifecycle management. | `any` | <pre>[<br>  {<br>    "abort_incomplete_multipart_upload_days": 7,<br>    "enabled": true,<br>    "id": "default-lifecycle-rule",<br>    "noncurrent_version_transition": [<br>      {<br>        "days": 30,<br>        "storage_class": "GLACIER"<br>      }<br>    ],<br>    "transition": [<br>      {<br>        "days": 7,<br>        "storage_class": "INTELLIGENT_TIERING"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | (optional) logging configuration that controls how logs are written to your distribution (maximum one) | `list(any)` | `[]` | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | (optional) tls minimum protocol version | `string` | `"TLSv1"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for the static site. If null, will default to product. | `string` | `null` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | (optional) an ordered list of cache behaviors resource for this distribution | `list(any)` | `[]` | no |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | (Optional) - List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid from earlier documents in the list. Statements with non-blank sids will also override statements with the same sid from documents provided in the source\_json and source\_policy\_documents arguments. Non-overriding statements will be added to the exported document. | `list(string)` | `null` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | (optional) price class for the distribution | `string` | `"PriceClass_100"` | no |
| <a name="input_replication_configuration_set"></a> [replication\_configuration\_set](#input\_replication\_configuration\_set) | Set of (single) replication that needs to be managed by this bucket. If empty, no replication takes place. | <pre>set(object({<br>    role = string,<br>    rules = set(object({<br>      id                                           = string<br>      priority                                     = number<br>      status                                       = string<br>      destination_account_id                       = string<br>      destination_bucket                           = string<br>      destination_access_control_translation_owner = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_replication_configuration_shortcut"></a> [replication\_configuration\_shortcut](#input\_replication\_configuration\_shortcut) | Shorthand version of the configuration used in replication\_configuration\_set. Is overridden by replication\_configuration\_set if defined. | <pre>object({<br>    destination_account_id = string<br>    destination_bucket     = string<br>  })</pre> | `null` | no |
| <a name="input_replication_source"></a> [replication\_source](#input\_replication\_source) | The account number and role for the source bucket in a replication configuration. Creates a bucket policy. | <pre>object({<br>    account_id = string<br>    role       = string<br>  })</pre> | `null` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_restriction_locations"></a> [restriction\_locations](#input\_restriction\_locations) | (optional) locations to use in access restriction (whitelist or blacklist based on restriction\_type) | `list(string)` | `[]` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | (optional) type of restriction for CDN | `string` | `"none"` | no |
| <a name="input_s3_regional_domain_name"></a> [s3\_regional\_domain\_name](#input\_s3\_regional\_domain\_name) | (optional) s3 regional domain name. | `string` | `null` | no |
| <a name="input_source_policy_documents"></a> [source\_policy\_documents](#input\_source\_policy\_documents) | (Optional) - List of IAM policy documents that are merged together into the exported document. Statements defined in source\_policy\_documents or source\_json must have unique sids. Statements with the same sid from documents assigned to the override\_json and override\_policy\_documents arguments will override source statements. | `list(string)` | `null` | no |
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
| <a name="output_oia_arns"></a> [oia\_arns](#output\_oia\_arns) | Origin Access Identity ARNs |
