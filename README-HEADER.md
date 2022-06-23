# PBS TF static website module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-static-website-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an S3 bucket fronted by CloudFront to serve static content.

Integrate this module like so:

```hcl
module "static-website" {
  source = "github.com/pbs/terraform-aws-static-website-module?ref=x.y.z"

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

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
