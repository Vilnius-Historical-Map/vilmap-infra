module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = ["${var.subdomain}${var.domain}"]
  enabled             = true
  is_ipv6_enabled     = false
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = false
  create_origin_access_control  = true
  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    s3_oac = {
      domain_name           = module.frontend_s3_bucket.s3_bucket_bucket_regional_domain_name
      origin_access_control = "s3_oac"
    }
  }

  default_root_object = "index.html"
  default_cache_behavior = {
    target_origin_id       = "s3_oac"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD"]

    use_forwarded_values = false

    cache_policy_name            = "Managed-CachingOptimized"
    origin_request_policy_name   = "Managed-UserAgentRefererHeaders"
    response_headers_policy_name = "Managed-SimpleCORS"
    compress                     = true
    query_string                 = false
  }

  viewer_certificate = {
    acm_certificate_arn      = module.acm.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
