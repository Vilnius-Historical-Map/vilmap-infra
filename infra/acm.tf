module "acm" {
  source      = "terraform-aws-modules/acm/aws"
  domain_name = var.domain
  zone_id     = var.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain}"
  ]

  region              = "us-east-1"
  wait_for_validation = true

  tags = var.tags
}