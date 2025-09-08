module "acm" {
  source      = "terraform-aws-modules/acm/aws"
  domain_name = var.domain
  zone_id     = "Z07484993CJEBX0BD8VOJ"

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain}"
  ]

  region              = "us-east-1"
  wait_for_validation = true

  tags = var.tags
}