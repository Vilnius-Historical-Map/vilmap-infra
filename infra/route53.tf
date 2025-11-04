module "route53" {
  source      = "terraform-aws-modules/route53/aws"
  name        = var.zone_name
  create_zone = false

  records = {
    "app_record" = {
      name = var.subdomain
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = "Z2FDTNDATAQYW2"
      }
    }
  }
}
