resource "aws_iam_role" "role" {
  name = var.product

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "extra" {
  statement {
    sid = "ExtraPermissions"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.role.arn]
    }

    actions = ["s3:*"]
    resources = [
      module.static_website.bucket_arn,
      "${module.static_website.bucket_arn}/*",
    ]
  }
}

module "static_website" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone
  default_root_object = "index.html"

  force_destroy = true

  override_policy_documents = [data.aws_iam_policy_document.extra.json]

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

resource "aws_s3_object" "object" {
  bucket = module.static_website.bucket_name
  key    = "index.html"
  source = "../../tests/nginx-index.html"

  etag = filemd5("../../tests/nginx-index.html")
}
