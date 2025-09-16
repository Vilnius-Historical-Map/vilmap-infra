module "route53_records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name = var.subdomain
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = "Z2FDTNDATAQYW2"
      }
    }
  ]
}