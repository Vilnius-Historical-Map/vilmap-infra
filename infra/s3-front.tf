module "frontend_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${var.project_name}-frontend"
  region = var.region

  cors_rule = [
    {
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["https://${var.subdomain}${var.domain}"]
      allowed_headers = ["*"]
      max_age_seconds = 3000
    }
  ]
  lifecycle_rule = [
    {
      id      = "expire-noncurrent-versions"
      enabled = true
      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]

  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = module.frontend_s3_bucket.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${module.frontend_s3_bucket.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}