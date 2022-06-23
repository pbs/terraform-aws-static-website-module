module "static_website" {
  source = "../.."

  primary_hosted_zone = var.primary_hosted_zone
  default_root_object = "index.html"

  force_destroy = true

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
